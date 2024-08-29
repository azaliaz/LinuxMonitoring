#!/bin/bash
. ./main.sh
if [[ $# -eq 1 ]];then
	if [[ -e $1 ]] && [[ -d $1 ]] && [[ "${1: -1}" == "/" ]]; then
		start=$(date +%s)
		total_folders $1
		top_folders $1
		top_files $1
		files_types $1
		top_files $1
		top_executable_files $1
		end=$(date +%s.%N)
		time=$(echo "$end - $start" | bc)
		echo "Script execution time (in seconds) = $time"
	else
		echo "Wrong! There is no such way"
	fi
else
	echo "Wrong! The script runs like this, for example ./output.sh /var/log/"
fi
