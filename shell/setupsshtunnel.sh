#!/bin/bash
source ~/.bash_functions 

tunnelcmd="ssh -f -N sshtunnel"
# ssh -R 22223:localhost:22 glenn@glenn.io

# http://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/
# ssh args: -f means go to background, -N means don't run a remote command
numtunnels=$( ps aux | grep -v grep | grep -c "$tunnelcmd" ) 
debugmsg "$numtunnels" tunnels 
if [ "$numtunnels" == "0" ]
then
	# start the tunnel
	debugmsg "starting ssh tunnel"
	$tunnelcmd
fi
