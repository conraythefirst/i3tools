i3tools
=======

## i3wsave.sh

This is a small shell script to easily save and restore workspaces you've setup once.
It utilizes "rofi" to create an interface for saving and restoring workspaces.

Bind this script to a shortcut by putting something like
```
	bindsym $mod+Shift+w exec bash /path/to/i3wsave.sh
```
in your i3 config.


It tries to find the commands of all open windows and generates a new shell script to automatically open the programs you had running. This might be a bit off under some circumstances. 
After saving a workspace it opens xterm with $EDITOR to check the result. 

I'd suggest making the terminal window it opens floating by default
```
	for_window [class="XTerm" title="i3wsave"] floating enable
```

### Dependencies
	rofi
	jq
	wmctrl
	xterm



## switchScreen.sh

Easily switch focus and move the current workspace to a second screen in a dual screen setup.

```
	./switchScreen.sh move 	#move current workspace to other screen
	./switchScreen.sh focus 	#switch to workspace visible on other screen
```

### Dependencies
	jq




## rofi_scratchpad.sh

Select window to show from scratchpad with rofi.

```
	./rofi_scratchpad.sh
```

### Dependencies
	jq
	rofi



