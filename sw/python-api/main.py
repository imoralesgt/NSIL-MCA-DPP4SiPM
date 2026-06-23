"""
Example usage of the DAQ MCA API for the IAEA/NSIL DPP4SiPM DAQ/MCA board.
It exposes reliable control and data acquisition methods for any Python application
through a persistent serial connection.

This API uses `uv` as the default package manager. Check the `pyproject.toml` file
for more details on the requirements.

Usage:
    Check the `main()` function at the end of this document for an example of
    how to use the API.

Available methods in the API:
    For most of the applications, the following methods can be used to control and 
    acquire the data from the MCA board:
        - open(): Establishes a long-lived persistent connection session to the connected DAQ.
        - close(): Safely disconnects the active physical serial communications channel.
        - get_version(): Returns the firmware version of the connected DAQ.
        - get_serial(): Returns the serial number of the connected DAQ.
        - data_acquisition_start(): Starts the spectrum acquisition in the DAQ.
        - read_spectrum(): Reads the spectrum data from the DAQ.
        - timers_reset(): Resets the timers in the DAQ.
        - clear_spectrum(): Clears the spectrum data in the DAQ.
        - timers_read(): Reads simultaneously all the real- and live-time timer values in the DAQ.

    Advanced applications or customizations can leverage the following methods as well:
        - data_acquisition_stop(): Stops the spectrum acquisition in the DAQ.
        - read_oscilloscope(): Reads the waveforms from both scope channels in the DAQ.
        - set_dpp_params(submodule, parameters): Uploads the configuration parameters to a specific DPP submodule in the DAQ.
        - get_dpp_params(submodule): Queries active DPP register values from a specific sumbodule in the DAQ.
        - dpp_initialize(): Called on automatically during API initialization. Sends ALL the DPP modules configuration parameters to the DAQ.

Available constructor arguments for the API, types, and default values (see `dpp_parameters.py`):
    - tau_d : float,
    - tau_r : float,
    - shaper_s_tau_pk : float = 2.0e-6
    - shaper_s_tau_pk_top : float = 1.0e-6
    - shaper_f_tau_pk : float = 0.3e-6
    - shaper_f_tau_pk_top : float = 0
    - shaper_s_gain : float = 1.0
    - shaper_f_gain : float = 1.0
    - blr_s_threshold_high : float = 0.0
    - blr_s_threshold_low : float = -0.05
    - blr_s_threshold_gain : float = 2.5
    - blr_s_threshold_low_gain : float = 50.0
    - blr_s_enable : bool = True
    - blr_f_threshold_high : float = 0.0
    - blr_f_threshold_low : float = -0.05
    - blr_f_threshold_gain : float = 1.5
    - blr_f_threshold_low_gain : float = 2.0
    - blr_f_enable : bool = False
    - pkd_blanking_time_factor = 0.9
    - pkd_time_over_threshold_factor = 0.44
    - pur_guard_time_factor=1.5
    - pur_enable = True
    - pkd_s_x_min = 0.01
    - pkd_s_x_max = 1.99
    - pkd_f_x_min = 0.025
    - pkd_f_x_max = 1.957
    - invert_pulse : bool = False
    - smoothing_factor : int = 1
    - dc_offset : float = -0.77
    - poles : int = 2
    - tau_l : float = 50e-6
    - scope_bram_size : int = 2048
    - scope_threshold : float = 0.04
    - scope_delay : int = 1000
    - scope_enabled : bool = True
    - scope_clear : bool = True
    - scope_downsample : int = 1
    - scope_sampling_mode_flag : int = 1
    - scope_mux_ch1 : int = 3
    - scope_mux_ch2 : int = 1
    - timers_preset : int = 10000000
    - timers_auto_mode : bool = False
    - timers_a_live_time : bool = False
    - timers_b_live_time : bool = False
    - timers_c_live_time : bool = True
    - timers_a_enable : bool = True
    - timers_b_enable : bool = False
    - timers_c_enable : bool = True
    - timers_a_clear : bool = False
    - timers_b_clear : bool = False
    - timers_c_clear : bool = False
    - high_voltage : float = 0.0
    - vga_board_version : str = 'B'
    - vga_gain_fine : float = 1.0
    - vga_gain_coarse : float = 1.0

Revisions:
    1.0.0 - Initial release (2026-06-01) - I. Morales
"""

from __future__ import annotations
__version__ = "1.0.0"
__author__ = "I. Morales"
__date__ = "2026-06-10"

from core.daq_commands import DaqCommands # DAQ/MCA API library
from time import sleep # Specturm collection delay (native Python module)
from datetime import datetime # Used to record the timestamp in the SPE spectrum file
from tqdm import trange # Spectrum collection progress bar
import matplotlib.pyplot as plt  # Spectrum plot visualization

def get_spectrum(daq_instance : DaqCommands) -> list:
    """Example function on how to collect a spectrunm with the MCA/DAQ board.

    1. Clear the spectrum data 
    2. Reset the timers
    3. Start the data acquisition
    4. Wait for the spectrum to be collected
    5. Retrieve the collected spectrum data from the DAQ

    Args:
        daq_instance (DaqCommands): An instance of the DaqCommands class representing the DAQ/MCA board API.
    
    Returns:
        list: A list containing the collected spectrum data from the DAQ.
    """

    # 1. Cleat the spectrum data
    daq_instance.clear_spectrum()

    # 2. Reset the timers
    daq_instance.timers_reset()
    
    # 3. Start acquisition
    daq_instance.data_acquisition_start()

    # Getting the wait time based on the timers preset time. This is an optional
    # step. The collection could be running in a separate async thread as well.
    wait_time = int(daq_instance.timers_read()['preset']/1000) # Timers are in milliseconds
    print(f"Collection time: {wait_time} seconds")

    # 4. Wait the spectrum to be collected
    for _ in trange(wait_time, desc="Collecting spectrum"):
        _ = daq_instance.get_version() # Live heartbeat will trigger an exception if a hardware error is detected
        sleep(1.1)

    # 5. Retrieve the spectrum data from the DAQ
    spectrum = daq_instance.read_spectrum()

    return spectrum

def create_spe_file(file_path: str, spectrum: list, live_time: float, real_time: float) -> None:
    """
    Generates a standard ORTEC .Spe spectrum file.
    
    Args:
        file_path (str): Destination path for the output .Spe file.
        spectrum (list): List of integers representing counts per ADC channel.
        live_time (float): Live time of the measurement in seconds.
        real_time (float): Real time time of the measurement in seconds.
    """
    
    # Get the channel range (0 to N-1)
    first_channel = 0
    last_channel = len(spectrum) - 1
    
    with open(file_path, "w", encoding="ascii") as f:
        # File identification header
        f.write("$SPEC_ID:\n")
        f.write("Example spectrum from DPP4SiPM DAQ/MCA API\n")
        
        # Measurement date and time (Required format: MM/DD/YYYY HH:MM:SS)

        # Format date to standard SPE format: MM/DD/YYYY HH:MM:SS
        date_str = datetime.now().strftime("%m/%d/%Y %H:%M:%S")
        f.write("$DATE_MEA:\n")
        f.write(f"{date_str}\n")
        
        # Live time and Real time in seconds
        f.write("$MEAS_TIM:\n")
        f.write(f"{live_time:.2f} {real_time:.2f}\n")
        
        # Data channel bounds
        f.write("$DATA:\n")
        f.write(f"{first_channel} {last_channel}\n")
        
        # Counts per channel (one integer per line)
        for counts in spectrum:
            f.write(f"{int(counts)}\n")

        # Deafult calibration parameters
        f.write("$MCA_CAL:\n3\n0.000 1.000 0.000\n")

        # End of file marker
        f.write("$ENDRECORD:\n")


def plot_spectrum(spectrum : list) -> None:
    """Plots the energy spectrum data collected with the MCA/DAQ board.    
    """
    plt.style.use('ggplot')
    plt.figure(figsize=(10, 5))
    plt.plot(range(len(spectrum)), spectrum, label='MCA counts', linewidth=1.0)
    plt.title('Captured Energy Spectrum (NaI(Tl) SiPM)', fontsize=12, fontweight='bold')
    plt.xlabel('ADC Channel Bin Number', fontsize=10)
    plt.ylabel('Event Count (N)', fontsize=10)
    plt.yscale('log')
    plt.grid(True, linestyle='--', alpha=0.6)
    plt.xlim(0, 2048)
    plt.legend(loc='upper right')    
    plt.show()

def main():
    # Setup the DAQ/MCA board parameters. Some parameters are shown in the
    # example below. Refer to the documentation for more details.
    daq_api = DaqCommands(
        tau_d = 1.21e-6, # Decay time of the detector signal pulse shape
        tau_r = 0.206e-6, # Rise time of the detector signal pulse shape
        timers_preset = 120_000, # Spectrum collection time in MILLISECONDS. Based on Timer C (live time)
        timers_a_live_time = False, # Live time for timer A
        timers_c_live_time = True, # Live time for timer C
        shaper_s_tau_pk = 2.5e-6, # Peaking time of the slow pulse shaper
        shaper_s_tau_pk_top = 1.0e-6, # Peaking time of the top of the slow pulse shaper
        blr_s_threshold_gain = 2.95, # Baseline restorer (slow) threshold gain (baseline noise removal)
        vga_gain_coarse = 6.4, # Analog amplifier gain prior to the ADC input
        smoothing_factor = 2, # Averaging filter smoothing factor. Improves SNR prior to shaper.
        invert_pulse = False, # Invert the detector signal polarity
    )
    
    # Open the serial port channel through the DAQ/MCA API
    daq_api.open()

    # Get the DAQ/MCA board version and serial number just to check the connectivity
    daq_ver = daq_api.get_version()
    daq_sn  = daq_api.get_serial()

    print(f"Connected Device Firmware Version: {daq_ver}")
    print(f"Connected Device Serial Number: {daq_sn}")


    # Collect the spectrum from the DAQ/MCA board
    spectrum = get_spectrum(daq_api)
    
    # Print the timers data and spectrum statistics
    timers_data = daq_api.timers_read()
    total_counts = sum(spectrum)
    print(f"Timers data: {timers_data}")
    print(f"Total counts: {total_counts}")

    # Store the spectrum as an SPE file (timers are in milliseconds)
    print("Creating spectrum.spe file")
    create_spe_file("spectrum.spe", spectrum, timers_data['tmr_c']/1000.0, timers_data['tmr_a']/1000.0)
    
    # And plot the spectrum once it has been collected
    plot_spectrum(spectrum)

    daq_api.close()


if __name__ == "__main__":
    main()
