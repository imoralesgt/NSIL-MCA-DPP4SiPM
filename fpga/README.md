## Folder distribution
- **bd** contains the Vivado block design recreation script. Once a new project has been setup and the IP cores and interfaces have been added, the block design can be rebuilt by executing `source ./bd/bd_dpp.tcl` in the TCL console.
- **bitstream** contains both the bitstream (including the compiled binary for MicroBlaze) and the exported Hardware definition file from Vivado. The former (download.bit) can be used to directly program the onboard flash, whereas the latter (design\_1\_wrapper.xsa) can be imported into a new Vitis software application project.
- **constraints** contains the FPGA constraints file, including the custom GPIO pin mapping.
- **if** contains the custom interfaces for the Vivado design. It must be imported to the Vivado Project to succesfully build the block design.
- **ip** contains the IP cores used in the FPGA design. It must be imported to the Vivado Project to succesfully build the block design. 
- **projects** is an empty folder where both the hardware/gateware design (Vivado) and the embedded software (Vitis) projects can be locally developed. Such project names must start with the keyword *project_* to follow the .gitignore rule and keep the repository clean. The Vivado and Vitis project names could be something like *projects/project_dpp* and *projects/project_dpp_sw*, respectively.
- **ublaze_sw** contains the source code for the software executed in the MicroBlaze embedded soft-processor (firmware). These source files can be used by creating an empty standalone C application and importing all the files into the project. 

