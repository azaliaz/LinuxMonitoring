#!/bin/bash

sym=$1
if [ -n "$1" ] && (($# == 1))
then
	if [[ $1 =~ ^[[:alpha:][:punct:]]+$ ]]
	then
		echo $1
	else
		echo "enter the string"
	fi
else
	echo "error reading parametrs"
fi
