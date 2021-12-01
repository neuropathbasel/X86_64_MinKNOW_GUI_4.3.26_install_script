# X86_64_MinKNOW_GUI_4.3.26_install_script #

Scripted installation of Minknow control software version 4.3.26, nvidia GPU drivers and CUDA for GPU based base calling and GPU based sequence analysis such as methylation calling.

The following series of steps was found to work with more than three different PCs of different vendors.

## this is work in progress
Before getting started, please refresh this page to work with the latest version.

## Prerequisite
* Knowledge of Linux command line and VNC.
* PC equipped with GPU (>= 8GB RAM) and *one* SSD or HDD with at least 1 TB capacity, 1 USB3 port and access to the internet.
* Ubuntu 18.04 installed on the above mentioned PC with only *one user* called *minknow*.
* Minion unit. The Unit *must not be connected*  to the PC while the first two scripts detailed below are executed. You will be asked to connect the Minion Unit.
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

Please note:  For unclear reasons firefox crashes during the system updates. However, this does (so far) not impair this procedure.

Upon completion, you will be asked for verification of a reboot.

Make sure there is *no* Minion unit connected to the PC. A connected Minion device can impair system startup.

# After reboot

Only command line login prompt is shown on the screen attached to the control PC.

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

*copy debian files defined above to /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script/ directory*

In the /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script/ directory run

`./b_minknow_guppy_install_deb.sh`

Verify installation of additional packages.
If necessary, exit minknow service status dialogue by pressing “q”.

After the completion of this script you should see something like the following:

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/screenshots/cuda_on_guppy.png)

You should see an entry in the second but last line, indicating that .../bin/guppy_basecall_server is using more than 3.5 GB of GPU memory.

## Minknow UI
* Ensure no MinION Unit is connected to the control PC.
* Start MinKNOW UI from the start menu (upper left corner with little mouse head; enter 'minknow').
* Login with your Nanopore account or as a guest. In the next dialogue box “update available”, *skip this version*. If there is no response to any mouse click and there is a dialogue for tutorials, choose in the upper right corner: ship all tutorials by clicking three vertical dots and then skip tutorials (or something similar).
* For the time being, please, *never ever* choose to update of MinKNOW. Any update will prevent all scripts developed for our nanodip pipeline from proper execution and you will not obtain any useful results. It will be hard or impossible to revert to the state before applying an update.

After starting the MinKNOW User Interface, you should see something similar to the following image

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/screenshots/Minknow_UI_start_screen.png)

*After connecting the MinION unit with a flow cell inserted you should see something like:*

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/screenshots/Minknow_UI_Minion_w_FC.png)

Your setup should be now ready for sequencing.
Please verify this by starting a short test sequencing run with an old flow cell in the Minknow UI.

#NanoDiP
 After a successful hardware check.
 In the /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script/ directory run in the terminal

 `./c_nanodip_and_dependencies.sh`

 For compatibility reasons most of the programs used in the NanoDiP pipeline have to be compiled from source, this step will take some time.

# Reference data:
NanoDiP will not work without reference data.

## Download of reference data

Please use Chromium to obtain reference data (approx. 80 GB) from:
https://drive.google.com/drive/folders/11DnOE7ET3MmbQ9q8HbXoqvSZqgjSI-NZ?usp=sharing

Please download the reference data as multiple zip files to the /home/minknow/Downloads directory

*After the creation of  a zip file, please do allow the determination of your location by chromium/ google. Otherwise the download will not start at all and you will have to resume it.*

Do *NOT* proceed before you have completed the download of all (typically 28 zip) files.

The google server will generate the zip files ad hoc for your particular download. This process will also take some time. Do not interrupt this process. Furthermore, you may be asked to allow downloading of multiple files simultaneously.

## Script for moving the reference data to the correct folders

After completion of the download, run in the terminal

`cd /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script`

`./d_reference_data.sh`

# Starting  NanoDip UI in Jupyter Notebook for testing the installation and configuration
For testing the configuration you can launch NanoDiP from Jupyter Notebook. Further possibilities to start NanoDiP will be given below.

In the terminal please run:

`cd ~/scripts`

`./activate_nanodip_jupyter_notbook.sh`

Chromium should start and display the following page:

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/screenshots/nanodip_Jupyter_startpage_crop.png)

Single click NanoDiP_allinOne.ipyb.

In Chromium you will see (with-out the red circle):
![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/screenshots/NanoDiP_startpage_in_Jupyter.png)

Please double click the triangle icon within the red circle and the subsequent dialogue box "Restart and run all cells" and upon completion open a new tab (ctrl +T) and enter http//:localhost:8080.

The next page you see will be similar to (without the red and blue circles containing numbers 1 and 2):
![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/screenshots/NanoDiP_start_page_numbers.png)

# Verify the installation:
## NanoDip starting of one test run
With a MinION (containing an old, used flow cell) connected to the USB3 port of the control PC,
Select Start test run (above the red circle "1").
A six minute test run (with a total run time of app. 11 minutes) will be initiated. Depending on the age of your flow cell you could see read generated in MinKNOW.

## Activate playback run.
In the reference files you downloaded there is a "raw" fast-5. In very simple terms, this is a recording of all electric signals obtained during sequencing a human DNA in our lab. Upon activation of a playback run, a simulation based on this "old" sequencing run is initiated. The  signals recorded in our lab for one selected sample are simulated as if they came from the MinION sequencing unit attached to your control PC. The purpose of the playback run is the verification of the setup. Playback runs can be used for other test purposes as well, in particular for software development. Playback requires a physical MinION to be connected to your computer and a real flow cell to be inserted. The real flow cell ID will be used. Note that the temperature of the flow cell will not be adjusted and that it is 35 instead of 34 degrees C.

*Important: All signals  recorded in playback mode do not reflect the sample you potentially loaded in the flow cell*. During the test phase, do not load your flow cell with relevant samples and preferably use a flow cell at the end of its life.

## *Please deactivate the playback feature after the completion of following system test steps.*

To activate the playback test feature, please close MinKNOW UI and run in the /home/minknow/scripts/ directory:

`./playback_true.sh`

Start MinKNOW again and in the NanoDiP UI (in Chromium) start the next testrun. In playback mode you will see reads generated in Minknow.

After successful completion of the second test run, please start a simulated run in playback mode (link above the blue 2), enter on the next page the sample name and choose in addition the AllIDatv2_20200804.xls as reference set from the drop down menue.

After this simulated test run was started, under Mk1b status you are advised to single-click:

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/screenshots/terminate_run_150_MB_box.png)

This will activate an automatic termination program in a new browser tab. Upon reaching 150 megabases of simulated sequencing, the termination program will stop the sequencing procedure. Basecalling will continue unless already completed. 150 megabases have empirically been determined to be sufficient for tumor classification.

While the sequencing procedure is running and after the run terminator has been launched, navigate to the Analyze selection, then single-click: get_CpGs (1 in below screenshot):

In the Analyze selection, please choose: get_CpGs (1 in below screenshot):

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/screenshots/Analyze_dialogue.png)

Another new tab will open and the number o analyzed fast5 files that have been screened for diagnostically relevant CpG (methylation) sites should increase over time. Each fast5 file will contain 400 reads and analysis takes about 30 seconds per file. If many thousands of reads have been collected and the file counter does not increase, methylation calling (depening on guppy, minimap2, samtools, f5c, and R) does not work correctly.

After obtaining the first completely "aligned and methylation called" fast-5 (i.e. counter increments), single-click  plot CMV (#2 in above screen shot). Again, a new tab will open.

After having obtained 3 or more "aligned and methylation called" fast5 files, a (coarse) copy number plot will appear. Re-loading of the tab will re-initiate CNV plotting. The more fast5 files, the longer the computation will take.

In order to analyze methylation data, single-clickSelect plot UMAP against AllIDATv2_20210804GSE90496_ifP01 (#3 in above screenshot). Depending on the amount of data "sequenced" so far by the simulation, the UMAP plot will show separate clusters for reference datasets and an arrow indicate the current run.

After the simulated sequencing run reached app. 150 MB  it should be terminated by NanoDiP without any user intervention.

# You should obtain the following plots:

## Copy number plot:

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/screenshots/2021_11_30_cnv_plot_run_completed.png)

Please verify that you can create a pdf report.

## UMAP plot.

![picture alt](https://github.com/neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script/blob/main/screenshots/2021-12-01_14-10-25_UMAP_ifp_references.png)

#place correct  scrrenshot#

# Upon completion, please deactivate the playback feature by running in the terminal:
 in the /home/minknow/scripts/ dirctory run:

`./playback_FALSE.sh`

In case of any error messages or deviations from above description, please contact us.

# Routine operation of NanoDiP

After successful completion of the tests described above, please
start NanoDiP  by entering in the terminal:

`cd /home/minknow/scripts`

and

 `./activate_nandip_python.sh`

 or double click the NanoDip Ikon/link on the desktop.

In both cases chromium will start. Please press "F5" or refresh. You will see the NanoDiP UI in chromium with the features described above.

#In case any test above should fail

In a fist rest, please, re-run in the /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script/ directory

`./c_nanodip_and_dependencies.sh`

So far most of recent issues we have seen were fixed this way. Our current scripts can be impaired by network interruptions. If these interruptions are encountered during the download of additional system libraries, compilation errors may occur that will impair subsequent compilation of R (libraries) and f5c.
