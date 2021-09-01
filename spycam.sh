#!/bin/bash
# snap a pic using webcam at regular intervals; Alternative: do it via crontab

cd ~/experimental;
mkdir -p fsw/"$(date --rfc-3339=date)";
cd fsw/"$(date --rfc-3339=date)";
fswebcam -r 1024x768 "$(echo $(date) | awk -v N=5 '{print $N}' | sed 's/:/_/g')".jpg;
cd -
