#!/bin/bash
# repeatedly calls someone with the help of adb connected phone

let a=0
while [ $a -lt 50 ]
do
adb shell am start -a android.intent.action.CALL -d tel:<enter-phone-number-here>
sleep 30
adb shell input keyevent KEYCODE_ENDCALL
a=`expr $a + 1`
done

