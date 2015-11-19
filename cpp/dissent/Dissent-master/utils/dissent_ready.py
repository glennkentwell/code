#!/usr/bin/python

import httplib
import json
import sys
import time

def send(ip, port):
  conn = httplib.HTTPConnection(ip, port)
  try:
    conn.request("GET", "/session")
  except:
    return False

  resp = conn.getresponse()
  if resp.status != 200:
    return False

  output = resp.read()
  try:
    msg = json.loads(output)
    return msg["round"] == True
  except:
    return False

def main():
  if len(sys.argv) != 3:
    sys.stderr.write("Usage: %s ip port\n" % sys.argv[0])
    return

  print "Waiting for Dissent to connect..."
  ip = sys.argv[1]
  port = int(sys.argv[2])

  while not send(ip, port):
    time.sleep(1)

  print "Dissent connected..."

if __name__ == "__main__":
  main()
  
