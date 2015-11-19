#!/bin/bash

# first argument is string to find (needle)
# second arg is string to search within (haystack)
isin () {
	for arg in $2; do
		if [ "$arg" == "$1" ]; then return 1; fi
	done
	return 0
}

# create it if it aint there
backup () {
	mkdir -p $dest

	arrdirs=$(echo $dirs | tr ":" "\n")
	for x in $arrdirs
	do
		filename=$(echo $x | tr "/" "_")
		filename="$dest/$ds$filename.tar"
		tar -czpf $filename $x
		gzip $filename
	done

	#backup mysql
	filename=$dest/${ds}-mysql.sql.gz
	/usr/bin/mysqldump --all-databases -uroot -p$(cat /root/.p) |gzip > $filename
}

# create a .tar.gz archive of a backup dir if there's space
# args
#	archivepath: path of the new .tar.gz file
#	backuppath:  path of the backup folder
archive () {
	if [ $# -lt 2 ]; then echo "archive() requires 2 args, archivepath backuppath"; exit; fi
	backuppath=$2
	archivepath=$1

	diskspace=$(df|tail -n 1|awk '{print $4}')
	if [ "$diskspace" == "" ]; then diskspace=0; fi
	# how big is the backup?
	backupsize=$(du -s "$backuppath" | awk '{print $*')
	if [ "$backupsize" == "" ]; then backupsize=0; fi

	if [ $diskspace -gt $backupsize ]; then
		tar -czf "$backuppath" "$archivepath"			# create a .tar.gz of the backup
	fi
}

# send the file offsite
send () {
	if [ $# -lt 2 ]; then echo "send(): requires a file path to send and a remote scp path"; exit; fi

	sendingfilepath="$1"
	sendingfile=$(basename "$1")
	destination="$2"
	deleteaftersending="$3"
	# parse remote path from scp destination
	remotehost=$(echo $destination|awk -F\: '{print $1}')
	remotepath=$(echo $destination|awk -F\: '{print $2}')

	localsz=$(stat -c %s $sendingfilepath 2> /dev/null)
	if [ "$localsz" == "" ]; then localsz=0; fi
	remotesz=$(sudo su -c "ssh $remotehost \"stat -c %s $remotepath/$sendingfile 2> /dev/null\"" - glenn)
	if [ "$remotesz" == "" ]; then remotesz=0; fi

	if [ $localsz -gt 0 ] && [ $localsz -gt $remotesz ]; then
		sudo su -c "scp \"$sendingfilepath\" $destination" - glenn;
	else
		if [ $remotesz != 0 ] && [ "$deleteaftersending" != "delete" ]
			then

			echo deleting $sendingfilepath...
			rm -rf "$sendingfilepath" "$dest"
		fi
	fi
	
	echo localsize = $localsz     remotesize = $remotesz
}

# Create a .tar.gz for any historical backup directories that dont have one
archiveoldbackups () {
	if [ $# -lt 1 ]; then echo archiveoldbackups requires a remote location; exit; fi
	remotelocation="$1"

	backups=$(find /var/archive/* -maxdepth 1 -type d)
	for backup in $backups
	do
		if [ $(ls -1 $backup*gz | wc -l) -eq 0 ];
			then
			archive "$backup/" "$backup-$(hostname).tar.gz" 
		fi

		send "$backup-$(hostname).tar.gz" "$remotelocation" deleteok
	done
}


# make a nice date format
ds=`date +"%Y%m%d"`
# where to stick everything
dest="/var/archive/${ds}"
# name the tar.gz archive this
archivename=$ds-$(hostname).tar.gz
# where it's at
archivepath=/var/archive/$archivename
# remote server path (SCP)
sendtoremote="kentwell.net@kentwell.net:data/"
# what to backup
dirs="/etc:/home:/var/www:/var/log"

isin "nobackup" "$*"; nobackup=$?		# return val
if [ $nobackup -eq 0 ]; then backup; fi

isin "noarchive" "$*"; noarchive=$?
if [ $noarchive -eq 0 ]; then archive "$dest" "$archivepath"; fi

isin "nosend" "$*"; nosend=$?
if [ $nosend -eq 0 ]; then send "$archivepath" "$sendtoremote" delete; fi

isin "archiveoldbackups" "$*"; do_archiveoldbackups=$?
if [ $do_archiveoldbackups -eq 1 ]; then archiveoldbackups "$sendtoremote"; fi
