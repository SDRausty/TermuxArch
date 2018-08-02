#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about TermuxArch. 
################################################################################
set -euox pipefail 
unset LD_PRELOAD

arg2dir () {
	arg2="$(echo "$args" | awk '{print $2}')"
	if [[ "$arg2" = "" ]] ;then
		rootdir=/arch
		nameinstalldir 
	else
		rootdir=/"$arg2" 
		nameinstalldir 
	fi
}

arg3dir () {
	arg3="$(echo "$args" | awk '{print $3}')"
	if [[ "$arg3" = "" ]] ;then
		rootdir=/arch
		nameinstalldir 
	else
		rootdir=/"$arg3"
		nameinstalldir 
	fi
}

bloom () {
	opt=bloom 
	intrbloom 
	if [[ -d "$HOME"/TermuxArchBloom ]];then 
		rmbloomq 
	fi
	if [[ ! -d "$HOME"/TermuxArchBloom ]];then 
		mkdir "$HOME"/TermuxArchBloom
	fi
	cd "$HOME"/TermuxArchBloom
	printf "\\e[1;34mTermuxArch Bloom option via \\e[1;32msetupTermuxArch.sh bloom\\e[0m 📲\\n\\n\\e[0m"'\033]2;  Thank you for using TermuxArch Bloom option via `setupTermuxArch.sh bloom` 📲 \007'
	ls -agl
	printf "\\n"
	pwd
	printf "\\n"
	dependsblock 
	ls -agl
	printf "\\n\\e[1;34mUse \\e[1;32mcd ~/TermuxArchBloom\\e[1;34m to continue.  Edit any of these files.  Then use \\e[1;32mbash $0 run \\e[1;34mto run the files in \\e[1;32m~/TermuxArchBloom\\e[1;34m to continue.\\n\\n\\e[0m"'\033]2;  Thank you for using TermuxArch Bloom option via `setupTermuxArch.sh bloom` 📲 \007'
}

bloomdependsblock () {
	intrbloom 
	cd "$HOME"/TermuxArchBloom
	printf "\\e[1;34mTermuxArch Bloom option via \\e[1;32mbash setupTermuxArch.sh run\\e[0m 📲\\n\\n\\e[0m"'\033]2;  Thank you for using TermuxArch Bloom option via `bash setupTermuxArch.sh run` 📲 \007'
	ls -al
	printf "\\n"
	pwd
	. animationfunctions.sh
	. archsystemconfigs.sh
	. getimagefunctions.sh
	. knownconfigurations.sh
	. necessaryfunctions.sh
	. printoutstatements.sh
	. systemmaintenance.sh
	printf "\\n\\e[0;34m 🕛 > 🕑 \\e[1;34mTermuxArch $versionid integrity: \\e[1;32mOK\\n"
	mainblock
}

bsdtarif () {
	if [[ ! -x "$PREFIX"/bin/bsdtar ]];then
		printf "\\n\\e[1;34mInstalling \\e[0;32mbsdtar\\e[1;34m…\\n\\n\\e[1;32m"
		pkg install bsdtar --yes
		printf "\\n\\e[1;34mInstalling \\e[0;32mbsdtar\\e[1;34m: \\e[1;32mDONE\\n\\e[0m"
	fi
	if [[ ! -x "$PREFIX"/bin/bsdtar ]];then
		pe
	fi
}

chk () {
	if "$PREFIX"/bin/applets/sha512sum -c termuxarchchecksum.sha512 1>/dev/null ;then
		chkself 
		printf "\\e[0;34m 🕛 > 🕜 \\e[1;34mTermuxArch $versionid integrity: \\e[1;32mOK\\n"
		if [[ "$opt" = manual ]];then
			manual
		else 
			ldconf
		fi
		. animationfunctions.sh
		. archsystemconfigs.sh
		. getimagefunctions.sh
		. necessaryfunctions.sh
		. printoutstatements.sh
		. systemmaintenance.sh
		if [[ "$opt" = bloom ]];then
			rm termuxarchchecksum.sha512 
		else 
			rmdsc 
		fi
	else
		rmdsc 
		printsha512syschker
	fi
}

chkdwn () {
	if "$PREFIX"/bin/applets/sha512sum -c setupTermuxArch.sha512 1>/dev/null ;then
		printf "\\e[0;34m 🕛 > 🕐 \\e[1;34mTermuxArch download: \\e[1;32mOK\\n\\n"
		#exec proot --link2symlink -0 $PREFIX/bin/applets/tar xf setupTermuxArch.tar.gz ||:
		"$PREFIX"/bin/applets/tar xf setupTermuxArch.tar.gz 
		rmds 
	else
		rm setupTermuxArch.tmp
		rmds 
		printsha512syschker
	fi
}

chkself () {
	if [[ -f "setupTermuxArch.tmp" ]];then
		if [[ "$(<setupTermuxArch.sh)" != "$(<setupTermuxArch.tmp)" ]];then
			printf "\\e[0;32msetupTermuxArch.sh: \\e[1;32mUPDATED\\n\\e[0;32mTermuxArch: \\e[1;32mRESTARTED\\n\\e[0m"
			rm setupTermuxArch.tmp
			rmdsc 
			. setupTermuxArch.sh "$args"
		fi
		rm setupTermuxArch.tmp
	fi
}

curlif () {
	if [[ ! -x "$PREFIX"/bin/curl ]];then
		printf "\\n\\e[1;34mInstalling \\e[0;32mcurl\\e[1;34m…\\n\\n\\e[1;32m"
		pkg install curl --yes 
		printf "\\n\\e[1;34mInstalling \\e[0;32mcurl\\e[1;34m: \\e[1;32mDONE\\n\\e[0m"
	fi
	if [[ ! -x "$PREFIX"/bin/curl ]];then
		pe
	fi
}

curlifdm () {
	if [[ "$dm" = curl ]];then
		curlif 
	fi
}

depends () {
	printf "\\e[1;34mChecking prerequisites…\\n\\e[1;32m"
	curlifdm 
	wgetifdm 
	if [[ -x "$PREFIX"/bin/curl ]];then
		dm=curl 
	fi
	if [[ -x "$PREFIX"/bin/wget ]];then
		dm=wget 
	fi
	if [[ "$dm" = "" ]];then
		dm=wget 
		wgetif 
	fi
	dependbp 
	printf "\\n\\e[0;34m 🕛 > 🕧 \\e[1;34mPrerequisites: \\e[1;32mOK  \\e[1;34mDownloading TermuxArch…\\n\\n\\e[0;32m"
}

dependsblock () {
	depends 
	if [[ -f animationfunctions.sh ]] && [[ -f archsystemconfigs.sh ]] && [[ -f getimagefunctions.sh ]] && [[ -f knownconfigurations.sh ]] && [[ -f necessaryfunctions.sh ]] && [[ -f printoutstatements.sh ]] && [[ -f systemmaintenance.sh ]];then
		. animationfunctions.sh
		. archsystemconfigs.sh
		. getimagefunctions.sh
		. knownconfigurations.sh
		. necessaryfunctions.sh
		. printoutstatements.sh
		. systemmaintenance.sh
	else
		dwnl
		if [[ -f "setupTermuxArch.sh" ]];then
			cp setupTermuxArch.sh setupTermuxArch.tmp
		fi
		chkdwn
		chk
	fi
}

dependbp () {
	if [[ "$cpuabi" = "$cpuabix86" ]] || [[ "$cpuabi" = "$cpuabix8664" ]];then
		bsdtarif 
		prootif 
	else
		prootif 
	fi
}

dwnl () {
	if [[ "$dm" = wget ]];then
		wget "$dmverbose" -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.sha512 
		wget "$dmverbose" -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.tar.gz
		printf "\\n\\e[1;33m"
	else
		curl "$dmverbose" -O https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.sha512 -O https://raw.githubusercontent.com/sdrausty/TermuxArch/master"$dfl"/setupTermuxArch.tar.gz
		printf "\\n\\e[1;33m"
	fi
}

editors () {
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

edq () {
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

edqa () {
	ed="${ceds[$i]}"
	ind=1
}

edqaquestion () {
	while true; do
		printf "\\n"
		if [[ "$opt" = bloom ]] || [[ "$opt" = manual ]];then
			printf "The following editor(s) $cedst\b\b are present.  Would you like to use \`\\e[1;32m${ceds[$i]}\\e[0;32m\` to edit \`\\e[1;32msetupTermuxArchConfigs.sh\\e[0;32m\`?  "
			read -p "Answer yes or no [Y|n]. "  yn
		else 
			printf "Change the worldwide mirror to a mirror that is geographically nearby.  Choose only ONE active mirror in the mirrors file that you are about to edit.  The following editor(s) $cedst\b\b are present.  Would you like to use \`\\e[1;32m${ceds[$i]}\\e[0;32m\` to edit the Arch Linux configuration files?  "
			read -p "Answer yes or no [Y|n]. "  yn
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

edq2 () {
	while true; do
		if [[ "$opt" = bloom ]] || [[ "$opt" = manual ]];then
			printf "\\n\\e[1;34m  Would you like to use \\e[1;32mnano\\e[1;34m or \\e[1;32mvi\\e[1;34m to edit \\e[1;32msetupTermuxArchConfigs.sh\\e[1;34m?  "
			read -p "Answer nano or vi [n|V]? "  nv
		else 
			printf "\\e[1;34m  Change the worldwide mirror to a mirror that is geographically nearby.  Choose only ONE active mirror in the mirrors file that you are about to edit.  Would you like to use \\e[1;32mnano\\e[1;34m or \\e[1;32mvi\\e[1;34m to edit the Arch Linux configuration files?  "
			read -p "Answer nano or vi [n|V]? "  nv
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

finish () {
	printf "\e[?25h\e[0mint caught\\n"
	printtail 
}

intro () {
	printf '\033]2;  bash setupTermuxArch.sh 📲 \007'
	rmarchq
	rootdirexception 
	spaceinfo
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mTermuxArch $versionid will attempt to install Linux in \\e[0;32m$installdir\\e[1;34m.  Arch Linux in Termux PRoot will be available upon successful completion.  To run this BASH script again, use \`!!\`.  Ensure background data is not restricted.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock 
}

intrbloom () {
	printf '\033]2;  bash setupTermuxArch.sh bloom 📲 \007'
	spaceinfo
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mTermuxArch $versionid bloom option.  Run \\e[1;32mbash setupTermuxArch.sh help \\e[1;34mfor additional information.  Ensure background data is not restricted.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
}

introdebug () {
	printf '\033]2;  bash setupTermuxArch.sh sysinfo 📲 \007'
	spaceinfo
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34msetupTermuxArch $versionid will create a system information file.  Ensure background data is not restricted.  Run \\e[0;32mbash setupTermuxArch.sh help \\e[1;34mfor additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock 
}

introrefresh () {
	printf '\033]2;  bash setupTermuxArch.sh refresh 📲 \007'
	spaceinfo
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34msetupTermuxArch $versionid will refresh your TermuxArch files in \\e[0;32m$installdir\\e[1;34m.  Ensure background data is not restricted.  Run \\e[0;32mbash setupTermuxArch.sh help \\e[1;34mfor additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock 
	refreshsys
}

ldconf () {
	if [[ -f "setupTermuxArchConfigs.sh" ]];then
		. setupTermuxArchConfigs.sh
		printconfloaded 
	else
		. knownconfigurations.sh
	fi
}

manual () {
	printf '\033]2;  Thank you for using `bash setupTermuxArch.sh manual` 📲 \007'
	editors
	if [[ -f "setupTermuxArchConfigs.sh" ]];then
		"$ed" setupTermuxArchConfigs.sh
		. setupTermuxArchConfigs.sh
		printconfloaded 
	else
		cp knownconfigurations.sh setupTermuxArchConfigs.sh
		"$ed" setupTermuxArchConfigs.sh
		. setupTermuxArchConfigs.sh
		printconfloaded 
	fi
}

nanoif () {
	if [[ ! -x "$PREFIX"/bin/nano ]];then
		printf "\\n\\e[1;34mInstalling \\e[0;32mnano\\e[1;34m…\\n\\n\\e[1;32m"
		pkg install nano --yes 
		printf "\\n\\e[1;34mInstalling \\e[0;32mnano\\e[1;34m: \\e[1;32mDONE\\n\\e[0m"
	fi
	if [[ ! -x "$PREFIX"/bin/nano ]];then
		pe
	fi
}

nameinstalldir () {
	if [[ "$rootdir" = "" ]] ;then
		rootdir=arch
	fi
	declare -g installdir="$(echo "$HOME/${rootdir%/}" |sed 's#//*#/#g')"
}

namestartarch () {
	# echo ${@%/} removes trailing slash
	darch="$(echo "${rootdir%/}" |sed 's#//*#/#g')"
	if [[ "$darch" = "/arch" ]];then
		aarch=""
		startbi2=arch
	else
		aarch="$(echo "$darch" |sed 's/\//\+/g')"
		startbi2=arch
	fi
	declare -g startbin=start"$startbi2$aarch"
}

opt2 () {
	if [[ "$2" = [Dd]* ]] || [[ "$2" = [Ss]* ]] ;then
		introdebug 
		sysinfo 
		printtail
	elif [[ "$2" = [Ii]* ]] ;then
		arg3dir 
	else
		arg2dir 
	fi
}

pe () {
	printf "\\n\\e[1;31mPrerequisites exception.  Run the script again…\\n\\n\\e[0m"'\033]2;  Thank you for using setupTermuxArch.sh.  Run `bash setupTermuxArch.sh` again…\007'
	exit
}

printconfloaded () {
	printf "\\n\\e[0;34m 🕛 > 🕑 \\e[1;34mTermuxArch configuration \\e[0;32m$PWD/\\e[1;32msetupTermuxArchConfigs.sh \\e[1;34mloaded: \\e[1;32mOK\\n"
}

printsha512syschker () {
	printf "\\n\\e[07;1m\\e[31;1m\\n 🔆 WARNING sha512sum mismatch!  Setup initialization mismatch!\\e[34;1m\\e[30;1m  Try again, initialization was not successful this time.  Wait a little while.  Then run \`bash setupTermuxArch.sh\` again…\\n\\e[0;0m\\n"'\033]2;  Thank you for using setupTermuxArch.sh.  Run `bash setupTermuxArch.sh` again…\007'
	exit 
}

printtail () {
	namestartarch
        "$startbin" help 2>/dev/null
	printf "\\a\\n\\e[0mThank you for using \\e[0;32msetupTermuxArch.sh \\e[0m$versionid 🏁  \\n\\n\\a\\e[0m"'\033]2;  Thank you for using setupTermuxArch.sh  🏁 \007'
	exit
}

printusage () {
	printf "\\n\\n\\e[1;34mUsage information for \\e[0;32msetupTermuxArch.sh \\e[1;34m$versionid.  Arguments can abbreviated to one letter; Two letter arguments are acceptable.  For example, \\e[0;32mbash setupTermuxArch.sh cs\\e[1;34m will use \\e[0;32mcurl\\e[1;34m to download TermuxArch and produce a \\e[0;32msetupTermuxArchDebug$stime.log\\e[1;34m file.\\n\\nUser configurable variables are in \\e[0;32msetupTermuxArchConfigs.sh\\e[1;34m.  Create this file from \\e[0;32mkownconfigurations.sh\\e[1;34m in the working directory.  Use \\e[0;32mbash setupTermuxArch.sh manual\\e[1;34m to create and edit \\e[0;32msetupTermuxArchConfigs.sh\\e[1;34m.\\n\\n\\e[1;33mDEBUG\\e[1;34m    Use \\e[0;32msetupTermuxArch.sh sysinfo \\e[1;34mto create a \\e[0;32msetupTermuxArchDebug$stime.log\\e[1;34m and populate it with system information.  Post this along with detailed information about the issue at https://github.com/sdrausty/TermuxArch/issues.  If screenshots will help in resolving the issue better, include them in a post along with information from the debug log file.\\n\\n\\e[1;33mHELP\\e[1;34m     Use \\e[0;32msetupTermuxArch.sh help \\e[1;34mto output this help screen.\\n\\n\\e[1;33mINSTALL\\e[1;34m  Run \\e[0;32m./setupTermuxArch.sh\\e[1;34m without arguments in a bash shell to install Arch Linux in Termux.  Use \\e[0;32mbash setupTermuxArch.sh curl \\e[1;34mto envoke \\e[0;32mcurl\\e[1;34m as the download manager.  Copy \\e[0;32mknownconfigurations.sh\\e[1;34m to \\e[0;32msetupTermuxArchConfigs.sh\\e[1;34m with preferred mirror.  After editing \\e[0;32msetupTermuxArchConfigs.sh\\e[1;34m, run \\e[0;32mbash setupTermuxArch.sh\\e[1;34m and \\e[0;32msetupTermuxArchConfigs.sh\\e[1;34m loads automatically from the same directory.  Change mirror to desired geographic location to resolve download errors.\\n\\n\\e[1;33mPURGE\\e[1;34m    Use \\e[0;32msetupTermuxArch.sh uninstall\\e[1;34m \\e[1;34mto uninstall Arch Linux from Termux.\\n\\n\\e[0;32miPRoot Start Script "
}

prootif () {
	if [[ ! -x "$PREFIX"/bin/proot ]];then
		printf "\\n\\e[1;34mInstalling \\e[0;32mproot\\e[1;34m…\\n\\n\\e[1;32m"
		pkg install proot --yes 
		printf "\\n\\e[1;34mInstalling \\e[0;32mproot\\e[1;34m: \\e[1;32mDONE\\n\\e[0m"
	fi
	if [[ ! -x "$PREFIX"/bin/proot ]];then
		pe
	fi
}

rmarch () {
	namestartarch 
	nameinstalldir
	while true; do
		printf "\\n\\e[1;30m"
		read -p "Uninstall $installdir? [Y|n] " ruanswer
		if [[ "$ruanswer" = [Ee]* ]] || [[ "$ruanswer" = [Nn]* ]] || [[ "$ruanswer" = [Qq]* ]];then
			break
		elif [[ "$ruanswer" = [Yy]* ]] || [[ "$ruanswer" = "" ]];then
			printf "\\e[30mUninstalling $installdir…\\n"
			if [[ -e "$PREFIX/bin/$startbin" ]];then
				rm "$PREFIX/bin/$startbin" 
			else 
				printf "Uninstalling $PREFIX/bin/$startbin: nothing to do for $PREFIX/bin/$startbin.\\n"
			fi
			if [[ -e "$HOME/bin/$startbin" ]];then
				rm "$HOME/bin/$startbin" 
			else 
				printf "Uninstalling $HOME/bin/$startbin: nothing to do for $HOME/bin/$startbin.\\n"
			fi
			if [[ -d "$installdir" ]];then
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
	printf "\e[0m\\n"
}

rmarchrm () {
	cd "$installdir"
	rootdirexception 
	rm -rf * 2>/dev/null ||:
	find -type d -exec chmod 700 {} \; 2>/dev/null ||:
	cd ..
	rm -rf "$installdir" 2>/dev/null ||:
}

rmarchq () {
	if [[ -d "$installdir" ]];then
		printf "\\n\\e[0;33mTermuxArch: \\e[1;33mDIRECTORY WARNING!  $installdir/ \\e[0;33mdirectory detected.  \\e[1;30mTermux Arch installation shall continue.  If in doubt, answer yes.\\n"
		rmarch
	fi
}

rmbloomq () {
	if [[ -d "$HOME"/TermuxArchBloom ]];then
		printf "\\n\\n\\e[0;33mTermuxArch: \\e[1;33mDIRECTORY WARNING!  $HOME/TermuxArchBloom/ \\e[0;33mdirectory detected.  \\e[1;30msetupTermuxArch.sh bloom will continue.\\n"
		while true; do
			printf "\\n\\e[1;30m"
			read -p "Refresh $HOME/TermuxArchBloom? [Y|n] " rbuanswer
			if [[ "$rbuanswer" = [Ee]* ]] || [[ "$rbuanswer" = [Nn]* ]] || [[ "$rbuanswer" = [Qq]* ]];then
				printtail 
			elif [[ "$rbuanswer" = [Yy]* ]] || [[ "$rbuanswer" = "" ]];then
				printf "\\e[30mUninstalling $HOME/TermuxArchBloom…\\n"
				if [[ -d "$HOME"/TermuxArchBloom ]];then
					rm -rf "$HOME"/TermuxArchBloom 
				else 
					printf "Uninstalling $HOME/TermuxArchBloom, nothing to do for $installdir.\\n"
				fi
				printf "Uninstalling $HOME/TermuxArchBloom done.\\n"
				break
			else
				printf "\\nYou answered \\e[33;1m$rbuanswer\\e[30m.\\n\\nAnswer \\e[32mYes\\e[30m or \\e[1;31mNo\\e[30m. [\\e[32mY\\e[30m|\\e[1;31mn\\e[30m]\\n"
			fi
		done
	fi
}

rmdsc () {
	rm animationfunctions.sh
	rm archsystemconfigs.sh
	rm getimagefunctions.sh
	rm knownconfigurations.sh
	rm necessaryfunctions.sh
	rm printoutstatements.sh
	rm systemmaintenance.sh
	rm termuxarchchecksum.sha512 
}

rmds () {
	rm setupTermuxArch.sha512 
	rm setupTermuxArch.tar.gz
}

rootdirexception () {
	if [[ "$installdir" = "$HOME" ]] || [[ "$installdir" = "$HOME"/ ]] || [[ "$installdir" = "$HOME"/.. ]] || [[ "$installdir" = "$HOME"/../ ]] || [[ "$installdir" = "$HOME"/../.. ]] || [[ "$installdir" = "$HOME"/../../ ]];then
		printf "\\n\\e[1;31mRootdir exception.  Run the script again with different options…\\n\\n\\e[0m"'\033]2;Rootdir exception.  Run `bash setupTermuxArch.sh` again with different options…\007'
		exit
	fi
}

runbloom () {
	if [[ -d "$HOME"/TermuxArchBloom ]];then 
		opt=bloom
		bloomdependsblock 
	else
		dependsblock
		bloom 
	fi
}

setrootdir () {
	if [[ "$cpuabi" = "$cpuabix86" ]];then
	#	rootdir=/root.i686
		rootdir=/arch
	elif [[ "$cpuabi" = "$cpuabix8664" ]];then
	#	rootdir=/root.x86_64
		rootdir=/arch
	else
		rootdir=/arch
	fi
}

spaceinfo () {
	units="$(df 2>/dev/null | awk 'FNR == 1 {print $2}')"
	if [[ "$units" = Size ]];then
		spaceinfogsize 
		printf "$spaceMessage"
	elif [[ "$units" = 1K-blocks ]];then
		spaceinfoksize 
		printf "$spaceMessage"
	fi
}

spaceinfogsize () {
	userspace return
	if [[ "$cpuabi" = "$cpuabix86" ]] || [[ "$cpuabi" = "$cpuabix8664" ]];then
		if [[ "$usrspace" = *G ]];then 
			spaceMessage=""
		elif [[ "$usrspace" = *M ]];then
			usspace="${usrspace: : -1}"
			if [[ "$usspace" < "800" ]];then
				spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for x86 and x86_64 is 800M of free user space.\\n\\e[0m"
			fi
		fi
	elif [[ "$usrspace" = *G ]];then
		usspace="${usrspace: : -1}"
		if [[ "$cpuabi" = "$cpuabi8" ]];then
			if [[ "$usspace" < "1.5" ]];then
				spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\\n\\e[0m"
			else
				spaceMessage=""
			fi
		elif [[ "$cpuabi" = "$cpuabi7" ]];then
			if [[ "$usspace" < "1.23" ]];then
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

spaceinfoq () {
	if [[ "$suanswer" != [Yy]* ]];then
		spaceinfo
		if [[ -n "$spaceMessage" ]];then
			while true; do
				printf "\\n\\e[1;30m"
				read -p "Continue with setupTermuxArch.sh? [Y|n] " suanswer
				if [[ "$suanswer" = [Ee]* ]] || [[ "$suanswer" = [Nn]* ]] || [[ "$suanswer" = [Qq]* ]];then
					printtail
				elif [[ "$suanswer" = [Yy]* ]] || [[ "$suanswer" = "" ]];then
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

spaceinfoksize () {
	userspace return
	if [[ "$cpuabi" = "$cpuabi8" ]];then
		if [[ "$usrspace" -lt "1500000" ]];then
			spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace $units of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\\n\\e[0m"
		else
			spaceMessage=""
		fi
	elif [[ "$cpuabi" = "$cpuabi7" ]];then
		if [[ "$usrspace" -lt "1250000" ]];then
			spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace $units of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for armv7 is 1.25G of free user space.\\n\\e[0m"
		else
			spaceMessage=""
		fi
	elif [[ "$cpuabi" = "$cpuabix86" ]] || [[ "$cpuabi" = "$cpuabix8664" ]];then
		if [[ "$usrspace" -lt "800000" ]];then
			spaceMessage="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$usrspace $units of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for x86 and x86_64 is 800M of free user space.\\n\\e[0m"
		else
			spaceMessage=""
		fi
	fi
}

userspace () {
	usrspace="$(df /data 2>/dev/null | awk 'FNR == 2 {print $4}')"
	if [[ "$usrspace" = "" ]];then
		usrspace="$(df /data 2>/dev/null | awk 'FNR == 3 {print $3}')"
	fi
}

wgetifdm () {
	if [[ "$dm" = wget ]];then
		wgetif 
	fi
}

wgetif () {
	if [[ ! -x "$PREFIX"/bin/wget ]];then
		printf "\\n\\e[1;34mInstalling \\e[0;32mwget\\e[1;34m…\\n\\n\\e[1;32m"
		pkg install wget --yes 	
		printf "\\n\\e[1;34mInstalling \\e[0;32mwget\\e[1;34m: \\e[1;32mDONE\\n\\e[0m"
	fi
	if [[ ! -x "$PREFIX"/bin/wget ]];then
		pe
	fi
}

# User configurable variables such as mirrors and download manager options are in `setupTermuxArchConfigs.sh`.  Creating this file from `kownconfigurations.sh` in the working directory is simple, use `setupTermuxArch.sh manual` to create, edit and run `setupTermuxArchConfigs.sh`; `setupTermuxArch.sh help` has more information.  All options can be abbreviated to the first letter(s). 

commandif="$(command -v getprop)" ||:
cpuabi="$(getprop ro.product.cpu.abi 2>/dev/null)" ||:
cpuabi5="armeabi"
cpuabi7="armeabi-v7a"
cpuabi8="arm64-v8a"
cpuabix86="x86"
cpuabix8664="x86_64"

declare COUNTER=""
declare -g args="$@"
declare bin=""
declare dfl=""
declare dm=""
declare installdir=""
declare -g kid="0"
declare opt=""
declare rootdir=""
declare spaceMessage""

dfl=/gen
dmverbose="-q"
# dmverbose="-v"
stim="$(date +%s)"
stime="${stim:0:4}"
# trap finish SIGINT SIGTERM 
trap finish EXIT
versionid="gen.v1.6 id564275471675"

if [[ "$commandif" = "" ]];then
	echo Run \`setupTermuxArch.sh\` from the Android system in Termux.
	exit
fi

nameinstalldir 
namestartarch  
setrootdir  

# [] Run default Arch Linux install.
if [[ -z "${1+x}" ]];then
	intro 
	mainblock
fi

# [curl debug|curl sysinfo] Get device system information using `curl`.
if [[ "$1" = [Cc][Dd]* ]] || [[ "$1" = -[Cc][Dd]* ]] || [[ "$1" = --[Cc][Dd]* ]] || [[ "$1" = [Cc][Ss]* ]] || [[ "$1" = -[Cc][Ss]* ]] || [[ "$1" = --[Cc][Ss]* ]];then
	dm=curl
	introdebug 
	sysinfo 
# [curl installdir|curl install installdir] Install Arch Linux using `curl`.
elif [[ "$1" = [Cc]* ]] || [[ "$1" = -[Cc]* ]] || [[ "$1" = --[Cc]* ]] || [[ "$1" = [Cc][Ii]* ]] || [[ "$1" = -[Cc][Ii]* ]] || [[ "$1" = --[Cc][Ii]* ]];then
	dm=curl
	opt2 "$args" 
	intro 
	mainblock
# [wget debug|wget sysinfo] Get device system information using `wget`.
elif [[ "$1" = [Ww][Dd]* ]] || [[ "$1" = -[Ww][Dd]* ]] || [[ "$1" = --[Ww][Dd]* ]] || [[ "$1" = [Ww][Ss]* ]] || [[ "$1" = -[Ww][Ss]* ]] || [[ "$1" = --[Ww][Ss]* ]];then
	dm=wget
	introdebug 
	sysinfo 
# [wget installdir|wget install installdir] Install Arch Linux using `wget`.
elif [[ "$1" = [Ww]* ]] || [[ "$1" = -[Ww]* ]] || [[ "$1" = --[Ww]* ]] || [[ "$1" = [Ww][Ii]* ]] || [[ "$1" = -[Ww][Ii]* ]] || [[ "$1" = --[Ww][Ii]* ]];then
	dm=wget
	opt2 "$args" 
	intro 
	mainblock
# [bloom] Create local copy of TermuxArch in TermuxArchBloom.  Useful for hacking and customizing TermuxArch.  
elif [[ "$1" = [Bb]* ]] || [[ "$1" = -[Bb]* ]] || [[ "$1" = --[Bb]* ]];then
	dependsblock
	bloom
# [debug|sysinfo] Get system information.
elif [[ "$1" = [Dd]* ]] || [[ "$1" = -[Dd]* ]] || [[ "$1" = --[Dd]* ]] || [[ "$1" = [Ss]* ]] || [[ "$1" = -[Ss]* ]] || [[ "$1" = --[Ss]* ]];then
	introdebug 
	sysinfo 
# [help|?] Display built-in help.
elif [[ "$1" = [Hh]* ]] || [[ "$1" = -[Hh]* ]] || [[ "$1" = --[Hh]* ]]  || [[ "$1" = [?]* ]] || [[ "$1" = -[?]* ]] || [[ "$1" = --[?]* ]];then
	printusage
# [manual] Manual Arch Linux install, useful for resolving download issues.
elif [[ "$1" = [Mm]* ]] || [[ "$1" = -[Mm]* ]] || [[ "$1" = --[Mm]* ]];then
	opt=manual
	intro 
	mainblock
# [purge |uninstall] Remove Arch Linux.
elif [[ "$1" = [Pp]* ]] || [[ "$1" = -[Pp]* ]] || [[ "$1" = --[Pp]* ]] || [[ "$1" = [Uu]* ]] || [[ "$1" = -[Uu]* ]] || [[ "$1" = --[Uu]* ]];then
	arg2dir 
	rmarch
# [install installdir|rootdir installdir] Install Arch Linux in custom directory.  Instructions: Install in userspace. $HOME is appended to installation directory. To install Arch Linux in $HOME/installdir use `bash setupTermuxArch.sh install installdir`. In bash shell use `./setupTermuxArch.sh install installdir`.  All options can be abbreviated to one or two letters.  Hence `./setupTermuxArch.sh install installdir` can be run as `./setupTermuxArch.sh i installdir` in BASH.
elif [[ "$1" = [Ii]* ]] || [[ "$1" = -[Ii]* ]] || [[ "$1" = --[Ii]* ]] ||  [[ "$1" = [Rr][Oo]* ]] || [[ "$1" = -[Rr][Oo]* ]] || [[ "$1" = --[Rr][Oo]* ]];then
	arg2dir 
	intro 
	mainblock
# [refresh|refresh installdir] Refresh Arch Linux in Termux PRoot scripts created by TermuxArch.  Useful for refreshing TermuxArch generated scripts to the newest version.  
elif [[ "$1" = [Rr][Ee]* ]] || [[ "$1" = -[Rr][Ee]* ]] || [[ "$1" = --[Rr][Ee]* ]];then
	arg2dir 
	introrefresh 
# [run] Run local copy of TermuxArch from TermuxArchBloom.  Useful for running customized TermuxArch locally.  
elif [[ "$1" = [Rr]* ]] || [[ "$1" = -[Rr]* ]] || [[ "$1" = --[Rr]* ]];then
	runbloom 
# [] Run default Arch Linux install.
# elif [[ "$1" = "" ]];then
# 	intro 
# 	mainblock
else
	printusage
fi
printtail 
