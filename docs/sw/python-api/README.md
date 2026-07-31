# DPP4SiPM Python API Documentation

Reference documentation for the Python communications API used to control and
acquire spectroscopy data from the IAEA/NSIL DPP4SiPM DAQ/MCA board. This
documentation is generated automatically from the docstrings in
[`sw/python-api`](../../../sw/python-api) via
[lazydocs](https://github.com/ml-tooling/lazydocs), and is kept in sync with
`main` by the `python-api-docs.yml` GitHub Actions workflow. A combined PDF
export is attached to each tagged [release](../../../../releases).

## Regular user methods

Covers most applications: connecting to the board, running an acquisition,
and reading back results.

| Method | Description |
| --- | --- |
| [`open()`](core.daq_commands.md#method-open) | Establishes a long-lived persistent connection session to the connected DAQ. |
| [`close()`](core.daq_commands.md#method-close) | Safely disconnects the active physical serial communications channel. |
| [`get_version()`](core.daq_commands.md#method-get_version) | Returns the firmware version of the connected DAQ. |
| [`get_serial()`](core.daq_commands.md#method-get_serial) | Returns the serial number of the connected DAQ. |
| [`data_acquisition_start()`](core.daq_commands.md#method-data_acquisition_start) | Starts the spectrum acquisition in the DAQ. |
| [`read_spectrum()`](core.daq_commands.md#method-read_spectrum) | Reads the spectrum data from the DAQ. |
| [`timers_reset()`](core.daq_commands.md#method-timers_reset) | Resets the timers in the DAQ. |
| [`clear_spectrum()`](core.daq_commands.md#method-clear_spectrum) | Clears the spectrum data in the DAQ. |
| [`timers_read()`](core.daq_commands.md#method-timers_read) | Reads simultaneously all the real- and live-time timer values in the DAQ. |

## Advanced user methods

For advanced applications or customizations of the acquisition pipeline.

| Method | Description |
| --- | --- |
| [`data_acquisition_stop()`](core.daq_commands.md#method-data_acquisition_stop) | Stops the spectrum acquisition in the DAQ. |
| [`read_oscilloscope()`](core.daq_commands.md#method-read_oscilloscope) | Reads the waveforms from both scope channels in the DAQ. |
| [`set_dpp_params(submodule, parameters)`](core.daq_commands.md#method-set_dpp_params) | Uploads the configuration parameters to a specific DPP submodule in the DAQ. |
| [`get_dpp_params(submodule)`](core.daq_commands.md#method-get_dpp_params) | Queries active DPP register values from a specific submodule in the DAQ. |
| [`dpp_initialize()`](core.daq_commands.md#method-dpp_initialize) | Called automatically during API initialization; sends all DPP module configuration parameters to the DAQ. |
| [`get_timers_settings()`](core.daq_commands.md#method-get_timers_settings) | Reads the current timer configuration from the DAQ. |
| [`set_timers_enable(...)`](core.daq_commands.md#method-set_timers_enable) | Enables/disables individual timer channels. |
| [`set_timers_mode(...)`](core.daq_commands.md#method-set_timers_mode) | Configures live-time vs. real-time mode per timer channel. |
| [`set_timers_preset(...)`](core.daq_commands.md#method-set_timers_preset) | Sets the timer preset value. |
| [`set_timers_run_mode(...)`](core.daq_commands.md#method-set_timers_run_mode) | Configures the timers' automatic run mode. |

## Full reference

- [`main`](main.md) — example application entry point (`sw/python-api/main.py`), including the full list of DPP constructor arguments.
- [`core.daq_commands`](core.daq_commands.md) — the complete `DaqCommands` public API surface.
