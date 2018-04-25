#!/bin/sh

#
# switchScreen.sh
# Author: conray
# script to easily move focus or workspace to other screen
# dependencies:
#       jq
#

if [ $# -ne 1 ];
then
	echo "Usage: switchScreen move|focus"
	exit 0
fi

if [ "$1" == "move" ]
then

	#get name of other screen
	targetScreen=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==false) | select(.visible==true) | .output')

	#move to target screen
	i3-msg "move workspace to output $targetScreen"
	
elif [ "$1" == "focus" ]
then
	#get workspacename on other screen
	targetWorkspace=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==false) | select(.visible==true) | .name' )

	#focus workspace on other screen
	i3-msg "workspace $targetWorkspace"
	
else
	echo "Invalid argument: $1"
	exit 0
fi
