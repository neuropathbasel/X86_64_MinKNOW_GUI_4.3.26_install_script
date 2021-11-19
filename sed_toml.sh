#!/bin/bash
#translocation_speed_max = 425

#path to raw seq file



sed '/^anothervalue=.*/a after=me' test.txt
#!/bin/bash
RawPath=/data/raw_seq_files/BRCA_playback_FAQ19962_MN35285_6081f4aa_BC01.fast5
TOML=/home/minknow/scripts/TOML/sequencing_MIN106_DNA.toml
pbTOML=/home/minknow/scripts/TOML/sequencing_MIN106_DNA.toml.playback
sim_line='simulation=/path/to/file'
sed '/^translocation_speed_max.*/a '$sim_line'' $TOML > $pbTOML


#working version  Fr 19.11.2021 16.18 hrs
#!/bin/bash
RawPath=/data/raw_seq_files/BRCA_playback_FAQ19962_MN35285_6081f4aa_BC01.fast5
TOML=/home/minknow/scripts/TOML/sequencing_MIN106_DNA.toml
pbTOML=/home/minknow/scripts/TOML/sequencing_MIN106_DNA.toml.playback
sim_line='simulation='$RawPath''
sed '/^translocation_speed_max.*/a '$sim_line'' $TOML > $pbTOML
