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
