"""
Module: daq_hw.py
Description: Data Acquisition Hardware (DAQ) management class over UART.

Revisions:
    1.0.0 - Initial release (2026-06-10) - I. Morales
"""

from __future__ import annotations

__all__ = ["DaqHw"]
__version__ = "1.0.0"
__author__ = "I. Morales"
__date__ = "2026-06-10"

from serial import Serial
from serial.tools import list_ports
import os
from sys import platform

class DaqHw(Serial):
    """Data Acquisition Hardware (DAQ) management class over UART.

    Inherits from `Serial` and provides utility methods to filter out JTAG 
    channels and automatically detect ports based on Vendor ID (VID) and 
    Product ID (PID).

    Attributes:
        DEFAULT_VID (str): Default Vendor ID for the USB-UART FTDI chip.
        DEFAULT_PID (str): Default Product ID for the CMOD A7 board.
        DEFAULT_BAUDRATE (int): Default serial baud rate (115200).

        OS_WINDOWS (str): Operating system identifier for Windows.
        OS_LINUX (str): Operating system identifier for Linux.
        OS_MAC (str): Operating system identifier for macOS.
        OS_UNKNOWN (str): Operating system identifier for unknown systems.
    """

    #: Use these default values for the USB-UART FTDI chip in the CMOD A7 board
    DEFAULT_VID = "0403"
    DEFAULT_PID = "6010"
    DEFAULT_BAUDRATE = 115200

    #: Internal operating system identifiers
    OS_WINDOWS = 'windows'
    OS_LINUX = 'linux'
    OS_MAC = 'macos'
    OS_UNKNOWN = 'unknown'

    def __init__(self, port = None):
        """Constructor for the `DaqHw` class. Initializes the inherited Serial class
        and determines the current operating system.
        
        Args:
            port (str): The name of the serial port to open, if available.
        """
        super().__init__(port)
        self.__os = self.__set_os()

    def _disregard_jtag(self):
        """Finds and filters UART-only ports while ignoring JTAG channels.

        Scans the `/dev/serial/by-id/` directory for interfaces associated 
        with `/dev/ttyUSB` or `/dev/ttyACM` devices, disregarding any 
        JTAG instances present on the FTDI chip.

        Returns:
            list: A sorted list of strings containing absolute paths to 
            the UART-only ports.
        """
        
        base_path = "/dev/serial/by-id/"
        uart_ports = []

        # Validate the working directory exists
        if not os.path.exists(base_path):
            return uart_ports

        # Seek in the directory for the available serial ports
        for filename in os.listdir(base_path):
            # Filter out everything besides the if01 (UART)
            if "if01" in filename:
                full_path = os.path.join(base_path, filename)

                # Solve the symbolic link (for example. ../../ttyUSB1 -> /dev/ttyUSB1)
                real_path = os.path.realpath(full_path)
                uart_ports.append(real_path)

        # Returns a list of UART-only ports associated to /dev/ttyUSB or /dev/ttyACM... 
        return sorted(uart_ports)

    def __set_os(self):
        """Determines the current operating system based on the `platform`.
        Sets it to the private attribute `__os`.
        """
        if platform == "win32" or platform == "cygwin":
            self.__os = self.OS_WINDOWS
        elif platform == "linux":
            self.__os = self.OS_LINUX
        elif platform == "darwin":
            self.__os = self.MAC
        else:
            self.__os = self.OS_UNKNOWN

    def get_os(self):
        """Returns the current operating system."""
        return self.__os

    def find_port(self, vid : int, pid : int) -> list[str] | None:
        """Finds the target device's serial port name based on its VID and PID.

        If you are uncertain about the specific values, use the `DEFAULT_VID` 
        and `DEFAULT_PID` class attributes.

        Args:
            vid (int | str): The Vendor ID of the target device (can be an 
                integer or a hexadecimal string).
            pid (int | str): The Product ID of the target device (can be an 
                integer or a hexadecimal string).

        Returns:
            list | None: A list of lists containing the port name of the devices found.
            A single-element list is returned if only one device is found.
            None is returned if nothig is found.
        """
        
        # Convert to integers in case hexadecimal text is passed as parameter
        target_vid = int(vid, 16) if isinstance(vid, str) else vid
        target_pid = int(pid, 16) if isinstance(pid, str) else pid

        # All the COM ports, including JTAG instances
        ports = list_ports.comports()
        
        # Valid UART ports, no matter VID, PID
        valid_uart_ports = self._disregard_jtag()

        devices = []

        # Scan the available ports, looking for the target device
        for port in ports:
            if port.vid == target_vid and port.pid == target_pid:
                device_name = port.device
                
                #Only if matches a UART (serial port) instance, disregard JTAG
                if device_name in valid_uart_ports: 
                    devices.append(device_name)

        if len(devices):
            return devices               

        return None
    
    def retrieve_serial(self, port_name : str) -> str | None:
        """Retrieves the serial number of a specific serial port name listed in the system.

        Args:
            port_name (str): The name of the specific port name to look for its serial number for.

        Returns:
            str | None: The serial number of the specified device name. None if no matches are found.
        """

        # Characters in the base serial number, without channel (JTAG:A, UART:B)
        BASE_SN_LEN = 12 

        # All the COM ports
        ports = list_ports.comports()

        # Look for the serial number of the specified `port_name`
        for port in ports:
            if port.device in port_name:
                port_serial = str(port.serial_number).upper()

                #: Strip out leading characters out of the serial number, which may indicate
                #: the channel of the FTDI chip (JTAG, UART, etc).
                port_serial = port_serial[:BASE_SN_LEN]
                
                #: Matching the convetion of the JTAG/UART names. JTAG channel ends with 'A', UART ends with 'B'.
                #: Thus, the 'B' is added at the end to match the UART channel S/N.
                port_serial = f"{port_serial}B"
                
                return str(port_serial)

        return None

    
    def open_port(self, port_name : str, baudrate : int) -> Serial:
        """Opens a specific serial port.

        Args:
            port_name (str): The identifier or path of the serial port to open.
            baudrate (int): The transmission speed (baud rate) for the port.

        Returns:
            Serial: The initialized and opened serial port instance.
        """
        return super().__init__(port_name, baudrate)
    
    def close_port(self, port_instance : Serial) -> bool:
        """Closes an active serial port instance.

        Args:
            port_instance (Serial): The instance of the serial port to close.

        Returns:
            bool: True if the port was successfully closed, False if it was 
            already closed or inactive.
        """
        if port_instance.is_open:
            port_instance.close()
            return True
        return False

if __name__ == "__main__":

    ## The following is a validation code that should not
    # be run in production. Meant for development only.
    daq = DaqHw()

    ## Finding the port corresponding to the device we are looking for
    ## Taking the default VID and PID for the CMOD A7 development board
    port_name = daq.find_port(daq.DEFAULT_VID, daq.DEFAULT_PID)
    print(f"DAQ found in port: {port_name}")

    ## Checking if the port can be opened, the S/N retrieved and finally be closed
    daq.open_port(port_name, 115200)
    print(f"Port opened: {daq.is_open}")
    daq.get_serial(daq.DEFAULT_VID, daq.DEFAULT_PID)
    print(f"Serial number: {daq.get_serial(daq.DEFAULT_VID, daq.DEFAULT_PID)}")
    daq.close_port(daq)
    print(f"Port closed: {not daq.is_open}")
