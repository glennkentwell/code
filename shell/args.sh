#!/bin/sh

# all command-line arguments that are passed
echo '$* = all arguments'
echo $*

echo ' '
echo '**************'
echo ' '

# current program?
echo '$0 = the program itself is the 0th argument'
echo $0

echo ' '
echo '**************'
echo ' '

# first argument
echo '$1 and $2 etc are the arguments that are passed '
echo ' to the program '
echo $1
echo $2
