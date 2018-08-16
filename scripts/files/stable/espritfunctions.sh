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

bloom() { # Bloom = `setupTermuxArch.sh manual verbose` 
	if [[ -d "$HOME"/TermuxArchBloom ]];then 
		rmbloomq 
	fi
	if [[ ! -d "$HOME"/TermuxArchBloom ]];then 
		mkdir "$HOME"/TermuxArchBloom
	fi
	cd "$HOME"/TermuxArchBloom
	printf "\\e[1;34mTermuxArch Bloom option via \\e[1;32msetupTermuxArch.sh bloom\\e[0m 📲\\n\\n\\e[0m"'\033]2; TermuxArch Bloom option via `setupTermuxArch.sh bloom` 📲 \007'
	ls -agl
	printf "\\n"
	pwd
	printf "\\n"
	dependsblock "$@" 
	printf "\\n"
	ls -agl
	printf "\\n\\e[1;34mUse \\e[1;32mcd ~/TermuxArchBloom\\e[1;34m to continue.  Edit any of these files; Then use \\e[1;32mbash $0 [options] \\e[1;34mto run the files in \\e[1;32m~/TermuxArchBloom\\e[1;34m.\\n\\e[0m"'\033]2;  TermuxArch Bloom option via `setupTermuxArch.sh bloom` 📲 \007'
}

editfiles() {
	if [[ "${ceds[$i]}" = "applets/vi" ]];then
		sed -i -e 1,4d "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vi instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local mirror.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local mirror.\n# Choose only one mirror.  Use :x to save your work.\n# Comment out the Geo-IP mirror	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vi instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$installdir"/etc/locale.gen
	elif [[ "${ceds[$i]}" = "vim" ]];then
		sed -i -e 1,4d "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local mirror.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local mirror.\n# Choose only one mirror.  Use :x to save your work.\n#Comment out the Geo-IP mirror	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$installdir"/etc/locale.gen
	elif [[ "${ceds[$i]}" = "nvim" ]];then
		sed -i -e 1,4d "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch neovim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local mirror.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local mirror.\n# Choose only one mirror.  Use :x to save your work.\n# Comment out the Geo-IP mirror	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch neovim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$installdir"/etc/locale.gen
	else
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch edit instructions:	 Locate the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Choose only one mirror.\n# Delete # to uncomment your local mirror.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
	fi
}

editors() {
	aeds=("zile" "nano" "nvim" "vi" "emacs" "joe" "jupp" "micro" "ne" "applets/vi")
	for i in "${!aeds[@]}"; do
		if [[ -e "$PREFIX/bin/${aeds[$i]}" ]];then
			ceds+=("${aeds[$i]}")
		fi
	done
	for i in "${!ceds[@]}"; do
		cedst+="\`\\e[1;32m${ceds[$i]}\\e[0;32m\`, "
	done
	for i in "${!ceds[@]}"; do
		edq 
		if [[ "$ind" = 1 ]];then
			break
		fi
	done
}

edq() {
	printf "\\e[0;32m"
	for i in "${!ceds[@]}"; do
		if [[ "${ceds[$i]}" = "applets/vi" ]];then
			edq2
			ind=1
			break
		fi
		edqa "$ceds"
		if [[ "$ind" = 1 ]];then
			break
		fi
	done
}

edqa() {
	ed="${ceds[$i]}"
	ind=1
}

edqaquestion() {
	while true; do
		printf "\\n"
		if [[ "$opt" = bloom ]] || [[ "$opt" = manual ]];then
			printf "The following editor(s) $cedst\\b\\b are present.  Would you like to use \`\\e[1;32m${ceds[$i]}\\e[0;32m\` to edit \`\\e[1;32msetupTermuxArchConfigs.sh\\e[0;32m\`?  "
			wead -n 1 -p "Answer yes or no [Y|n]. "  yn
		else 
			printf "Change the worldwide mirror to a mirror that is geographically nearby.  Choose only ONE active mirror in the mirrors file that you are about to edit.  The following editor(s) $cedst\\b\\b are present.  Would you like to use \`\\e[1;32m${ceds[$i]}\\e[0;32m\` to edit the Arch Linux configuration files?  "
			read -n 1 -p "Answer yes or no [Y|n]. "  yn
		fi
		if [[ "$yn" = [Yy]* ]] || [[ "$yn" = "" ]];then
			ed="${ceds[$i]}"
			ind=1
			break
		elif [[ "$yn" = [Nn]* ]];then
			break
		else
			printf "\\nYou answered \\e[1;36m$yn\\e[1;32m.\\n"
			printf "\\nAnswer yes or no [Y|n].  \\n"
		fi
	done
}

edq2() {
	while true; do
		if [[ "$opt" = bloom ]] || [[ "$opt" = manual ]];then
			printf "\\n\\e[1;34m  Would you like to use \\e[1;32mnano\\e[1;34m or \\e[1;32mvi\\e[1;34m to edit \\e[1;32msetupTermuxArchConfigs.sh\\e[1;34m?  "
			read -n 1 -p "Answer nano or vi [n|V]? "  nv
		else 
			printf "\\e[1;34m  Change the worldwide mirror to a mirror that is geographically nearby.  Choose only ONE active mirror in the mirrors file that you are about to edit.  Would you like to use \\e[1;32mnano\\e[1;34m or \\e[1;32mvi\\e[1;34m to edit the Arch Linux configuration files?  "
			read -n 1 -p "Answer nano or vi [n|V]? "  nv
		fi
		if [[ "$nv" = [Nn]* ]];then
			ed=nano
			nanoif
			ind=1
			break
		elif [[ "$nv" = [Vv]* ]] || [[ "$nv" = "" ]];then
			ed="$PREFIX"/bin/applets/vi
			ind=1
			break
		else
			printf "\\nYou answered \\e[36;1m$nv\\e[1;32m.\\n\\nAnswer nano or vi [n|v].  \\n"
		fi
	done	
	printf "\\n"
}

rmbloomq() {
	if [[ -d "$HOME"/TermuxArchBloom ]];then
		printf "\\n\\n\\e[0;33mTermuxArch: \\e[1;33mDIRECTORY WARNING!  $HOME/TermuxArchBloom/ \\e[0;33mdirectory detected.  \\e[1;30msetupTermuxArch.sh bloom will continue.\\n"
		while true; do
			printf "\\n\\e[1;30m"
			read -n 1 -p "Refresh $HOME/TermuxArchBloom? [Y|n] " rbuanswer
			if [[ "$rbuanswer" = [Ee]* ]] || [[ "$rbuanswer" = [Nn]* ]] || [[ "$rbuanswer" = [Qq]* ]];then
				printf "\\n" 
				exit $? 
			elif [[ "$rbuanswer" = [Yy]* ]] || [[ "$rbuanswer" = "" ]];then
				printf "\\e[30mUninstalling $HOME/TermuxArchBloom…\\n"
				if [[ -d "$HOME"/TermuxArchBloom ]];then
					rm -rf "$HOME"/TermuxArchBloom 
				else 
					printf "Uninstalling $HOME/TermuxArchBloom, nothing to do for $installdir.\\n\\n"
				fi
				printf "Uninstalling $HOME/TermuxArchBloom done.\\n\\n"
				break
			else
				printf "\\nYou answered \\e[33;1m$rbuanswer\\e[30m.\\n\\nAnswer \\e[32mYes\\e[30m or \\e[1;31mNo\\e[30m. [\\e[32mY\\e[30m|\\e[1;31mn\\e[30m]\\n"
			fi
		done
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
			printf " %s %s\e[1;34m:\e[1;32m %s\e[?25h\e[0m\n" "✓" "$task" "DONE                    "
			break
		}
		for (( i=0; i<${#SPINNER}; i++ )); do
			sleep 0.05
			printf " %s %s%s\r" "${SPINNER:$i:1}" "$task" "$msg"
		done
	done
}

# EOF
