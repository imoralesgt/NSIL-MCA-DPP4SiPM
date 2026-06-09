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
import time

# Dedicated global logger for high-level operations and serial transactions
logger = logging.getLogger("DAQ_MCA_API")

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
        self.daq = DaqHw(port=None) 
        
        logger.info("Initializing underlying Dpp_Parameters submodules framework...")
        logger.info("[DEBUG START]: Passing arguments to Dpp_Parameters constructor...")
        logger.info(f"[DEBUG PARAM]: sampling_rate={sampling_rate}, tau_d={tau_d}, tau_r={tau_r}")
        logger.info(f"[DEBUG KWARGS]: {dpp_kwargs}")
        
        try:
            self.dpp = DppParameters(
                sampling_rate=sampling_rate,
                tau_d=tau_d,
                tau_r=tau_r,
                **dpp_kwargs
            )
            logger.info("[DEBUG END]: DppParameters object created successfully!")
        except Exception as e:
            logger.error(f"[DEBUG FAULT]: DppParameters constructor threw an exception: {e}")
            raise e

    def open(self, boot_delay: float = 0.5):
        """Establishes a long-lived persistent connection session to the target hardware."""
        if not self.daq.is_open:
            logger.info(f"[SESSION]: Opening persistent channel -> {self.port_name}")
            self.daq.open_port(self.port_name, self.baudrate)
            self.daq.timeout = 2.0
            
            if boot_delay > 0:
                logger.info(f"[SESSION]: Waiting {boot_delay} s for hardware bootloader stabilization...")
                time.sleep(boot_delay)
                self.daq.reset_input_buffer()

    def close(self):
        """Safely tears down the active physical serial transaction layer."""
        if self.daq.is_open:
            logger.info("[SESSION]: Closing active hardware connection.")
            self.daq.close_port(self.daq)

    def __enter__(self):
        """Supports native context tracking 'with DaqCommands(...) as api:' blocks."""
        self.open()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Automatically closes lines when exiting runtime workspace scopes."""
        self.close()

    @contextmanager
    def _connection_transaction(self):
        """Context manager hook isolating the active connection lifecycle state."""
        self.open()  # Ensure connection is up and hot
        try:
            yield self.daq
        except Exception as e:
            logger.error(f"Transaction communication breakdown encountered: {e}")
            raise e

    def _send_ascii_cmd(self, cmd: DaqCliCommands, params: str = "") -> str:
        """Transmits standard text command frames within a live port instance transaction."""
        cmd_code = cmd.value
        if cmd == DaqCliCommands.PING:
            packet_str = f"{cmd_code}\r"
        else:
            param_space = " " if params else ""
            packet_str = f"${cmd_code}{param_space}{params}\r"

        with self._connection_transaction() as active_bus:
            logger.info("[TX RAW BUS]: Sending packet -> %r", packet_str)
            active_bus.write(packet_str.encode('ascii'))

            logger.info("[RX RAW BUS]: Awaiting data from hardware (timeout=2.0s)...")
            response_bytes = active_bus.read_until(b'\n\r')

            response = response_bytes.decode('ascii').strip()
            logger.debug("[SERIAL BUS <- RX RAW LINE]: %r", response_bytes)

        if not response:
            raise DaqException(f"Communication Timeout: No response received from hardware for command '{cmd_code}'.")

        if "!ERROR:" in response:
            error_code = response.split(":")[-1].strip()
            logger.error(f"Hardware execution fault intercepted. Error code: {error_code}")
            if error_code == "00":
                raise DaqUnknownCommandException(f"Command '{cmd_code}' not recognized.")
            elif error_code == "01":
                raise DaqInvalidParameterException(f"Invalid parameters for command '{cmd_code}'.")
            else:
                raise DaqException(f"Unhandled hardware execution error: {error_code}")

        return response

    def ping(self) -> bool:
        """Performs live diagnostic heartbeat checking."""
        response = self._send_ascii_cmd(DaqCliCommands.PING)
        return DaqCliCommands.PING.value in response

    def get_version(self) -> str:
        """Retrieves the system firmware version string from the hardware."""
        response = self._send_ascii_cmd(DaqCliCommands.GET_VERSION)
        return response.replace(f"!{DaqCliCommands.GET_VERSION.value}", "").strip()

    def get_serial(self) -> str:
        """Retrieves the system serial number string from the hardware."""
        response = self._send_ascii_cmd(DaqCliCommands.GET_SERIAL)
        return response.replace(f"!{DaqCliCommands.GET_SERIAL.value}", "").strip()

    def data_acquisition_start(self) -> bool:
        """Starts the spectrum acquisition in the hardware."""
        response = self._send_ascii_cmd(DaqCliCommands.DATA_ACQUISITION, "1")
        return response is not None

    def data_acquisition_stop(self) -> bool:
        """Stops the spectrum acquisition in the hardware."""
        response = self._send_ascii_cmd(DaqCliCommands.DATA_ACQUISITION, "0")
        return response is not None

    def timers_reset(self) -> bool:
        """Resets the timers in the hardware board."""
        response = self._send_ascii_cmd(DaqCliCommands.DATA_ACQUISITION, "4")
        return response is not None

    def clear_spectrum(self, segment_index: int = 0) -> bool:
        """Erases memory histograms safely using $CS instructions."""
        response = self._send_ascii_cmd(DaqCliCommands.CLEAR_SPECTRUM, str(segment_index))
        return f"!{DaqCliCommands.CLEAR_SPECTRUM.value}" in response

    def set_dpp_params(self, submodule: DppSubmodules, dpp_instance: DppParameters = None) -> bool:
        """Uploads pre-calculated 32-bit parameters straight to hardware registers.

        Args:
            submodule (DppSubmodules): Target hardware register block enum member.
            dpp_instance (DppParameters, optional): A newly instantiated parameters context.
        """
        if dpp_instance is not None:
            self.dpp = dpp_instance

        getter_func = getattr(self.dpp, submodule.getter_name, None)
        if not getter_func:
            raise NotImplementedError(f"Getter method '{submodule.getter_name}' missing in library backend.")
        
        # Invoke the correct '_daq' layout array retrieval function
        parameter_data = getter_func()
        
        # Handle dict value collection or pass down direct lists safely
        if isinstance(parameter_data, dict):
            register_array = list(parameter_data.values())
        else:
            register_array = list(parameter_data)

        # Serialize the integer values into a clean space-delimited text sequence
        serialized_string = " ".join(str(int(reg_val)) for reg_val in register_array)
        arguments = f"{submodule.group_index} {serialized_string}"

        response = self._send_ascii_cmd(DaqCliCommands.SET_DPP_PARAMS, arguments)
        return f"!{DaqCliCommands.SET_DPP_PARAMS.value}" in response


    def get_dpp_params(self, submodule: DppSubmodules) -> List[int]:
        """Queries active register data contents directly from hardware lanes."""
        response = self._send_ascii_cmd(DaqCliCommands.GET_DPP_PARAMS, str(submodule.group_index))
        payload_data = response.replace(f"!{DaqCliCommands.GET_DPP_PARAMS.value}", "").strip()
        return [int(reg_str) for reg_str in payload_data.split()]
    
    def timers_read(self) -> Dict[str, int]:
        """Reads simultaneously all the real-time timer values in the hardware board."""
        response = self._send_ascii_cmd(DaqCliCommands.READ_TIMERS, "-1")
        payload = response.replace(f"!{DaqCliCommands.READ_TIMERS.value}", "").strip().split()
        values = [int(v) for v in payload]

        return {
            "tmr_a": values[0],
            "tmr_b": values[1],
            "tmr_c": values[2],
            "status": values[3],
            "preset": values[4],
            "ctrl_bits": values[5]
        }

    def read_oscilloscope(self) -> Tuple[List[int], List[int]]:
        """Reads the waveform data from the hardware board inside an active transaction window."""
        packet = f"${DaqCliCommands.LOAD_SCOPE.value}\r"
        
        with self._connection_transaction() as active_bus:
            logger.info("[TX RAW BUS]: Sending scope request -> %r", packet)
            active_bus.write(packet.encode('ascii'))

            header = active_bus.read_until(b'\n\r')
            if b"!L" not in header:
                raise DaqException("Synchronization error: Text stream header mismatch during scope trace capture.")

            raw_binary = active_bus.read(self.SCOPE_LENGTH * self.BYTES_IN_WORD)
            active_bus.read_until(b'\n\r')  # Flush final bounding indicators

        ch1_trace, ch2_trace = [], []
        for offset in range(0, self.SCOPE_LENGTH * self.BYTES_IN_WORD, 4):
            chunk = raw_binary[offset:offset+4]
            val_ch2, val_ch1 = struct.unpack("<hh", chunk)
            ch1_trace.append(val_ch1)
            ch2_trace.append(val_ch2)

        return ch1_trace, ch2_trace

    def read_spectrum(self, base_address: int = 0) -> List[int]:
        """Reads the spectrum data from the hardware board inside an active transaction window."""
        packet = f"${DaqCliCommands.READ_SPECTRUM.value} {base_address}\r"
        
        with self._connection_transaction() as active_bus:
            logger.info("[TX RAW BUS]: Sending spectrum request -> %r", packet)
            active_bus.write(packet.encode('ascii'))

            header = active_bus.read_until(b'\n\r')
            if b"!R" not in header:
                raise DaqException("Synchronization error: Text stream header mismatch during spectrum capture.")

            raw_binary = active_bus.read(self.MCA_BINS * self.BYTES_IN_WORD)
            active_bus.read_until(b'\n\r')  # Flush final bounding indicators

        return list(struct.unpack(f"<{self.MCA_BINS}I", raw_binary))
    
if __name__ == '__main__':
    daq = DaqHw()
    port_name = daq.find_port(daq.DEFAULT_VID, daq.DEFAULT_PID)
    daq.open_port(port_name, daq.DEFAULT_BAUDRATE)

