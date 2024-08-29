#!/bin/bash

if [ $# != 4 ]; then
	echo "Parametrs can't be here"
elif [[ $1 != [1-6] || $2 != [1-6] || $3 != [1-6] || $4 != [1-6] ]];
	then
	echo "error type of color"
elif [[ $1 == $2 || $3 == $4 ]];
	then
	echo "Background and text color values must not match. Please try again."
else
	export bcol1=$1
	export tcol1=$2
	export bcol2=$3
	export tcol2=$4
	chmod +x color.sh
	chmod +x main.sh
	bash main.sh
fi
