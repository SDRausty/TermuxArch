#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project. 
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# _STANDARD_="function name" && STANDARD="variable name" are under construction.
################################################################################

addbinds() { # Checks if /proc/stat is usable. 
	if [[ ! -r /proc/stat ]] ; then
		_ADDfbindprocstat_
	fi
}

addlangq() {
	while true; do
		printf "\\e[1;34m  Add languages to the Arch Linux system? To edit \\e[1;32m/etc/locale.gen\\e[1;34m for your preferred language(s) before running \\e[1;32mlocale-gen\\e[1;34m choose edit.  Would you like to run \\e[1;32mlocale-gen\\e[1;34m with the English en_US.UTF-8 locale only?  "
		read -n 1 -p "Answer yes to generate the English en_US.UTF-8 locale only [Y|e] " ye
		if [[ "$ye" = [Yy]* ]] || [[ "$ye" = "" ]];then
			break
		elif [[ "$ye" = [Ee]* ]] || [[ "$ye" = [Nn]* ]];then
			printf "\\e[0m"
			"$ed" "$INSTALLDIR"/etc/locale.gen
			sleep 1
			break
		else
			printf "\\nYou answered \\e[1;36m$ye\\e[1;32m.\\n"
			sleep 1
			printf "\\nAnswer yes to run, or edit to edit the file [Y|e]\\n"
		fi
	done
}

_BLOOM_() { # Bloom = `setupTermuxArch.sh manual verbose` 
	if [[ -d "$HOME"/TermuxArchBloom ]];then 
		rmbloomq 
	fi
	if [[ ! -d "$HOME"/TermuxArchBloom ]];then 
		mkdir "$HOME"/TermuxArchBloom
	fi
	cp *sh "$HOME"/TermuxArchBloom
	cd "$HOME"/TermuxArchBloom
	printf "\\e[1;34mTermuxArch Bloom option via \\e[1;32msetupTermuxArch.sh bloom\\e[0m 📲\\n\\n\\e[0m"'\033]2; TermuxArch Bloom option via `setupTermuxArch.sh bloom` 📲 \007'
	printf "\\n"
	ls -agl
	printf "\\n\\e[1;34mUse \\e[1;32mcd ~/TermuxArchBloom\\e[1;34m to continue.  Edit any of these files; Then use \\e[1;32mbash $0 [options] \\e[1;34mto run the files in \\e[1;32m~/TermuxArchBloom\\e[1;34m.\\n\\e[0m"'\033]2;  TermuxArch Bloom option via `setupTermuxArch.sh bloom` 📲 \007'
	exit
}

_COPYSTARTBIN2PATHQ_() {
	while true; do
	printf "\\e[0;34m 🕛 > 🕚 \\e[0mCopy \\e[1m$STARTBIN\\e[0m to \\e[1m$BPATH\\e[0m?  "'\033]2; 🕛 > 🕚 Copy to $PATH [Y|n]?\007'
	read -n 1 -p "Answer yes or no [Y|n] " answer
	if [[ "$answer" = [Yy]* ]] || [[ "$answer" = "" ]];then
		cp "$INSTALLDIR/$STARTBIN" "$BPATH"
		printf "\\n\\e[0;34m 🕛 > 🕦 \\e[0mCopied \\e[1m$STARTBIN\\e[0m to \\e[1m$BPATH\\e[0m.\\n\\n"
		break
	elif [[ "$answer" = [Nn]* ]] || [[ "$answer" = [Qq]* ]];then
		printf "\\n"
		break
	else
		printf "\\n\\e[0;34m 🕛 > 🕚 \\e[0mYou answered \\e[33;1m$answer\\e[0m.\\n\\n\\e[0;34m 🕛 > 🕚 \\e[0mAnswer yes or no [Y|n]\\n\\n"
	fi
	done
}

_CREATEMENU_() { # https://stackoverflow.com/users/258523/etan-reisner
       	ARSIZE=$1
       	printf "This option to install Linux flavors is being developed; \\n\\nChoose one of these options by inputting a number to continue:\\n"
       	echo 
	select CSYSTEM in "${@:2}"; do
	       	if [ "$REPLY" -eq "$ARSIZE" ];
	       	then
		       	echo "Exiting..."
		       	break;
	       	elif [ 1 -le "$REPLY" ] && [ "$REPLY" -le $((ARSIZE-1)) ];
	       	then
		       	echo 
		       	echo "You selected $CSYSTEM which is option $REPLY"
		       	break;
	       	else
		       	echo "Incorrect Input: Select a number 1-$ARSIZE"
       			echo 
	       	fi
       	done
}

_EDITFILES_() {
       	if [[ "${ceds[$i]}" = "applets/vi" ]];then
		sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vi instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# 17j then i opens edit mode for the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap ESC to return to command mode in vi.\\n# CTRL+d and CTRL+b to find your local mirror.\\n# / for search, N and n for next match.\\n# Tap x to delete # to uncomment your local mirror.\\n# Choose only one mirror.  Use :x to save your work.\\n# Comment out the Geo-IP mirror	end G	top gg\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vi instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# Tap i for insert, ESC to return to command mode in vi.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap x to delete # to uncomment your favorite language(s).\\n# Enter the # hash/num/pounds symbol to comment out locales.\\n# CTRL+d and CTRL+b for PGUP & PGDN.\\n# top gg	bottom G\\n# / for search, N and n for next match.\\n# Choose as many as you like.  Use :x to save your work.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n#' "$INSTALLDIR"/etc/locale.gen
	elif [[ "${ceds[$i]}" = "vim" ]];then
		sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# 17j then i opens edit mode for the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap ESC to return to command mode in vi.\\n# CTRL+d and CTRL+b to find your local mirror.\\n# / for search, N and n for next match.\\n# Tap x to delete # to uncomment your local mirror.\\n# Choose only one mirror.  Use :x to save your work.\\n#Comment out the Geo-IP mirror	end G	top gg\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# Tap i for insert, ESC to return to command mode in vi.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap x to delete # to uncomment your favorite language(s).\\n# Enter the # hash/num/pounds symbol to comment out locales.\\n# CTRL+d and CTRL+b for PGUP & PGDN.\\n# top gg	bottom G\\n# / for search, N and n for next match.\\n# Choose as many as you like.  Use :x to save your work.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n#' "$INSTALLDIR"/etc/locale.gen
	elif [[ "${ceds[$i]}" = "nvim" ]];then
		sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch neovim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# 17j then i opens edit mode for the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap ESC to return to command mode in vi.\\n# CTRL+d and CTRL+b to find your local mirror.\\n# / for search, N and n for next match.\\n# Tap x to delete # to uncomment your local mirror.\\n# Choose only one mirror.  Use :x to save your work.\\n# Comment out the Geo-IP mirror	end G	top gg\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch neovim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# Tap i for insert, ESC to return to command mode in vi.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap x to delete # to uncomment your favorite language(s).\\n# Enter the # hash/num/pounds symbol to comment out locales.\\n# CTRL+d and CTRL+b for PGUP & PGDN.\\n# top gg	bottom G\\n# / for search, N and n for next match.\\n# Choose as many as you like.  Use :x to save your work.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n#' "$INSTALLDIR"/etc/locale.gen
	else
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch edit instructions:	 Locate the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Choose only one mirror.\\n# Delete # to uncomment your local mirror.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
	fi
}

_EDITORS_() {
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
		if [[ "$OPT" = *bloom* ]] || [[ "$OPT" = *manual* ]];then
			printf "The following editor(s) $cedst\\b\\b are present.  Would you like to use \`\\e[1;32m${ceds[$i]}\\e[0;32m\` to edit \`\\e[1;32msetupTermuxArchConfigs.sh\\e[0;32m\`?  "
			read -n 1 -p "Answer yes or no [Y|n]. "  yn
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
		if [[ "$OPT" = *bloom* ]] || [[ "$OPT" = *manual* ]];then
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

_LOADCONF_() {
	if [[ -f "${WDIR}setupTermuxArchConfigs.sh" ]] 
	then
		. "${WDIR}setupTermuxArchConfigs.sh"
		_PRINT_CONFLOADED_ 
	else
		. "${AF[3]}" # AF[3]=knownconfigurations.sh 
	fi
}

_MANUAL_() {
	printf "\033]2;%s\007" "bash ${0##*/} manual 📲"
	_EDITORS_
	if [[ -f "${WDIR}setupTermuxArchConfigs.sh" ]] 
	then
		"$ed" "${WDIR}setupTermuxArchConfigs.sh"
		. "${WDIR}setupTermuxArchConfigs.sh"
		_PRINT_CONFLOADED_ 
	else
       	if [[ "$LCW" = 0 ]] 
	then
		cp "$WDIR${AF[3]}" "${WDIR}setupTermuxArchConfigs.sh"
	else
		cp "${TAMPDIR}/${AF[3]}" "${WDIR}setupTermuxArchConfigs.sh"
	fi	
 		sed -i "7s/.*/\# The architecture of this device is $CPUABI; Adjust configurations in the appropriate section.  Change mirror (https:\/\/wiki.archlinux.org\/index.php\/Mirrors and https:\/\/archlinuxarm.org\/about\/mirrors) to desired geographic location to resolve 404, checksum and similar issues.  /" "${WDIR}setupTermuxArchConfigs.sh" 
		"$ed" "${WDIR}setupTermuxArchConfigs.sh"
		. "${WDIR}setupTermuxArchConfigs.sh"
		_PRINT_CONFLOADED_ 
	fi
}

nanoif() {
	if [[ ! -x "$PREFIX"/bin/nano ]] ; then
		apt -o APT::Keep-Downloaded-Packages="true" install "nano" -y
		if [[ ! -x "$PREFIX"/bin/nano ]] ; then
				printf "\\n\\e[7;1;31m%s\\e[0;1;32m %s\\n\\n\\e[0m" "PREREQUISITE EXCEPTION!" "RUN ${0##*/} $ARGS AGAIN…"
				printf "\\e]2;%s %s\\007" "RUN ${0##*/} $ARGS" "AGAIN…"
				exit
 		fi
	fi
}

_OPTIONAL_SYSTEMS_() {
       	# AVSYSTEMS=( Alpine Arch Archman Debian CentOS Fedora FreeBSD Gentoo GhostBSD Kali Nethunter Manjaro Mint OpenBSD Oracle Parabola "Red Hat" Slackware Ubuntu )
       	AVSYSTEMS=( Alpine "Arch Linux" Debian Fedora Parabola Slackware Ubuntu )
       	echo
	
	_CREATEMENU_ "${#AVSYSTEMS[@]}" "${AVSYSTEMS[@]}" 
	
	if [[ "$CSYSTEM" = Alpine ]]
#	#	Available architectures: aarch64 armhf x86_64 x86 and more.
# 	#	https://alpinelinux.org/downloads/
	then
		if [[ "$CPUABI" = armeabi ]]
		then
			echo "Alpine Linux does not appear to be available for your device.  Check at https://alpinelinux.org/downloads/."
			exit 198
		elif [[ "$CPUABI" = armeabi-v7a ]]
		then
		       	SPECS_ARMV7L_=( [DIST]="$CSYSTEM" [FILE]="alpine-minirootfs-3.8.1-armhf.tar.gz" [PROTOCOL]="http" [RPATH]="/alpine/v3.8/releases/armhf/" [SITE]="dl-cdn.alpinelinux.org" [SFNM]="alpine-minirootfs-3.8.1-armhf.tar.gz.sha256" [STYPE]="sha256sum" )
		elif [[ "$CPUABI" = arm64-v8a ]]
		then
		       	SPECS_ARMV8L_=( [DIST]="$CSYSTEM" [FILE]="alpine-minirootfs-3.8.1-aarch64.tar.gz" [PROTOCOL]="http" [RPATH]="/alpine/v3.8/releases/aarch64/" [SITE]="dl-cdn.alpinelinux.org" [SFNM]="alpine-minirootfs-3.8.1-aarch64.tar.gz.sha256" [STYPE]="sha256sum" )
		elif [[ "$CPUABI" = x86 ]]
		then
		       	SPECS_X86_=( [DIST]="$CSYSTEM" [FILE]="alpine-minirootfs-3.8.1-x86.tar.gz" [PROTOCOL]="http" [RPATH]="/alpine/v3.8/releases/x86/" [SITE]="dl-cdn.alpinelinux.org" [SFNM]="alpine-minirootfs-3.8.1-x86.tar.gz.sha256" [STYPE]="sha256sum" )
		elif [[ "$CPUABI" = x86_64 ]]
		then
		       	SPECS_X86_64_=( [DIST]="$CSYSTEM" [FILE]="alpine-minirootfs-3.8.1-x86_64.tar.gz" [PROTOCOL]="http" [RPATH]="/alpine/v3.8/releases/x86_64/" [SITE]="dl-cdn.alpinelinux.org" [SFNM]="alpine-minirootfs-3.8.1-x86_64.tar.gz.sha256" [STYPE]="sha256sum" )
		fi
	elif [[ "$CSYSTEM" = "Arch Linux" ]]
#	#	Available architectures: aarch64 armv7 armv5 x86_64 x86 and more.
# 	#	https://os.archlinuxarm.org/os/
	then
		if [[ "$CPUABI" = armeabi ]]
		then
			SPECS_ARMV5L_=( [DIST]="$CSYSTEM" [FILE]="ArchLinuxARM-armv5-latest.tar.gz" [PROTOCOL]="https" [RPATH]="/os/" [SITE]="os.archlinuxarm.org" [SFNM]="ArchLinuxARM-armv5-latest.tar.gz.md5" [STYPE]="md5sum" )
			
		elif [[ "$CPUABI" = armeabi-v7a ]]
		then
			SPECS_ARMV7L_=( [DIST]="$CSYSTEM" [FILE]="ArchLinuxARM-armv7-latest.tar.gz" [PROTOCOL]="https" [RPATH]="/os/" [SITE]="os.archlinuxarm.org" [SFNM]="ArchLinuxARM-armv7-latest.tar.gz.md5" [STYPE]="md5sum" )
# 			SPECS_ARMV7LC_=( [DIST]="$CSYSTEM" [FILE]="ArchLinuxARM-armv7-chromebook-latest.tar.gz" [PROTOCOL]="https" [RPATH]="/os/" [SITE]="os.archlinuxarm.org" [SFNM]="ArchLinuxARM-armv7-chromebook-latest.tar.gz.md5sum" [STYPE]="md5sum" )
		elif [[ "$CPUABI" = arm64-v8a ]]
		then
	       		SPECS_ARMV8L_=( [DIST]="$CSYSTEM" [FILE]="ArchLinuxARM-aarch64-latest.tar.gz" [PROTOCOL]="https" [RPATH]="/os/" [SITE]="os.archlinuxarm.org" [SFNM]="ArchLinuxARM-aarch64-latest.tar.gz.md5" [STYPE]="md5sum" )
		elif [[ "$CPUABI" = x86 ]]
		then
			SPECS_X86_=( [DIST]="$CSYSTEM" [FILE]="" [PROTOCOL]="https" [RPATH]="/iso/2017.03.01/" [SITE]="archive.archlinux.org" [SFNM]="md5sums.txt" [STYPE]="md5sum" )
		elif [[ "$CPUABI" = x86_64 ]]
		then
			SPECS_X86_64_=( [DIST]="$CSYSTEM" [FILE]="" [PROTOCOL]="https" [RPATH]="/archlinux/iso/latest/" [SITE]="mirror.rackspace.com" [SFNM]="md5sums.txt" [STYPE]="md5sum" )
		fi
	elif [[ "$CSYSTEM" = Debian ]]
	then
#		# Available architectures: aarch64 
# 		# https://people.debian.org/~wookey/bootstrap.html
	       	SPECS_ARMV8L_=( [DIST]="$CSYSTEM" [FILE]="saucy-arm64.tar.gz" [PROTOCOL]="https" [RPATH]="/~wookey/bootstrap/rootfs/" [SITE]="people.debian.org" [SFNM]="" [STYPE]="" )
	elif [[ "$CSYSTEM" = Fedora ]]
	then
#		# Available architectures: aarch64 armhfp x86_64
# 		# https://download.fedoraproject.org/pub/fedora/linux/releases/28/Container/
	       	SPECS_ARMV8L_=( [DIST]="$CSYSTEM" [FILE]="Fedora-Container-Base-28-1.1.aarch64.tar.xz" [PROTOCOL]="https" [RPATH]="/pub/fedora/linux/releases/28/Container/aarch64/images/"  [SITE]="download.fedoraproject.org" [SFNM]="Fedora-Container-28-1.1-aarch64-CHECKSUM" [STYPE]="" )
	elif [[ "$CSYSTEM" = Parabola ]]
	then # http://mirror.fsf.org/parabola/iso/
	       	SPECS_ARMV7L_=( [DIST]="$CSYSTEM" [FILE]="parabola-systemd-cli-armv7h-tarball-2018-02-06.tar.gz" [PROTOCOL]="https" [RPATH]="/parabola/iso/systemd-cli-2018-02-06/" [SITE]="mirror.fsf.org" [SITE]="mirror.fsf.org" [SFNM]="parabola-systemd-cli-armv7h-tarball-2018-02-06.tar.gz.sig" [STYPE]="" )
	elif [[ "$CSYSTEM" = Slackware ]]
	then
	       	SPECS_ARMV8L_=( [DIST]="$CSYSTEM" [FILE]="slack-current-miniroot_11Oct17.tar.xz" [PROTOCOL]="ftp" [RPATH]="/slackwarearm/slackwarearm-devtools/minirootfs/roots/" [SITE]="ftp.arm.slackware.com" [SFNM]="" [STYPE]="sha256sum" )
	elif [[ "$CSYSTEM" = Ubuntu ]]
	then # https://partner-images.canonical.com/core/bionic/current/
	       	SPECS_ARMV8L_=( [DIST]="$CSYSTEM" [FILE]="ubuntu-bionic-core-cloudimg-arm64-root.tar.gz" [PROTOCOL]="https" [SITE]="partner-images.canonical.com" [RPATH]="/core/bionic/current/" [SFNM]="SHA256SUMS" [STYPE]="" )
	else
	       	echo "$CSYSTEM is not currently implemented. "
	       	exit 163
	       	#	loadimage "$@" 
	fi
	_MAINBLOCK_
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
					printf "Uninstalling $HOME/TermuxArchBloom, nothing to do for $INSTALLDIR.\\n\\n"
				fi
				printf "Uninstalling $HOME/TermuxArchBloom done.\\n\\n"
				break
			else
				printf "\\nYou answered \\e[33;1m$rbuanswer\\e[30m.\\n\\nAnswer \\e[32mYes\\e[30m or \\e[1;31mNo\\e[30m. [\\e[32mY\\e[30m|\\e[1;31mn\\e[30m]\\n"
			fi
		done
	fi
}

_RUNFINISHSETUPQ_() {
	while true; do
		printf "\\n\\e[0;32mWould you like to run \\e[1;32mfinishsetup.sh\\e[0;32m to complete the Arch Linux configuration and update now, or at a later time?  \\e[1;32mNow is recommended.  \\e[0;32m"
		read -n 1 -p "Answer yes to complete the Arch Linux configuration and update now; Or answer no for later [Y|n] " nl
	if [[ "$nl" = [Yy]* ]] || [[ "$nl" = "" ]];then
		_RUNFINISHSETUP_ 
		break
	elif [[ "$nl" = [Nn]* ]];then
		printf "\\n\\e[0;32mSet the geographically nearby mirror in \\e[1;32m/etc/pacman.d/mirrorlist\\e[0;32m first.  Then use \\e[1;32m$INSTALLDIR/root/bin/setupbin.sh\\e[0;32m in Termux to run \\e[1;32mfinishsetup.sh\\e[0;32m or simply \\e[1;32mfinishsetup.sh\\e[0;32m in Arch Linux Termux PRoot to complete the Arch Linux configuration and update."
		break
	else
		printf "\\nYou answered \\e[1;36m$nl\\e[1;32m.\\n"
		sleep 1
		printf "\\nAnswer yes to complete, or no for later [Y|n]\\n"
	fi
	done
	printf '\\n'
}

spinner() {
	:
}

spinnerdepreciated() { # Based on https://github.com/ringohub/sh-spinner
 	printf "\\e[?25l\\e[1;32m"
#  	SPINNER="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
#  	SPINNER="🌑🌒🌓🌔🌕🌖🌗🌘"
#  	SPINNER="🕛🕧🕐🕜🕑🕝🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕥🕚🕦"
#  	SPINNER="🕧🕜🕝🕟🕠🕡🕢🕣🕤🕥🕦"
	SPINNER="🕛🕐🕑🕓🕔🕕🕖🕗🕘🕙🕚"
	task="$1"
	msg="$2"
	while true ; do
		jobs %1 > /dev/null 2>&1
		[[ "$?" = 0 ]] || {
		printf " %s %s\\e[1;34m:\\e[1;32m %s\\e[?25h\\e[0m\\n\\n" "✓" "$task" "DONE                                "
		break
		}
		for (( i=0; i<${#SPINNER}; i++ )) ; do
			sleep 0.05
			printf " %s %s %s\\r" "${SPINNER:$i:1}" "$task" "$msg"
		done
	done
}

# EOF
