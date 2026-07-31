<!-- markdownlint-disable -->

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/main.py#L0"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

# <kbd>module</kbd> `main`
Example usage of the DAQ MCA API for the IAEA/NSIL DPP4SiPM DAQ/MCA board. It exposes reliable control and data acquisition methods for any Python application through a persistent serial connection. 

This API uses `uv` as the default package manager. Check the `pyproject.toml` file for more details on the requirements. 

Usage:  Check the `main()` function at the end of this document for an example of  how to use the API. 

Available methods in the API:  For most of the applications, the following methods can be used to control and   acquire the data from the MCA board: 
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

Revisions:  1.0.0 - Initial release (2026-06-01) - I. Morales 


---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/main.py#L105"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

## <kbd>function</kbd> `get_spectrum`

```python
get_spectrum(daq_instance: 'DaqCommands') → list
```

Example function on how to collect a spectrunm with the MCA/DAQ board. 

1. Clear the spectrum data  2. Reset the timers 3. Start the data acquisition 4. Wait for the spectrum to be collected 5. Retrieve the collected spectrum data from the DAQ 



**Args:**
 
 - <b>`daq_instance`</b> (DaqCommands):  An instance of the DaqCommands class representing the DAQ/MCA board API. 



**Returns:**
 
 - <b>`list`</b>:  A list containing the collected spectrum data from the DAQ. 


---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/main.py#L145"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

## <kbd>function</kbd> `create_spe_file`

```python
create_spe_file(
    file_path: 'str',
    spectrum: 'list',
    live_time: 'float',
    real_time: 'float'
) → None
```

Generates a standard ORTEC .Spe spectrum file. 



**Args:**
 
 - <b>`file_path`</b> (str):  Destination path for the output .Spe file. 
 - <b>`spectrum`</b> (list):  List of integers representing counts per ADC channel. 
 - <b>`live_time`</b> (float):  Live time of the measurement in seconds. 
 - <b>`real_time`</b> (float):  Real time time of the measurement in seconds. 


---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/main.py#L191"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

## <kbd>function</kbd> `plot_spectrum`

```python
plot_spectrum(spectrum: 'list') → None
```

Plots the energy spectrum data collected with the MCA/DAQ board.      




---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/main.py#L206"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

## <kbd>function</kbd> `main`

```python
main()
```








---

_This file was automatically generated via [lazydocs](https://github.com/ml-tooling/lazydocs)._
