<!-- markdownlint-disable -->

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L0"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

# <kbd>module</kbd> `core.daq_commands`
Module: daq_commands.py Description: High-level abstraction API layer for controlling and acquiring  data from the IAEA/NSIL DPP4SiPM DAQ/MCA board. 

Revisions:  1.0.0 - Initial release (2026-06-01) - I. Morales 

**Global Variables**
---------------
- **LOG_DIR**
- **LOG_FILE**
- **LOG_MAX_BYTES**
- **LOG_BACKUP_COUNT**

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L68"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

## <kbd>function</kbd> `log_except_hook`

```python
log_except_hook(exctype, value, tb)
```






---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L78"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

## <kbd>class</kbd> `DaqException`
Base exception for all DAQ CLI execution and communication errors. 





---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L82"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

## <kbd>class</kbd> `DaqUnknownCommandException`
Raised when the DAQ returns Error Code 00 (Unknown Command). 





---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L86"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

## <kbd>class</kbd> `DaqInvalidParameterException`
Raised when the DAQ returns Error Code 01 (Wrong/Missing parameters). 





---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L94"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

## <kbd>class</kbd> `DaqCommands`
High-level API facade to interact with the DAQ/MCA hardware via CLI. 

This class abstracts low-level ASCII framing and binary unpacking operations  into clean, easy-to-use Python methods. It interfaces directly with an  underlying DaqHw serial instance and references commands via DaqCliCommands. 

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L106"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `__init__`

```python
__init__(
    port_name: 'str' = None,
    baudrate: 'int' = 115200,
    sampling_rate: 'float' = 50000000.0,
    tau_d: 'float' = 1.145e-06,
    tau_r: 'float' = 2.2e-07,
    **dpp_kwargs
)
```

Prepares session state elements and encapsulates the DPP parameter library. 




---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L401"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `clear_spectrum`

```python
clear_spectrum(segment_index: 'int' = 0) → bool
```

Erases memory contents of the histogram. 



**Args:**
 
 - <b>`segment_index`</b> (int):  Segment index to clear. Default is 0. The   current firmware version only supports this segment, anyways. 



**Returns:**
 
 - <b>`bool`</b>:  True if the spectrum clearing operation was successful 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L741"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `clear_timers`

```python
clear_timers(
    tmr_a: 'bool' = False,
    tmr_b: 'bool' = False,
    tmr_c: 'bool' = False
) → bool
```

Issues a one-shot clear pulse to the requested timer counters on the Timers DPP submodule (group 4), resetting them to 0 without touching Preset, the live/real-time bits, the enable bits, or any other DPP submodule. 

The clear bits are pulse-triggered (not level-held): this method performs two back-to-back writes internally - first setting the requested clear bit(s) to 1, then immediately writing them back to 0 - so the caller only needs to invoke this once per clear operation. No delay is required between the two writes: UART transmission time is far slower than the hardware's internal processing time, so the second write is guaranteed to land after the pulse has registered. 



**Args:**
 
 - <b>`tmr_a`</b> (bool):  Pulse-clear Timer A. Default False (leave untouched). 
 - <b>`tmr_b`</b> (bool):  Pulse-clear Timer B. Default False (leave untouched). 
 - <b>`tmr_c`</b> (bool):  Pulse-clear Timer C. Default False (leave untouched). 



**Returns:**
 
 - <b>`bool`</b>:  True if BOTH writes (pulse-high and pulse-low) succeeded. 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L210"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `close`

```python
close()
```

Safely tears down the active physical serial transaction layer. 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L345"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `data_acquisition_start`

```python
data_acquisition_start() → bool
```

Starts the spectrum acquisition in the DAQ. This method should be called once to start the data acquisition process. For a precise spectrum acquisition time, leverage the timers to set the desired live or real time collection time.  

Avoid using the `data_acquisition_stop` method, since it will also clear the spectrum data.  

The spectrum can be safely collected while the acquisition is in progress. 



**Returns:**
 
 - <b>`bool`</b>:  True if the operation was successful 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L364"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `data_acquisition_stop`

```python
data_acquisition_stop() → bool
```

Stops the spectrum acquisition in the DAQ manually, without clearing the accumulated spectrum or the timer counters. 

FIXED: this previously sent flag "0", which per the $AQ command documentation actually means "Starts automatic acquisition. Cleans BRAM contents prior to starting." - i.e. a START-with-clear command, not a stop. Calling it after a genuine acquisition would silently wipe the just-collected spectrum and reset the timers, then immediately begin a NEW automatic acquisition cycle - explaining symptoms like a spectrum read back as all zeros, or live/real time stuck at a tiny fixed value regardless of the requested collection duration (whatever few hundred milliseconds elapsed between this call and the next read). Flag "2" is the documented manual stop with no clearing side effect. 

This is safe to call routinely as a normal stop operation (e.g. at the end of a survey/background/batch run) - it does not need to be reserved for whole-system shutdown. 



**Returns:**
 
 - <b>`bool`</b>:  True if the operation was successful 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L415"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `dpp_initialize`

```python
dpp_initialize() → bool
```

Initializes all the DPP submodules in the DAQ with the provided constructor arguments. 



**Returns:**
 
 - <b>`bool`</b>:  True if the DPP initialization was successful 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L521"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `get_dpp_params`

```python
get_dpp_params(submodule: 'DppSubmodules') → List[int]
```

Queries active DPP register values from the DAQ. 



**Args:**
 
 - <b>`submodule`</b> (DppSubmodules):  Target hardware register block enum member  (PULSE_SHAPER_SLOW, TIMERS, etc.). See `DppSubmodules` in  `daq_constants.py`. 



**Returns:**
 
 - <b>`List[int]`</b>:  List of 32-bit unsigned integer values 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L334"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `get_serial`

```python
get_serial() → str
```

Returns the serial number retrieved from the onboard FTDI UART chip in the constructor. This method overrides the `_get_serial_old` method, which relied on a hard-coded serial number in the MicroBlaze firmware of the DAQ. 



**Returns:**
 
 - <b>`str`</b>:  The serial number of the MCA board 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L319"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `get_serial_old`

```python
get_serial_old() → str
```

Do not use this method until the MicroBlaze firmware has been updated. An alternative method has been implemented. Use `get_serial` instead. 

Retrieves the system serial number string from the hardware. It relies on the hard-coded serial number in the MicroBlaze firmware of the DAQ. 





**Returns:**
 
 - <b>`str`</b>:  The serial number of the MCA board 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L603"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `get_timers_settings`

```python
get_timers_settings() → Dict[str, Any]
```

Reads the current Timers DPP submodule configuration (group 4) directly from the hardware via `$RT -1`, without requiring driver reinitialization. 

Decodes the Ctrl_bits register into individual per-timer live/real-time and enable flags, alongside the raw Preset value (ms). 

NOTE: The hardware does not implement an automatic acquisition run mode. 'run_mode' is always reported as 'manual', matching the value every setter in this API always writes back (see set_timers_run_mode). 



**Returns:**
 
 - <b>`Dict[str, Any]`</b>:  { 
 - <b>`"preset_ms"`</b>:  int, 
 - <b>`"run_mode"`</b>:  str,        # always "manual" - see set_timers_run_mode 
 - <b>`"tmr_a_live"`</b>:  bool,     # True = live time, False = real time 
 - <b>`"tmr_b_live"`</b>:  bool, 
 - <b>`"tmr_c_live"`</b>:  bool, 
 - <b>`"tmr_a_enabled"`</b>:  bool, 
 - <b>`"tmr_b_enabled"`</b>:  bool, 
 - <b>`"tmr_c_enabled"`</b>:  bool, } 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L309"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `get_version`

```python
get_version() → str
```

Retrieves the system firmware version string from the hardware. 



**Returns:**
 
 - <b>`str`</b>:  The firmware version string 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L170"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `is_device_present`

```python
is_device_present() → bool
```

Lightweight autodiscovery presence check (issue #70): queries the DAQ board's known USB VID/PID the same way _find_port() does, but without constructing a full DaqCommands instance or opening a serial connection - suitable for cheap, frequent polling (e.g. a 1-second heartbeat loop) to detect a physical disconnect. Replaces the old approach of checking os.path.exists() on a specific port path remembered from a prior connection - detectors.json no longer stores a port name at all, so there's nothing to remember; autodiscovery is queried fresh every time. 



**Returns:**
 
 - <b>`bool`</b>:  True if at least one matching device is currently connected. 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L193"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `open`

```python
open(boot_delay: 'float' = 0.5, timeout: 'float' = 0.8)
```

Establishes a long-lived persistent connection session to the target DAQ/MCA hardware board. 



**Args:**
 
 - <b>`boot_delay`</b> (float):  Number of seconds to wait for the DAQ to boot up. 
 - <b>`timeout`</b> (float):  Number of seconds to wait for a response from the DAQ. 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L814"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `read_oscilloscope`

```python
read_oscilloscope() → Tuple[List[int], List[int]]
```

Reads the waveforms datafrom the DAQ inside an active transaction window. Delivers both channels (CH1, CH2) data simultaneously as a signed integer each. 



**Returns:**
 
 - <b>`Tuple[List[int], List[int]]`</b>:  Tuple containing the waveform data for both channels 



**Raises:**
 
 - <b>`DaqException`</b>:  If the scope capture fails 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L847"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `read_spectrum`

```python
read_spectrum(base_address: 'int' = 0) → List[int]
```

Reads the spectrum data from the DAQ/MCA. 



**Args:**
 
 - <b>`base_address`</b> (int, optional):  Base address to start reading from. Defaults to 0.  The current firmware version only supports this segment, anyways. 



**Returns:**
 
 - <b>`List[int]`</b>:  List of 32-bit unsigned integer values as the uncalibrated the spectrum 



**Raises:**
 
 - <b>`DaqException`</b>:  If the spectrum read operation fails 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L484"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `set_dpp_params`

```python
set_dpp_params(
    submodule: 'DppSubmodules',
    dpp_instance: 'DppParameters' = None
) → bool
```

Uploads pre-calculated 32-bit unsigned parameters to hardware registers in the DAQ. 



**Args:**
 
 - <b>`submodule`</b> (DppSubmodules):  Target hardware register block enum member  (PULSE_SHAPER_SLOW, TIMERS, etc.). 
 - <b>`dpp_instance`</b> (DppParameters, optional):  Only if a a newly instantiated parameters  context with pre-calculated values is required. Do not pass this argument otherwise. 



**Returns:**
 
 - <b>`bool`</b>:  True if the operation was successful 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L701"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `set_timers_enable`

```python
set_timers_enable(
    tmr_a: 'bool' = None,
    tmr_b: 'bool' = None,
    tmr_c: 'bool' = None
) → bool
```

Enables or disables the requested timers on the Timers DPP submodule (group 4), without touching Preset, the live/real-time bits, or any other DPP submodule. 

Performs a read-modify-write against the hardware (`$RT -1`): any argument left as None keeps that timer's current enable state unchanged. 

Note: Timer C must remain enabled for spectrum collection to function (the hardware documentation states it "must always be enabled"). This method does not enforce that constraint - the caller is responsible for it. 



**Args:**
 
 - <b>`tmr_a`</b> (bool, optional):  True = enabled, False = disabled.  None (default) leaves Timer A's current state unchanged. 
 - <b>`tmr_b`</b> (bool, optional):  Same semantics, for Timer B. 
 - <b>`tmr_c`</b> (bool, optional):  Same semantics, for Timer C. 



**Returns:**
 
 - <b>`bool`</b>:  True if the operation was successful 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L666"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `set_timers_mode`

```python
set_timers_mode(
    tmr_a_live: 'bool' = None,
    tmr_b_live: 'bool' = None,
    tmr_c_live: 'bool' = None
) → bool
```

Updates ONLY the live-time/real-time selection bits for the requested timers on the Timers DPP submodule (group 4), without touching Preset, the enable bits, or any other DPP submodule. 

Performs a read-modify-write against the hardware (`$RT -1`): any argument left as None keeps that timer's current live/real-time setting unchanged. 



**Args:**
 
 - <b>`tmr_a_live`</b> (bool, optional):  True = live time, False = real time.  None (default) leaves Timer A's current setting unchanged. 
 - <b>`tmr_b_live`</b> (bool, optional):  Same semantics, for Timer B. 
 - <b>`tmr_c_live`</b> (bool, optional):  Same semantics, for Timer C. 



**Returns:**
 
 - <b>`bool`</b>:  True if the operation was successful 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L642"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `set_timers_preset`

```python
set_timers_preset(preset_ms: 'int') → bool
```

Updates ONLY the Preset register (Timer C collection window, in ms) on the Timers DPP submodule (group 4), without touching any other DPP submodule and without requiring driver reinitialization. 

Performs a read-modify-write: the current Ctrl_bits value is read live from the hardware via `$RT -1` and preserved as-is (aside from forcing the run-mode bit to manual), so any previously configured live/real-time or enable flags are left untouched. 



**Args:**
 
 - <b>`preset_ms`</b> (int):  Desired collection time / Timer C preset, in ms. 



**Returns:**
 
 - <b>`bool`</b>:  True if the operation was successful 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L785"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `set_timers_run_mode`

```python
set_timers_run_mode(manual: 'bool' = True) → bool
```

PLACEHOLDER - not backed by hardware in the current firmware revision. 

The DPP4SiPM board does not implement an automatic acquisition run mode; this driver always operates the Timers submodule in manual mode (Ctrl_bits bit 0 = 0), regardless of what is requested here. This method exists so application code has a stable entry point to call once a future hardware revision implements auto mode, without needing further API changes. 



**Args:**
 
 - <b>`manual`</b> (bool):  Intended run mode. True = manual (the only mode  currently supported). False (auto) is accepted but ignored,  and logs a warning. 



**Returns:**
 
 - <b>`bool`</b>:  True if the (manual-mode-only) write succeeded. 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L537"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `timers_read`

```python
timers_read() → Dict[str, int]
```

Reads simultaneously all the real-time timer values in the DAQ. 

The timers measure the collection time of the spectrum (histogram). Three timers are available: A, B, and C. Each timer can be configured to count real time or live time. They can be disabled or enabled individually. Notice that **Timer C** controls the collection time and must be always enabled. 

Preset time is the duration of the spectrum collection window. It is tied to the **Timer C** value, which can be configured as a real-time or live-time timer. 



**Returns:**
 
 - <b>`Dict[str, int]`</b>:  Dictionary containing the timer values. 

---

<a href="https://github.com/imoralesgt/NSIL-MCA-DPP4SiPM/blob/main/sw/python-api/core/daq_commands.py#L390"><img align="right" style="float:right;" src="https://img.shields.io/badge/-source-cccccc?style=flat-square"></a>

### <kbd>method</kbd> `timers_reset`

```python
timers_reset() → bool
```

Resets the timers in the DAQ. This method should be called before starting the data acquisition process. 



**Returns:**
 
 - <b>`bool`</b>:  True if the operation was successful 




---

_This file was automatically generated via [lazydocs](https://github.com/ml-tooling/lazydocs)._
