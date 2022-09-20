#!/bin/bash
# repeatedly calls someone with the help of adb connected phone

let COUNT=0
let NUM_TIMES=50 # number of times you want to call the person
let TIME_DELAY=30 # in seconds; time delay between each call
let PHONE_NUMBER=0000000000 # replace 0s with the target's phone number

while [ $COUNT -lt $NUM_TIMES ]
do
adb shell am start -a android.intent.action.CALL -d tel:$PHONE_NUMBER
sleep $TIME_DELAY
adb shell input keyevent KEYCODE_ENDCALL
a=`expr $COUNT + 1`
done

