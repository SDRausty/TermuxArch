#!/usr/bin/env bash
# Copyright 2017-2020 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project.
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
_BLOOM_() { # Bloom = `setupTermuxArch manual verbose`
	[[ -d "$HOME"/TermuxArchBloom ]] && _RMBLOOMQ_
	mkdir -p "$HOME"/TermuxArchBloom
	cp *sh "$HOME"/TermuxArchBloom
	cp setupTermuxArch "$HOME"/TermuxArchBloom
	cd "$HOME"/TermuxArchBloom
	printf "\\e[1;34m%s\\e[1;32m%s\\e[0m 📲\\n\\n" "TermuxArch Bloom option via " "setupTermuxArch bloom"
	ls -agl
	printf "\\n\\e[1;34m%s\\e[1;32m%s\\e[1;34m%s\\e[1;32m%s\\e[1;34m%s\\e[1;32m%s\\e[1;34m.\\e[0m\\n" "Use " "cd ~/TermuxArchBloom" " to continue.  Edit any of these files;  Then use " "bash ${0##*/} [options]" " to run the files in " "~/TermuxArchBloom"
	printf '\033]2;  TermuxArch Bloom option via `setupTermuxArch bloom` 📲 \007'
}

_EDITFILES_() {
	if [[ -z "${ceds[$i]:-}" ]]
	then
		editor "${WDIR}setupTermuxArchConfigs.bash"
	elif [[ "${ceds[$i]}" = "vi" ]]
	then
		sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vi instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP CMIRROR.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://CMIRROR.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local CMIRROR.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local CMIRROR.\n# Choose only one CMIRROR.  Use :x to save your work.\n# Comment out the Geo-IP CMIRROR	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vi instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$INSTALLDIR"/etc/locale.gen
	elif [[ "${ceds[$i]}" = "vim" ]]
	then
		sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP CMIRROR.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://CMIRROR.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local CMIRROR.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local CMIRROR.\n# Choose only one CMIRROR.  Use :x to save your work.\n#Comment out the Geo-IP CMIRROR	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$INSTALLDIR"/etc/locale.gen
	elif [[ "${ceds[$i]}" = "nvim" ]]
	then
		sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch neovim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP CMIRROR.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://CMIRROR.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local CMIRROR.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local CMIRROR.\n# Choose only one CMIRROR.  Use :x to save your work.\n# Comment out the Geo-IP CMIRROR	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch neovim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$INSTALLDIR"/etc/locale.gen
	else
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch edit instructions:	 Locate the Geo-IP CMIRROR.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://CMIRROR.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Choose only one CMIRROR.\n# Delete # to uncomment your local CMIRROR.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
	fi
}

_EDITORS_() {
	aeds=("emacs" "joe" "jupp" "nano" "ne" "nvim" "micro" "vi" "vim" "zile")
	for i in "${!aeds[@]}"
	do
		if [[ -e "$PREFIX/bin/${aeds[$i]}" ]]
		then
			ceds+=("${aeds[$i]}")
		fi
	done
	for i in "${!ceds[@]}"
	do
		cedst+="${ceds[$i]}, "
	done
	for i in "${!ceds[@]}"
	do
		edq
		if [[ "$ind" = 1 ]]
		then
			break
		fi
	done
}

edq() {
	printf "\\e[0;32m"
	for i in "${!ceds[@]}"
	do
		if [[ "${ceds[$i]}" = "vi" ]]
		then
			_EDQ2_
			ind=1
			break
		fi
		_EDQA_ "$ceds"
		if [[ "$ind" = 1 ]]
		then
			break
		fi
	done
}

_EDQA_() {
	ed="${ceds[$i]}"
	ind=1
}

_EDQAQUESTION_() {
	while true
	do
		printf "\\n"
		if [[ "$OPT" = BLOOM ]] || [[ "$OPT" = MANUAL ]]
		then
			printf "The following editor(s) $cedst\\b\\b are present.  Would you like to use \`\\e[1;32m${ceds[$i]}\\e[0;32m\` to edit \`\\e[1;32msetupTermuxArchConfigs.bash\\e[0;32m\`?  "
			read -n 1 -p "Answer yes or no [Y|n]. "  yn
		else
			printf "Change the worldwide CMIRROR to a CMIRROR that is geographically nearby.  Choose only ONE active CMIRROR in the CMIRRORs file that you are about to edit.  The following editor(s) $cedst\\b\\b are present.  Would you like to use \`\\e[1;32m${ceds[$i]}\\e[0;32m\` to edit the Arch Linux configuration files?  "
			read -n 1 -p "Answer yes or no [Y|n]. "  yn
		fi
		if [[ "$yn" = [Yy]* ]] || [[ "$yn" = "" ]]
		then
			ed="${ceds[$i]}"
			ind=1
			break
		elif [[ "$yn" = [Nn]* ]]
		then
			break
		else
			printf "\\nYou answered \\e[1;36m$yn\\e[1;32m.\\n"
			printf "\\nAnswer yes or no [Y|n].  \\n"
		fi
	done
}

_EDQ2_() {
	while true
	do
		if [[ "$OPT" = BLOOM ]] || [[ "$OPT" = MANUAL ]]
		then
			printf "\\n\\e[1;34m  Would you like to use \\e[1;32mnano\\e[1;34m or \\e[1;32mvi\\e[1;34m to edit \\e[1;32msetupTermuxArchConfigs.bash\\e[1;34m?  "
			read -n 1 -p "Answer nano or vi [n|V]? "  nv
		else
			printf "\\e[1;34m  Change the worldwide CMIRROR to a CMIRROR that is geographically nearby.  Choose only ONE active CMIRROR in the CMIRRORs file that you are about to edit.  Would you like to use \\e[1;32mnano\\e[1;34m or \\e[1;32mvi\\e[1;34m to edit the Arch Linux configuration files?  "
			read -n 1 -p "Answer nano or vi [n|V]? "  nv
		fi
		if [[ "$nv" = [Nn]* ]]
		then
			ed=nano
			_NANOIF_
			ind=1
			break
		elif [[ "$nv" = [Vv]* ]] || [[ "$nv" = "" ]]
		then
			ed=vi
			ind=1
			break
		else
			printf "\\nYou answered \\e[36;1m$nv\\e[1;32m.\\n\\nAnswer nano or vi [n|v].  \\n"
		fi
	done
	printf "\\n"
}

_NANOIF_() {
	if [[ ! -x "$PREFIX"/bin/nano ]]
	then
		apt -o APT::Keep-Downloaded-Packages="true" install "nano" -y
		if [[ ! -x "$PREFIX"/bin/nano ]]
		then
				printf "\\n\\e[7;1;31m%s\\e[0;1;32m %s\\n\\n\\e[0m" "PREREQUISITE EXCEPTION!" "RUN ${0##*/} $ARGS AGAIN..."
				printf "\\e]2;%s %s\\007" "RUN ${0##*/} $ARGS" "AGAIN..."
				exit
		fi
	fi
}

_RMBLOOMQ_() {
	if [[ -d "$HOME"/TermuxArchBloom ]]
	then
		printf "\\n\\n\\e[0;33m%s\\e[1;33m%s\\e[0;33m%s\\e[1;30m%s\\e[0;33m%s\\n" "TermuxArch:  " "DIRECTORY WARNING!  $HOME/TermuxArchBloom/ " "directory detected;  " "setupTermuxArch bloom" " will continue."
		while true
		do
			printf "\\n\\e[1;30m"
			read -n 1 -p "Refresh $HOME/TermuxArchBloom? [Y|n] " RBUANSWER
			if [[ "$RBUANSWER" = [Ee]* ]] || [[ "$RBUANSWER" = [Nn]* ]] || [[ "$RBUANSWER" = [Qq]* ]]
			then
				printf "\\n"
				exit $?
			elif [[ "$RBUANSWER" = [Yy]* ]] || [[ "$RBUANSWER" = "" ]]
			then
				printf "\\e[30m%s\\n" "Uninstalling $HOME/TermuxArchBloom..."
				if [[ -d "$HOME"/TermuxArchBloom ]]
				then
					rm -rf "$HOME"/TermuxArchBloom
				fi
				printf "%s\\n\\n" "Uninstalling $HOME/TermuxArchBloom done."
				break
			else
				printf "\\n%s\\e[33;1m%s\\e[30m.\\n\\nAnswer \\e[32mYes\\e[30m or \\e[1;31mNo\\e[30m. [\\e[32mY\\e[30m|\\e[1;31mn\\e[30m]\\n" "You answered " "$RBUANSWER"
			fi
		done
	fi
}

_TASPINNER_() {	# print spinner; derivation based on https://github.com/ringohub/sh-spinner and https://github.com/vozdev/termux-setup
	INCREMNT=1
	if [[ -z "${1:-}" ]]
	then
	  	SPINNERL="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
	elif [[ "${1//-}" = clock ]]
	then
		SPINNERL="🕛🕐🕑🕓🕔🕕🕖🕗🕘🕙🕚"
	elif [[ "${1//-}" = moon ]]
	then
		SPINNERL="🌑🌒🌓🌔🌕🌖🌗🌘"
	fi
	SPINDLAY="0.$(shuf -i 1-4 -n 1)"
	printf "\\e[?25l"
	while :
		do
		printf "  \b\b\b%s\b" "${SPINNERL:INCREMNT++%${#SPINNERL}:1}"
		sleep $SPINDLAY
	done
	printf "\\n\\e[?25h"
}

_TAMATRIX_() {	# print TermuxArch source code as matrix
	# Terminal codes VT100 \\e[?25l information at https://wiki.bash-hackers.org/scripting/terminalcodes website.
	printf "\\e[?25l\\e[1;32m%s" "$(tr -d '\n' < $0)"
	# split a string from file and print this split string
	IFS=';' read -ra TAMATARR <<< "$(tr -d '\n' < $0)" && for EMSTRING in "${TAMATARR[@]}" ; do printf "\\e[0;32m%s" "$EMSTRING" ; sleep 0.0"$(shuf -i 0-999 -n 1)" ; done ; tail -n 8 "$0" ; printf "\\e[0m" ; printf "\\e[?25h"; exit
}
# espritfunctions.bash EOF
