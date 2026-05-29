## Folder distribution
- **bd** contains the Vivado block design recreation script. Once a new project has been setup and the IP cores and interfaces have been added, the block design can be rebuilt by executing `source ./bd/bd_dpp.tcl` in the TCL console.
- **bitstream** contains both the bitstream (including the compiled binary for MicroBlaze) and the exported Hardware definition file from Vivado. The former (download.bit) can be used to directly program the onboard flash, whereas the latter (design\_1\_wrapper.xsa) can be imported into a new Vitis software application project.
- **constraints** contains the FPGA constraints file, including the custom GPIO pin mapping.
- **if** contains the custom interfaces for the Vivado design. It must be imported to the Vivado Project to succesfully build the block design.
- **ip** contains the IP cores used in the FPGA design. It must be imported to the Vivado Project to succesfully build the block design. 
- **projects** is an empty folder where both the hardware/gateware design (Vivado) and the embedded software (Vitis) projects can be locally developed. Such project names must start with the keyword *project_* to follow the .gitignore rule and keep the repository clean. The Vivado and Vitis project names could be something like *projects/project_dpp* and *projects/project_dpp_sw*, respectively.
- **ublaze_sw** contains the source code for the software executed in the MicroBlaze embedded soft-processor (firmware). These source files can be used by creating an empty standalone C application and importing all the files into the project. 

## Recreate the FPGA projects from sources
The FPGA design is partitioned in two domains: 
1. Hardware/gateware for the real-time signal processing deployed in the FPGA fabric. These source files can be synthesized in AMD/Xilinx Vivado.
2. Embedded software (firmware) running in the MicroBlaze soft-processor (also inside the FPGA). AMD/Xilinx Vitis is used for this task.

**Vivado 2022.2** was used to develop the system. Although it may work with newer versions, some adaptation may be needed to import the source files.

### FPGA design
These steps will guide you through the AMD/Xilinx Vivado workflow to recreate the FPGA design. The expected result is an exported Hardware Definition File (XSA) that can be further imported into AMD/Xilinx Vitis for the software development stage.

1. Clone this repository into a directory **withouth spaces** in your computer.
2. Open Vivado 2022.2.
3. If not present yet, install the **Cmod A7-35t (revision 1.2)** board from the Vivado Store.
4. Create a new Vivado Project. Use the `fpga/projects` folder to create it. The name ought to start with the preffix **project_** to be compatible with the repository structure. For example: **project_dpp**.
5. In the New Project wizard, import all the constraints files in the *fpga/constraints/* directory.
6. Choose the **Cmod A7-35t (revision 1.2)** board as the target platform.
7. The new project is now created. Locate the *Flow Navigator* pane in Vivado (left) and under *PROJECT MANAGER*, click **Settings**.
8. In the Settings window, navigate to Project Settings -> IP -> Repository.
9. In the IP repositories list, click the **+** button to add new repositories.
10. Locate and select the **ip** folder in the *fpga/* directory, click Select.
11. A window should pop-up, indicating new IP cores and interfaces have been found.
12. Repeat steps 9. and 10. to include also the **if** folder in the *fpga/* directory as well.
13. Close the Settings window by clicking OK.
14. Now you can recreate the block design. In Vivado's main window, locate the **TCL Console** in the lowermost pane.
15. In the TCL Console you can use typical terminal commands (such as `pwd`, `cd`, `ls`) to navigate into the block design subfolder. Locate and navigate into the `fpga/bd/` folder.
16. Execute the block design recreation script by typing: `source ./bd_dpp.tcl`.
> This step will open a new Block Design window and recreate the entire FPGA system. It may take a bit of time to conclude.
17. Create an HDL wrapper for the new block design.
18. Synthesize, implement the design, and generate the bitstream. You can now export the hardware definition file (xsa), which **must include the bitstream**. This file will be used to create the Vitis project for the embedded software development stage.
> In case you do not require any changes in the original FPGA design, the exported hardware definition file (including the bitstream) is also available in the repository: `fpga/bitstream/design_1_wrapper.xsa`. This file can be directly imported to Vitis to start a new application project.

### MicroBlaze embedded software
This step will guide you through the steps required to compile the MicroBlaze firmware (embedded software) prior to uploading it to the FPGA.

1. Launch Vitis and setup a new workspace. Use the `fpga/projects` folder to create it. The name ought to start with the preffix **project_** to be compatible with the repository structure. For example: **project_dpp_sw**.
> Do not use the same folder reserved for the Vivado project.
2. Create a New Application project in Vitis.
3. Import the XSA hardware definition file (see Step 18. from [FPGA design](#fpga-design)). Alternatively, you can also import the previously-exported file in the repository: `fpga/bitstream/design_1_wrapper.xsa`.
4. Set the application name in the project wizard and click Next. The name can be something like **dpp_app**.
5. In the domain step, choose **standalone** as the Operating System, and leave *microblaze_0* as the Processor. Click Next.
6. In the templates step, choose **Empty Application (C)**. Click Finish. A new project has just been created.
7. In the Vitis main window, in the left pane (Explorer), right click on the `src` folder and select **Import Sources...**.
8. Click on **Browse...** and navigate to the *fpga/src* folder in the downloaded files of this repository. Click **Open**.
9. Mark (select) all the available files under the chosen folder, andn click on **Finish**.
10. All the sources have been imported. Now proceed to building the entire system. In the Vitis main menu, click on *Project->Clean*. A new window will pop-up. Enable the **Clean all the projects** and **Start a build immediately** selection boxes. Then click on the *Clean* button. This process will compile all the system elements and create a binary ELF file.
11. You can now program the FPGA with the latest version you just compiled.

#### Optional: generate the bitstream to flash the non-volatile onboard memory
You can upload the bitstream to the FPGA through the JTAG debugger (via the USB cable). However, after power-cycling the configuration will be lost. The onboard SPI flash memory can be levaraged to overcome such an issue.

First, a bitstream with the embedded compiled software (ELF binary) should be prepared. This bleded file will be further uploaded to the onboard flash.

##### Preparing the bitstream with the compiled software
This process guides you through the steps required to generate a compiled bitstream with the initialized BRAM values including the binary ELF file. 

>You can skip this stage if you did not perform any change in the FPGA nor the MicroBlaze design files. You can find the original compiled bitstream in ths repository: `fpga/bitstream/download.bit`.


1. Click on the Vitis main menu *Xilinx->Program Device*. The *Program Device* window will appear. In the *Software Configuration* pane, click on the dropdown menu in the *ELF/MEM File to Initialize in Block RAM* column. Change the original selection (*bootloop*) and choose *Browse...* instead.
2. A new window will appeaer. Brows the compiled binary (ELF) that you just generated. You can find it within your Vitis workspace, inside the application name folder. For instance, it can be something similar to `fpga/projects/project_dpp_sw/dpp_app/Debug/dpp_app.elf`.
3. In the Program Device window click on the **Generate** button (do not click on Program).
4. Check the bitstream compilation process in the Vitis console pane (usually placed in the lowermost side). At the end of the process, a new bitstream will be available in the path specified in the Vitis console. The file should be named **download.bit**. If you followed the naming convention mentioned in this guide, the generated bitstream may be located at: `fpga/projects/project_dpp_sw/dpp_app/_ide/bitstream/download.bit`.

##### Uploading the compiled bitstream to the onboard flash
Before starting, be sure to install the proper Digilent drivers (provided by AMD/Xilinx) for the Cmod A7-35t board. 

Once the drivers have been installed, connect the DAQ/MCA to your computer using the USB cable.

1. In the Vitis main meny, click on *Xilinx -> Program Flash*. The *Program Flash Memory* window will pop-up.
2. In the *Image File* field browse and locate the **download.bit** file you have just generated.
3. In the *Offset* field write *0* (zero).
4. The flash type depends on the Cmod A7-35t board revision. You are very likely to have **Rev C**, although some MCA/DAQ boards may have been built using the older **Rev B** version.
For **Rev C** choose **mx25l3273f-spi-x1_x2_x4**. In case you are working with a **Rev B** board, choose **n25q32-3.3v-spi-x1_x2_x4**, instead.
5. Enable the **Verify after flash** checkbox.
6. Click on the **Program** button. A progress bar should pop-up indicating the onboard flash programming process.
7. After the operation is completed, a confirmation message should appear in the Vitis Console (lowermost pane): **Flash Operation Successful**.
8. Power-cycle (unplug and plug-in) the board to load the fresh bitstream into the FPGA.
