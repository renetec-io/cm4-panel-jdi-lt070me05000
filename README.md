Overview
======

This repository contains a PCB design and drivers for Raspberry Pi CM4 Сarrier with Hi-Res MIPI Display project.<br>
For details, see https://hackaday.io/project/176098-raspberry-pi-cm4-arrier-with-hi-res-mipi-display

The display used is JDI LT070ME05000 with Goodix touch input driver IC. The project also uses MCP23008 IO expander to save some GPIO pins.

Raspberry Pi only supports its official 7-inch MIPI DSI display with FKMS(Fake/Firmware KMS) out of the box. 
To make the display work, we need to use full KMS and Linux kernel driver for the panel.

The PCB design is contained in the KiCAD directory.

Setup
======

1. Install the latest Raspberry PI OS image, either on SD card (with CM4 Lite) or onto eMMC.
   With Lite version, you can use [SD card instruction](https://www.raspberrypi.org/documentation/installation/installing-images), 
   otherwise use [eMMC instruction](https://www.raspberrypi.org/documentation/hardware/computemodule/cm-emmc-flashing.md).   
   The jumper that enables boot from usb is located near the micro-USB connector on the PCB.
   
1. Mount `boot` partition onto your computer.

1. Enable and connect the serial console.
   1. Add `enable_uart=1` to the config.txt file on `boot` partition.   
   1. Use the serial interface to connect to Raspberry Pi: [elinux.org instruction](https://elinux.org/RPi_Serial_Connection).   
   
1. Enable USB port. <br>
   By default, to conserve power, USB is not enabled on CM4.<br>
   To enable, add `dtoverlay=dwc2,dr_mode=host` to config.txt.
   
1. Boot your Raspberry Pi and connect it to the internet. If you have a module without Wi-Fi, 
   you need a USB Wi-Fi or Ethernet adapter. 
   If Wi-Fi doesn't work, and you are receiving the message like "Could not communicate with wpa_supplicant" from raspi-config 
   when trying to set up wireless network, you may need to add the following
   ```
   allow-hotplug wlan0
   iface wlan0 inet manual
   wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
   ```
   to /etc/network/interfaces and then reboot.

1. On the Raspberry Pi, 
   1. Install git and dkms: 
   ```
   sudo apt-get update
   sudo apt-get install git dkms
   ```
   2. Clone the repository and install the drivers
   ```
   git clone https://github.com/renetec-io/cm4-panel-jdi-lt070me05000.git
   cd cm4-panel-jdi-lt070me05000
   ./setup.sh
   ```

1. Enable display driver.<br>
   Add the following in the end of /boot/config.txt:
   ```
   dtparam=i2c_vc=on   
   lcd_ignore=1   
   dtoverlay=vc4-kms-v3d-pi4,noaudio   
   dtoverlay=cm4-dsi-lt070me05000   
   ```
   
1. Enable sound.<br>
   Add the following to /boot/config.txt:
   ```
   # Sound configuration   
   dtparam=audio=on   
   dtoverlay=hifiberry-dac   
   dtoverlay=i2s-mmap   
   ```   

8. Reboot.
