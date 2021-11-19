#!/bin/bash
RawPath='"/data/raw_seq_files/BRCA_playback_FAQ19962_MN35285_6081f4aa_BC01.fast5"'
TOML=/home/minknow/scripts/TOML/sequencing_MIN106_DNA.toml
pbTOML=/home/minknow/scripts/TOML/sequencing_MIN106_DNA.toml.playback
sim_eq="simulation="
echo "sim_eq:"
echo $sim_eq
sim_line="$sim_eq$RawPath"
echo "echo simline"
echo $sim_line
sed '/^translocation_speed_max.*/a '$sim_line'' $TOML > $pbTOML
