#!/bin/bash
source ~/.bash_functions 

# if the server isn't contactable then don't even bother
ping -c 1 -q glenn.io &> /dev/null
if [ $? -ne 0 ]; then exit; fi

# http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/
# ssh args: -f means go to background, -N means don't run a remote command
# you need to have a host alias setup in ~/.ssh/config called sshtunnel
tunnelcmd="ssh -f -N sshtunnel"

numtunnels=$( ps aux | grep -v grep | grep -c "$tunnelcmd" ) 
debugmsg "$numtunnels" tunnels 
if [ "$numtunnels" == "0" ]
then
	# start the tunnel
	debugmsg "starting ssh tunnel"
	$tunnelcmd
fi
