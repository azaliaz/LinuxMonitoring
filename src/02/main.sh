#!/bin/bash
chmod +x output.sh
file=output.sh
if [ ! -f "$file" ]; then
	echo Error: missing file: $file
	exit
fi
tmp="tmp1"
echo "HOSTNAME =" $(hostname) | tee -a $tmp
echo "TIMEZONE =" $(cat /etc/timezone) UTC $(date +"%Z") | tee -a $tmp
echo "USER =" $USER | tee -a $tmp
echo "OS =" $(lsb_release -a | awk '/Description/ {for (i=3; i<=NF; i++) printf "%s ", $i}') | tee -a $tmp
echo "DATE =" $(date +"$d %b %Y %T") | tee -a $tmp
echo "UPTIME =" $(uptime -p) | tee -a $tmp
echo "UPTIME_SEC =" $(cat /proc/uptime | awk '{printf($1)}') | tee -a $tmp
echo "IP =" $(hostname -I | awk '{printf($1)}') | tee -a $tmp
echo "MASK =" $(ifconfig $(ip r | grep default | awk '{printf($5)}') | awk '/netmask / {printf($4)}') | tee -a $tmp
echo "GATEWAY =" $(ip r | grep default | awk '{printf($3)}') | tee -a $tmp
echo "RAM_TOTAL =" $(free | grep -e Mem: | awk '{printf("%.3f", $2/(1024 * 1024))}') "Gb" | tee -a $tmp
echo "RAM_USED =" $(free | grep -e Mem:| awk '{printf("%.3f", $3/(1024*1024))}') "Gb" | tee -a $tmp
echo "RAM_FREE =" $(free | grep -e Mem:| awk '{printf("%.3f", $4/(1024*1024))}') "Gb" | tee -a $tmp
echo "SPACE_ROOT =" $(df /| grep dev | awk '{printf("%.2f", $2/1024)}') "Mb" | tee -a $tmp
echo "SPACE_ROOT_USED =" $(df / | grep dev | awk '{printf("%.2f", $3/1024)}') "Mb" | tee -a  $tmp
echo "SPACE_ROOT_FREE =" $(df / | grep dev | awk '{printf("%.2f", $4/1024)}') "Mb" | tee -a $tmp
./output.sh $tmp
rm $tmp
