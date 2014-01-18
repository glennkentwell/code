#!/usr/bin/python

import pyttsx       # text to speech
import re           # regex
import subprocess   # create sub-processes & shell cmds

class talker:
    @staticmethod
    def say(txt):
        engine = pyttsx.init()
        if type(txt) is str:
            print(x[0:79])
            engine.say(txt)
        else:
            engine.say("txt is not a string, it is a {0}".format(type(txt)))
            print(type(txt))
        engine.runAndWait()


class temp:
    device = ''
    adapter = ''
    temp = 0
    critical = 100

    def isover(self):
        return self.temp >= self.critical


# call 'sensors' program to get CPU etc temps

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


temp = str(temp)
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
