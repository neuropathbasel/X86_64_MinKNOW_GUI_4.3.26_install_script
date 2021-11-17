#/bin/sh

vnc4server -kill :1
sleep 15
vnc4server -geometry 1700x1050 -alwaysshared :1
