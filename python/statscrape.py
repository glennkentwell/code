#!/usr/bin/python

sabnzbd_url = 'http://champ:8888/'
savefile = '/var/www/default/stats.html'

import curl
c = curl.Curl()
page = c.get(sabnzbd_url)

fs = page.find('<b>Download Dir')
fe = page.find('</body')
f = page[fs:fe-len('</body>')]

# save to file for now
stats = open(savefile, 'w+')
stats.write(f)
stats.close()

if 
import subprocess as sp
sp.call(['chromium-browser','http://localhost/stats.html'])
