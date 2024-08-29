#! /bin/bash
function get_color_name {
	case "$1" in
		1) echo "(white)" ;;
		2) echo "(red)" ;;
		3) echo "(green)" ;;
		4) echo "(blue)" ;;
		5) echo "(purple)" ;;
		6) echo "(black)" ;;
	esac
}
function color {
	case "$1" in
		1) echo "\e["$2"7m" ;;
		2) echo "\e["$2"1m" ;;
		3) echo "\e["$2"2m" ;;
		4) echo "\e["$2"4m" ;;
		5) echo "\e["$2"5m" ;;
		6) echo "\e["$2"0m" ;;
		* ) echo "default" ;;
	esac
}

function output {
	declare -a data=(
		"$HOSTNAME"
		"$(date +"%Z %z")"
		"$USER"
		"$(hostnamectl | awk '/Operating System/ {print $3, $4, $5}')"
		"$(date +"%d %b %Y %H:%M:%S")"
		"$(uptime -p)"
		"$(cat /proc/uptime | cut -d " " -f 1)"
		"$(ip route get 1 | awk '{print $(NF-2);exit}')"
		"$(ifconfig | awk 'NR==11{print $4}')"
		"$(ip r | awk '{print $3}' | head -1)"
		"$(free | awk '/Mem:/{printf "%.3f Gb", $2/1024*1024}')"
		"$(free | awk '/Mem:/ {printf "%.3f Gb", $3/1024*1024}')"
		"$(free | awk '/Mem:/ {printf "%.3f Gb", $4/1024*1024}')"
		"$(df /root | awk '/\/$/ {printf "%.2f Mb", $2/1024}')"
		"$(df /root | awk '/\/$/ {printf "%.2f Mb", $3/1024}')"
		"$(df /root | awk '/\/$/ {printf "%.2f Mb", $4/1024}')"
	)

	declare -a name=(
		"HOSTNAME"
		"TIMEZONE"
		"USER"
		"OS"
		"DATE"
		"UPTIME"
		"UPTIME_SEC"
		"IP"
		"MASK"
		"GATEWAY"
		"RAM_TOTAL"
		"RAM_USED"
		"RAM_FREE"
		"SPACE_ROOT"
		"SPACE_ROOT_USED"
		"SPACE_ROOT_FREE"
	)
	for index in "${!data[@]}"; do
		echo -e "$column1_font_color$column1_background${name[$index]}\e[0m=$column2_font_color$column2_background${data[$index]}\e[0m"
	done
}
function get_color {
	local color_conf=$(grep "$1" conf.txt | cut -b 20-)
	local def_col=$(color "$color_conf" "$2")
	if [ "$def_col" = "default" ]; then
		echo "\e[${2}0m"
	else
		echo "$def_col"
	fi
}
function set_color {
	local conf_key=$1
	local color_code=$2
	local default_color="\e[${color_code}0m"
	local color_from_conf=$(grep "$conf_key" conf.txt | cut -d "=" -f 2)
	local defcolor=$(color "$color_from_conf" "$conf_key")
	if [ "$defcolor" = "default" ]; then
		eval "$conf_key=\"$default_color\""
		default="default"
		key=$(get_color_name $color_code)
	else
		eval "$conf_key=\"\e[${defcolor}\""
		default="$color_from_conf"
		key=$(get_color_name $color_from_conf)
	fi
}
function display {
	default="default"
	key="(black)"
	set_color "column1_background" 6
	column1bg="Column 1 background = $default $key"
	set_color "column1_font_color" 1
	column1f="Column 1 font color = $default $key"
	set_color "column2_background" 2
	column2bg="Column 2 background = $default $key"
	set_color "column2_font_color" 4
	column2f="Column 2 font color = $default $key"
	echo -e "$column1bg\n$column1f\n$column2bg\n$column2f"
}
column1_background=$(get_color "column1_background" 4)
column1_font_color=$(get_color "column1_font_color" 3)
column2_background=$(get_color "column2_background" 4)
column2_font_color=$(get_color "column2_font_color" 3)
output
echo
display
