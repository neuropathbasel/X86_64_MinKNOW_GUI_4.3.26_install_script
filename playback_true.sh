#!/bin/bash

sudo cp TOML/sequencing_MIN106_DNA.toml.playback /opt/ont/minknow/conf/package/sequencing/sequencing_MIN106_DNA.toml
sudo service minknow restart
