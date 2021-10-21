# X86_64_MinKNOW_GUI_4.3.26_install_script #

Author: Claus Hultschig, IfP

Date: 2021 10 21

Version:02

The following series of steps was found to work with more than three different PCs of different vendors. 

To minimize confusion: Please have only one SSD/HDD conneted in your PC.

Please note: we will be unable to provide any support if you deviate from below steps.

## Prerequisite
* Knowledge of Linux command line and VNC.
* PC equipped with GPU (>= 8GB RAM) and one SSD or HDD with at least 1 TB capacity, 1 USB3 port and access to the internet.
* Ubuntu 18.04 installed on the above mentioned PC with only one user called minknow set up.
* Minion unit. The Unit *must not be connected*  to the PC while the scripts detailed below are executed.  
* Relevant config files and scripts  in MinKNOW_4.3.26_20210929_x86_64_1804 directory (will be downloaded using the git clone command):
  * a_2021_10_14_setup.sh
  * b_2021_10_13_minknow_guppy_install_deb.sh
  * add_config_files/guppyd.service
  * add_config_files/vnc_start.sh
  * add_config_files/xstartup
  * ont-guppy_5.0.14_linux64.tar.gz (open source, will be downloaded in the second script)
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

For licence reasons we must not provide any of the deb files. Please request them from ONT directly yourself via the support chat in the community forum (https://community.nanoporetech.com/)

# After installation of xUbuntu 18.04
## login
Do *not* update to xUbuntu 20.04 LTS (or any other more recent distribution)

## Installation of GPU driver and CUDA
*Please note:* After running the a_2021_10_14_setup.sh script the local screen will no longer show a GUI, but only a login prompt. You can, however, access a GUI of the machine via VNC. This is needed to prevent any resource conflict with GPU usage for calculation (e.g. during basecalling) and display of a GUI(login screen).

The PC will automatically reboot after the execution of script  a_2021_10_14_setup.sh

# Git clone scripts and config files.
In the command line run the following command:

`sudo apt install git`

Provide your password and verify each question with ‘yes’

Run the following commands

`cd /home/minknow/Downloads`

`git clone https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script.git`

`cd X86_64_MinKNOW_GUI_4.3.26_install_script`

## first setup script

run in the X86_64_MinKNOW_GUI_4.3.26_install_script directory:

`./a_2021_10_14_setup.sh`

Verify requests for updates and downloads of additional spaces and usage of storage space by pressing y, define VNC password for user minkow in the respective dialogues.

Upon completion, the system will reboot.

Make sure there is *no* Minion unit connected to the PC. A connected Minion device can impair system startup.

# start and use vnc server
## ssh login to the control PC

In the example code below the new control PC has the IP adddress 192.168.1.27

On your second local machine enter in the terminal:

'ssh minknow@192.168.1.27`

after login enter in the SSH shell:

`./scripts/vnc_start.sh`

## start a vnc viewer for access
e.g. on a second linux machine enter:

`xvncviewer 192.168.1.27:1`

The desktop of the control PC should be shown.

## copy debian files defined above to /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script/ directory

in the /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script/ directory run

`./b_2021_10_13_minknow_guppy_install_deb.sh`

Verify installation of additional packages.
If necessary, exit minkow service status dialogue by pressing “q”.

System will reboot.

# After 3rd reboot
activate and use vnc server (see above)

## Minknow UI
* Ensure no Minion Unit is connected to the control PC.
* Start Minknow UI from the start menu (upper left corner with little mouse head).
* Login with your Nanopore account or as a guest. In the next dialogue box “update available”, *skip this version*. If there is no response to any mouse click and there is a dialogue for tutorials, choose in the upper right corner: ship all tutorials by clicking three vertical dots and then skip tutorials (or something similar).

You should see something similar to the following image

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/Minknow_UI_start_screen.png)

## After connecting the Minion unit with a flow cell inserted you should see something like:

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/Minknow_UI_Minion_w_FC.png)

The setup should be now ready for sequencing.
