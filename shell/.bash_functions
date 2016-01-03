#!/bin/bash

DEBUG=0
if [ "$1" == "-d" ]
then
	DEBUG=1
else
	if [ "$1" == "-dd" ]
	then
		DEBUG=2
		set -x	# turn bash tracing/debugging on as well
	fi
fi
debugmsg () {
    if [ "$DEBUG" -ne 0 ]
    then
        logfile="$0.log"
        echo $( datetimestamp ) "$1" >> "$logfile"
    fi
}

# Some functions:
#	timestamp()
#		UNIX timestamp format, seconds since Jan 1, 1970
#	datestamp()
#		outputs 20151223 aka YYYYmmdd
#	datetimestamp()
#		outputs 20151224-053844 aka a sortable, human readable date and time
#	today()
#		edits a note named for today's date
#	editnote()
#		edits a named note or today's note
#	notes()
#		opens today's note or the note with the name you specify eg. "notes git" opens notes-git.txt
#	savenotes()
#		does pull from git origin repo, commits changes and pushes to remote	

# nice date format aka 20151223
function datestamp () {
	date '+%Y%m%d'; 
}
export -f datestamp

# UNIX timestamp seconds since the epoch
function timestamp () {
	date '+%s'
}
export -f timestamp

# prints a nice sortable timestamp like 20151224-053844
function datetimestamp () {
	date +%Y%m%d-%H%M%S
}
export -f datetimestamp

# edit today's notes aka ~/notes/notes-20151223.txt
function today () { vi ~/notes/notes-$( datestamp ).txt; }
export -f today

# edit a given note, adding the timestamp jazz at the bottom
function editnote () { 
	cd ~/notes/

	backupfilename=~/notes/notes-"$1"_$( timestamp ).txt
	cp ~/notes/notes-"$1".txt "$backupfilename"
	vi ~/notes/notes-"$1".txt

	# see if the file has changed
	diff -q ~/notes/notes-"$1".txt "$backupfilename" 
	changed=$?
	echo $changed has changed?
	if [ "$changed" -gt 0 ]
	then
		echo >> ~/notes/notes-"$1".txt
		echo Edited by $USER on $HOST at $(timestamp) >> ~/notes/notes-"$1".txt		
		git add notes-"$1".txt
		git commit notes-"$1".txt -m "Updated notes for $1"
		git status .
	fi
	rm -f "$backupfilename"	
}
export -f editnote
# edit notes for a topic or today's date
function notes () { 
	if [ -z "$1" ]
		then today
	else
		if [ -f ~/notes/notes-"$1".txt ]
		then
			editnote "$1"
		else
			ls -1 ~/notes/notes-*"$1"*.txt
		fi
	fi
}
export -f notes

# commit notes to git repo
function savenotes () {
	pushd .

	cd ~/notes/
	git pull origin master
	git add notes-*.txt
	if [ -z "$1" ]
	then
		git commit -m "$(timestamp)"
	else
		git commit -m "$1"
	fi
	git push origin master

	popd
}
