#!/bin/bash

param=$(grep ip.glenn.io ~/.cloudns | awk '{print $2}')

if [ -z "$1" ]; then
    wget -r --read-timeout=0.0 --waitretry=5 --tries=400 --background http://ipv4.cloudns.net/api/dynamicURL/?q=$param 2>&1 > /dev/null
else
# debug mode
    wget -v --read-timeout=0.0 --waitretry=5 --tries=400 --background http://ipv4.cloudns.net/api/dynamicURL/?q=$param
fi


