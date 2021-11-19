#!/bin/bash

# reload NVIDIA Driver
# adapted from  https://stackoverflow.com/questions/43022843/nvidia-nvml-driver-library-version-mismatch

lsmod | grep nvidia

# our final goal is to unload nvidia mod, so we should unload the module depend on nvidia
sudo rmmod nvidia_drm
sudo rmmod nvidia_modeset
sudo rmmod nvidia_uvm

# then, unload nvidia
sudo rmmod nvidia

#Troubleshooting
#if you get an error like rmmod: ERROR: Module nvidia is in use, which indicates that the kernel module is in use, you should kill the process that using the kmod:

sudo lsof /dev/nvidia*

#and then kill those process, then continue to unload the kmods

#Test: confirm you successfully unload those kmods

lsmod | grep nvidia

#you should get nothing, then confirm you can load the correct driver

nvidia-smi
