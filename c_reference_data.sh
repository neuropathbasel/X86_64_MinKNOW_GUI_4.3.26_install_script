#!/bin/bash
#
echo "please continue this script only after completion of the download of the reference data. incomplete downlaods will result in errors"

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
cd /home/minknow/Downloads

#unpacking of the zip archives of the reference data

#for z in *.zip; do unzip "$z"; done

#for z in `ls *.zip`; do unzip $z; done


#move raw fast file to /data/raw_seq_files
sudo mkdir -p /data/raw_seq_files
sudo chown minknow /data/raw_seq_files
#mv *.fast5 /data/raw_seq_files
