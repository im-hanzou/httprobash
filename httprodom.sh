#!/bin/bash
RD="\e[91m"
GR="\e[92m"
CY="\e[96m"
YL="\e[93m"
BL="\e[94m"
NC="\e[0m"
clear
echo -ne "     Httprobe in Bash \n "
echo -ne "     Nakanosec.com \n "
echo -ne "[${YL}?${NC}] Your Enter Your list = "
read list
if [[ ! -f $list ]]; then
	echo -e "[${RD}!${NC}] I can't find your fu*king list!"
	exit 1
fi


getting(){
	RD="\e[91m"
	GR="\e[92m"
	CY="\e[96m"
	YL="\e[93m"
	BL="\e[94m"
	NC="\e[0m"
	site=${1%$'\r'}
	tnt=$(curl -A "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:65.0) Gecko/20100101 Firefox/65.0" -I -s -L "$site" | grep "Location" | sed 's/Location//g' | sed 's|[:,] ||g' | tail -1 || echo "$site" >&2)
		echo "$tnt" | sed '/^$/d' | grep -Eo "(http|https)://[a-zA-Z0-9.-][a-zA-Z0-9.-]*" >> nakanosec.txt
		echo "$tnt"
}
export -f getting
echo -e "===============[Save in Nakanosec.txt]==============="
sort -u $list | xargs -P 50 -n1 bash -c 'getting "$@"' _
