#!/bin/bash
# cheat at typeracer

string="$1"
strlength=${#string}
let marker1=0
let marker2=strlength/3
let marker3=marker2*2
let marker4=strlength-marker2
echo str1
echo
echo str2
echo $strlength
echo marker1 = $marker1 marker2 = $marker2 marker3 = $marker3 marker4 = $marker4
while read -r line
do
	str1=${string:$marker1:$marker2}
	str2=${string:$marker2:$marker2}
	str3=${string:$marker3:$marker4}
done < <(printf '%s\n' "$string")

echo $str1
echo
echo $str2
echo
echo $str3

let speed0=100

rand_num=$(($RANDOM%100))
let speed1=rand_num+speed0
echo speed1 = $speed1

rand_num=$(($RANDOM%100))
let speed2=rand_num+speed0
echo speed2 = $speed2

rand_num=$(($RANDOM%100))
let speed3=rand_num+speed0
echo speed3 = $speed3

xdotool sleep 1 type --delay $speed1 "$str1"
xdotool type --delay $speed2 "$str2"
xdotool type --delay $speed3 "$str3"
