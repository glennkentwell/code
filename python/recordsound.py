#!/usr/bin/python

import pyaudio
import sys
import wave
import time


def save_speech(data, p):
    filename = 'output_'+str(int(time.time()))
    # write data to WAVE file
    data = ''.join(data)
    wf = wave.open(filename+'.wav', 'wb')
    wf.setnchannels(1)
    wf.setsampwidth(p.get_sample_size(pyaudio.paInt16))
    wf.setframerate(48000)
    wf.writeframes(data)
    wf.close()
    print "finished saving wav: %s" % filename
    return filename

chunk = 1024
FORMAT = pyaudio.paInt16
CHANNELS = 1
RATE = 44100
RECORD_SECONDS = 5

p = pyaudio.PyAudio()
stream = p.open(format=FORMAT,
                channels=CHANNELS,
                rate=RATE,
                input=True,
                output=True,
                frames_per_buffer=chunk)

print " recording"

all_data = []

f = open('pythonsound.bin', 'w+')

for i in range(0, 44100/chunk * RECORD_SECONDS):
    data = stream.read(chunk)
    all_data.append(data)
    f.write(data)

print "finished"

f.close()

wavfile = save_speech(all_data, p)

stream.stop_stream()
stream.close()
p.terminate()
