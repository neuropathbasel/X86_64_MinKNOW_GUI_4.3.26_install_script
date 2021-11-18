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

#for z in `ls *.zip`; do unzip -o $z; done


#move raw fast file to /data/raw_seq_files
sudo mkdir -p /data/raw_seq_files
sudo chown minknow /data/raw_seq_files
mv /home/minknow/Downloads/raw_fast5/*.fast5 /data/raw_seq_files

#move all bin file with beta values to /applications/reference_data/betaEPIC450Kmix_bin folder
sudo mv /home/minknow/Downloads/betaEPIC450Kmix_bin/ /applications/reference_data/

cd /applications/reference_data/
mkdir -p reference_annotations
sudo chown minknow reference_annotations
wget https://docs.google.com/spreadsheets/d/1svy9s3noE8-rBxri_mU7OOWEw7MTrNDw/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true
wget https://docs.google.com/spreadsheets/d/1qSNZKaQxYbvBvGg1mZgRas7IqmmGNxBI/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true
wget https://docs.google.com/spreadsheets/d/1UcPHsbph9RoWKnGXSBPhFG35PEVbYscK/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true
wget https://docs.google.com/spreadsheets/d/1A50bFWUBPBgO00AHYYfaE8H3iTZrGKNo/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true
