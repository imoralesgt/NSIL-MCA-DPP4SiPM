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
import struct, logging, os, gzip, shutil
from logging.handlers import RotatingFileHandler
from contextlib import contextmanager
import time, sys, traceback
from typing import List, Tuple, Dict, Any

# Dedicated global logger for high-level operations and serial transactions
logger = logging.getLogger("DAQ_MCA_API")

LOG_DIR = "logs"
LOG_FILE = os.path.join(LOG_DIR, "daq_mca.log")
LOG_MAX_BYTES = 10 * 1024 * 1024  # split into a new file every 10 MB
LOG_BACKUP_COUNT = 100  # circular rotation: oldest rotated file is discarded past this count (1 GB of compressed logs max)

def _gzip_rotator(source: str, dest: str) -> None:
    """Compress a just-rotated log file with gzip and drop the plaintext copy."""
    with open(source, "rb") as f_in, gzip.open(dest, "wb") as f_out:
        shutil.copyfileobj(f_in, f_out)
    os.remove(source)

def _gzip_namer(name: str) -> str:
    return f"{name}.gz"

def _resolve_log_level(default: int = logging.INFO) -> int:
    """Log level is configurable via the DAQ_MCA_LOG_LEVEL env var (e.g. DEBUG, INFO, WARNING)."""
    level_name = os.environ.get("DAQ_MCA_LOG_LEVEL")
    if not level_name:
        return default
    return logging.getLevelNamesMapping().get(level_name.upper(), default)

os.makedirs(LOG_DIR, exist_ok=True)

_file_handler = RotatingFileHandler(
    filename=LOG_FILE,
    maxBytes=LOG_MAX_BYTES,
    backupCount=LOG_BACKUP_COUNT,
    encoding="utf-8",
)
_file_handler.rotator = _gzip_rotator
_file_handler.namer = _gzip_namer

logging.basicConfig(level=_resolve_log_level(),
                    format='%(asctime)s - %(levelname)s - %(name)s: %(message)s',
                    handlers=[_file_handler],
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

    @staticmethod
    def is_device_present() -> bool:
        """Lightweight autodiscovery presence check (issue #70): queries the
        DAQ board's known USB VID/PID the same way _find_port() does, but
        without constructing a full DaqCommands instance or opening a serial
        connection - suitable for cheap, frequent polling (e.g. a 1-second
        heartbeat loop) to detect a physical disconnect. Replaces the old
        approach of checking os.path.exists() on a specific port path
        remembered from a prior connection - detectors.json no longer stores
        a port name at all, so there's nothing to remember; autodiscovery is
        queried fresh every time.

        Returns:
            bool: True if at least one matching device is currently connected.
        """
        try:
            probe = DaqHw()
            port_list = probe.find_port(probe.DEFAULT_VID, probe.DEFAULT_PID)
            return bool(port_list)
        except Exception as e:
            logger.debug(f"Autodiscovery liveness check found no device: {e}")
            return False

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

    def get_serial_old(self) -> str:
        """Do not use this method until the MicroBlaze firmware has been updated.
        An alternative method has been implemented. Use `get_serial` instead.
        
        Retrieves the system serial number string from the hardware. It relies
        on the hard-coded serial number in the MicroBlaze firmware of the DAQ.

        
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
        """Stops the spectrum acquisition in the DAQ manually, without clearing
        the accumulated spectrum or the timer counters.

        FIXED: this previously sent flag "0", which per the $AQ command
        documentation actually means "Starts automatic acquisition. Cleans BRAM
        contents prior to starting." - i.e. a START-with-clear command, not a
        stop. Calling it after a genuine acquisition would silently wipe the
        just-collected spectrum and reset the timers, then immediately begin a
        NEW automatic acquisition cycle - explaining symptoms like a spectrum
        read back as all zeros, or live/real time stuck at a tiny fixed value
        regardless of the requested collection duration (whatever few hundred
        milliseconds elapsed between this call and the next read). Flag "2" is
        the documented manual stop with no clearing side effect.

        This is safe to call routinely as a normal stop operation (e.g. at the
        end of a survey/background/batch run) - it does not need to be reserved
        for whole-system shutdown.

        Returns:
            bool: True if the operation was successful
        """
        logging.info("Stopping data acquisition.")
        response = self._send_ascii_cmd(DaqCliCommands.DATA_ACQUISITION, "2")
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

    # =====================================================================
    # HIGH-LEVEL TIMERS DPP SUBMODULE API (issue #34)
    # =====================================================================
    # The methods below let application code query/update the Timers DPP
    # submodule (group 4: Preset + Ctrl_bits) WITHOUT requiring a full driver
    # reinitialization via the DppParameters/Dpp_Timers object layer. That
    # layer is reserved for one-time full-board programming (dpp_initialize);
    # these methods talk `$SP 4` / `$RT -1` directly instead, the same way
    # timers_read() and data_acquisition_start/stop already do, so application
    # code never needs to import or construct DppParameters/Dpp_Timers just to
    # change the collection duration or timer mode.
    #
    # Ctrl_bits bit layout (see daq_constants.py / hardware documentation,
    # DPP parameter group 4):
    #   bit 0       = run mode (0=manual, 1=auto). NOT hardware-implemented -
    #                 always forced to 0 (manual) by every method below.
    #   bit 2/3/4   = TMR C/B/A live-time select (1=live time, 0=real time)
    #   bit 5/6/7   = TMR C/B/A enable (1=enabled, 0=disabled)
    #   bit 8/9/10  = TMR C/B/A clear (pulse-triggered, NOT level-held - see
    #                 clear_timers() below)
    # =====================================================================

    def _set_bit(self, value: int, bit_index: int, bit_state: bool) -> int:
        """Sets or clears a single bit position within an integer bitmask value.

        Args:
            value (int): The original integer value.
            bit_index (int): Zero-indexed bit position to modify.
            bit_state (bool): True to set the bit to 1, False to clear it to 0.

        Returns:
            int: The updated integer value with the requested bit modified.
        """
        if bit_state:
            return value | (1 << bit_index)
        return value & ~(1 << bit_index)

    def get_timers_settings(self) -> Dict[str, Any]:
        """Reads the current Timers DPP submodule configuration (group 4)
        directly from the hardware via `$RT -1`, without requiring driver
        reinitialization.

        Decodes the Ctrl_bits register into individual per-timer live/real-time
        and enable flags, alongside the raw Preset value (ms).

        NOTE: The hardware does not implement an automatic acquisition run
        mode. 'run_mode' is always reported as 'manual', matching the value
        every setter in this API always writes back (see set_timers_run_mode).

        Returns:
            Dict[str, Any]: {
                "preset_ms": int,
                "run_mode": str,        # always "manual" - see set_timers_run_mode
                "tmr_a_live": bool,     # True = live time, False = real time
                "tmr_b_live": bool,
                "tmr_c_live": bool,
                "tmr_a_enabled": bool,
                "tmr_b_enabled": bool,
                "tmr_c_enabled": bool,
            }
        """
        logger.info("Retrieving high-level Timers DPP submodule configuration.")
        timers = self.timers_read()
        ctrl_bits = timers["ctrl_bits"]

        return {
            "preset_ms": timers["preset"],
            "run_mode": "manual",
            "tmr_a_live": bool(ctrl_bits & (1 << 4)),
            "tmr_b_live": bool(ctrl_bits & (1 << 3)),
            "tmr_c_live": bool(ctrl_bits & (1 << 2)),
            "tmr_a_enabled": bool(ctrl_bits & (1 << 7)),
            "tmr_b_enabled": bool(ctrl_bits & (1 << 6)),
            "tmr_c_enabled": bool(ctrl_bits & (1 << 5)),
        }

    def set_timers_preset(self, preset_ms: int) -> bool:
        """Updates ONLY the Preset register (Timer C collection window, in ms)
        on the Timers DPP submodule (group 4), without touching any other DPP
        submodule and without requiring driver reinitialization.

        Performs a read-modify-write: the current Ctrl_bits value is read live
        from the hardware via `$RT -1` and preserved as-is (aside from forcing
        the run-mode bit to manual), so any previously configured live/real-time
        or enable flags are left untouched.

        Args:
            preset_ms (int): Desired collection time / Timer C preset, in ms.

        Returns:
            bool: True if the operation was successful
        """
        current = self.timers_read()
        ctrl_bits = self._set_bit(current["ctrl_bits"], 0, False)  # force manual mode

        logger.info(f"Setting Timers preset to {preset_ms} ms (ctrl_bits preserved: {ctrl_bits}).")
        arguments = f"{DppSubmodules.TIMERS.group_index} {preset_ms} {ctrl_bits}"
        response = self._send_ascii_cmd(DaqCliCommands.SET_DPP_PARAMS, arguments)
        return f"!{DaqCliCommands.SET_DPP_PARAMS.value}" in response

    def set_timers_mode(self, tmr_a_live: bool = None, tmr_b_live: bool = None, tmr_c_live: bool = None) -> bool:
        """Updates ONLY the live-time/real-time selection bits for the requested
        timers on the Timers DPP submodule (group 4), without touching Preset,
        the enable bits, or any other DPP submodule.

        Performs a read-modify-write against the hardware (`$RT -1`): any
        argument left as None keeps that timer's current live/real-time
        setting unchanged.

        Args:
            tmr_a_live (bool, optional): True = live time, False = real time.
                None (default) leaves Timer A's current setting unchanged.
            tmr_b_live (bool, optional): Same semantics, for Timer B.
            tmr_c_live (bool, optional): Same semantics, for Timer C.

        Returns:
            bool: True if the operation was successful
        """
        current = self.timers_read()
        ctrl_bits = current["ctrl_bits"]

        if tmr_c_live is not None:
            ctrl_bits = self._set_bit(ctrl_bits, 2, tmr_c_live)
        if tmr_b_live is not None:
            ctrl_bits = self._set_bit(ctrl_bits, 3, tmr_b_live)
        if tmr_a_live is not None:
            ctrl_bits = self._set_bit(ctrl_bits, 4, tmr_a_live)

        ctrl_bits = self._set_bit(ctrl_bits, 0, False)  # force manual mode

        logger.info(f"Setting Timers mode -> tmr_a_live={tmr_a_live}, tmr_b_live={tmr_b_live}, tmr_c_live={tmr_c_live} (ctrl_bits={ctrl_bits}).")
        arguments = f"{DppSubmodules.TIMERS.group_index} {current['preset']} {ctrl_bits}"
        response = self._send_ascii_cmd(DaqCliCommands.SET_DPP_PARAMS, arguments)
        return f"!{DaqCliCommands.SET_DPP_PARAMS.value}" in response

    def set_timers_enable(self, tmr_a: bool = None, tmr_b: bool = None, tmr_c: bool = None) -> bool:
        """Enables or disables the requested timers on the Timers DPP submodule
        (group 4), without touching Preset, the live/real-time bits, or any
        other DPP submodule.

        Performs a read-modify-write against the hardware (`$RT -1`): any
        argument left as None keeps that timer's current enable state
        unchanged.

        Note: Timer C must remain enabled for spectrum collection to function
        (the hardware documentation states it "must always be enabled"). This
        method does not enforce that constraint - the caller is responsible
        for it.

        Args:
            tmr_a (bool, optional): True = enabled, False = disabled.
                None (default) leaves Timer A's current state unchanged.
            tmr_b (bool, optional): Same semantics, for Timer B.
            tmr_c (bool, optional): Same semantics, for Timer C.

        Returns:
            bool: True if the operation was successful
        """
        current = self.timers_read()
        ctrl_bits = current["ctrl_bits"]

        if tmr_c is not None:
            ctrl_bits = self._set_bit(ctrl_bits, 5, tmr_c)
        if tmr_b is not None:
            ctrl_bits = self._set_bit(ctrl_bits, 6, tmr_b)
        if tmr_a is not None:
            ctrl_bits = self._set_bit(ctrl_bits, 7, tmr_a)

        ctrl_bits = self._set_bit(ctrl_bits, 0, False)  # force manual mode

        logger.info(f"Setting Timers enable -> tmr_a={tmr_a}, tmr_b={tmr_b}, tmr_c={tmr_c} (ctrl_bits={ctrl_bits}).")
        arguments = f"{DppSubmodules.TIMERS.group_index} {current['preset']} {ctrl_bits}"
        response = self._send_ascii_cmd(DaqCliCommands.SET_DPP_PARAMS, arguments)
        return f"!{DaqCliCommands.SET_DPP_PARAMS.value}" in response

    def clear_timers(self, tmr_a: bool = False, tmr_b: bool = False, tmr_c: bool = False) -> bool:
        """Issues a one-shot clear pulse to the requested timer counters on the
        Timers DPP submodule (group 4), resetting them to 0 without touching
        Preset, the live/real-time bits, the enable bits, or any other DPP
        submodule.

        The clear bits are pulse-triggered (not level-held): this method
        performs two back-to-back writes internally - first setting the
        requested clear bit(s) to 1, then immediately writing them back to 0 -
        so the caller only needs to invoke this once per clear operation. No
        delay is required between the two writes: UART transmission time is
        far slower than the hardware's internal processing time, so the
        second write is guaranteed to land after the pulse has registered.

        Args:
            tmr_a (bool): Pulse-clear Timer A. Default False (leave untouched).
            tmr_b (bool): Pulse-clear Timer B. Default False (leave untouched).
            tmr_c (bool): Pulse-clear Timer C. Default False (leave untouched).

        Returns:
            bool: True if BOTH writes (pulse-high and pulse-low) succeeded.
        """
        current = self.timers_read()
        preset = current["preset"]
        base_ctrl_bits = self._set_bit(current["ctrl_bits"], 0, False)  # force manual mode

        # First write: pulse the requested clear bit(s) high
        pulse_high = base_ctrl_bits
        if tmr_c: pulse_high = self._set_bit(pulse_high, 8, True)
        if tmr_b: pulse_high = self._set_bit(pulse_high, 9, True)
        if tmr_a: pulse_high = self._set_bit(pulse_high, 10, True)

        logger.info(f"Pulsing Timers clear -> tmr_a={tmr_a}, tmr_b={tmr_b}, tmr_c={tmr_c} (ctrl_bits={pulse_high}).")
        arguments_high = f"{DppSubmodules.TIMERS.group_index} {preset} {pulse_high}"
        response_high = self._send_ascii_cmd(DaqCliCommands.SET_DPP_PARAMS, arguments_high)
        success_high = f"!{DaqCliCommands.SET_DPP_PARAMS.value}" in response_high

        # Second write: immediately release the clear bit(s) back to 0
        arguments_low = f"{DppSubmodules.TIMERS.group_index} {preset} {base_ctrl_bits}"
        response_low = self._send_ascii_cmd(DaqCliCommands.SET_DPP_PARAMS, arguments_low)
        success_low = f"!{DaqCliCommands.SET_DPP_PARAMS.value}" in response_low

        return success_high and success_low

    def set_timers_run_mode(self, manual: bool = True) -> bool:
        """PLACEHOLDER - not backed by hardware in the current firmware revision.

        The DPP4SiPM board does not implement an automatic acquisition run
        mode; this driver always operates the Timers submodule in manual mode
        (Ctrl_bits bit 0 = 0), regardless of what is requested here. This
        method exists so application code has a stable entry point to call
        once a future hardware revision implements auto mode, without needing
        further API changes.

        Args:
            manual (bool): Intended run mode. True = manual (the only mode
                currently supported). False (auto) is accepted but ignored,
                and logs a warning.

        Returns:
            bool: True if the (manual-mode-only) write succeeded.
        """
        if not manual:
            logger.warning("Automatic acquisition run mode was requested but is not implemented in the current firmware. Falling back to manual mode.")

        current = self.timers_read()
        ctrl_bits = self._set_bit(current["ctrl_bits"], 0, False)  # always manual

        logger.info("Setting Timers run mode -> manual (auto mode not hardware-supported).")
        arguments = f"{DppSubmodules.TIMERS.group_index} {current['preset']} {ctrl_bits}"
        response = self._send_ascii_cmd(DaqCliCommands.SET_DPP_PARAMS, arguments)
        return f"!{DaqCliCommands.SET_DPP_PARAMS.value}" in response

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