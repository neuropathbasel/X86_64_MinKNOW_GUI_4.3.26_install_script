#!/bin/bash
#note: there must be no /var/lib/minknow/data directory - not as a physical or as a symbolic linked director.
#if this directory exists, remove it or rename it before starting the installation
#this script is for internal use at the IFP only

#To be started in the ~/Downloads/priv_test directory.
#working directory might change in the future
#wirte current working directory to a variable
curr_dir="$PWD"

#read in passwords for unattended installation
#echo "Please enter password for local user minknow"
#read PW_minknow

#echo "please enter password for jhench on meqneuropat01"
#read PW_JHench01

#echo "please enter password for jhench on meqneuropat02"
#read PW_JHench02


#copy debians via scp from meqneuropat to current working directory
#echo $PW_JHench02 | scp jhench@meqneuropat02.uhbs.ch:/mnt/patholabor/NGS_Diagnostik/SangerSeq/molPath_software/MinKNOW/MinKNOW_4.3.26_20210929_x86_64_1804/* .


sudo apt-get -y install -f
sudo dpkg -i ont-jwt-auth_0.28-1~bionic_amd64.deb
sudo dpkg -i minknow-core-minion-nc_4.3.12-bionic_amd64.deb
sudo usermod -aG sudo minknow
sudo usermod -aG user minknow
sudo dpkg -i ont-bream4-minion_6.2.6-1~bionic_all.deb
sudo dpkg -i ont-configuration-customer-minion_4.3.11-1~bionic_all.deb
sudo dpkg -i ont-kingfisher-ui-minion_4.3.26-1~bionic_all.deb
sudo dpkg -i ont-vbz-hdf-plugin_1.0.0-1~bionic_amd64.deb
sudo dpkg -i ont-guppy-cpu-for-minion_5.0.13-1~bionic_amd64.deb
sudo apt-get -y install -f
sudo dpkg -i ont-guppyd-for-minion_5.0.13-1~bionic_all.deb
sudo dpkg -i minion-nc_21.06.10-1~bionic_all.deb
#sudo service minknow status
#sudo service minknow start
#sudo service minknow status
#nvidia-smi

#GUPPy in GPU mode - extracted form local tar.gz archive
sudo mkdir -p /applications
sudo chmod a=rwx /applications/
#cd ~/Downloads/MinKNOW_4.3.26_20210929_x86_64_1804

#one way - via ONT Downloads
#wget https://mirror.oxfordnanoportal.com/software/analysis/ont-guppy_5.0.14_linux64.tar.gz
#placed a copy in this debian collection
#direct unpacking to /applications
tar xvf ont-guppy_5.0.14_linux64.tar.gz -C /applications

#rename /applications/ont-guppy directory
sudo mv -T /applications/ont-guppy /applications/ont-guppy_5.0.14_linux64_GPU

#reconfiguration so that GPU guppy is us used
sudo service minknow stop
sudo service guppyd stop

#replace guppyd.service config file
sudo cp add_config_files/guppyd.service /lib/systemd/system/guppyd.service
sudo rm -rf /etc/systemd/system/guppyd.service
sudo rm -rf /etc/systemd/system/guppyd.service.d
sudo ln -s /lib/systemd/system/guppyd.service /etc/systemd/system/

sudo mkdir -p /data
sudo chown minknow /data
sudo mv /var/lib/minknow/data /var/lib/minknow/data_old
sudo ln -s /data /var/lib/minknow/data

#create directories needed for nanodip
sudo mkdir -p /data/nanodip_reports
sudo chown minknow /data/nanodip_reports

sudo mkdir -p /data/nanodip_output
sudo chown minknow /data/nanodip_output

#echo $PW_minknow|sudo systemctl daemon-reload
#echo $PW_minknow|sudo service guppyd start
nvidia-smi

#set chromium as default browser
#echo $PW_minknow|sudo update-alternatives --set x-www-browser /usr/bin/chromium-browser

xdg-settings set default-web-browser chromium-browser.desktop

#test if nvidia-smi is still working
nvidia-smi

#installation of  nanodip dependencies
cd /applications

git clone https://github.com/neuropathbasel/nanodip_dependencies.git

cd nanodip_dependencies
chmod +x all_build_x86_64.sh

./all_build_x86_64.sh

#installation of nanodip

cd /applications

git clone https://github.com/neuropathbasel/nanodip.git

cd nanodip

chmod +x python_37_nanodip_venv_setup.sh

./python_37_nanodip_venv_setup.sh

#dialogue before reboot to find possible errors that might occur
echo "Please remove any external USB stick after unmounting it from the File explorer"
echo "Please attach the minion unit to a USB3 port"

read -p "please enter y to restart the minknow service " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo $PW_minknow|sudo service minknow restart
fi

#copy scripts for starting the virtual environment for epidip and the jupyter notebook to ~/scripts
cp $curr_dir/activate_nandip_venv.sh ~/scripts/
chmod +x ~/scripts/activate_nandip_venv.sh
cp $curr_dir/activate_nanodip_jupyter_notebook.sh ~/scripts/
chmod +x ~/scripts/activate_nanodip_jupyter_notebook.sh

ln -s ~/scripts/activate_nandip_venv.sh ~/Desktop/
ln -s ~/scripts/activate_nanodip_jupyter_notebook.sh ~/Desktop/


#dialogue before reboot to find possible errors that might occur
#read -p "please enter y for immidiate reboot" -n 1 -r
#echo    # (optional) move to a new line
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
#    echo $PW_minknow|sudo reboot
#fi

#scirpts and files for activating / dectivating playbackmode with known reference for GBM
cd /data/
mkdir -p raw_seq_files
#sudo chown minknow /data/raw_seq_files

#scp jhench@meqneuropat01.uhbs.ch:/mnt/8TBraid03/imagesets/Nanopore_RAW/meqneuropat17_20210311_1152_FAP12445_MN26891_sequencing_run_B2021_10463_20210311_BC06_cc9c5597.fast5 /data/raw_seq_files/

mkdir -p /home/minknow/scripts/TOML

#sudo chown minknow /home/minknow/scripts/TOML

#scp jhench@meqneuropat02.uhbs.ch:/mnt/patholabor/NGS_Diagnostik/SangerSeq/molPath_software/MinKNOW/MinKNOW_4.3.26_20210929_x86_64_1804_TOML/* /home/minknow/scripts/TOML
#cd /home/minknow/scripts/TOML
#chmod 666 *

#copy shell scripts for copying of TOML files to ~/scripts
#cp $curr_dir/playback_FALSE.sh /home/minknow/scripts/
#chmod +x /home/minknow/scripts/playback_FALSE.sh

#cp $curr_dir/playback_true.sh /home/minknow/scripts/
#chmod +x /home/minknow/scripts/playback_true.sh

#still missing: copy remaining reference data to /applications/references data
#betaEPIC4505mix_bin, hg19, hg19_cnv, reference_annotations
#10.11.2021 am einfachsten: rm-rf /applications/reference_data und referncen data von meqneuropa01 kmplett wieder rüber kopieren
#rm -rf /applications/reference_data/
#mkdir /applications/reference_data/

#echo $PW_JHench01|scp -rp jhench@meqneuropat01.uhbs.ch:/mnt/16TBraid01/reference_data_nanodip_2021_11_09/* /applications/reference_data
