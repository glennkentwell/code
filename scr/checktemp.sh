#!/bin/bash

# requires lm-sensors, to install, run:
# sudo apt-get install lm-sensors

# get each of the temps from 'sensors'
# this is pretty customised for the sensors in my machine lollll

numcores=$(grep cores /proc/cpuinfo |uniq|awk '{print $4}')
core=0
while [ "$core" -lt "$numcores" ]
do
	temps[$core]=`sensors|grep Core|awk '{print $3}'|head -n $(($core+1))|tail -n 1`	
    core=$(($core+1))
done
temps[$(($core+1))]=`sensors|grep Virtual -A 2 |grep temp1|awk '{print $2}'`
temps[$(($core+2))]=`sensors|grep Virtual -A 2 |grep temp2|awk '{print $2}'`
temps[$(($core+3))]=`sensors|grep radeon -A 2|grep temp1|awk '{print $2}'`

hottest=0
for item in ${temps[*]}		# all array items http://tldp.org/LDP/abs/html/arrays.html
do
	inttemp=`echo $item | sed -re 's/[\+C\°\.]//g'`
	if [ $inttemp -gt $hottest ]; then hottest=$inttemp; fi
done

# have we spoken in the last 5 mins?
spoken=` find ~/.temphistory/ -maxdepth 1 -type f -mmin -5 -name 'spoken'| wc -l`
if [ $spoken -eq 0 ];
then
	speak=1
else
	speak=0
fi

if [ $inttemp -gt 1000 ]
then
	notify-send -u critical "VERY HOT!  Do something!"
    espeak $(($inttemp/10))
    #if [ $speak -eq 1 ]; then espeak "WARNING $(($inttemp/10)) degrees "; touch ~/.temphistory/spoken; fi
elif [ $inttemp -gt 900 ]
then
	notify-send -u low "Hot! Temps over 90C check it out"
    espeak $(($inttemp/10))
    #if [ $speak -eq 1 ]; then espeak "$(($inttemp/10)) degrees"; touch ~/.temphistory/spoken; fi
elif [ $inttemp -gt 800 ]
then
	notify-send -u low "getting warmer - over 80C"
fi

exit

#save some temps for posterity, to see if we can see if the fing is overheatin when it shuts downnn
when=`date +%Y%m%d%H%M%S`
if [ ! -d ~/.temphistory ]; then mkdir ~/.temphistory; fi 
f=~/.temphistory/$when

for item in ${temps[*]}
do
	echo $item
	echo $item >> $f
done

exit
### end ###


# be rid of punctuations and symbols
# cat $f|sed -e 's/[\+\.]//g'|sed -e 's/°C//g'|sort -nk 2 
