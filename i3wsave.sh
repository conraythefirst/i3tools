#!/bin/bash

conf_path=~/.i3tools/workspaces

IFS='
'

#rofi
ws=$(ls -1 $conf_path/ | grep .json | sed 's/.json//' | rofi -dmenu -i -p "Workspace")


if [ ! -z $ws ]
then
	
	if [ -e "$conf_path/$ws.json" ]
	then
		#append selected layout
		i3-msg "append_layout $conf_path/$ws.json"

		#start programs
		sh $conf_path/$ws.sh
	else
		#save layout
		i3-save-tree  | sed 's#// "class"#"class"#g;s#// "instance"\(.*\),#"instance"\1#g' >  "$conf_path/$ws.json"

		#get current workspace
		active_ws=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true) | .name' | tr -d '"');

		#create .sh script
		echo '#!/bin/sh' > $conf_path/$ws.sh 
		
		#get window ids from running windows
		for i in $(i3-msg -t get_tree | jq ".nodes[].nodes[].nodes[] | select(.name==\"$active_ws\")" | grep '"window":' | grep -o '[0-9]*' | awk -Wposix '{printf("0x%08x\n", $1)}')
		do
		    #getting pid from windowid
		    pidof=$(wmctrl -lxp | grep $i | awk '{print $3}')

		    #get command of pid
		    cmd=$(tr '\0' ' ' < /proc/$pidof/cmdline) 
		    echo "$cmd &"

		#write commands to .sh file
		done >> $conf_path/$ws.sh


		xterm -bg black -fg white -e "vim $conf_path/$ws.sh"
		##lxterminal --command="vim $conf_path/$ws.sh"

	fi
fi
