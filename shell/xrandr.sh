#!/bin/bash

DEBUG=1
logfn="/tmp/xrandr.log"
scaleamt="$1"

function debug() {
	if [ 0 -lt $DEBUG ]; then
		echo $* >> "$logfn"
	fi
}
debug "#### $( date +%Y-%m-%dT%H:%M:%S%z ) ######################################################################"

function printargs() {
	debug $( printf "CLI Arguments: 0: %s\n1: %s\n2: %s\n3: %s\n" $0 $1 $2 $3 )
}
function scaleby() {
	defaultamt=1.2
	if [ "" == "$scaleamt" ]
	then 
		debug "scale factor was empty so $defaultamt"
		printf "%2.2f\n" $defaultamt | sed -e 's/\ //g'
	else
		debug "scale factor was NOT empty so it is $scaleamt"
		printf "%2.2f\n" $scaleamt | sed -e 's/\ //g'
	fi
}
# test scale multiplier func
function scaletest() {
	if [ "" != "$SCALETEST" ]
	then
		debug "just testing scale func"
			scaleamt="1.2"
		scale=$( scaleby )
#		debug $( printf "scale is: %2.2f, scaleby becomes %2.2f", "0$1", $scale )
		echo
		scaleamt="0.2"
		scale=$( scaleby )
#		debug $( printf "scale is: %2.2f, scaleby becomes %2.2f", "0$1", $scale )
		echo
		scaleamt="-2.1"
		scale=$( scaleby )
#		debug $( printf "scale is: %2.2f, scaleby becomes %2.2f", "0$1", $scale )
		echo
	
		exit
	else
		debug "Not testing scalefunc: $SCALETEST"
	fi
}
function xrandrline1() {
	xrandr --prop | head -n 1
}
function currentresx() {
	xrandrline1 |\
		awk -F, '{ split($2, res, " "); } END { print res[2]; }'
}
function currentresy() {
	xrandrline1 |\
		awk -F, '{ split($2, res, " "); } END { print res[4]; }'
}
function nativeresx(){
	xrandr --prop |\
		awk /\ \ \ [0-9]+x[0-9]+/ | grep '*' | awk '{ split($1, res, "x"); print res[1]; }' 
}
function nativeresy() {
	xrandr --prop |\
		awk /\ \ \ [0-9]+x[0-9]+/ | grep '*' | awk '{ split($1, res, "x"); print res[2]; }' 
}
function screenname() {
	xrandr --prop |\
		head -n 2 | tail -n 1 | awk '{print $1}'
}
function multiply() {
	res="$1"
	multiplier="$2"
	if [ -z "$res" ] || [ -z "$multiplier" ]
	then
		debug "multiply(): missing either the resolution ($res) or the scale factor ($multiplier)"
	else
		product=$( echo "$res * $multiplier" | bc )
	fi
	echo "$product"
}
# export -f scaleby
# export -f multiply

scaletest "$0"

screen=$( screenname )
scaleamt=$( scaleby ) 
width=$( nativeresx )
height=$( nativeresy )
debug scale is "$scaleamt and not $1"
debug current resolution is $( currentresx ) by $( currentresy )
debug native resolution is $( nativeresx ) by $( nativeresy )
debug width is "$width*$scaleamt"
debug height is "$height*$scaleamt"

resolution=$width"x"$height

newwidth=$( printf "%2.0f\n" $( multiply $width $scaleamt ) )
debug $( printf "formatted newwidth is %2.0f\n" $newwidth )

newheight=$( printf "%2.0f\n" $( multiply $height $scaleamt ) )
debug $( printf "new height is: %2.0f\n" "$newheight" )

newresolution=$newwidth"x"$newheight
cmd="xrandr --output $screen --mode $resolution --scale $scaleamt"x"$scaleamt --panning $newresolution"

debug new height is $newheight
debug new width is $newwidth
debug new resolution is $newresolution
debug $( printf "cmd is %s" "$cmd" )

# run the xrandr command
bash -c "$cmd"

