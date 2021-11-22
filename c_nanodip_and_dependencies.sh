#!/bin/bash
#this script is for moving reference data to /applications/reference_data/betaEPIC450Kmix_bin folder
#
#raw sequening example files to
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
