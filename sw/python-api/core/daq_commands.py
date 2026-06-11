"""
Module: daq_commands.py
Description: High-level abstraction API layer for controlling and acquiring
             data from the IAEA/NSIL DPP4SiPM DAQ/MCA board.

Revisions:
    1.0.0 - Initial release (2026-06-01) - I. Morales
"""

from __future__ import annotations

__all__ = ["DaqCommands", "DaqException", "DaqUnknownCommandException", "DaqInvalidParameterException"]
__version__ = "1.0.0"
__author__ = "I. Morales"
__date__ = "2026-06-10"

from core.daq_hw import DaqHw
from core.dpp_parameters import DppParameters
from core.daq_constants import DaqCliCommands, DppSubmodules
from enum import Enum
import struct, logging
from contextlib import contextmanager
import time, sys, traceback
from typing import List, Tuple, Dict, Any

# Dedicated global logger for high-level operations and serial transactions
logger = logging.getLogger("DAQ_MCA_API")
logging.basicConfig(filename='daq_mca.log',
                    encoding='utf-8',
                    level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(name)s: %(message)s',
                    force=True)

# Recording unhandled exceptions in log file
def log_except_hook(exctype, value, tb):
    text = "".join(traceback.format_exception(exctype, value, tb))
    logger.error(f"Unhandled exception:\n{text}")

    # Keep showning the original exception in the console
    sys.__excepthook__(exctype, value, tb)

sys.excepthook = log_except_hook


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

    def __init__(self, port_name: str = None, baudrate: int = 115200, 
                 sampling_rate: float = 50e6, tau_d: float = 1.145e-6, tau_r: float = 0.220e-6, 
                 **dpp_kwargs):
        """Prepares session state elements and encapsulates the DPP parameter library."""
        self.daq = DaqHw() 

        if port_name is None:
            logger.info("No serial port name provided, attempting to auto-discover...")
            port_name = self._find_port()
            logger.info(f"Discovered DAQ board at port {port_name}")
        
        self.port_name = port_name
        self.baudrate = baudrate
        serial_number = self.daq.retrieve_serial(port_name)
        self.__set_sn(serial_number)

        logger.info(f"DAQ board serial number: {serial_number}")
        
        logger.info("Initializing underlying Dpp_Parameters submodules...")
        logger.debug("[DEBUG START]: Passing arguments to Dpp_Parameters constructor...")
        logger.debug(f"[DEBUG PARAM]: sampling_rate={sampling_rate}, tau_d={tau_d}, tau_r={tau_r}")
        logger.debug(f"[DEBUG KWARGS]: {dpp_kwargs}")
        
        try:
            self.dpp = DppParameters(
                sampling_rate=sampling_rate,
                tau_d=tau_d,
                tau_r=tau_r,
                **dpp_kwargs
            )
            logger.debug("[DEBUG END]: DppParameters object created successfully!")
        except Exception as e:
            logger.error(f"[DEBUG FAULT]: DppParameters constructor threw an exception: {e}")
            raise e
        
        self.dpp_initialize()
        logger.info("Dpp_Parameters submodules initialized successfully!")
        
    def _find_port(self):
        """Discovers and returns the active serial port name of the connected DAQ.
        
        Args:
            None

        Returns:
            str: The serial port name

        Raises:
            DaqException: If no DAQ hardware is found

        """
        port_name_list = self.daq.find_port(self.daq.DEFAULT_VID, self.daq.DEFAULT_PID)

        if not port_name_list:
            raise DaqException(f"No DAQ hardware found matching VID {self.daq.DEFAULT_VID} and PID {self.daq.DEFAULT_PID}.")

        # Falling back to the first available hardware device if multiple are found
        if isinstance(port_name_list, list):
            port_name = port_name_list[0]

            return port_name
        
        return None

    def open(self, boot_delay: float = 0.5, timeout: float = 0.8):
        """Establishes a long-lived persistent connection session to the target DAQ/MCA hardware board.
        
        Args:
            boot_delay (float): Number of seconds to wait for the DAQ to boot up.
            timeout (float): Number of seconds to wait for a response from the DAQ.
        """
        if not self.daq.is_open:
            logger.info(f"[SESSION]: Opening persistent serial port channel -> {self.port_name}")
            self.daq.open_port(self.port_name, self.baudrate)
            self.daq.timeout = timeout
            
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

    def __set_sn(self, serial_number: str):
        """Sets the serial number of the device based on the scanned s/n from the USB VID/PID.
        This method overrides the serial number setting/getting originally present in the 
        documentation.

        Args:
            serial_number (str): The serial number of the device
        """
        self.__serial_number = serial_number

    def __get_serial(self) -> str:
        """Retrieves the serial number of the connected device. This method must be called
        only after the device name and serial number has been obtained with `find_port()`
        or `get_serial()` methods from the `DaqHw`class.

        Returns:
            str: The serial number of the device
        """
        return self.__serial_number

    @contextmanager
    def _connection_transaction(self):
        """Context manager hook isolating the active connection lifecycle state.
        
        Raises:
            Exception: If an exception is encountered during the transaction
        """
        self.open()  # Ensure connection is up and hot
        try:
            yield self.daq
        except Exception as e:
            logger.error(f"Transaction communication breakdown encountered: {e}")
            raise e

    def _send_ascii_cmd(self, cmd: DaqCliCommands, params: str = "") -> str:
        """Transmits standard text command frames within a live port instance transaction.
        
        Args:
            cmd (DaqCliCommands): The command code to send. See `DaqCliCommands` in `daq_constants.py`.
            params (str): The command parameters to send. See the documentation for the available arguments.

        Returns:
            str: The response received from the DAQ
            
        Raises:
            Exception: If an error is encountered during the transaction
        """
        cmd_code = cmd.value
        if cmd == DaqCliCommands.PING:
            packet_str = f"{cmd_code}\r"
        else:
            param_space = " " if params else ""
            packet_str = f"${cmd_code}{param_space}{params}\r"

        with self._connection_transaction() as active_bus:
            logger.info("[TX RAW BUS]: Sending packet -> %r", packet_str)
            active_bus.write(packet_str.encode('ascii'))

            logger.info(f"[RX RAW BUS]: Awaiting reply from DAQ/MCA board (timeout= {self.daq.timeout} s)...")
            response_bytes = active_bus.read_until(b'\n\r')

            response = response_bytes.decode('ascii').strip()
            logger.debug("[SERIAL BUS <- RX RAW LINE]: %r", response_bytes)

        if not response:
            raise DaqException(f"Communication Timeout: No response received from DAQ/MCA board for command '{cmd_code}'.")

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

    def __ping(self) -> bool: ## Not implemented in hardware yet
        """Performs live diagnostic heartbeat checking."""
        response = self._send_ascii_cmd(DaqCliCommands.PING)
        return DaqCliCommands.PING.value in response

    def get_version(self) -> str:
        """Retrieves the system firmware version string from the hardware.
        
        Returns:
            str: The firmware version string
        """
        logging.info("Retrieving DAQ firmware version.")
        response = self._send_ascii_cmd(DaqCliCommands.GET_VERSION)
        return response.replace(f"!{DaqCliCommands.GET_VERSION.value}", "").strip()

    def _get_serial_old(self) -> str:
        """Retrieves the system serial number string from the hardware.
        
        Returns:
            str: The serial number of the MCA board
        """
        logging.info("Retrieving DAQ serial number.")
        response = self._send_ascii_cmd(DaqCliCommands.GET_SERIAL)
        return response.replace(f"!{DaqCliCommands.GET_SERIAL.value}", "").strip()
    
    def get_serial(self) -> str:
        """Returns the serial number retrieved from the onboard FTDI UART chip in the
        constructor. This method overrides the `_get_serial_old` method, which relied
        on a hard-coded serial number in the MicroBlaze firmware of the DAQ.

        Returns:
            str: The serial number of the MCA board
        """
        logging.info("Retrieving the DAQ serial number from the onboard FTDI UART chip.")
        return self.__get_serial()

    def data_acquisition_start(self) -> bool:
        """Starts the spectrum acquisition in the DAQ. This method should be
        called once to start the data acquisition process. For a precise
        spectrum acquisition time, leverage the timers to set the desired
        live or real time collection time. 

        Avoid using the `data_acquisition_stop` method, since it will also
        clear the spectrum data. 
        
        The spectrum can be safely collected while the acquisition
        is in progress.
        
        Returns:
            bool: True if the operation was successful
        """
        logging.info("Starting data acquisition.")
        response = self._send_ascii_cmd(DaqCliCommands.DATA_ACQUISITION, "1")
        return response is not None

    def data_acquisition_stop(self) -> bool:
        """Stops the spectrum acquisition in the DAQ. Spectrum
        data is cleared in the process. For a precise stop, configure
        the timers to the desired live or real time collection time.

        Use this method only if the whole system is meant to be stopped, 
        such as when shutting down the system (not required) or fine-tuning
        power saving features. Do not use this method otherwise.
        
        Returns:
            bool: True if the operation was successful
        """
        logging.info("Stopping data acquisition.")
        response = self._send_ascii_cmd(DaqCliCommands.DATA_ACQUISITION, "0")
        return response is not None

    def timers_reset(self) -> bool:
        """Resets the timers in the DAQ. This method should be called before
        starting the data acquisition process.

        Returns:
            bool: True if the operation was successful
        """
        logging.info("Resetting timers.")
        response = self._send_ascii_cmd(DaqCliCommands.DATA_ACQUISITION, "4")
        return response is not None

    def clear_spectrum(self, segment_index: int = 0) -> bool:
        """Erases memory contents of the histogram.
        
        Args:
            segment_index (int): Segment index to clear. Default is 0. The 
                current firmware version only supports this segment, anyways.
        
        Returns:
            bool: True if the spectrum clearing operation was successful
        """
        logging.info(f"Clearing spectrum segment with base address: {segment_index}.")
        response = self._send_ascii_cmd(DaqCliCommands.CLEAR_SPECTRUM, str(segment_index))
        return f"!{DaqCliCommands.CLEAR_SPECTRUM.value}" in response

    def dpp_initialize(self) -> bool:
        """Initializes all the DPP submodules in the DAQ with the provided
        constructor arguments.
        
        Returns:
            bool: True if the DPP initialization was successful
        """
        logger.info("Initializing pulse shaper slow")
        if not self.set_dpp_params(DppSubmodules.PULSE_SHAPER_SLOW):
            raise DaqException("DPP initialization failed: Pulse Shaper Slow module could not be configured")
        logger.info("DPP: Pulse shaper slow initialization OK.")

        logger.info("Initializing peak detector slow")
        if not self.set_dpp_params(DppSubmodules.PEAK_DETECTOR_SLOW):
            raise DaqException("DPP initialization failed: Peak Detector Slow module could not be configured")
        logger.info("DPP: Peak detector slow initialization OK.")

        logger.info("Initializing oscilloscope")
        if not self.set_dpp_params(DppSubmodules.SCOPE):
            raise DaqException("DPP initialization failed: Oscilloscope module could not be configured")
        logger.info("DPP: Oscilloscope initialization OK.")

        logger.info("Initializing timers")
        if not self.set_dpp_params(DppSubmodules.TIMERS):
            raise DaqException("DPP initialization failed: Timers module could not be configured")
        logger.info("DPP: Timers initialization OK.")

        logger.info("Initializing baseline restorer slow")
        if not self.set_dpp_params(DppSubmodules.BASELINE_RESTORER_SLOW):
            raise DaqException("DPP initialization failed: Baseline Restorer Slow module could not be configured")
        logger.info("DPP: Baseline restorer slow initialization OK.")

        logger.info("Initializing scope mux")
        if not self.set_dpp_params(DppSubmodules.SCOPE_MUX):
            raise DaqException("DPP initialization failed: Scope Mux module could not be configured")
        logger.info("DPP: Scope Mux initialization OK.")

        logger.info("Initializing formatter")
        if not self.set_dpp_params(DppSubmodules.FORMATTER):
            raise DaqException("DPP initialization failed: Formatter module could not be configured")
        logger.info("DPP: Formatter initialization OK.")

        logger.info("Initializing pulse shaper fast")
        if not self.set_dpp_params(DppSubmodules.PULSE_SHAPER_FAST):
            raise DaqException("DPP initialization failed: Pulse Shaper Fast module could not be configured")
        logger.info("DPP: Pulse shaper fast initialization OK.")

        logger.info("Initializing baseline restorer fast")
        if not self.set_dpp_params(DppSubmodules.BASELINE_RESTORER_FAST):
            raise DaqException("DPP initialization failed: Baseline Restorer Fast module could not be configured")
        logger.info("DPP: Baseline restorer fast initialization OK.")

        logger.info("Initializing peak detector fast")
        if not self.set_dpp_params(DppSubmodules.PEAK_DETECTOR_FAST):
            raise DaqException("DPP initialization failed: Peak Detector Fast module could not be configured")
        logger.info("DPP: Peak detector fast initialization OK.")

        logger.info("Initializing pileup rejector")
        if not self.set_dpp_params(DppSubmodules.PILEUP_REJECTOR):
            raise DaqException("DPP initialization failed: Pileup Rejector module could not be configured")
        logger.info("DPP: Pileup rejector initialization OK.")

        logger.info("Initializing variable gain amplifier (VGA)")
        if not self.set_dpp_params(DppSubmodules.VARIABLE_GAIN_AMPLIFIER):
            raise DaqException("DPP initialization failed: Variable Gain Amplifier (VGA) module could not be configured")
        logger.info("DPP: Variable gain amplifier (VGA) initialization OK.")

        return True

    def set_dpp_params(self, submodule: DppSubmodules, dpp_instance: DppParameters = None) -> bool:
        """Uploads pre-calculated 32-bit unsigned parameters to hardware registers in the DAQ.

        Args:
            submodule (DppSubmodules): Target hardware register block enum member
              (PULSE_SHAPER_SLOW, TIMERS, etc.).
            dpp_instance (DppParameters, optional): Only if a a newly instantiated parameters
              context with pre-calculated values is required. Do not pass this argument otherwise.

        Returns:
            bool: True if the operation was successful
        """
        if dpp_instance is not None:
            self.dpp = dpp_instance

        getter_func = getattr(self.dpp, submodule.getter_name, None)
        if not getter_func:
            raise NotImplementedError(f"Getter method '{submodule.getter_name}' missing in library backend.")
        
        # Invoke the correct '_daq' layout array retrieval function
        parameter_data = getter_func()
        
        # Handle dict value collection (params_***) or pass down direct lists (params_***_daq) safely
        if isinstance(parameter_data, dict):
            register_array = list(parameter_data.values())
        else:
            register_array = list(parameter_data)

        # Serialize the integer values into a space-delimited text sequence
        serialized_string = " ".join(str(int(reg_val)) for reg_val in register_array)
        arguments = f"{submodule.group_index} {serialized_string}"

        logger.info(f"Setting DPP parameters for submodule: {submodule.name}, values: {serialized_string}")
        response = self._send_ascii_cmd(DaqCliCommands.SET_DPP_PARAMS, arguments)
        return f"!{DaqCliCommands.SET_DPP_PARAMS.value}" in response


    def get_dpp_params(self, submodule: DppSubmodules) -> List[int]:        
        """Queries active DPP register values from the DAQ.

        Args:
            submodule (DppSubmodules): Target hardware register block enum member
              (PULSE_SHAPER_SLOW, TIMERS, etc.). See `DppSubmodules` in
              `daq_constants.py`.

        Returns:
            List[int]: List of 32-bit unsigned integer values
        """
        logger.info(f"Retrieving DPP parameters for submodule: {submodule.name}")
        response = self._send_ascii_cmd(DaqCliCommands.GET_DPP_PARAMS, str(submodule.group_index))
        payload_data = response.replace(f"!{DaqCliCommands.GET_DPP_PARAMS.value}", "").strip()
        return [int(reg_str) for reg_str in payload_data.split()]
    
    def timers_read(self) -> Dict[str, int]:
        """Reads simultaneously all the real-time timer values in the DAQ.

        The timers measure the collection time of the spectrum (histogram).
        Three timers are available: A, B, and C. Each timer can be configured
        to count real time or live time. They can be disabled or enabled individually.
        Notice that **Timer C** controls the collection time and must be always enabled.

        Preset time is the duration of the spectrum collection window.
        It is tied to the **Timer C** value, which can be configured as a
        real-time or live-time timer.
        
        Returns:
            Dict[str, int]: Dictionary containing the timer values.
        """
        logging.info("Reading timer values from DAQ.")
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
        """Reads the waveforms datafrom the DAQ inside an active transaction window.
        Delivers both channels (CH1, CH2) data simultaneously as a signed integer each.

        Returns:
            Tuple[List[int], List[int]]: Tuple containing the waveform data for both channels
        
        Raises:
            DaqException: If the scope capture fails
        """
        packet = f"${DaqCliCommands.LOAD_SCOPE.value}\r"
        
        logger.info("Retrieveing oscilloscope trace capture.")
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
        """Reads the spectrum data from the DAQ/MCA.
        
        Args:
            base_address (int, optional): Base address to start reading from. Defaults to 0.
                The current firmware version only supports this segment, anyways.
        
        Returns:
            List[int]: List of 32-bit unsigned integer values as the uncalibrated the spectrum

        Raises:
            DaqException: If the spectrum read operation fails
        """
        packet = f"${DaqCliCommands.READ_SPECTRUM.value} {base_address}\r"
        
        logger.info("Retrieveing spectrum from DAQ.")
        with self._connection_transaction() as active_bus:
            logger.info("[TX RAW BUS]: Sending spectrum request -> %r", packet)
            active_bus.write(packet.encode('ascii'))

            header = active_bus.read_until(b'\n\r')
            if b"!R" not in header:
                raise DaqException("Synchronization error: Text stream header mismatch during spectrum capture.")

            raw_binary = active_bus.read(self.MCA_BINS * self.BYTES_IN_WORD)
            active_bus.read_until(b'\n\r')  # Flush final bounding indicators

            logger.debug("[RX RAW BUS]: Received spectrum data -> %r", raw_binary)
            logger.debug(f"[RX RAW BUS]: Data length: {len(raw_binary)} bytes")

        return list(struct.unpack(f"<{self.MCA_BINS}I", raw_binary))
    
if __name__ == '__main__':
    daq_api = DaqCommands()
    daq_api.open()
    logging.info(f"Running API test. DAQ firmware version: {daq_api.get_version()}")
    daq_api.close()
