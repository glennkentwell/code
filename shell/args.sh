#!/bin/bash

echo all args: "$*"

echo num args: "$#"
echo '$0 ' "$0"
echo '$1 ' "$1"
echo '$2 ' "$2"
echo '$3 ' "$3"

argfun () { 
	echo '$0 ' "$0"
	echo '$1 ' "$1"
	echo '$2 ' "$2"
	echo '$3 ' "$3"
}

argfun "$0" "$1" "$2" "$3"
argfun "argone", "argtwo", "argtree", "argfour"

# test if a variable is set
# returns true (1) if not set
if [ -v  ]; then echo not set; fi


echo '$BASH_CMDS: ' $BASH_CMDS
echo '$BASH_SOURCE: ' $BASH_SOURCE

function argcount () { 
    set | head -n $LINES #get the vars
    read        # wait for the human
    clear       # clear the screen
    echo $#     # number of arguments
}
