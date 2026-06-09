"""
Module: daq_commands.py
Description: Main high-level abstraction API layer for executing MCA operations
             equipped with micro-level low-level hardware serial bus proxies.
"""

from core.daq_hw import DaqHw
from core.dpp_parameters import DppParameters
from core.daq_constants import DaqCliCommands, DppSubmodules
from enum import Enum
import struct, logging
from typing import List, Tuple, Dict, Any
from contextlib import contextmanager

# Dedicated global logger for high-level operations and serial transactions
logger = logging.getLogger("DAQ_MCA_API")

class LoggedDaqHw:
    """Proxy class wrapper that logs every operation occurring on the DaqHw serial port.
    
    Intercepts and logs every outgoing byte array and raw incoming byte buffers 
    before handing them back to the caller application context.
    """
    def __init__(self, raw_daq_instance: Any):
        """Initializes the wrapper proxy with an active DaqHw instance."""
        self._daq = raw_daq_instance

    def write(self, data: bytes) -> int:
        """Logs and forwards data written directly to the serial hardware buffer."""
        logger.debug("[SERIAL BUS -> TX RAW]: %r", data)
        return self._daq.write(data)

    def read(self, size: int = 1) -> bytes:
        """Logs and forwards byte blocks captured from the hardware read lines."""
        raw_bytes = self._daq.read(size)
        logger.debug("[SERIAL BUS <- RX RAW BLOCK (%d bytes)]: %r", len(raw_bytes), raw_bytes)
        return raw_bytes

    def read_until(self, expected: bytes = b'\n') -> bytes:
        """Logs and forwards sequential strings read until matching terminators."""
        raw_bytes = self._daq.read_until(expected)
        logger.debug("[SERIAL BUS <- RX RAW LINE]: %r", raw_bytes)
        return raw_bytes

    def __getattr__(self, name: str) -> Any:
        """Fallback to expose native methods from the underlying DaqHw object."""
        return getattr(self._daq, name)

class DaqException(Exception):
    """Base exception for all DAQ CLI execution and communication errors."""
    pass

class DaqUnknownCommandException(DaqException):
    """Raised when the DAQ returns Error Code 00 (Unknown Command)."""
    pass

class DaqInvalidParameterException(DaqException):
    """Raised when the DAQ returns Error Code 01 (Wrong/Missing parameters)."""
    pass

# =====================================================================
# MAIN DAQ COMMANDS API CLASS
# =====================================================================

class DaqCommands:
    """High-level API facade to interact with the DAQ/MCA hardware via CLI.

    This class abstracts low-level ASCII framing and binary unpacking operations 
    into clean, easy-to-use Python methods. It interfaces directly with an 
    underlying DaqHw serial instance and references commands via DaqCliCommands.
    """

    MCA_BINS = 2048
    SCOPE_LENGTH = 2048
    BYTES_IN_WORD = 4

    def __init__(self, port_name: str, baudrate: int = 115200, 
                 sampling_rate: float = 50e6, tau_d: float = 1.145e-6, tau_r: float = 0.220e-6, 
                 **dpp_kwargs):
        """Prepares session state elements and encapsulates the DPP parameter library."""
        self.port_name = port_name
        self.baudrate = baudrate
        self.daq = DaqHw()
        
        logger.info("Initializing underlying Dpp_Parameters submodules framework...")
        self.dpp = DppParameters(
            sampling_rate=sampling_rate,
            tau_d=tau_d,
            tau_r=tau_r,
            **dpp_kwargs
        )

    @contextmanager
    def _connection_transaction(self):
        """Context manager hook isolating the active connection life-cycle state."""
        logger.debug("[SERIAL BUS -> ATTEMPT OPEN]: Port '%s' at %d baud", self.port_name, self.baudrate)
        self.daq.open_port(self.port_name, self.baudrate)
        try:
            yield self.daq
        finally:
            logger.debug("[SERIAL BUS -> ATTEMPT CLOSE]: Releasing hardware lines safely")
            self.daq.close_port(self.daq)

    def _send_ascii_cmd(self, cmd: DaqCliCommands, params: str = "") -> str:
        """Transmits standard text command frames within a live port instance transaction."""
        cmd_code = cmd.value
        if cmd == DaqCliCommands.PING:
            packet_str = f"{cmd_code}\r"
        else:
            param_space = " " if params else ""
            packet_str = f"${cmd_code}{param_space}{params}\r"

        with self._connection_transaction() as active_bus:
            logger.debug("[SERIAL BUS -> TX RAW]: %r", packet_str)
            active_bus.write(packet_str.encode('ascii'))

            response_bytes = active_bus.read_until(b'\n\r')
            response = response_bytes.decode('ascii').strip()
            logger.debug("[SERIAL BUS <- RX RAW LINE]: %r", response_bytes)

        if "!ERROR:" in response:
            error_code = response.split(":")[-1].strip()
            logger.error(f"Hardware execution fault intercepted. Error code: {error_code}", )
            if error_code == "00":
                raise DaqUnknownCommandException(f"Command '{cmd_code}' not recognized.")
            elif error_code == "01":
                raise DaqInvalidParameterException(f"Invalid parameters for command '{cmd_code}'.")
            else:
                raise DaqException(f"Unhandled hardware execution error: {error_code}")

        return response
    
    def get_version(self) -> str:
        """Retrieves the system firmware version string from the hardware.
        
        Returns:
            str: The system firmware version string.
        """
        response = self._send_ascii_cmd(DaqCliCommands.GET_VERSION)
        return response.replace(f"!{DaqCliCommands.GET_VERSION.value}", "").strip()
    
    def get_serial(self) -> str:
        """Retrieves the system serial number string from the hardware.
        
        Returns:
            str: The system serial number string.
        """
        response = self._send_ascii_cmd(DaqCliCommands.GET_SERIAL)
        return response.replace(f"!{DaqCliCommands.GET_SERIAL.value}", "").strip()
    
    def data_acquisition_start(self) -> bool:
        """Starts the spectrum acquisition in the hardware.

        Returns:
            bool: True if the spectrum acquisition was started successfully.
        """
        response = self._send_ascii_cmd(DaqCliCommands.DATA_ACQUISITION, "1")
        return True if response != None else False
    
    def data_acquisition_stop(self) -> bool:
        """Stops the spectrum acquisition in the hardware.

        Returns:
            bool: True if the spectrum acquisition was stopped successfully.
        """
        response = self._send_ascii_cmd(DaqCliCommands.DATA_ACQUISITION, "0")
        return True if response != None else False
    
    def timers_reset(self) -> bool:
        """Resets the timers in the hardware board.
        
        Returns:
            bool: True if the timers were reset successfully.
        """
        response = self._send_ascii_cmd(DaqCliCommands.DATA_ACQUISITION, "4")
        return True if response != None else False
    
    def timers_read(self) -> Dict[str, int]:
        """Reads simultaneouslly all the real-time timer values in the hardware board.
        
        Returns:
            Dict[str, int]: A dictionary containing the timer values, status register,
                preset (collection) time, and control bit values.
        """

        response = self._send_ascii_cmd(DaqCliCommands.READ_TIMERS, "-1")
        payload = response.replace(f"!{DaqCliCommands.READ_TIMERS}", "").strip().split()
        values = [int(v) for v in payload]

        return {"tmr_a": values[0],
                "tmr_b": values[1],
                "tmr_c": values[2],
                "status": values[3],
                "preset": values[4],
                "ctrl_bits": values[5]}

    def read_oscilloscope(self) -> Tuple[List[int], List[int]]:
        """Reads the waveform data from the hardware board.
        
        Does not make use of the `_send_ascii_cmd` method, since its
        response format (binary) is different from the other CLI commands.

        Returns:
            Tuple[List[int], List[int]]: A tuple containing the x-axis and y-axis data points.
        """

        packet = f"${DaqCliCommands.LOAD_SCOPE}\r".encode('ascii')
        self.daq.write(packet)

        header = self.daq.read_until(b'\n\r')

        if b"!L" not in header:
            raise DaqException("Synchronization error: Text stream header mismatch during scope trace capture.")

        raw_binary = self.daq.read(self.SCOPE_LENGTH*self.BYTES_IN_WORD)
        
        ch1_trace, ch2_trace = [], []

        for offset in range(0, 8192, 4):
            chunk = raw_binary[offset:offset+4]
            val_ch1, val_ch2 = struct.unpack("<hh", chunk)
            ch1_trace.append(val_ch1)
            ch2_trace.append(val_ch2)

        return ch1_trace, ch2_trace
    
    def read_spectrum(self, base_address : int = 0) -> List[int]:
        """Reads the spectrum data from the hardware board.
        
        Does not make use of the `_send_ascii_cmd` method, since its
        response format (binary) is different from the other CLI commands.

        Returns:
            List[int]: A list containing the spectrum data points.
        """

        packet = f"${DaqCliCommands.READ_SPECTRUM} {base_address}\r".encode('ascii')
        self.daq.write(packet)

        header = self.daq.read_until(b'\n\r')

        if b"!R" not in header:
            raise DaqException("Synchronization error: Text stream header mismatch during spectrum capture.")

        raw_binary = self.daq.read(self.MCA_BINS*self.BYTES_IN_WORD)
        return list(struct.unpack("<I" * self.MCA_BINS, raw_binary))
    

    # -------------------------------------------------------------------------
    # DPP Parameter Setter and Getter ($SP / $GP)
    # -------------------------------------------------------------------------

    def set_dpp_params(self, submodule: DppSubmodules, **human_values) -> bool:
        """Modifies config variables dynamically and flashes 32-bit uint arrays down."""
        for field, value in human_values.items():
            if hasattr(self.dpp, field):
                setattr(self.dpp, field, value)
                logger.info("Updated parameter locally: %s = %s", field, value)
            else:
                raise AttributeError(f"Dpp_Parameters class has no attribute named '{field}'.")

        for recompute_hook in ("_compute_parameters", "recompute", "update"):
            if hasattr(self.dpp, recompute_hook):
                getattr(self.dpp, recompute_hook)()
                break

        getter_func = getattr(self.dpp, submodule.getter_name, None)
        if not getter_func:
            raise NotImplementedError(f"Getter method '{submodule.getter_name}' missing.")
        
        register_array = getter_func()
        serialized_string = " ".join(str(int(reg_val)) for reg_val in register_array)
        arguments = f"{submodule.group_index} {serialized_string}"

        response = self._send_ascii_cmd(DaqCliCommands.SET_DPP_PARAMS, arguments)
        return f"!{DaqCliCommands.SET_DPP_PARAMS.value}" in response


    def get_dpp_params(self, submodule: DppSubmodules) -> List[int]:
        """Queries active register data contents directly from hardware lanes."""
        response = self._send_ascii_cmd(DaqCliCommands.GET_DPP_PARAMS, str(submodule.group_index))
        payload_data = response.replace(f"!{DaqCliCommands.GET_DPP_PARAMS.value}", "").strip()
        return [int(reg_str) for reg_str in payload_data.split()]
    
if __name__ == '__main__':
    daq = DaqHw()
    port_name = daq.find_port(daq.DEFAULT_VID, daq.DEFAULT_PID)
    daq.open_port(port_name, daq.DEFAULT_BAUDRATE)

