"""
Module: tests.test_daq_hw_autodiscovery
Location: sw/python-api/tests/test_daq_hw_autodiscovery.py
Description: Unit tests for DaqHw's OS detection and JTAG/UART channel
             disambiguation (issue #27). Fully mocked - no physical
             hardware required, runs on any host OS/in CI.
Notes:
    - To run (from the python-api root): `uv run python -m pytest tests/test_daq_hw_autodiscovery.py -v`
"""

from __future__ import annotations

__version__ = "1.0.0"
__author__ = "I. Morales"
__date__ = "2026-07-31"

from dataclasses import dataclass
from unittest.mock import patch

import pytest
from core.daq_hw import DaqHw


@dataclass
class FakePort:
    """Minimal stand-in for `serial.tools.list_ports_common.ListPortInfo`."""
    device: str
    vid: int | None = None
    pid: int | None = None
    serial_number: str | None = None


@pytest.mark.parametrize(
    "sys_platform, expected_os",
    [
        ("win32", DaqHw.OS_WINDOWS),
        ("cygwin", DaqHw.OS_WINDOWS),
        ("linux", DaqHw.OS_LINUX),
        ("darwin", DaqHw.OS_MAC),
        ("freebsd13", DaqHw.OS_UNKNOWN),
    ],
)
def test_get_os(sys_platform, expected_os):
    with patch("core.daq_hw.platform", sys_platform):
        assert DaqHw().get_os() == expected_os


def test_disregard_jtag_linux_filters_if01(tmp_path):
    with patch("core.daq_hw.platform", "linux"):
        daq = DaqHw()

    with patch("core.daq_hw.os.path.exists", return_value=True), \
         patch("core.daq_hw.os.listdir", return_value=[
             "usb-FTDI_Dual_RS232-HS-if00-port0",
             "usb-FTDI_Dual_RS232-HS-if01-port0",
         ]), \
         patch("core.daq_hw.os.path.realpath", side_effect=lambda p: p.replace(
             "/dev/serial/by-id/usb-FTDI_Dual_RS232-HS-if01-port0", "/dev/ttyUSB1"
         )):
        uart_ports = daq._disregard_jtag()

    assert uart_ports == ["/dev/ttyUSB1"]


def test_disregard_jtag_linux_missing_by_id_dir():
    with patch("core.daq_hw.platform", "linux"):
        daq = DaqHw()

    with patch("core.daq_hw.os.path.exists", return_value=False):
        assert daq._disregard_jtag() == []


def test_disregard_jtag_windows_filters_by_serial_suffix():
    with patch("core.daq_hw.platform", "win32"):
        daq = DaqHw()

    fake_ports = [
        FakePort(device="COM3", vid=0x0403, pid=0x6010, serial_number="FT1ABCDEA"),  # JTAG
        FakePort(device="COM4", vid=0x0403, pid=0x6010, serial_number="FT1ABCDEB"),  # UART
    ]
    with patch("core.daq_hw.list_ports.comports", return_value=fake_ports):
        assert daq._disregard_jtag() == ["COM4"]


def test_disregard_jtag_windows_multiple_devices():
    with patch("core.daq_hw.platform", "win32"):
        daq = DaqHw()

    fake_ports = [
        FakePort(device="COM5", vid=0x0403, pid=0x6010, serial_number="FT2ABCDEA"),
        FakePort(device="COM4", vid=0x0403, pid=0x6010, serial_number="FT1ABCDEB"),
        FakePort(device="COM6", vid=0x0403, pid=0x6010, serial_number="FT2ABCDEB"),
    ]
    with patch("core.daq_hw.list_ports.comports", return_value=fake_ports):
        assert daq._disregard_jtag() == ["COM4", "COM6"]


def test_find_port_windows_excludes_jtag_channel():
    """Regression test for issue #27: on Windows, find_port() must not
    return the JTAG interface of the FTDI chip alongside the UART one,
    even though both share the same VID/PID."""
    with patch("core.daq_hw.platform", "win32"):
        daq = DaqHw()

    fake_ports = [
        FakePort(device="COM3", vid=0x0403, pid=0x6010, serial_number="FT1ABCDEA"),  # JTAG
        FakePort(device="COM4", vid=0x0403, pid=0x6010, serial_number="FT1ABCDEB"),  # UART
        FakePort(device="COM5", vid=0x1234, pid=0x5678, serial_number="UNRELATEDB"),  # other device
    ]
    with patch("core.daq_hw.list_ports.comports", return_value=fake_ports):
        assert daq.find_port(daq.DEFAULT_VID, daq.DEFAULT_PID) == ["COM4"]
