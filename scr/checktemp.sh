#!/bin/bash

# requires lm-sensors, to install, run:
# sudo apt-get install lm-sensors

# get each of the temps from 'sensors'
# this is pretty customised for the sensors in my machine lollll
for core in {0..3}
do
	temps[$core]=`sensors|grep Core|awk '{print $3}'|head -n $(($core+1))|tail -n 1`	
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

if [ $inttemp -gt 1000 ]
then
	notify-send -u critical "VERY HOT!  Do something!"
elif [ $inttemp -gt 900 ]
then
	notify-send -u low "Hot! Temps over 90C check it out"
elif [ $inttemp -gt 800 ]
then
	notify-send -u low "getting warmer - over 80C"
fi


#save some temps for posterity, to see if we can see if the fing is overheatin when it shuts downnn
when=`date +%Y%m%d%H%M%S`
if [ -d /dev/shm ];
then 
	f=/dev/shm/$when
else
	f=/tmp/$when
fi
echo t1 $temp1 >> $f
echo t2 $temp2 >> $f
for core in {0..3}
do
	echo c$core ${cores[$core]} >> $f
done
echo rg $radeon >> $f

exit
### end ###


# be rid of punctuations and symbols
# cat $f|sed -e 's/[\+\.]//g'|sed -e 's/°C//g'|sort -nk 2 
