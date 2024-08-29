#!/bin/bash
echo -n "do you want to write data in file? (Y/n) " 
read answer
case "$answer" in 
	y|Y) cp $1 $(date +"%d_%m_%y_%H_%M_%S").status;;
	*) echo  "the data will not be saved"
esac
