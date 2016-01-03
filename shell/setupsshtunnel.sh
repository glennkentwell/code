#!/bin/bash
source ~/.bash_functions 

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
