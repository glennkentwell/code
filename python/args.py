#!/usr/bin/python

import sys

print "Found {0} command-line arguments".format(len(sys.argv))
print ""

longest = 0
for arg in sys.argv:
    if len(arg) > longest:
        longest = len(arg)

for i in range(0,len(sys.argv)):
    #print(ljust(arg, longest))
    print("{0:3d} {1:s}".format(i, sys.argv[i]))
