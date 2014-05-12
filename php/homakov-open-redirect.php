<?php
# trying out Egor Homakov's path encoding redirect vulnerability
#
# http://homakov.blogspot.com.au/2014/01/path-encoding-vulnerability-in-httpswww.html
# http://homakov.blogspot.com.au/2014/05/covert-redirect-faq.html

print_r( parse_url('///host.com') );
echo "\n";
print_r( parse_url('\/host.com') );
echo "\n";
print_r( parse_url('/\host.com') );
