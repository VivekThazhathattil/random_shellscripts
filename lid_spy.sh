#!/bin/bash
	PREV_STATE=open
# periodic webcam prog with lid status consideration

while true
do
	CURR_STATE="$(cat /proc/acpi/button/lid/LID0/state | grep -oP 'open|closed')";
	echo $CURR_STATE
	if [[ $CURR_STATE == "open" ]] && [[ $PREV_STATE == "closed" ]]
		then fswebcam -r 1024x768 "$(echo $(date) | awk -v N=5 '{print $N}' | sed 's/:/_/g')".jpg;
	fi
	PREV_STATE=$CURR_STATE
	sleep 2
done
