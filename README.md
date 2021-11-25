# X86_64_MinKNOW_GUI_4.3.26_install_script #

Scripted installation of Minknow control software version 4.3.26, nvidia GPU drivers and CUDA for GPU based base calling and GPU based sequence analysis such as methylation calling.

The following series of steps was found to work with more than three different PCs of different vendors.

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

`./a_gpu_cuda.sh`

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

`./b_minknow_guppy_install_deb.sh`

Verify installation of additional packages.
If necessary, exit minknow service status dialogue by pressing “q”.

After the completion of this scipt you should see something like the following:

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/cuda_on_guppy.png)

You should see an entry in the second but last line, indicating that .../bin/guppy_basecall_server is using more than 3.5 GB of GPU.

## Minknow UI
* Ensure no Minion Unit is connected to the control PC.
* Start Minknow UI from the start menu (upper left corner with little mouse head; enter 'minknow').
* Login with your Nanopore account or as a guest. In the next dialogue box “update available”, *skip this version*. If there is no response to any mouse click and there is a dialogue for tutorials, choose in the upper right corner: ship all tutorials by clicking three vertical dots and then skip tutorials (or something similar).
* For the time being, please, *never ever* choose update of minknow. Any update will prevent all scripts developed for our nanodip pipeline from proper execution and you will not obtain any useful results.

After starting the Minknow User Interface, you should see something similar to the following image

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/Minknow_UI_start_screen.png)

## After connecting the Minion unit with a flow cell inserted you should see something like:

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/Minknow_UI_Minion_w_FC.png)

Your setup should be now ready for sequencing.
Please verify this by starting a short test sequencing run with an old flow cell in the Minknow UI.

# Reference data:
NanoDip will not work without reference data.
Chromium should be your default browser.

Please use Chromium to obtain reference data (app 80 GB) from:
https://drive.google.com/drive/folders/11DnOE7ET3MmbQ9q8HbXoqvSZqgjSI-NZ?usp=sharing
Please download the reference data as multiple zip files to the /home/minknow/Downloads directory

*There are chances you will have to resume the file transfers*
*After the creation of  a zip file, please do allow the determination of your location by chromium/ google. Otherwise the download will not start at all and you will have to resume it.*

Do *NOT* proceed before you have completed the download of all 28 zip files.

After completion, run
/home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script directory/d_reference_data.sh.

# Starting  NanoDip UI
Currently you can launch NanoiDip from Jupyter Notebook. Further possibilities to start the code shall be provided in due time.

Please run:

'/home/minknow/scripts/activate_nanodip_jupyter_notbook.sh'

Chromium should start and display the following page:

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/nanodip_Jupyter_startpage.png)

Double click NanoDiP_allinOne.ipyb.

In Chromium you will see (with out the red circle):
![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/NanoDiP_startpage_in_Jupyter.png)

Please double click the double arrow in the red circle and the subsequent dialogue box "Restart and run all cells" and upon completion open a new tab (ctrl +T) ansd enter http:localhost:8080.

The next page you see will be similar to (without the red arrow):
![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/NanoDiP_startpage_in_Jupyter.pngNanoDiP_start_page_arrow.png)

# Verify the installation:
## NanoDip starting of one test run
With a Minion (containing a flow cell) connected to the USB3 port of the control PC,
Select Start test run (above the red circle "1")
A six minute test run should be initiated. Depending on the age of your flow cell you could see read generated in MinKnow.

## Activate playback run.
In the reference files you downloaded there is a "raw" fast 5. In very simple terms, the is a recording of all electric signals obtained during sequencing a human sample. *Upon activation of a playback run the  recorded signals are send form the Minion sequencing unit,  do no longer record any signals resulting from the seuquencing of your sample but those recorded in our lab.*

## *Please deactivate the playback feature after the completion of following system test steps.*

To activate the playback test feature, please close Minknow UI and run:

`/home/minknow/scripts/playback_true.sh`

Start Minknow again and in the nanodip UI start the next testrun. In playback mode you will see reads generated in Minknow.

After successfull completion of the second test run, please start a run in playback mode (link above the blue 2) and coose the GSE90496.xls reference set:

After this simulated test run was started, under Mk1b status you are advised to select:
![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/terminate_run_150_MB_box.png).

In the Analyze selection, please choose: get_CpGs (1 in below screenshot):
![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/Analyze_dialogue.png)

The number of the CPG has to increase over time. Otherwise the configuration of f5c is not correct.

Next choose plot cnv (2 in above screen shot).

At the beginning of the playback a raw copy number plot has to be shown.

Select plot UMAP against GSE90496_ifP01 (#3 in above screenshot).

After the simulated sequencing run reached app. 150 MB  it should be terminated by NanoDiP without any user intervention.

You should obtain the following:


Copy number plot:

and UMAP plot.

Upon completion, please deactivate the playback feature by running in the terminal:

`/home/minknow/scripts/playback_FALSE.sh`.
