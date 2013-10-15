#!/bin/bash

echo $HOSTNAME
echo $USER

# if [ $HOSTNAME = $USER ]
# 	then
# 	echo hostname and user are totes samesies
# fi

if $USER != $HOSTNAME; then echo yep; fi

