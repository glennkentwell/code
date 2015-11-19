#!/bin/sh

pid=$(pidof rygel)

if [ -z "$pid" ]; then

    echo >> $HOME/rygel.log
    echo Starting rygel >> $HOME/rygel.log
    date +%c >> $HOME/rygel.log
    rygel -c $HOME/.config/rygel.conf 2>> $HOME/rygel.log
fi

