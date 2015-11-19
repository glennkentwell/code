#!/bin/sh

# create a file named rygel.off in your homedir to disable rygel starting
OFF="$HOME/rygel.off"
if [ -f "$OFF" ]; then exit; fi

# where rygel logs to
LOG="$HOME/rygel.log"
# rygel config file
CFG="$HOME/.config/rygel.conf"

pid=$(pidof rygel)
if [ -z "$pid" ]
then
    echo >> "$HOME/rygel.log"
    echo Starting rygel >> "$HOME/rygel.log"
    date +%c >> "$HOME/rygel.log"
    rygel -c "$HOME/.config/rygel.conf" 2>> "$HOME/rygel.log"
fi
