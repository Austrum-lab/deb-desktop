#!/bin/bash

# Stop services and unload modules related for nvidia driver

systemctl stop gdm.service
systemctl stop nvidia-persistenced.service
systemctl stop nvidia-powerd.service

modprobe -r nvidia_wmi_ec_backlight
modprobe -r nvidia_uvm
modprobe -r nvidia_drm
modprobe -r nvidia_modeset
modprobe -r nvidia
