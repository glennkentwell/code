#!/bin/bash
MAILTO=""

DEBUG=$1

# only do all the checking and alerting stuff if not plugged in
charging=`ibam -as|grep profile|grep -c charge`
if [ $charging -ne 0 ]; then exit; fi

export DISPLAY=:0
secs=`ibam -as|grep Adapted\ battery|awk '{print $5}'`

if [ -n "$DEBUG" ]; then echo $secs aka $(($secs / 60)) minutes; fi

if [ $secs -lt $((60 * 6)) ]; then 
	# notify-send -u critical "BATTERY VERY LOW!" "Only $(($secs/60)) minutes remaining"
	feh -F ~/scr/img/battery_low_neutondesigns.jpg
	if [ -n "$DEBUG" ]; then logger -t checkbattery "BATTERY LOW" "Only $(($secs/60)) minutes remaining"; fi
elif [ $secs -lt $((60 * 10)) ]; then
	notify-send -u critical "BATTERY LOW" "Only $(($secs/60)) minutes remaining"
	if [ -n "$DEBUG" ]; then logger -t checkbattery "BATTERY LOW" "Only $(($secs/60)) minutes remaining"; fi
elif [ $secs -lt $((60 * 20)) ]; then
	notify-send -u low "Battery getting low" "$(($secs/60)) minutes remaining"
	if [ -n "$DEBUG" ]; then logger -t checkbattery "Battery getting low" "$(($secs/60)) minutes remaining"; fi
fi
 

