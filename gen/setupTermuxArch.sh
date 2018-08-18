#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README for TermuxArch information. 
################################################################################
IFS=$'\n\t'
set -Eeuxo pipefail
shopt -s nullglob globstar
unset LD_PRELOAD
versionid="gen.v1.6 id622888292040"
## Init Functions ##############################################################
addcurl() { # Adds `curl` to $PATH if not found.
	cat > "$PREFIX"/bin/curl <<- EOM
	#!/bin/sh
	unset LD_LIBRARY_PATH LD_PRELOAD
	PATH=\$PATH:/system/bin exec /system/bin/curl "\$@"
	EOM
	chmod 500 "$PREFIX"/bin/curl 
}

apin() {
	if [[ "$aptin" != "" ]] ; then
		printf "\\n\\e[1;34mInstalling \\e[0;32m%s\\e[1;34m…\\n\\n\\e[1;32m" "$aptin"
		pkg install "$aptin" -o APT::Keep-Downloaded-Packages="true" 
		printf "\\n\\e[1;34mInstalling \\e[0;32m%s\\e[1;34m: \\e[1;32mDONE\\n\\e[0m" "$aptin"
	fi
}

aria2cif() { 
	declare dm=aria2c
	if [[ ! -x "$(command -v aria2c)" ]] || [[ ! -x "$PREFIX"/bin/aria2c ]] ; then
		aptin+="aria2 "
		pins+="aria2c "
	fi
}

aria2cifdm() {
	if [[ "$dm" = aria2c ]] ; then
		aria2cif return 
	fi
}

arg2dir() { 
	arg2="${@:2:1}"
	if [[ -z "${arg2:-}" ]] ; then
		rootdir=/arch
		nameinstalldir 
	else
		rootdir=/"$arg2" 
		nameinstalldir 
	fi
}

arg3dir() {
	arg3="${@:3:1}"
	if [[ -z "${arg3:-}" ]] ; then
		rootdir=/arch
		nameinstalldir 
	else
		rootdir=/"$arg3"
		nameinstalldir 
	fi
}

axelif() { 
	declare dm=axel
	if [[ ! -x "$(command -v axel)" ]] || [[ ! -x "$PREFIX"/bin/axel ]] ; then
		aptin+="axel "
		pins+="axel "
	fi
}

axelifdm() {
	if [[ "$dm" = axel ]] ; then
		axelif return 
	fi
}

bsdtarif() {
	if [[ ! -x "$(command -v bsdtar)" ]] || [[ ! -x "$PREFIX"/bin/bsdtar ]] ; then
		aptin+="bsdtar "
		pins+="bsdtar "
	fi
}

chk() {
	if "$PREFIX"/bin/applets/sha512sum -c termuxarchchecksum.sha512 1>/dev/null  ; then
		chkself "$@"
		printf "\\e[0;34m 🕛 > 🕜 \\e[1;34mTermuxArch $versionid integrity: \\e[1;32mOK\\e[0m\\n"
		loadconf
		. archlinuxconfig.sh
		. espritfunctions.sh
		. getimagefunctions.sh
		. maintenanceroutines.sh
		. necessaryfunctions.sh
		. printoutstatements.sh
		if [[ "$opt" = bloom ]] ; then
			rm -f termuxarchchecksum.sha512 
		fi
		if [[ "$opt" = manual ]] ; then
			manual
		fi
	else
		printsha512syschker
	fi
}

chkdwn() {
	if "$PREFIX"/bin/applets/sha512sum -c setupTermuxArch.sha512 1>/dev/null  ; then
		printf "\\e[0;34m 🕛 > 🕐 \\e[1;34mTermuxArch download: \\e[1;32mOK\\n\\n"
		if [[ "$tm" = tar ]] ; then
	 		proot --link2symlink -0 "$PREFIX"/bin/tar xf setupTermuxArch.tar.gz 
		else
	 		proot --link2symlink -0 "$PREFIX"/bin/applets/tar xf setupTermuxArch.tar.gz 
		fi
	else
		printsha512syschker
	fi
}

chkself() {
	if [[ -f "setupTermuxArch.tmp" ]] ; then
		if [[ "$(<setupTermuxArch.sh)" != "$(<setupTermuxArch.tmp)" ]] ; then
			cp setupTermuxArch.sh "${wdir}setupTermuxArchConfigs.sh"
			printf "\\e[0;32m%s\\e[1;34m: \\e[1;32mUPDATED\\n\\e[1;32mRESTART %s %s \\n\\e[0m"  "${0##*/}" "${0##*/}" "$@"
			.  "${wdir}setupTermuxArchConfigs.sh" "$@"
		fi
	fi
}

curlif() {
	declare dm=curl
	if [[ ! -x "$(command -v curl)" ]] || [[ ! -x "$PREFIX"/bin/curl ]] ; then
		aptin+="curl "
		pins+="curl "
	fi
}

curlifdm() {
	if [[ "$dm" = curl ]] ; then
		curlif return 
	fi
}

dependbp() {
	if [[ "$cpuabi" = "$cpuabix86" ]] || [[ "$cpuabi" = "$cpuabix86_64" ]] ; then
		bsdtarif return 
		prootif return 
	else
		prootif return 
	fi
}

depends() { # checks for missing commands.  
	prepcurl return # installs curl from system if available.  
	printf "\\e[1;34mChecking prerequisites…\\n\\e[1;32m"
	aria2cifdm return 
	axelifdm return 
	lftpifdm return 
	curlifdm return 
	wgetifdm return 
	if [[ "$dm" = "" ]] ; then
		if [[ -x "$PREFIX"/bin/aria2c ]] || [[ -x "$(command -v aria2c)" ]] ; then
			aria2cif return 
	 	elif [[ -x "$PREFIX"/bin/axel ]] || [[ -x "$(command -v axel)" ]] ; then
			axelif return 
	 	elif [[ -x "$PREFIX"/bin/lftpget ]] || [[ -x "$(command -v lftpget)" ]] ; then
			lftpif return 
		elif [[ -x "$PREFIX"/bin/curl ]] || [[ -x "$(command -v curl)" ]] ; then
			curlif return 
		elif [[ -x "$PREFIX"/bin/wget ]] || [[ -x "$(command -v wget)" ]] ; then
			wgetif return 
		fi
	fi
	dependbp return 
	apin "$aptin"
# 	pe "$pins"
	echo
	echo "Using $dm to manage downloads." 
	printf "\\n\\e[0;34m 🕛 > 🕧 \\e[1;34mPrerequisites: \\e[1;32mOK  \\e[1;34mDownloading TermuxArch…\\n\\n\\e[0;32m"
}

dependsblock() {
	depends 
	if [[ -f archlinuxconfig.sh ]] && [[ -f espritfunctions.sh ]] && [[ -f getimagefunctions.sh ]] && [[ -f knownconfigurations.sh ]] && [[ -f maintenanceroutines.sh ]] && [[ -f necessaryfunctions.sh ]] && [[ -f printoutstatements.sh ]] && [[ -f setupTermuxArch.sh ]] ; then
		. archlinuxconfig.sh
		. espritfunctions.sh
		. getimagefunctions.sh
		. knownconfigurations.sh
		. maintenanceroutines.sh
		. necessaryfunctions.sh
		. printoutstatements.sh
		if [[ "$opt" = manual ]] ; then
			manual
		fi 
	else
		cd "$tdir" 
		dwnl
		if [[ -f "${wdir}setupTermuxArch.sh" ]] ; then
			cp "${wdir}setupTermuxArch.sh" setupTermuxArch.tmp
		fi
		chkdwn
		chk "$@"
	fi
}

dwnl() {
	if [[ "$dm" = aria2c ]] ; then
		aria2c https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.sha512 
		aria2c https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.tar.gz 
	elif [[ "$dm" = axel ]] ; then
		axel https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.sha512 
		axel https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.tar.gz 
		echo
		echo warning: axel is not full implemented
		echo continuing
 		curlif 
		apin "$aptin"
	elif [[ "$dm" = lftp ]] ; then
		lftpget -v https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.sha512 
		lftpget -v https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.tar.gz 
	elif [[ "$dm" = wget ]] ; then
		wget "$dmverbose" -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.sha512 
		wget "$dmverbose" -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.tar.gz 
		printf "\\n\\e[1;33m"
	else
		curl "$dmverbose" -OL https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.sha512 -OL https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.tar.gz
		printf "\\n\\e[1;33m"
	fi
}

finishe() { # on exit
	rm -rf "$tdir"
	printf "\\e[?25h\\e[0m"
	set +Eeuo pipefail 
  	printtail "$args"  
}

finisher() { # on script signal
	printf "\\e[?25h\\e[1;7;38;5;0mTermuxArch warning:  Script signal $? generated!\\e[0m\\n"
 	exit 
}

finishs() { # on signal
	printf "\\e[?25h\\e[1;7;38;5;0mTermuxArch warning:  Signal $? received!\\e[0m\\n"
 	exit 
}

finishq() { # on quit
	printf "\\e[?25h\\e[1;7;38;5;0mTermuxArch warning:  Quit signal $? received!\\e[0m\\n"
 	exit 
}

intro() {
	printf '\033]2;  bash setupTermuxArch.sh 📲 \007'
	preptmpdir
	rmarchq
	rootdirexception 
	spaceinfo
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mTermuxArch $versionid will attempt to install Linux in \\e[0;32m$installdir\\e[1;34m.  Arch Linux in Termux PRoot will be available upon successful completion.  To run this BASH script again, use \`!!\`.  Ensure background data is not restricted.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock "$@" return
	mainblock
}

introbloom() { # Bloom = `setupTermuxArch.sh manual verbose` 
	opt=bloom 
	printf '\033]2;  bash setupTermuxArch.sh bloom 📲 \007'
	preptmpdir
	spaceinfo
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mTermuxArch $versionid bloom option.  Run \\e[1;32mbash setupTermuxArch.sh help \\e[1;34mfor additional information.  Ensure background data is not restricted.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock "$@" return
	bloom 
}

introdebug() {
	printf '\033]2;  bash setupTermuxArch.sh sysinfo 📲 \007'
	preptmpdir
	spaceinfo
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34msetupTermuxArch $versionid will create a system information file.  Ensure background data is not restricted.  Run \\e[0;32mbash setupTermuxArch.sh help \\e[1;34mfor additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock "$@" return
	sysinfo 
}

introrefresh() {
	printf '\033]2;  bash setupTermuxArch.sh refresh 📲 \007'
	preptmpdir
	rootdirexception 
	spaceinfo
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34msetupTermuxArch $versionid will refresh your TermuxArch files in \\e[0;32m$installdir\\e[1;34m.  Ensure background data is not restricted.  Run \\e[0;32mbash setupTermuxArch.sh help \\e[1;34mfor additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock "$@" return
	refreshsys "$@"
}

lftpif() {
	declare dm=lftp
	if [[ ! -x "$(command -v lftp)" ]] || [[ ! -x "$PREFIX"/bin/lftp ]] ; then
		aptin+="lftp "
		pins+="lftpget "
	fi
}

lftpifdm() {
	if [[ "$dm" = lftp ]] ; then
		lftpif return 
	fi
}

loadconf() {
	if [[ -f "${wdir}setupTermuxArchConfigs.sh" ]] ; then
		. "${wdir}setupTermuxArchConfigs.sh"
		printconfloaded 
	else
		. knownconfigurations.sh 
	fi
}

manual() {
	printf '\033]2; `bash setupTermuxArch.sh manual` 📲 \007'
	editors
	if [[ -f "${wdir}setupTermuxArchConfigs.sh" ]] ; then
		"$ed" "${wdir}setupTermuxArchConfigs.sh"
		. "${wdir}setupTermuxArchConfigs.sh"
		printconfloaded 
	else
		cp knownconfigurations.sh "${wdir}setupTermuxArchConfigs.sh"
		sed -i '20i# The architecture of this device is '"$(uname -m)"'; Adjust the appropriate section.' "${wdir}setupTermuxArchConfigs.sh" 
		"$ed" "${wdir}setupTermuxArchConfigs.sh"
		. "${wdir}setupTermuxArchConfigs.sh"
		printconfloaded 
	fi
}

nameinstalldir() {
	if [[ "$rootdir" = "" ]]  ; then
		rootdir=arch
	fi
	installdir="$(echo "$HOME/${rootdir%/}" |sed 's#//*#/#g')"
}

namestartarch() { # ${@%/} removes trailing slash
 	darch="$(echo "${rootdir%/}" |sed 's#//*#/#g')"
	if [[ "$darch" = "/arch" ]] ; then
		aarch=""
		startbi2=arch
	else
 		aarch="$(echo "$darch" |sed 's/\//\+/g')"
		startbi2=arch
	fi
	declare -g startbin=start"$startbi2$aarch"
}

opt1() { 
	if [[ "$2" = [Ii]* ]]  ; then
		arg3dir "$@" 
	else
		arg2dir "$@" 
	fi
}

opt2() { 
	if [[ "$2" = [Dd]* ]] || [[ "$2" = [Ss]* ]]  ; then
		introdebug "$@"  
	elif [[ "$2" = [Ii]* ]]  ; then
		arg3dir "$@" 
	else
		arg2dir "$@" 
	fi
}

pe() {
	echo "$pins" 
	printf "\\n\\e[1;31mPrerequisites exception.  Run the script again…\\n\\n\\e[0m"'\033]2; Run `bash setupTermuxArch.sh` again…\007'
	exit
}

pec() {
	if [[ "$pins" != "" ]] ; then
		pe @pins
	fi
}

pecc() {
	if [[ "$pins" != "" ]] ; then
		pe @pins
	fi
}

prepcurl() { # installs curl from system if available.  
	if [[ -x /system/bin/curl ]] && [[ ! -x "$PREFIX"/bin/curl ]] ; then
		addcurl
	fi
}

preptmpdir() { 
  	t="$(</proc/sys/kernel/random/uuid)"
 	td="${t//-}"
 	tdi="${td:0:16}"
 	tdir="$TMPDIR/${0##*/}$tdi"
	mkdir -p "$tdir" 
}

printconfloaded() {
	printf "\\n\\e[0;34m 🕛 > 🕑 \\e[1;34mTermuxArch configuration \\e[0;32m$PWD/\\e[1;32msetupTermuxArchConfigs.sh \\e[1;34mloaded: \\e[1;32mOK\\n"
}

printsha512syschker() {
	printf "\\n\\e[07;1m\\e[31;1m\\n 🔆 WARNING sha512sum mismatch!  Setup initialization mismatch!\\e[34;1m\\e[30;1m  Try again, initialization was not successful this time.  Wait a little while.  Then run \`bash setupTermuxArch.sh\` again…\\n\\e[0;0m\\n"'\033]2; Run `bash setupTermuxArch.sh` again…\007'
	exit 
}

printtail() {   
 	printf "\\a\\a\\a\\a"
	sleep 0.4
 	printf "\\a\\n\\e[0;32m%s %s \\a\\e[0m$versionid\\e[1;34m: \\a\\e[1;32m%s\\e[0m\\n\\n\\a\\e[0m" "${0##*/}" "$args" "DONE 🏁 "
	printf '\033]2; '"${0##*/} $args"': DONE 🏁 \007'
}

printusage() {
	printf "\\n\\n\\e[1;34mUsage information for \\e[0;32msetupTermuxArch.sh \\e[1;34m$versionid.  Arguments can abbreviated to one letter; Two letter arguments are acceptable.  For example, \\e[0;32mbash setupTermuxArch.sh cs\\e[1;34m will use \\e[0;32mcurl\\e[1;34m to download TermuxArch and produce a \\e[0;32msetupTermuxArchDebug$stime.log\\e[1;34m file.\\n\\nUser configurable variables are in \\e[0;32msetupTermuxArchConfigs.sh\\e[1;34m.  Create this file from \\e[0;32mkownconfigurations.sh\\e[1;34m in the working directory.  Use \\e[0;32mbash setupTermuxArch.sh manual\\e[1;34m to create and edit \\e[0;32msetupTermuxArchConfigs.sh\\e[1;34m.\\n\\n\\e[1;33mDEBUG\\e[1;34m    Use \\e[0;32msetupTermuxArch.sh sysinfo \\e[1;34mto create a \\e[0;32msetupTermuxArchDebug$stime.log\\e[1;34m and populate it with system information.  Post this along with detailed information about the issue at https://github.com/sdrausty/TermuxArch/issues.  If screenshots will help in resolving the issue better, include them in a post along with information from the debug log file.\\n\\n\\e[1;33mHELP\\e[1;34m     Use \\e[0;32msetupTermuxArch.sh help \\e[1;34mto output this help screen.\\n\\n\\e[1;33mINSTALL\\e[1;34m  Run \\e[0;32m./setupTermuxArch.sh\\e[1;34m without arguments in a bash shell to install Arch Linux in Termux.  Use \\e[0;32mbash setupTermuxArch.sh curl \\e[1;34mto envoke \\e[0;32mcurl\\e[1;34m as the download manager.  Copy \\e[0;32mknownconfigurations.sh\\e[1;34m to \\e[0;32msetupTermuxArchConfigs.sh\\e[1;34m with preferred mirror.  After editing \\e[0;32msetupTermuxArchConfigs.sh\\e[1;34m, run \\e[0;32mbash setupTermuxArch.sh\\e[1;34m and \\e[0;32msetupTermuxArchConfigs.sh\\e[1;34m loads automatically from the same directory.  Change mirror to desired geographic location to resolve download errors.\\n\\n\\e[1;33mPURGE\\e[1;34m    Use \\e[0;32msetupTermuxArch.sh uninstall\\e[1;34m \\e[1;34mto uninstall Arch Linux from Termux.\\n\\n\\e[0;32m"
 	namestartarch 
	"$startbin" help 2>/dev/null
}

prootif() {
	if [[ ! -x "$(command -v proot)" ]] || [[ ! -x "$PREFIX"/bin/proot ]] ; then
		aptin+="proot "
		pins+="proot "
	fi
}

rmarch() {
	namestartarch 
	nameinstalldir
	while true; do
		printf "\\n\\e[1;30m"
		read -n 1 -p "Uninstall $installdir? [Y|n] " ruanswer
		if [[ "$ruanswer" = [Ee]* ]] || [[ "$ruanswer" = [Nn]* ]] || [[ "$ruanswer" = [Qq]* ]] ; then
			break
		elif [[ "$ruanswer" = [Yy]* ]] || [[ "$ruanswer" = "" ]] ; then
			printf "\\e[30mUninstalling $installdir…\\n"
			if [[ -e "$PREFIX/bin/$startbin" ]] ; then
				rm -f "$PREFIX/bin/$startbin" 
			else 
				printf "Uninstalling $PREFIX/bin/$startbin: nothing to do for $PREFIX/bin/$startbin.\\n"
			fi
			if [[ -e "$HOME/bin/$startbin" ]] ; then
				rm -f "$HOME/bin/$startbin" 
			else 
				printf "Uninstalling $HOME/bin/$startbin: nothing to do for $HOME/bin/$startbin.\\n"
			fi
			if [[ -d "$installdir" ]] ; then
				rmarchrm 
			else 
				printf "Uninstalling $installdir: nothing to do for $installdir.\\n"
			fi
			printf "Uninstalling $installdir: \\e[1;32mDone\\n\\e[30m"
			break
		else
			printf "\\nYou answered \\e[33;1m$ruanswer\\e[30m.\\n\\nAnswer \\e[32mYes\\e[30m or \\e[1;31mNo\\e[30m. [\\e[32my\\e[30m|\\e[1;31mn\\e[30m]\\n"
		fi
	done
	printf "\\e[0m\\n"
}

rmarchrm() {
	rootdirexception 
	rm -rf "$installdir"/* 2>/dev/null ||:
	find  "$installdir" -type d -exec chmod 700 {} \; 2>/dev/null ||:
	rm -rf "$installdir" 2>/dev/null ||:
}

rmarchq() {
	if [[ -d "$installdir" ]] ; then
		printf "\\n\\e[0;33mTermuxArch: \\e[1;33mDIRECTORY WARNING!  $installdir/ \\e[0;33mdirectory detected.  \\e[1;30mTermux Arch installation shall continue.  If in doubt, answer yes.\\n"
		rmarch
	fi
}

rootdirexception() {
	if [[ "$installdir" = "$HOME" ]] || [[ "$installdir" = "$HOME"/ ]] || [[ "$installdir" = "$HOME"/.. ]] || [[ "$installdir" = "$HOME"/../ ]] || [[ "$installdir" = "$HOME"/../.. ]] || [[ "$installdir" = "$HOME"/../../ ]] ; then
		printf "\\n\\e[1;31mRootdir exception.  Run the script again with different options…\\n\\n\\e[0m"'\033]2;Rootdir exception.  Run `bash setupTermuxArch.sh` again with different options…\007'
		exit
	fi
}

setrootdir() {
	if [[ "$cpuabi" = "$cpuabix86" ]] ; then
	#	rootdir=/root.i686
		rootdir=/arch
	elif [[ "$cpuabi" = "$cpuabix86_64" ]] ; then
	#	rootdir=/root.x86_64
		rootdir=/arch
	else
		rootdir=/arch
	fi
}

spaceinfo() {
	units="$(df "$installdir" 2>/dev/null | awk 'FNR == 1 {print $2}')" 
	if [[ "$units" = Size ]] ; then
		spaceinfogsize 
		printf "$spaceMessage"
	elif [[ "$units" = 1K-blocks ]] ; then
		spaceinfoksize 
		printf "$spaceMessage"
	fi
}

spaceinfogsize() {
	userspace return
	if [[ "$cpuabi" = "$cpuabix86" ]] || [[ "$cpuabi" = "$cpuabix86_64" ]] ; then
		if [[ "$usrspace" = *G ]] ; then 
			spaceMessage=""
		elif [[ "$usrspace" = *M ]] ; then
			usspace="${usrspace: : -1}"
			if [[ "$usspace" < "800" ]] ; then
				spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for x86 and x86_64 is 800M of free user space.\\n\\e[0m"
			fi
		fi
	elif [[ "$usrspace" = *G ]] ; then
		usspace="${usrspace: : -1}"
		if [[ "$cpuabi" = "$cpuabi8" ]] ; then
			if [[ "$usspace" < "1.5" ]] ; then
				spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\\n\\e[0m"
			else
				spaceMessage=""
			fi
		elif [[ "$cpuabi" = "$cpuabi7" ]] ; then
			if [[ "$usspace" < "1.23" ]] ; then
				spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for armv7 is 1.23G of free user space.\\n\\e[0m"
			else
				spaceMessage=""
			fi
		else
			spaceMessage=""
		fi
	else
		spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot is more than 1.5G for aarch64, more than 1.25G for armv7 and about 800M of free user space for x86 and x86_64 architectures.\\n\\e[0m"
	fi
}

spaceinfoq() {
	if [[ "$suanswer" != [Yy]* ]] ; then
		spaceinfo
		if [[ -n "$spaceMessage" ]] ; then
			while true; do
				printf "\\n\\e[1;30m"
				read -n 1 -p "Continue with setupTermuxArch.sh? [Y|n] " suanswer
				if [[ "$suanswer" = [Ee]* ]] || [[ "$suanswer" = [Nn]* ]] || [[ "$suanswer" = [Qq]* ]] ; then
					printf "\\n" 
					exit $?
				elif [[ "$suanswer" = [Yy]* ]] || [[ "$suanswer" = "" ]] ; then
					suanswer=yes
					printf "Continuing with setupTermuxArch.sh.\\n"
					break
				else
					printf "\\nYou answered \\e[33;1m$suanswer\\e[30m.\\n\\nAnswer \\e[32mYes\\e[30m or \\e[1;31mNo\\e[30m. [\\e[32my\\e[30m|\\e[1;31mn\\e[30m]\\n"
				fi
			done
		fi
	fi
}

spaceinfoksize() {
	userspace return
	if [[ "$cpuabi" = "$cpuabi8" ]] ; then
		if [[ "$usrspace" -lt "1500000" ]] ; then
			spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace $units of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\\n\\e[0m"
		else
			spaceMessage=""
		fi
	elif [[ "$cpuabi" = "$cpuabi7" ]] ; then
		if [[ "$usrspace" -lt "1250000" ]] ; then
			spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace $units of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for armv7 is 1.25G of free user space.\\n\\e[0m"
		else
			spaceMessage=""
		fi
	elif [[ "$cpuabi" = "$cpuabix86" ]] || [[ "$cpuabi" = "$cpuabix86_64" ]] ; then
		if [[ "$usrspace" -lt "800000" ]] ; then
			spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace $units of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for x86 and x86_64 is 800M of free user space.\\n\\e[0m"
		else
			spaceMessage=""
		fi
	fi
}

userspace() {
	usrspace="$(df "$installdir" 2>/dev/null | awk 'FNR == 2 {print $4}')"
	if [[ "$usrspace" = "" ]] ; then
		usrspace="$(df "$installdir" 2>/dev/null | awk 'FNR == 3 {print $3}')"
	fi
}

wgetif() {
	declare dm=wget 
	if [[ ! -x "$(command -v wget)" ]] || [[ ! -x "$PREFIX"/bin/wget ]] ; then
		aptin+="wget "
		pins+="wget "
	fi
}

wgetifdm() {
	if [[ "$dm" = wget ]] ; then
		wgetif return 
	fi
}

## User Information ############################################################
#  Configurable variables such as mirrors and download manager options are in `setupTermuxArchConfigs.sh`.  Working with `kownconfigurations.sh` in the working directory is very simple, use `setupTermuxArch.sh manual` to create and edit `setupTermuxArchConfigs.sh`; See `setupTermuxArch.sh help` for information.  
declare COUNTER=""
declare -a args="$@"
declare aptin="" # apt string
declare pins="" # Prerequisites exception string
declare bin=""
declare commandif="$(command -v getprop)" ||:
declare cpuabi="$(getprop ro.product.cpu.abi 2>/dev/null)" ||:
declare cpuabi5="armeabi"
declare cpuabi7="armeabi-v7a"
declare cpuabi8="arm64-v8a"
declare cpuabix86="x86"
declare cpuabix86_64="x86_64"
declare dfl="/gen" # used for development 
declare dm="" # download manager
declare dmverbose="-q" # -v for verbose download manager output from curl and wget;  for verbose output throughout runtime also change in `setupTermuxArchConfigs.sh` when using `setupTermuxArch.sh manual`. 
declare	ed=""
declare -g installdir=""
declare kid=""
declare	lc=""
declare -g md5sumr=""
declare opt=""
declare rootdir=""
declare wdir="$PWD/"
declare spaceMessage=""
declare stim="$(date +%s)"
declare stime="${stim:0:4}"
declare tm="" # tar manager
declare usrspace=""
declare idir="$PWD"


trap finishe EXIT
trap finisher ERR 
trap finishs INT TERM 
trap finishq QUIT 

if [[ "$commandif" = "" ]] ; then
	printf "\\nWarning: Run \`setupTermuxArch.sh\` from the OS system in Termux, i.e. Amazon Fire, Android and Chromebook.\\n"
	exit
fi

nameinstalldir 
namestartarch  
setrootdir  

## Available Arguments #########################################################
## []  Run default Arch Linux install.  `bash setupTermuxArch.sh help` has more information; All options can be abbreviated. 
if [[ -z "${1:-}" ]] ; then
	intro "$@" 
## A systemimage.tar.gz file can be used: `setupTermuxArch.sh ./[path/]systemimage.tar.gz` and `setupTermuxArch.sh /absolutepath/systemimage.tar.gz`; [./path/systemimage.tar.gz [installdir]]  Use path to system image file; install directory argument is optional. 
elif [[ "${args:0:1}" = "." ]]  ; then
	lc="1"
	arg2dir "$@"  
	intro "$@"    
	loadimage "$@"
## [/absolutepath/systemimage.tar.gz [installdir]]  Use absolute path to system image file; install directory argument is optional. 
elif [[ "${args:0:1}" = "/" ]] ; then
	arg2dir "$@"  
	intro "$@"   
	loadimage "$@"
## [axd|axs]  Get device system information with `axel`.
elif [[ "${1//-}" = [Aa][Xx][Dd]* ]] || [[ "${1//-}" = [Aa][Xx][Ss]* ]] ; then
	declare dm=axel
	introdebug "$@" 
## [axel installdir|axi installdir]  Install Arch Linux with `axel`.
elif [[ "${1//-}" = [Aa][Xx]* ]] || [[ "${1//-}" = [Aa][Xx][Ii]* ]] ; then
	declare dm=axel
	opt2 "$@" 
	intro "$@" 
## [ad|as]  Get device system information with `aria2c`.
elif [[ "${1//-}" = [Aa][Dd]* ]] || [[ "${1//-}" = [Aa][Ss]* ]] ; then
	declare dm=aria2c
	introdebug "$@" 
## [aria2c installdir|ai installdir]  Install Arch Linux with `aria2c`.
elif [[ "${1//-}" = [Aa]* ]] ; then
	declare dm=aria2c
	opt2 "$@" 
	intro "$@" 
## [bloom]  Create and run a local copy of TermuxArch in TermuxArchBloom.  Useful for running a customized setupTermuxArch.sh locally, for developing and hacking TermuxArch.  
elif [[ "${1//-}" = [Bb]* ]] ; then
	introbloom "$@"  
## [cd|cs]  Get device system information with `curl`.
elif [[ "${1//-}" = [Cc][Dd]* ]] || [[ "${1//-}" = [Cc][Ss]* ]] ; then
	declare dm=curl
	introdebug "$@" 
## [curl installdir|ci installdir]  Install Arch Linux with `curl`.
elif [[ "${1//-}" = [Cc]* ]] ; then
	declare dm=curl
	opt2 "$@" 
	intro "$@" 
## [debug|sysinfo]  Generate system information.
elif [[ "${1//-}" = [Dd]* ]] || [[ "${1//-}" = [Ss]* ]] ; then
	introdebug "$@" 
## [help|?]  Display builtin help.
elif [[ "${1//-}" = [Hh]* ]] || [[ "${1//-}" = [?]* ]] ; then
	printusage
## [install installdir|rootdir installdir]  Install Arch Linux in a custom directory.  Instructions: Install in userspace. $HOME is appended to installation directory. To install Arch Linux in $HOME/installdir use `bash setupTermuxArch.sh install installdir`. In bash shell use `./setupTermuxArch.sh install installdir`.  All options can be abbreviated to one or two letters.  Hence `./setupTermuxArch.sh install installdir` can be run as `./setupTermuxArch.sh i installdir` in BASH.
elif [[ "${1//-}" = [Ii]* ]] ||  [[ "${1//-}" = [Rr][Oo]* ]] ; then
	arg2dir "$@"  
	intro "$@"  
## [ld|ls]  Get device system information with `lftp`.
elif [[ "${1//-}" = [Ll][Dd]* ]] || [[ "${1//-}" = [Ll][Ss]* ]] ; then
	echo Getting device system information with \`lftp\`.
	declare dm=lftp
	introdebug "$@" 
## [lftp installdir|li installdir]  Install Arch Linux with `lftp`.
elif [[ "${1//-}" = [Ll]* ]] ; then
	echo Installing with \`lftp\`.
	declare dm=lftp
	opt2 "$@" 
	intro "$@" 
## [manual]  Manual Arch Linux install, useful for resolving download issues.
elif [[ "${1//-}" = [Mm]* ]] ; then
	opt=manual
	opt1 "$@" 
	intro "$@"  
## [purge |uninstall]  Remove Arch Linux.
elif [[ "${1//-}" = [Pp]* ]] || [[ "${1//-}" = [Uu]* ]] ; then
	arg2dir "$@" 
	rmarch
## [refresh|refresh installdir]  Refresh the Arch Linux in Termux PRoot scripts created by TermuxArch and the installation itself.  Useful for refreshing the installation and the TermuxArch generated scripts to their newest versions.  
elif [[ "${1//-}" = [Rr][Ee]* ]] ; then
	arg2dir "$@"  
	introrefresh "$@"  
## [wd|ws]  Get device system information with `wget`.
elif [[ "${1//-}" = [Ww][Dd]* ]] || [[ "${1//-}" = [Ww][Ss]* ]] ; then
	declare dm=wget
	introdebug "$@" 
## [wget installdir|wi installdir]  Install Arch Linux with `wget`.
elif [[ "${1//-}" = [Ww]* ]] ; then
	declare dm=wget
	opt2 "$@" 
	intro "$@"  
else
	printusage
fi

# EOF
