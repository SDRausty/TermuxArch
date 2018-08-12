#!/bin/env bash
# Copyright 2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about TermuxArch. 
################################################################################

editfiles() {
	if [[ "${ceds[$i]}" = "applets/vi" ]];then
		sed -i -e 1,4d "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vi instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# 17j then i opens edit mode for the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap ESC to return to command mode in vi.\\n# CTRL+d and CTRL+b to find your local mirror.\\n# / for search, N and n for next match.\\n# Tap x to delete # to uncomment your local mirror.\\n# Choose only one mirror.  Use :x to save your work.\\n# Comment out the Geo-IP mirror	end G	top gg\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vi instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# Tap i for insert, ESC to return to command mode in vi.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap x to delete # to uncomment your favorite language(s).\\n# Enter the # hash/num/pounds symbol to comment out locales.\\n# CTRL+d and CTRL+b for PGUP & PGDN.\\n# top gg	bottom G\\n# / for search, N and n for next match.\\n# Choose as many as you like.  Use :x to save your work.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n#' "$installdir"/etc/locale.gen
	elif [[ "${ceds[$i]}" = "vim" ]];then
		sed -i -e 1,4d "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# 17j then i opens edit mode for the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap ESC to return to command mode in vi.\\n# CTRL+d and CTRL+b to find your local mirror.\\n# / for search, N and n for next match.\\n# Tap x to delete # to uncomment your local mirror.\\n# Choose only one mirror.  Use :x to save your work.\\n#Comment out the Geo-IP mirror	end G	top gg\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# Tap i for insert, ESC to return to command mode in vi.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap x to delete # to uncomment your favorite language(s).\\n# Enter the # hash/num/pounds symbol to comment out locales.\\n# CTRL+d and CTRL+b for PGUP & PGDN.\\n# top gg	bottom G\\n# / for search, N and n for next match.\\n# Choose as many as you like.  Use :x to save your work.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n#' "$installdir"/etc/locale.gen
	elif [[ "${ceds[$i]}" = "nvim" ]];then
		sed -i -e 1,4d "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch neovim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# 17j then i opens edit mode for the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap ESC to return to command mode in vi.\\n# CTRL+d and CTRL+b to find your local mirror.\\n# / for search, N and n for next match.\\n# Tap x to delete # to uncomment your local mirror.\\n# Choose only one mirror.  Use :x to save your work.\\n# Comment out the Geo-IP mirror	end G	top gg\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch neovim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# Tap i for insert, ESC to return to command mode in vi.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap x to delete # to uncomment your favorite language(s).\\n# Enter the # hash/num/pounds symbol to comment out locales.\\n# CTRL+d and CTRL+b for PGUP & PGDN.\\n# top gg	bottom G\\n# / for search, N and n for next match.\\n# Choose as many as you like.  Use :x to save your work.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n#' "$installdir"/etc/locale.gen
	else
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch edit instructions:	 Locate the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Choose only one mirror.\\n# Delete # to uncomment your local mirror.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
	fi
}
	
spinner() { # Based on https://github.com/ringohub/sh-spinner
 	printf "\\e[?25l"
#  	SPINNER="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
#  	SPINNER="🕛🕧🕐🕜🕑🕝🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕚🕦"
	SPINNER="🕛🕐🕑🕓🕔🕕🕖🕗🕘🕙🕚"
	task="$1"
	msg="$2"
	while :; do
		jobs %1 > /dev/null 2>&1
		[ $? = 0 ] || {
			printf "\\e[1;32m ✓ $task DONE          \\n\\e[0m"
			break
		}
		for (( i=0; i<${#SPINNER}; i++ )); do
			sleep 0.05
			printf "\\e[1;32m ${SPINNER:$i:1} $task $msg\r"
		done
	done
 	printf "\\e[?25h"
}
