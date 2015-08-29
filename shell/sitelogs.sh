#!/bin/sh

tmpfile="/tmp/$BASHPID.tmp"
now=$(date +%Y%m%d\-%H%M%S)
logs="/home/40217/users/.home/data/logs/access*"
domain=$(pwd|sed -e 's/.*domains\///'|sed -e 's/\/log//' )

LOGS_SAVE=0		# output to a file with current time and domain as name
LOGS_INCR=1		# incremental: find most recent saved log and save subsequent rows

for arg in ${BASH_ARGV[*]}; do
	if [ "$arg" == "save" ]; then LOGS_SAVE=1; fi
	if [ "$arg" == "all" ]; then LOGS_INCR=0; fi
done

grep -h $domain $logs > $tmpfile

if [ 1 -eq $LOGS_INCR ]
then
	export marker=$(tail -n 1 $(ls -1tr *access-log|tail -n 1) | awk -F \" '{print $1}')
	echo MARKER\
		$marker \

	if [ $(expr length "$marker") -gt 1 ]
	then
		tmpmarker=$(echo $marker | sed -e 's/\(\W\)/\\\1/g' | sed -e 's/\\\]/\\\\]/g' | sed -e 's/\\\[/\\\\[/g'  )
		echo $tmpmarker
	read	
		#echo "linenum=\$\(grep -hn \"$tmpmarker\"  $tmpfile\) | sed -e 's/\:.*//' "
		echo tmpmarker=$tmpmarker
		linenum=$(grep -hn "$tmpmarker"  $tmpfile; echo TMP="$tmpmarker") 
		echo linenum=$linenum
		linenum=echo $linenum | sed -e 's/\:.*//' 
		if [ -z "$linenum" ]; then linenum="0"; fi
#		echo linenum=$linenum
#		echo "linenum=$(grep -hn \"$marker\"  $tmpfile | sed -e 's/\:.*//') "
#		linenum=$(grep -hn "$marker"  $tmpfile | sed -e 's/\:.*//') 
#		if [ -z "$linenum" ]; then linenum="0"; fi
		echo linenum=$linenum
	read
		numlines=$(cat $tmpfile | wc -l) 
		if [ -z "$numlines" ]; then numlines="0"; fi
		echo numlines=$numlines
	echo	tail -n $(($numlines - $linenum)) "$tmpfile" \> "$tmpfile.2"
		tail -n $(($numlines - $linenum)) "$tmpfile" > "$tmpfile.2"
		
		# mv "$tmpfile" "$tmpfile.3"
		rm -f "$tmpfile"
		mv "$tmpfile.2" "$tmpfile" 

	fi
fi

if [ 1 -eq $LOGS_SAVE ]
then
	cat "$tmpfile" >> $now-$domain.access-log
else 
	cat "$tmpfile"
fi

# rm -f "$tmpfile"
mv $tmpfile .

exit 0
#	|grep -v \.js|grep -v \.css \
#	|grep -v \.png|grep -v \.jpg|grep -v \.gif \
#	|grep -v \/wp-admin |grep -v \.xml|grep -v Googlebot |grep -v yandex.com\/bot |grep -v bingbot \
#	|grep -v favicon.ico|grep -v \.aspx|grep -v wp-cron\.php |grep -v \/wp-login\.php \
#	|grep -v ModSecurity 
	
	
	#\
	#| awk -F'"' '{print $1"\n"$2"\n"$4"\n"$6" _____"};' \
	#|grep -v error_log 
  652  echo $marker |cat
  653  sed -r 's/\\(.)/\1/g'
  654  echo $marker |sed -r 's/\\(.)/\1/g'
  655  echo $marker |sed -r 's/\(.)/\1/g'
  656  echo $marker |sed -r 's/\\(.)/\0/g'
  657  echo $marker |sed -r 's/\\(.)/\1/g'
  658  echo $marker$@#$ |sed -r 's/\\(.)/\1/g'
  659  echo $marker$@#$ |sed -r 's/\\(.)/\1/g'
  660  echo $marker$@#$ |sed -r 's/\\(.)/\\\1/g'
  661  echo $marker$@#$ |sed -r 's/\\(.)/\\\\1/g'
  662  echo $marker$@#$ |sed -r 's/\\(.)/\\\\\1/g'
  663  echo $marker$@#$ |sed -r 's/(.)/\\1/g'
  664  echo $marker$@#$ |sed -r 's/(.)/\1/g'
  665  echo $marker$@#$ |sed -r 's/(.)/\\\1/g'
  666  echo $marker$@#$ |sed -r 's/(.)/\\\1/g'|echo 
  667  echo $(echo $marker$@#$ |sed -r 's/(.)/\\\1/g' )
  668  sh
  669  man rev
  670  ./sitelogs.sh |wc -l
  671  rows=$(./sitelogs.sh |wc -l); ./sitelogs.sh |tail -n $(($rows/2))
  672  rows=$(./sitelogs.sh |wc -l); ./sitelogs.sh |tail -n $(($rows/2))|head -n 1
  673  rows=$(./sitelogs.sh |wc -l); ./sitelogs.sh |tail -n $(($rows/2))|head -n 1; echo $((rows / 2))
  674  rows=$(./sitelogs.sh |wc -l); ./sitelogs.sh |tail -n $(($rows/2))|head -n 1|awk '{print $1}'
  675  rows=$(./sitelogs.sh |wc -l); marker=$(./sitelogs.sh |tail -n $(($rows/2))|head -n 1|awk '{print $1}')
  676  echo $marker 
  677  ./sitelogs.sh |grep "$marker"
  678  echo $marker 
  679  rows=$(./sitelogs.sh |wc -l); marker=$(./sitelogs.sh |tail -n $(($rows/2))|head -n 1|awk -F \" '{print $1}')
  680  echo $marker 
  681  ./sitelogs.sh |grep "$marker"
  682  ./sitelogs.sh |grep $marker
  683  ./sitelogs.sh |grep '$marker'
  684  scr=$(echo grep $marker); echo $scr
  685  scr=$(echo grep \'$marker\'); echo $scr
  686  scr=$(echo grep \'$marker\'); ./sitelogs.sh |$($scr)
  687  bash
  688  bash --h
  689  man bash
  690  scr=$(echo grep \'$marker\'); ./sitelogs.sh |bash -c "$scr"
  691  scr=$(echo tail -n 1); ./sitelogs.sh |bash -c "$scr"
  692  scr=$(echo grep \'$marker\'); ./sitelogs.sh |bash -c "$scr"; echo $scr
  693  ./sitelogs.sh |bash -c $scr
  694  ./sitelogs.sh |bash -c "$scr"
  695  echo "./sitelogs.sh |$scr"
  696  $(echo "./sitelogs.sh |$scr")
  697  echo "./sitelogs.sh |$scr"
  698  echo "./sitelogs.sh |$scr"
  699  echo "./sitelogs.sh |$scr"|bash
  700  echo "./sitelogs.sh |$scr"|bash 
  701  echo "./sitelogs.sh |$scr"|bash -c 
  702  bash -c $(echo "./sitelogs.sh |$scr")
  703  echo "./sitelogs.sh |$scr"|bash -c 
  704  $(echo "./sitelogs.sh |$scr")
  705  history 
  706  history  |tail -n 55 >> sitelogs.sh 
