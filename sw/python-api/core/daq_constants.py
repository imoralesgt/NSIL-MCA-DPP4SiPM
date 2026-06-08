"""
Module: daq_constants.py
Description: Immutable enumerations and definitions for the DAQ/MCA API.
             The enum values match the specific documentation section indices.
             Deprecated modules 3.7 and 3.11 have been completely removed.
"""

from enum import Enum

class DaqCliCommands(Enum):
    """Enumeration of the low-level CLI command codes for the DAQ system."""
    GET_VERSION = "GV"
    GET_SERIAL = "SN"
    GET_DPP_PARAMS = "GP"
    SET_DPP_PARAMS = "SP"
    READ_TIMERS = "RT"
    READ_SPECTRUM = "RM"
    LOAD_SCOPE = "LS"
    DATA_ACQUISITION = "AQ"
    CLEAR_SPECTRUM = "CS"
    PING = "~~~"


class DppSubmodules(Enum):
    """Maps human-readable DPP modules to hardware documentation group IDs and hooks.
    
    Each tuple value contains: (group_index, library_getter_method_name).
    The group indices map explicitly to the document's hardware register addresses.
    """
    PULSE_SHAPER_SLOW = (1, "get_shaper_slow_params")          # Section 3.1
    PEAK_DETECTOR_SLOW = (2, "get_pk_detector_slow_params")    # Section 3.2
    SCOPE = (3, "get_scope_params")                            # Section 3.3
    TIMERS = (4, "get_timers_params")                          # Section 3.4
    BASELINE_RESTORER_SLOW = (5, "get_blr_slow_params")        # Section 3.5
    SCOPE_MUX = (6, "get_scope_mux_params")                    # Section 3.6
    # Section 3.7 DCS Slow is Deprecated (Omitted)
    FORMATTER = (8, "get_formatter_params")                    # Section 3.8
    PULSE_SHAPER_FAST = (9, "get_shaper_fast_params")          # Section 3.9
    BASELINE_RESTORER_FAST = (10, "get_blr_fast_params")       # Section 3.10
    # Section 3.11 DCS Fast is Deprecated (Omitted)
    PEAK_DETECTOR_FAST = (12, "get_pk_detector_fast_params")   # Section 3.12
    PILEUP_REJECTOR = (13, "get_pileup_rejector_params")       # Section 3.13
    HIGH_VOLTAGE = (14, "get_high_voltage_params")             # Section 3.14
    VARIABLE_GAIN_AMPLIFIER = (15, "get_vga_params")           # Section 3.15

    @property
    def group_index(self) -> int:
        """Returns the physical hardware command integer assignment identifier."""
        return self.value

    @property
    def getter_name(self) -> str:
        """Returns the matching serialization string method from dpp_parameters.py."""
        return self.value