#/bin/sh

vnc4server -kill :1
sleep 10
vnc4server -geometry 1700x1050 -alwaysshared :1
sleep
