#!/bin/bash

#
# rofi_scratchpad.sh
# Author: conray
# Select window to show from scratchpad with rofi.
# dependencies:
#       jq
#	rofi 
#


IFS='
'

declare -A entries

# get scratchpad contents of tree
for entry in $(i3-msg -t get_tree | jq -r '.nodes[].nodes[].nodes[] | select(.name=="__i3_scratch").floating_nodes[].nodes[].window_properties | {instance,class,title} | join(",")' )
do 
	IFS=','
	set -- $entry
	val='[instance="'$1'" class="'$2'" title="'$3'"]'
	key=$(echo 'i:'$1' t:'$3' c:'$3)
	entries["$key"]="$val"

done

# rofi select window
ret="$(for e in ${!entries[@]}; do echo $e;done | rofi -dmenu -i -p Scratchpad)"

if [ -z $ret ];then
	exit
else
	# show window
	i3-msg "${entries[$ret]}" scratchpad show
fi
