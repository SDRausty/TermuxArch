#!/bin/env bash
# Copyright 2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about TermuxArch. 
################################################################################

addlangq() {
	while true; do
		printf "\\e[1;34m  Add languages to the Arch Linux system? To edit \\e[1;32m/etc/locale.gen\\e[1;34m for your preferred language(s) before running \\e[1;32mlocale-gen\\e[1;34m choose edit.  Would you like to run \\e[1;32mlocale-gen\\e[1;34m with the English en_US.UTF-8 locale only?  "
		read -n 1 -p "Answer yes to generate the English en_US.UTF-8 locale only [Y|e] " ye
		if [[ "$ye" = [Yy]* ]] || [[ "$ye" = "" ]];then
			break
		elif [[ "$ye" = [Ee]* ]] || [[ "$ye" = [Nn]* ]];then
			printf "\\e[0m"
			"$ed" "$installdir"/etc/locale.gen
			sleep 1
			break
		else
			printf "\\nYou answered \\e[1;36m$ye\\e[1;32m.\\n"
			sleep 1
			printf "\\nAnswer yes to run, or edit to edit the file [Y|e]\\n"
		fi
	done
}

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
	
runfinishsetupq() {
	while true; do
		printf "\\n\\e[0;32mWould you like to run \\e[1;32mfinishsetup.sh\\e[0;32m to complete the Arch Linux configuration and update now, or at a later time?  \\e[1;32mNow is recommended.  \\e[0;32m"
		read -n 1 -p "Answer yes to complete the Arch Linux configuration and update now; Or answer no for later [Y|n] " nl
	if [[ "$nl" = [Yy]* ]] || [[ "$nl" = "" ]];then
		runfinishsetup 
		break
	elif [[ "$nl" = [Nn]* ]];then
		printf "\\n\\e[0;32mSet the geographically nearby mirror in \\e[1;32m/etc/pacman.d/mirrorlist\\e[0;32m first.  Then use \\e[1;32m$installdir/root/bin/setupbin.sh\\e[0;32m in Termux to run \\e[1;32mfinishsetup.sh\\e[0;32m or simply \\e[1;32mfinishsetup.sh\\e[0;32m in Arch Linux Termux PRoot to complete the Arch Linux configuration and update."
		break
	else
		printf "\\nYou answered \\e[1;36m$nl\\e[1;32m.\\n"
		sleep 1
		printf "\\nAnswer yes to complete, or no for later [Y|n]\\n"
	fi
	done
	printf '\\n'
}

spinner() { # Based on https://github.com/ringohub/sh-spinner
 	printf "\\e[?25l\e[1;32m"
#  	SPINNER="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
#  	SPINNER="🌑🌒🌓🌔🌕🌖🌗🌘"
#  	SPINNER="🕛🕧🕐🕜🕑🕝🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕥🕚🕦"
#  	SPINNER="🕧🕜🕝🕟🕠🕡🕢🕣🕤🕥🕦"
	SPINNER="🕛🕐🕑🕓🕔🕕🕖🕗🕘🕙🕚"
	task="$1"
	msg="$2"
	while :; do
		jobs %1 > /dev/null 2>&1
		[[ $? = 0 ]] || {
			printf " %s %s %s\e[?25h\e[0m\n" "✓" "$task" "DONE                    "
			break
		}
		for (( i=0; i<${#SPINNER}; i++ )); do
			sleep 0.05
			printf " %s %s%s\r" "${SPINNER:$i:1}" "$task" "$msg"
		done
	done
}

# EOF
