#!/bin/sh
ip=$(wget http://www.wieistmeineip.de -O - -o /dev/null | grep '<div class="title"><strong>' | sed -r 's/<div class="title"><strong>//' | sed -r 's/<\/strong><\/div>//')
echo $ip
exit 0
