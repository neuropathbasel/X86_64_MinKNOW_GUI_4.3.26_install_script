# X86_64_MinKNOW_GUI_4.3.26_install_script #

Scripted installation of Minknow control software version 4.3.26, nvidia GPU drivers and CUDA for GPU based base calling and GPU based sequence analysis such as methylation calling.

The following series of steps was found to work with more than three different PCs of different vendors. On a Zotac Zbox the complete installation (including installation of xUbuntu) was possible in less than 25 minutes.

##this is work in progress
before getting started, please refresh this page to work with the latest version.

## Prerequisite
* Knowledge of Linux command line and VNC.
* PC equipped with GPU (>= 8GB RAM) and *one* SSD or HDD with at least 1 TB capacity, 1 USB3 port and access to the internet.
* Ubuntu 18.04 installed on the above mentioned PC with only *one user* called *minknow*.
* Minion unit. The Unit *must not be connected*  to the PC while the scripts detailed below are executed.
* *second* computer for VNC access to the control PC.  
* Relevant debian packages (have to be requested form ONT)
  * minion-nc_21.06.10-1~bionic_all.deb
  * ont-bream4-minion_6.2.6-1~bionic_all.deb
  * ont-guppy-cpu-for-minion_5.0.13-1~bionic_amd64.deb
  * ont-kingfisher-ui-minion_4.3.26-1~bionic_all.deb
  * minknow-core-minion-nc_4.3.12-bionic_amd64.deb
  * ont-configuration-customer-minion_4.3.11-1~bionic_all.deb
  * ont-guppyd-for-minion_5.0.13-1~bionic_all.deb
  * ont-vbz-hdf-plugin_1.0.0-1~bionic_amd64.deb
  * ont-jwt-auth_0.28-1~bionic_amd64.deb

For license reasons we must not provide any of the debian files listed above. Please request them from ONT directly via the support chat in the community forum (https://community.nanoporetech.com/) before starting the steps detailed below.

# After installation of xUbuntu 18.04
## login
Do *not* update to xUbuntu 20.04 LTS (or any other more recent distribution)

## Installation of GPU driver and CUDA
*Please note:* After running the a_guppy_minknow_nanodip_dependencies.sh script the local screen will no longer show a graphical user interface (GUI), but only a login prompt. You can, however, access a GUI of the machine via Virtual Network Computing (VNC). This is needed to prevent any resource conflict with GPU usage for calculation (e.g. during basecalling) and display of a GUI. suitable packages will be downloaded and installed during this script.

The PC will automatically reboot after the execution of script  a_2021_10_14_setup.sh

# Git clone scripts and config files.
In the command line run the following command:

`sudo apt install git`

Provide your password and verify each question with ‘yes’

Run the following commands

`cd /home/minknow/Downloads`

`git clone https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script.git`

`cd X86_64_MinKNOW_GUI_4.3.26_install_script`

`./a_guppy_minknow_nanodip_dependencies.sh`

Verify requests for updates and downloads of additional spaces and usage of storage space by pressing y, define VNC password for user minknow in the respective dialogues.

Please note:  For unclear reasons firefox crashes during the system updates. This does (so far) not impair this procedure.

Upon completion, you be asked for verification of a reboot.

Make sure there is *no* Minion unit connected to the PC. A connected Minion device can impair system startup.

# After reboot

Only command line login is shown on the screen attached to the control PC.

# start and use vnc server
## ssh login to the control PC

In the example code below the new control PC has the IP address 192.168.1.27

On your second local machine enter in the terminal:

'ssh minknow@192.168.1.27`

after login enter in the SSH shell:

`./scripts/vnc_start.sh`

## start a vnc viewer for access
e.g. on a second linux machine enter:

`xvncviewer 192.168.1.27:1`

The desktop of the control PC should be shown.

## copy debian files defined above to /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script/ directory

In the /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script/ directory run

`.b_minknow_guppy_install_deb.sh`

Verify installation of additional packages.
If necessary, exit minknow service status dialogue by pressing “q”.

After the completion of this scipt you should see something like the following:
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 495.44       Driver Version: 495.44       CUDA Version: 11.5     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:01:00.0 Off |                  N/A |
|  0%   51C    P8    12W / 170W |   3929MiB / 12053MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A      4644      C   ...bin/guppy_basecall_server     3927MiB |
+-----------------------------------------------------------------------------+

You have to see an entry in the second but last line, indicating that .../bin/guppy_basecall_server is using more than 3.5 GB of memory on the GPU.

## Minknow UI
* Ensure no Minion Unit is connected to the control PC.
* Start Minknow UI from the start menu (upper left corner with little mouse head; enter 'minknow').
* Login with your Nanopore account or as a guest. In the next dialogue box “update available”, *skip this version*. If there is no response to any mouse click and there is a dialogue for tutorials, choose in the upper right corner: ship all tutorials by clicking three vertical dots and then skip tutorials (or something similar).
* For the time being, please, *never ever* choose update of minknow. Any update will prevent all scripts developed for the nanodip pipeline from proper execution and you will not obtain any useful results.

After starting the Minknow User Interface, you should see something similar to the following image

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/Minknow_UI_start_screen.png)

## After connecting the Minion unit with a flow cell inserted you should see something like:

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/Minknow_UI_Minion_w_FC.png)

Your setup should be now ready for sequencing.
Please verify this by a short test sequencing rung with an old flow cell.

##Reference data:
NanoDip will not work without reference data.
Chromium should be your default browser.

Please use Chromium to obtain reference data (app 80 GB) from:
https://sites.google.com/view/nanodipreferencedata/home
Please download the reference data as multiple zip files to the /home/minknow/Downloads directory

Download the following google sheet files as Excel xlsx to the /home/minknow/Downloads.
keep the proposed name.

https://docs.google.com/spreadsheets/d/1svy9s3noE8-rBxri_mU7OOWEw7MTrNDw/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true
https://docs.google.com/spreadsheets/d/1qSNZKaQxYbvBvGg1mZgRas7IqmmGNxBI/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true
https://docs.google.com/spreadsheets/d/1UcPHsbph9RoWKnGXSBPhFG35PEVbYscK/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true
https://docs.google.com/spreadsheets/d/1A50bFWUBPBgO00AHYYfaE8H3iTZrGKNo/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true

Do *NOT* proceed before you have the following files in you Downloads directory:
* GSE90496_IfP01.xlsx
* GSE90496.xlsx
* AllIDATv2_20210804.xlsx
* AllIDATv2_20210804.xlsx


After completion, run
/home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script directory/c_reference_data.sh
