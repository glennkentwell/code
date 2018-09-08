#!/bin/bash

screen="eDP-1" 	# call xrandr to show list of displays and get this
width=1366		# do xrandr | grep '*' to find the current resolution
height=768
scaleby=1.4	# let's make it smaller yo
DEBUG=1

###############################################################################

function debug() {
	if [ 0 -lt $DEBUG ]; then
		echo $*
	fi
}

resolution=$width"x"$height

newwidth=$( printf %.0f $( echo "$width*$scaleby" | bc ) )
newheight=$( printf %.0f $( echo "$height*$scaleby" | bc ) )
newresolution=$newwidth"x"$newheight
cmd="xrandr --output $screen --mode $resolution --scale $scaleby"x"$scaleby --panning $newresolution"

debug new height is $newheight
debug new width is $newwidth
debug new resolution is $newresolution
debug $cmd

# run the xrandr command
bash -c "$cmd"
