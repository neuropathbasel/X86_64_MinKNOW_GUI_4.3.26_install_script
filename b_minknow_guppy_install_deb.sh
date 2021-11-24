#!/bin/bash
#note: there must be no /var/lib/minknow/data directory - not as a physical or as a symbolic linked director.
#if this directory exists, remove it or rename it before starting the installation
#this script is for internal use at the IFP only

#To be started in the ~/Downloads/priv_test directory.
#working directory might change in the future
#wirte current working directory to a variable
curr_dir="$PWD"

#raw sequening example files to
echo "please continue this script only after copying the specified debian files of ONT to the current working directory"
echo    # (optional) move to a new line

#dialogue for termination of scipt
while true; do
    read -p "please press y for continuation of the script, n for termination:" yn
    echo ""
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "terminating scipt"; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "continuation of script"
cd /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script



sudo apt-get -y install -f
sudo dpkg -i ont-jwt-auth_0.28-1~bionic_amd64.deb
sudo apt-get -y install -f
sudo dpkg -i minknow-core-minion-nc_4.3.12-bionic_amd64.deb
sudo apt-get -y install -f
sudo usermod -aG sudo minknow
#sudo usermod -aG user minknow
sudo dpkg -i ont-bream4-minion_6.2.6-1~bionic_all.deb
sudo apt-get -y install -f
sudo dpkg -i ont-configuration-customer-minion_4.3.11-1~bionic_all.deb
sudo apt-get -y install -f
sudo dpkg -i ont-kingfisher-ui-minion_4.3.26-1~bionic_all.deb
sudo apt-get -y install -f
sudo dpkg -i ont-vbz-hdf-plugin_1.0.0-1~bionic_amd64.deb
sudo apt-get -y install -f
sudo dpkg -i ont-guppy-cpu-for-minion_5.0.13-1~bionic_amd64.deb
sudo apt-get -y install -f
sudo dpkg -i ont-guppyd-for-minion_5.0.13-1~bionic_all.deb
sudo apt-get -y install -f
sudo dpkg -i minion-nc_21.06.10-1~bionic_all.deb
sudo apt-get -y install -f
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

echo $PW_minknow|sudo systemctl daemon-reload
echo $PW_minknow|sudo service guppyd start

echo "please remove any USB dvice from the PC"
echo    # (optional) move to a new line

#dialogue for termination of scipt
while true; do
    read -p "please press y after removal of all USB storage devices, n for termination:" yn
    echo ""
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "terminating scipt"; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

#restart
sudo service minknow restart

#test if guppy is running in GPU mode
nvidia-smi
