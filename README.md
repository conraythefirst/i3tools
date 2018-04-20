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


It tries to find the commands of the window and generates a new shell script to automatically open the programs you had running. This might be a bit off under some circumstances. 
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




### License: Beerware
/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <phk@FreeBSD.ORG> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return. Poul-Henning Kamp
 * ----------------------------------------------------------------------------
 */
