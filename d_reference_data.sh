#!/bin/bash
#this script is for moving reference data to /applications/reference_data/betaEPIC450Kmix_bin folder
#
#raw sequening example files to
echo "please continue this script only after completing the download of the reference data."
echo "please downlaod form :"
echo "https://drive.google.com/drive/folders/11DnOE7ET3MmbQ9q8HbXoqvSZqgjSI-NZ?usp=sharing"
echo "Incomplete downloads will result in errors"
echo "In case you did modify the default downlaod path in your browser"
echo "Please copy all reference and xlsx file to /home/minknow/Downloads/"

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
#existing files are overwritten in case some archives have been downloaded more than once
for z in `ls *.zip`; do unzip -o $z; done

#move raw fast file to /data/raw_seq_files
sudo mkdir -p /data/raw_seq_files
sudo chown minknow /data/raw_seq_files
mv /home/minknow/Downloads/epidip_nanodip_distribution/demo_data/raw_fast5/*.fast5 /data/raw_seq_files

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

#copy scripts for activating / deactivating playback to ~/scripts
cp /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script/playback_true.sh /home/minknow/scripts/
cp /home/minknow/Downloads/X86_64_MinKNOW_GUI_4.3.26_install_script/playback_FALSE.sh /home/minknow/scripts/

#move all bin file with beta values to /applications/reference_data/betaEPIC450Kmix_bin folder
sudo mv /home/minknow/Downloads/epidip_nanodip_distribution/reference_data/betaEPIC450Kmix_bin/ /applications/reference_data/

mkdir -p /applications/reference_data/reference_annotations
sudo chown minknow:minknow /applications/reference_data/reference_annotations

#cd /home/minknow/Downloads
mv ~/Downloads/epidip_nanodip_distribution/reference_annotations/GSE90496_IfP01.xlsx /applications/reference_data/reference_annotations
mv ~/Downloads/epidip_nanodip_distribution/reference_annotations/GSE90496.xlsx /applications/reference_data/reference_annotations
mv ~/Downloads/epidip_nanodip_distribution/reference_annotations/AllIDATv2_20210804.xlsx /applications/reference_data/reference_annotations
mv ~/Downloads/epidip_nanodip_distribution/reference_annotations/20210721_EpiDiP_anno.xlsx /applications/reference_data/reference_annotations

chmod a=r /applications/reference_data/reference_annotations/*

##move  für copy number plotsminkno
#reference data for copy number
mv /home/minknow/Downloads/epidip_nanodip_distribution/reference_data/hg19_cnv/ /applications/reference_data/
