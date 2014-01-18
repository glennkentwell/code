#!/usr/bin/python

class talker:

    @staticmethod
    def say(txt):
# a rad cross-platform lib for text to speech
        engine = pyttsx.init()
        engine.say(txt)
        engine.runAndWait()


# call 'sensors' program to get CPU etc temps
import pyttsx       # text to speech
import re           # regex
import subprocess   # create sub-processes & shell cmds
sensors = subprocess.Popen("sensors", stdout=subprocess.PIPE)
if not sensors.stdout.closed:
    temps, errors = sensors.communicate()

if type(errors) is str:
    print("errors=\n" + errors)

# show ol cap'n user
# print(temps)
# raw_input('Press enter to continue...')
# subprocess.call("clear")

# find each of the temperature numbers
start = prev = count = 0

strtemps = re.findall("\ \ \ [+-]\d+\.\d+", temps)
floattemps = []
for st in strtemps:
    ft = float(st)
    floattemps.append(ft)
floattemps.sort(reverse=True)
# maxreading = floattemps[0]

    talker.say(temp)

# dont do this shit it's garbage
if 22 == 44:
# start = temps.find("+", start)
    while temps.find("+", start) >= 0:
        count += 1
        if start > 0:
            print temps[prev-1:start]
            prev = start + 1
        else:
            print "start not above zero"
        start = temps.find('+', start + 1)

    maxreading = "Completed {0} loops".format(count)
    if count == 1:
        maxreading = maxreading[0:len(maxreading)-1]    # ditch plural 's'


"""kunnet is a made-up class

   You can do anything you want with kunnet,
   except use it for something useful to the land
"""


class kunnet:
    """fuct() is the best of all methods

    You will not use any other methods!
    """
    def fuct(one, two):
        return "cunt"
