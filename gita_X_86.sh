#!/bin/bash
#
echo "This will push everything in "`pwd`" to GitHub..."
git add -A
git commit -m "update"
git push https://git@github.com:neuropathbasel/X86_64_MinKNOW_GUI_4.3.26_install_script
