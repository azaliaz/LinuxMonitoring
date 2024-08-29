# !/bin/bash
if [[ -z $1 ]]; then
	echo "Error, please provide a directory path as a parametr."
	exit 1
fi

if [[ ! -d $1 ]]; then
	echo "Error, the provided parametr is not a valid directory."
	exit 1
fi
function total_folders() {
	local count=$(find . -type d | wc -l)
	echo "Total number of folders (including all nested ones) = $count"
}
function top_folders() {
	echo "TOP 5 folders of maximum size arrangered in descending order (path and size):"
	du -h $1 | sort -rh | head -5 | awk 'BEGIN{i=1}{printf "$d - %s, %s\n",i,$2,$1; i++}'
}
function total_files() {
	local file_count=$(find . -type f | wc -l)
	echo "Total number of files = $file_count"
}
function files_types() {
	echo "Number of:"
	echo "Configuration files (with the .conf extension) = $(find . -type f -name "*.conf" | wc -l)"
	echo "Text files = $(find . -type f -executable | wc -l)"
	echo "Log files (with the extension .log) = $(find . -type f -name "*.log" | wc -l)"
	echo "Archive files = $(find . -type f -name "*.a" | wc -l)"
	echo "Symbolic links = $(find . -type l | wc -l)"
}
function top_files() {
	echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
	find `pwd` -xdev -type f -exec du -sh {} ';' | sort -rh | head -10 | awk 'BEGIN{i=1}{printf "%d.% s\n",i,$0; i++}'
}
function top_executable_files() {
	echo "TOP 10 executable files of maximum size arranged in descending order (path, size and MD5 hash of file);"
	find `pwd` -xdev -type f -executable -exec du -sh {} ';' | sort -rh | head -10>file.txt
	for (( i=1; i-1<`wc -l file.txt | awk '{print $1}'`; i++ ))
	do
		md5sum `cat file.txt | awk "NR==$i" | awk '{print $2}'` | awk '{print $1}'>>file2.txt
		sed "s/$/ `cat file2.txt | awk "NR==$i"`/" file.txt | awk "NR==$i"
	done
	rm file2.txt
	rm file.txt
}

#start=$(date +%s)
#total_folders $1
#top_folders $1
#total_files $1
#files_types $1
#top_files $1
#top_executable_files $1
#end=$(date +%s.%N)
#time=$(echo "$end - $start" | bc)
#echo "Script execution time (in seconds) = $time"
