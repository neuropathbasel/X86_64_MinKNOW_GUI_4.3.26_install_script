#!/bin/bash
#this script is for moving reference data to /applications/reference_data/betaEPIC450Kmix_bin folder
#
#raw sequening example files to
#installation of  nanodip dependencies

#wirte current working directory to a variable
curr_dir=`pwd`
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
cp $curr_dir/activate_nandip_python.sh ~/scripts/
chmod +x ~/scripts/activate_nandip_python.sh
cp $curr_dir/activate_nanodip_jupyter_notebook.sh ~/scripts/
chmod +x ~/scripts/activate_nanodip_jupyter_notebook.sh

ln -s ~/scripts/activate_nandip_python.sh ~/Desktop/
#ln -s ~/scripts/activate_nanodip_jupyter_notebook.sh ~/Desktop/

#scirpts and files for activating / dectivating playbackmode with known reference for GBM
cd /data/
mkdir -p raw_seq_files

mkdir -p /home/minknow/scripts/TOML

#scripts are defined in d_reference_data.sh
