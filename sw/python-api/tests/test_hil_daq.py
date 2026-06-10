"""
Module: tests.test_hil_daq
Location: sw/api/tests/test_hil_daq.py
Description: Hardware-in-the-Loop (HIL) integration test suite running
             with theconnected physical DAQ/MCA boards. Enforces sequential 
             parameter streaming and exports a plot of the captured spectrum
             and oscilloscope traces.
Notes: 
    - To execute this test suite, the DAQ/MCA board must be connected to the host.
    - To run (from the python-api root): `uv run python -m pytest tests/test_hil_daq.py -v -s --log-cli-level=INFO`
"""

import pytest, time, logging, os
import matplotlib.pyplot as plt  # Import for automated spectrum visualization
from tqdm import trange
from core.daq_constants import DppSubmodules
from core.daq_commands import DaqCommands

logger = logging.getLogger("DAQ_HIL_TEST")
plt.style.use('ggplot') # Nice looking plots :)
SPECTRUM_COLLECTION_TIME = 100


@pytest.fixture
def daq_api(target_port):
    """Initializes and opens the persistent hardware connection for testing."""
    api = DaqCommands(
        port_name=target_port,
        baudrate=115200,
        sampling_rate=50e6,
        tau_d=1.21e-6,
        tau_r=0.206e-6,
        poles=2,
        shaper_s_gain=1.0,
        shaper_f_gain=1.0,
        blr_s_threshold_gain = 4.0,
        vga_gain_coarse = 12,
        dc_offset = -0.03,
        invert_pulse = False,
        smoothing_factor = 4,
        scope_mux_ch1 = 3,
        scope_mux_ch2 = 1,
    )
    # Open connection and handle FTDI POR boot loader and FPGA bitstream settling time
    api.open(boot_delay=0.5)
    yield api
    api.close()


def test_hil_phase1_diagnostic_handshake(daq_api):
    """HIL Test: Verifies identity headers without executing a ping command."""
    version = daq_api.get_version()
    assert isinstance(version, str) and len(version) > 0
    logger.info(f"Connected Device Firmware Version: {version}", )
    
    serial_number = daq_api.get_serial()
    assert isinstance(serial_number, str) and len(serial_number) > 0
    logger.info(f"Connected Device Serial Number: {serial_number}")


def test_hil_phase2_sequential_parameter_stream(daq_api):
    """HIL Test: Streams physical DPP configuration settings sequentially to the DAQ/MCA."""
    logger.info("PHASE 2: Streaming DPP parameter values sequentially to hardware...")

    assert daq_api.set_dpp_params(DppSubmodules.PULSE_SHAPER_SLOW) is True
    logger.info("Streamed Group 1: Slow Pulse Shaper parameters uploaded.")

    assert daq_api.set_dpp_params(DppSubmodules.PEAK_DETECTOR_SLOW) is True
    logger.info("Streamed Group 2: Slow Peak Detector parameters uploaded.")

    assert daq_api.set_dpp_params(DppSubmodules.SCOPE) is True
    logger.info("Streamed Group 3: Oscilloscope parameters uploaded.")

    assert daq_api.set_dpp_params(DppSubmodules.TIMERS) is True
    logger.info("Streamed Group 4: Timers configuration parameters uploaded.")

    assert daq_api.set_dpp_params(DppSubmodules.BASELINE_RESTORER_SLOW) is True
    logger.info("Streamed Group 5: Slow Baseline Restorer parameters uploaded.")

    assert daq_api.set_dpp_params(DppSubmodules.SCOPE_MUX) is True
    logger.info("Streamed Group 6: Scope Mux parameters uploaded.")

    assert daq_api.set_dpp_params(DppSubmodules.FORMATTER) is True
    logger.info("Streamed Group 8: Formatter Preprocessing module parameters uploaded.")

    assert daq_api.set_dpp_params(DppSubmodules.PULSE_SHAPER_FAST) is True
    logger.info("Streamed Group 9: Fast Pulse Shaper parameters uploaded.")

    assert daq_api.set_dpp_params(DppSubmodules.BASELINE_RESTORER_FAST) is True
    logger.info("Streamed Group 10: Fast Baseline Restorer parameters uploaded.")

    assert daq_api.set_dpp_params(DppSubmodules.PEAK_DETECTOR_FAST) is True
    logger.info("Streamed Group 12: Fast Peak Detector parameters uploaded.")

    assert daq_api.set_dpp_params(DppSubmodules.PILEUP_REJECTOR) is True
    logger.info("Streamed Group 13: Pileup Rejector parameters uploaded.")

    assert daq_api.set_dpp_params(DppSubmodules.VARIABLE_GAIN_AMPLIFIER) is True
    logger.info("Streamed Group 15: Variable-Gain Amplifier (VGA) parameters uploaded.")


def test_hil_phase3_acquisition_and_streaming(daq_api):
    """HIL Test: Resets counters, activates acquisition run states, and collects binary buffers,
    including the energy spectrum and the dual-channel oscilloscope traces.
    
    Generates and saves a plot of the retrieved spectrum histogram data and the oscilloscope.
    """
    logger.info("PHASE 3: Initiating data acquisition routines on configured hardware...")

    # 1. Clear active histogram banks and reset timers
    assert daq_api.clear_spectrum(segment_index=0) is True
    assert daq_api.timers_reset() is True
    logger.info("Spectrum histogram and timers cleared.")

    # 2. Trigger active hardware spectrum acquisition
    assert daq_api.data_acquisition_start() is True
    logger.info("Spectrum acquisition started. Capturing signals...")

    # 3. Poll active timer statistics mid-run
    timer_metrics = daq_api.timers_read()
    assert isinstance(timer_metrics, dict)
    logger.info(f"Fetched active hardware run counters: {timer_metrics}")

    # 4. Collect the spectrum for the designated duration in `SPECTRUM_COLLECTION_TIME`
    logger.info(f"Collecting spectrum for {SPECTRUM_COLLECTION_TIME} seconds.")
    for i in trange(SPECTRUM_COLLECTION_TIME, desc="Collecting spectrum...", unit="s"):
        time.sleep(1)

    # 5. Poll again the timer statistics mid-run
    timer_metrics = daq_api.timers_read()
    assert isinstance(timer_metrics, dict)
    logger.info(f"Fetched active hardware run counters: {timer_metrics}", )

    # 6. Extract multi-channel analyzer spectrum data points (Exactly 2048 bins / 8KB)
    spectrum = daq_api.read_spectrum(base_address=0)
    assert len(spectrum) == 2048
    logger.info("Successfully fetched and unpacked 2048 spectrum channels from BRAM.")

    # 7. Stop spectrum acquisition safely before streaming out data blocks
    assert daq_api.data_acquisition_stop() is True
    logger.info("Spectrum acquisition gate closed.")

    # 8. AUTOMATED HIL VISUALIZATION: Plot the retrieved MCA spectrum histogram
    logger.info("Generating and saving visual chart representation of the MCA spectrum...")
    try:
        plt.figure(figsize=(10, 5))
        plt.plot(range(len(spectrum)), spectrum, label='MCA counts', linewidth=1.0)
        plt.title('Hardware-in-the-Loop (HIL) - Captured Energy Spectrum (NaI(Tl) SiPM)', fontsize=12, fontweight='bold')
        plt.xlabel('ADC Channel Bin Number', fontsize=10)
        plt.ylabel('Event Count (N)', fontsize=10)
        plt.yscale('log')
        plt.grid(True, linestyle='--', alpha=0.6)
        plt.xlim(0, 2048)
        plt.legend(loc='upper right')
        
        # Save plot to workspace directory path
        output_image_path = "hil_captured_spectrum.png"
        plt.savefig(output_image_path, dpi=300, bbox_inches='tight')
        plt.close() # Release memory overhead allocation from background thread loop
        logger.info(f"HIL spectrum plot successfully generated and exported to path: {os.path.abspath(output_image_path)}")

    except Exception as plot_err:
        logger.error(f"Failed to generate or save spectrum chart image due to plotting exception: {plot_err}")

    # 9. Extract real-time dual-trace sample signals from the Oscilloscope    
    ch1_trace, ch2_trace = daq_api.read_oscilloscope()
    assert len(ch1_trace) == 2048
    assert len(ch2_trace) == 2048
    try:
        plt.figure(figsize=(10, 5))
        plt.plot(range(len(ch1_trace)), ch1_trace, label='Channel 1', linewidth=1.5)
        plt.plot(range(len(ch2_trace)), ch2_trace, label='Channel 2', linewidth=1.5)
        plt.title('Hardware-in-the-Loop (HIL) Dual-Trace Oscilloscope Samples', fontsize=12, fontweight='bold')
        plt.xlabel('Sample Index (N)', fontsize=10)
        plt.ylabel('Amplitude (a.u.)', fontsize=10)
        plt.legend()
        plt.grid(True, linestyle='--', alpha=0.6)

        output_image_path = "hil_captured_oscilloscope.png"
        plt.savefig(output_image_path, dpi=300, bbox_inches='tight')
        plt.close()
        logger.info(f"HIL oscilloscope successfully generated and exported to path: {os.path.abspath(output_image_path)}")

    except Exception as plot_err:
        logger.error(f"Failed to generate or save spectrum chart image due to plotting exception: {plot_err}", )
    
    logger.info("Successfully processed 2048 dual-trace oscilloscope tracking samples.")
    
