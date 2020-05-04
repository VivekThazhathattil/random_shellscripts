#!/bin/zsh

readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "[INFO]    $*" | tee -a "$LOG_FILE" >&2 ; }
warning() { echo "[WARNING] $*" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo "[ERROR]   $*" | tee -a "$LOG_FILE" >&2 ; }
fatal()   { echo "[FATAL]   $*" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

flag=0;
mkdir temp_progress;
du ~/Downloads/* > temp_progress/diff1.txt;
du ~/Downloads/* > temp_progress/diff2.txt;
down_file="$(diff temp_progress/diff1.txt temp_progress/diff2.txt | grep -oP -m 1 '[\d]+\s\K(.*)')";
var="$(diff temp_progress/diff1.txt temp_progress/diff2.txt | grep -oP -m 1 '[\d]+\s.*' | grep -oP -m 1 '^[\d]+')";
echo $down_file;
#echo $var;

rm -rf temp_progress;
cd ~/Downloads;
let i=0;
while true
do

du "$down_file" | grep -oP -m 1 '^[\d]*'
var2="$(du "$down_file" | grep -oP -m 1 '^[\d]*')";
var_hum="$(du -h "$down_file" | grep -oP -m 1 '\K(^.*)\s')";
echo $var2 bytes downloaded
sleep 1;
if [ "$var" -eq "$var2" ] 
then
	mpv ~/Downloads/lg_echo.mp3;
	echo "Do you want to continue?(y/n)"
	read  -n 1
	if [ "x$REPLY" == "x" ]; then
		break;
	fi
	case $REPLY in 
		[Yy])
			;;
		[Nn])
			break
			;;
		*)
			echo "Unknown input, exiting..."
			break
			;;
	esac
fi

var=$var2;
let i=i+1;
done
cd -;
