#! /bin/bash
#background
black="\033[40m"
red="\033[41m"
green="\033[42m"
blue="\033[46m"
purple="\033[45m"
white="\033[47m"
#text
t_black="\033[30m"
t_red="\033[31m"
t_green="\033[32m"
t_blue="\033[36m"
t_purple="\033[35m"
t_white="\033[37m"

function background(){
	col=$1
if [[ $col == 1 ]];
	then
	echo $white
elif [[ $col == 2 ]];
	then
	echo $red
elif [[ $col == 3 ]];
	then
	echo $green
elif [[ $col == 4 ]];
	then
	echo $blue
elif [[ $col == 5 ]]
	then
	echo $purple
elif [[ $col == 6 ]];
	then
	echo $black
fi
}
function text() {
	col2=$1
if [[ $col2 == 1 ]];
	then
	echo $t_white
elif [[ $col2 == 2 ]];
	then
	echo $t_red
elif [[ $col2 == 3 ]];
	then
	echo $t_green;
elif [[ $col2 == 4 ]];
	then
	echo $t_blue;
elif [[ $col2 == 5 ]];
	then
	echo $t_purple
elif [[ $col2 == 6 ]];
	then
	echo $t_black
fi
}
echo -e $(background $bcol1)$(text $tcol1)$1$(background $bcol2)$(text $tcol2)$2"\e[0m"
