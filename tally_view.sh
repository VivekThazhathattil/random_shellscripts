# This program should be able to offer the user with a choice to make a new job, mark the number of tries he has at the job and print the tries in colorful tally marks.
# option to view the previous day's jobs
# creation of file with each day distinguished by the date header
# Todo: Format the output in colors, also represent it in proper tally form
# Todo: The date stored in masters is one day ahead. Change it in move_to_master function

#!/bin/zsh

# make the jobs text file (unless it already exists) which will include a date header followed by lines of jobs and their numbers

# check for permissions while making files 
# proper error handling
# make a master job file and store the existing jobs to the master file at the end of the day
# Add option to set target tries for the job
# The program may not have write permission in the current directory. In that case, it has to ask the user for sudo priveledges and state the reason.
# Change jobs.txt name as jobs is a function in bash
# Add an option to view the summary eg: Total number of pushups so far

check_dirfiles()
{
	cd $HOME;
	if [ ! -d $1 ]
	then
		mkdir -p $HOME/.tally
		echo "New directory created (~/.tally) to store the necessary files"
	fi
	cd - > /dev/null;
	cd $HOME/.tally;
	if [ ! -e $2 ] 
	then
		touch $2;
		echo "New file created in $1 ($2)" 
	fi

	if [ ! -e $3 ] 
	then
		touch $3;
		echo "New file created in $1 ($3)"
	fi

	cd - > /dev/null;
}

move_to_master()
{
	var1=$(ls -l $HOME/.tally/$1 --time-style=+%d_%m_%y | grep -oP '\d{2}_\d{2}_\d{2}')
	var2=$(date +%d_%m_%y)
	if [ $var1 != $var2 ]
	then
		echo $var2 >> $HOME/.tally/$2
		cat $HOME/.tally/$1 >> $HOME/.tally/$2
		touch $2
		sed -i -E 's/[0-9]+$/0/g' $HOME/.tally/$1
		echo  >> $HOME/.tally/$2
	fi
}


print_one()
{
	printf "$1 : "
	i=1;
	while [ $i -le $2 ]
	do
#	printf '\e[1;32m'\#'\e[0m'
	printf I
	if [ $(($i % 5)) -eq 0 ]
	then
		printf " - "
	fi
	let i=i+1;
	done | lolcat -S -d 1
	printf " ($2)"
	printf "\n"
}

print_output()
{
	printf "\n"
	let j=1;
	while read -r LINE
	do
		JOB="$(echo $LINE | grep -oP '\K(.+)\s')"
		TRIES="$(echo $LINE | grep -oP '.+\s\K(\d+)')"
		printf "$j. "
		print_one "$JOB" "$TRIES"
		let j=j+1;
	done < jobs.txt
}

new_job()
{
	read -p "Enter the name of the record you wish to create: " -r 
	echo "$REPLY 0" >> $HOME/.tally/jobs.txt
	printf "\nNew record : ($REPLY) created\n" | lolcat -S 0
}

delete_job()
{
#Todo: Ability to delete multiple files on a go
#Todo: List all the job names for the user 
#Todo: Error handling - no such record found 
	printf "\n"
	cat $HOME/.tally/jobs.txt | grep -oP '^.+\s' | lolcat
	printf "\n"
	read -p "Enter the name of the record you wish to delete: " -r
	JOB="$REPLY"
	sed -i "s/"$JOB"\ .*//g" jobs.txt
	sed -i '/^$/d' jobs.txt
	printf "\n Existing record : ($JOB) deleted\n" | lolcat -S 0
}

record_tries()
{
	print_output
#Todo: incorporate job name as an option
#	read -p "Enter job name or the Sr no: " -r
#	JOB="$REPLY"

	read -p "Enter the record no.: " -r
	SRNO="$REPLY"
	prev_tal=$(cat jobs.txt | sed -n ""$SRNO" p" | grep -oP '\d+$')
	JOB="$(cat jobs.txt | sed -n ""$SRNO" p" | grep -oP "^.+(?=\s\d+$)")"
	read -p "Enter the tally: " -r 
	TALLY="$REPLY"
#	prev_tal=$(cat jobs.txt | grep -oP ""$JOB"\s\K([\d]+)")
	let TALLY=prev_tal+TALLY;
	printf "\n"
	print_one "$JOB" "$TALLY"
	sed -i "s/"$JOB"\ .*/"$JOB"\ "$TALLY"/g" jobs.txt
	
# this function should serve the purpose of error correction in record tries as well
# ask for the job name and number of tries
# ask whether you are logging additional tries or just the total tries
# Error handling : if no records exist, inform the user about that 
}

driver()
{
	cd $HOME/.tally > /dev/null
	while :
	do
		printf "\n(press h for help) \n\n>> "
		read -r val;
		case $val in
		1 | record)
		       	record_tries
			;;
		2 | new)
			new_job
			;;
		3 | delete)
			delete_job
			;;
		4 | print | ls )
			print_output
			;;
		5 | exit | quit | q)
			exit
			;;
		6 | master)
			less $HOME/.tally/master.txt
			;;
		h)
			printf "\n\n1. Enter tally for a record \n2. Create new record\n"
	       		printf "3. Delete existing record\n4. Print all the records \n"
	      		printf "5. Exit the program \n "
			;;
		clear)
			clear
			;;

		*)
			printf "\n $val is not a valid command. Please try again\n"

		esac
	done
	cd - > /dev/null;


}

check_dirfiles ".tally" "jobs.txt" "master.txt"
move_to_master "jobs.txt" "master.txt"
driver
