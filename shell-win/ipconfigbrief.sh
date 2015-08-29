#!/bin/sh

x=$(ipconfig); 
echo $x|sed -e "s/\\([a-zA-Z]*\\)\ adapter/\\n\1\\n/gi"|sed -e 's/\(\ \.\)\+/\n/g'|sed -e "s/\\ \\:\\ /\\t/g"|sed -e 's/\:\ Media\ State//'|sed -e 's/[\  \t]\+/ /g'|sed -e 's/Connection-specific DNS Suffix//'|sed -e 's/Media //'
