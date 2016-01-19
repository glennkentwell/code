#!/bin/bash

search="$*"

numgoflags=$( echo $search | grep -c '\-go' )
echo found $numgoflags go flags in args
if [ "$numgoflags" -ne 0 ]
then
    OPENBROWSER=1
    search=$( echo $search | sed -e 's/\-go//g' )
else
    OPENBROWSER=0
fi

which nodejs
if [ $? -ne 0 ]
then
    echo Requires nodejs! Lol
    echo

    exit
fi
search=$( nodejs -e "console.log(encodeURIComponent('$1'));" )

curl --silent -A Mozilla "http://www.google.com.au/search?q=$search" > "$search.html"

cat "$search.html" | \
    sed -e 's/http/\nhttp/g' |\
    awk -F '"' '{print $1 }' | \
    grep '%252B' | \
    sed -e 's/\%252B.*//g' > "$search.results.html"

echo Found $( wc -l $search.results.html ) results

if [ "$OPENBROWSER" -eq 1 ]
then
    echo Opening first search result in web browser...
    topresult=$( head -n 1 $search.results.html )
    x-www-browser "$topresult" &
fi
