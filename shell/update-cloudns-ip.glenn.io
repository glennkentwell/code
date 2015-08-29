# #!/bin/bash
LOG=/home/glenn/update-cloudns-ip.glenn.io.log
# keep the secret thingy in a secret file
param=$(grep ip.glenn.io ~/.cloudns | awk '{print $2}')
curl --silent http://ipv4.cloudns.net/api/dynamicURL/?q=$param 2>&1 > $LOG
# 
# 
# if [ -z "$1" ]; then
#     echo param 1 is empty so normal quiet mode >> $LOG
# 
#     # wget -q --read-timeout=0.0 --waitretry=5 --tries=400 --background http://ipv4.cloudns.net/api/dynamicURL/?q=$param 2>&1 > /dev/null
# else
#     echo 1
#     # debug mode
#     echo the if statement was false >> $LOG
#     echo 2
#     echo $1 >> $LOG
#     echo 3
#     echo "$1" >> $LOG
#     # wget -v --read-timeout=0.0 --waitretry=5 --tries=400 --background http://ipv4.cloudns.net/api/dynamicURL/?q=$param
# 
#     echo 4
#     curl -vv http://ipv4.cloudns.net/api/dynamicURL/?q=$param 2>&1 >> $LOG
# fi
# 
# 
