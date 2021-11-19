#!/bin/bash
#this script is for moving reference data to /applications/reference_data/betaEPIC450Kmix_bin folder
#
#raw sequening example files to
echo "please continue this script only after completing the download of the reference data. Incomplete downloads will result in errors"

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
#existing files are overwritten in case some archives have been downlaoded more than once
for z in `ls *.zip`; do unzip -o $z; done

#move raw fast file to /data/raw_seq_files
sudo mkdir -p /data/raw_seq_files
sudo chown minknow /data/raw_seq_files
mv /home/minknow/Downloads/raw_fast5/*.fast5 /data/raw_seq_files

#create directory for TOML files to activate/ deactivate playback mode using the provided raw fast5 file
sudo mkdir -p /home/minknow/scripts/TOML
sudo chown minknow /home/minknow/scripts/TOML

#backup copy of sequencing_MIN106_DNA.toml
sudo cp /opt/ont/minknow/conf/package/sequencing/sequencing_MIN106_DNA.toml /home/minknow/scripts/TOML/
sudo chown minknow:minknow /home/minknow/scripts/TOML/*

#create a toml file for playback
RawPath='"/data/raw_seq_files/BRCA_playback_FAQ19962_MN35285_6081f4aa_BC01.fast5"'
TOML=/home/minknow/scripts/TOML/sequencing_MIN106_DNA.toml
pbTOML=/home/minknow/scripts/TOML/sequencing_MIN106_DNA.toml.playback
sim_eq="simulation="
sim_line="$sim_eq$RawPath"
sed '/^translocation_speed_max.*/a '$sim_line'' $TOML > $pbTOML


#move all bin file with beta values to /applications/reference_data/betaEPIC450Kmix_bin folder
sudo mv /home/minknow/Downloads/betaEPIC450Kmix_bin/ /applications/reference_data/

cd
mkdir -p /applications/reference_data/reference_annotations
sudo chown minknow:minknow /applications/reference_data/reference_annotations

cd /home/minknow/Downloads
mv GSE90496_IfP01.xlsx /applications/reference_data/reference_annotations
mv GSE90496.xlsx /applications/reference_data/reference_annotations
mv AllIDATv2_20210804.xlsx /applications/reference_data/reference_annotations
mv 20210721_EpiDiP_anno.xlsx /applications/reference_data/reference_annotations


#wget https://docs.google.com/spreadsheets/d/1svy9s3noE8-rBxri_mU7OOWEw7MTrNDw/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true
#wget https://docs.google.com/spreadsheets/d/1qSNZKaQxYbvBvGg1mZgRas7IqmmGNxBI/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true
#wget https://docs.google.com/spreadsheets/d/1UcPHsbph9RoWKnGXSBPhFG35PEVbYscK/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true
#wget https://docs.google.com/spreadsheets/d/1A50bFWUBPBgO00AHYYfaE8H3iTZrGKNo/edit?usp=sharing&ouid=106878302393215457558&rtpof=true&sd=true
