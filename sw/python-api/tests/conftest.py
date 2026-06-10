"""
Module: tests.conftest
Location: sw/api/tests/conftest.py
Description: PyTest shared fixtures for Hardware-in-the-Loop (HIL) validation.
             Automatically discovers physical connected DAQ/MCA devices.
"""

import pytest
from core.daq_hw import DaqHw

@pytest.fixture(scope="session")
def target_port():
    """Discovers and returns the active serial port name of the connected DAQ.

    Skips the HIL test session early if no hardware is physically present.
    """
    finder = DaqHw()
    
    # Scan system interfaces for the FTDI JTAG chip of the Cmod A7-35T board (VID: 0403, PID: 6010)
    port_name = finder.find_port(finder.DEFAULT_VID, finder.DEFAULT_PID)
    
    if not port_name:
        pytest.skip(
            f"HIL Setup Missing: No DAQ hardware found matching "
            f"VID {finder.DEFAULT_VID} and PID {finder.DEFAULT_PID}. Skipping HIL test suite."
        )
        
    if isinstance(port_name, list):
        # Fallback to the first available hardware link if multiple are found
        port_name = port_name[0]
        
    return port_name
