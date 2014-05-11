ls -1|sed -e 's/\..*//g'|sed -e 's/[^A-Za-z]//g'|uniq  -c|sort -n
