#!/bin/bash

venvname=nanodipVenv01
venvpath=/applications

source $venvpath/$venvname/bin/activate

# launch the jupyter notebook
cd /applications/nanodip
python -m notebook
