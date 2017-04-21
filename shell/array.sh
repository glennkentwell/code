#!/bin/sh

something=( "oh" my 3943943 gosh );
echo 'Array:'
echo $something     # only prints the first value
echo 

# print em all
echo 'Values:'
count=0
for i in "${something[@]}"
do
    echo "$count: $i"
    count=$(( $count+1 ))
done

