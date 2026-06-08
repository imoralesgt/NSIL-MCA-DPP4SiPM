"""
Module: daq_api_validation.py
Description: Production testing and verification script for the DAQ/MCA API.
             Queries the system for the DAQ board and requests its firmware version.
"""

import sys
import logging
from core.daq_hw import DaqHw
from core.daq_commands import DaqCommands

def setup_validation_logging():
    """Configures the logging engine to display serial port activity to the console."""
    logging.basicConfig(
        level=logging.DEBUG,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        stream=sys.stdout
    )

def main():
    setup_validation_logging()
    logger = logging.getLogger("DAQ_VALIDATION")
    logger.info("Starting DAQ Hardware API Validation...")

    # 1. Initialize the hardware finder layer
    daq_finder = DaqHw()

    # 2. Automatically locate the device using default VID/PID attributes
    logger.info("Scanning for connected DAQ boards (VID: %s, PID: %s)...", 
                daq_finder.DEFAULT_VID, daq_finder.DEFAULT_PID)
    
    port_name = daq_finder.find_port(daq_finder.DEFAULT_VID, daq_finder.DEFAULT_PID)

    if not port_name:
        logger.error("No valid matching DAQ hardware found on this system. Check USB connection.")
        sys.exit(1)
        
    # Handle edge case where find_port might return a list of devices
    if isinstance(port_name, list):
        logger.warning("Multiple target DAQ devices detected. Using first node: %s", port_name[0])
        port_name = port_name[0]

    logger.info("DAQ device successfully discovered at: %s", port_name)

    # 3. Instantiate the High-Level API Front Facade
    # Passing minimum required parameters for the internal Dpp_Parameters tracker
    try:
        api = DaqCommands(
            port_name=port_name,
            baudrate=daq_finder.DEFAULT_BAUDRATE,
            sampling_rate=50e6,
            tau_d=1.145e-6,
            tau_r=0.220e-6
        )
        
        logger.info("API Controller successfully mounted.")
        print("-" * 60)

        # 4. Execute the verification transaction
        # This single line handles the open -> read -> close sequence automatically
        logger.info("Dispatching transaction request: 'get_version' ($GV)...")
        firmware_version = api.get_version()
        
        print("-" * 60)
        logger.info("Transaction complete! Hardware returned successfully.")
        print(f"\n>>> Verified DAQ Firmware Version: {firmware_version} <<<\n")

    except Exception as err:
        logger.exception("An unexpected fault occurred during the transaction cycle: %s", err)
        sys.exit(1)

if __name__ == "__main__":
    main()