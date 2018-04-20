i3tools
=======

# i3wsave.sh

This is a small shell script to easily save and restore workspaces you've setup once.

It tries to find the commands of the window and generates a new shell script to automatically open the programs you had running. This might be a bit off under some circumstances.
So check the script after saving a workspace.

### Dependencies
	rofi
	jq
	wmctrl
	xterm

## License: Beerware
/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <phk@FreeBSD.ORG> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Poul-Henning Kamp
 * ----------------------------------------------------------------------------
 */
