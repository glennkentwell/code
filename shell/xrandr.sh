#!/bin/bash

# screen="eDP1"
# width=1366
# height=768
scaleamt="$1"

DEBUG=1
logfn="/tmp/xrandr.log"

function debug() {
	if [ 0 -lt $DEBUG ]; then
		echo $* >> "$logfn"
	fi
}
debug "#### $( date +%Y-%m-%dT%H:%M:%S%z ) ######################################################################"
debug $( printf "0: %s\n1: %s\n2: %s\n3: %s\n" $0 $1 $2 $3 )
function scaleby() {
	defaultamt=1
	if [ "" == "$scaleamt" ]
	then 
		debug "scale factor was empty so $defaultamt"
		printf "%2.0f\n" $defaultamt | sed -e 's/\ //g'
		exit
	fi
	debug "scale factor was NOT empty so it is $scaleamt"
	printf "%2.0f\n" "$scaleamt" | sed -e 's/\ //g'
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
# export -f multiply

screen=$( screenname )
scaleamt=$( scaleby )
width=$( nativeresx )
height=$( nativeresy )
debug scale is "$scaleamt"
debug current resolution is $( currentresx ) by $( currentresy )
debug native resolution is $( nativeresx ) by $( nativeresy )
debug width is "$width*$scaleamt"
debug height is "$height*$scaleamt"

resolution=$width"x"$height

newwidth=$( multiply $width $scaleamt )
debug "raw newwidth is $newwidth"
debug $( printf "formatted newwidth is %2.0f\n" $newwidth )

newheight=$( multiply $height $scaleamt )
debug "raw new height is $newheight"
debug $( printf "new height is: %2.0f\n" "$newheight" )

newresolution=$newwidth"x"$newheight
cmd="xrandr --output $screen --mode $resolution --scale $scaleamt"x"$scaleamt --panning $newresolution"

debug new height is $newheight
debug new width is $newwidth
debug new resolution is $newresolution
echo "here"
debug $( printf "cmd is %s" "$cmd" )
echo "here2"
# run the xrandr command
bash -c "$cmd"
