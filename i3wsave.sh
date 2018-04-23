#!/bin/bash

#
# i3wsave.sh
# Author: conray
# script to easily save and restore workspaces
# dependencies:
#	jq
#	rofi
#	wmctrl
#	xterm
#
# ideally use some keybind like
# bindsym $mod+Shift+w exec bash /path/to/i3wsave.sh
#
#/*
# * ----------------------------------------------------------------------------
# * "THE BEER-WARE LICENSE" (Revision 42):
# * <phk@FreeBSD.ORG> wrote this file. As long as you retain this notice you
# * can do whatever you want with this stuff. If we meet some day, and you think
# * this stuff is worth it, you can buy me a beer in return Poul-Henning Kamp
# * ----------------------------------------------------------------------------
# */
#


if [ -e $(dirname $0)/i3wsaverc ]
then 
	# load config
	. $(dirname $0)/i3wsaverc
else
	#set default config
	conf_path=$HOME/.config/i3
	editor=$EDITOR
	terminal=xterm
	terminal_opts=(-bg black -fg white -title i3wsave)
	rofi_opts=()
fi

#set seperator
IFS='
'

#rofi
ws=$(ls -1 $conf_path/ | grep .json | sed 's/.json//' | rofi -dmenu ${rofi_opts[@]} -i -p "Workspace")


if [ ! -z $ws ]
then
	
	if [ -e "$conf_path/$ws.json" ]
	then
		#append selected layout
		i3-msg "append_layout $conf_path/$ws.json"

		#start programs
		i3-msg "exec sh $conf_path/$ws.sh"
	else
		#save layout
		i3-save-tree  | sed 's#// "class"#"class"#g;s#// "instance"#"instance"#g;s#// "title"#"title"#g;s#// "transient_for"#"transient_for"#g' >  "$conf_path/$ws.json"

		#get current workspace
		active_ws=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true) | .name' | tr -d '"');

		#create .sh script
		echo '#!/bin/sh' > $conf_path/$ws.sh 
		
		#get window ids from running windows
		for i in $(i3-msg -t get_tree | jq ".nodes[].nodes[].nodes[] | select(.name==\"$active_ws\")" | grep '"window":' | grep -o '[0-9]*' | awk -Wposix '{printf("0x%08x\n", $1)}')
		do
		    #get pid from windowid
		    pidof=$(wmctrl -lxp | grep $i | awk '{print $3}')

		    #get command of pid
		    cmd=$(tr '\0' ' ' < /proc/$pidof/cmdline) 
		    echo "$cmd &"

		#write commands to .sh file
		done >> $conf_path/$ws.sh

		#show generated sh script in terminal
		$terminal ${terminal_opts[@]} -e "$editor $conf_path/$ws.sh"

	fi
fi
