#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project. 
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
################################################################################
IFS=$'\n\t'
set -Eeuo pipefail
shopt -s nullglob globstar
unset LD_PRELOAD
VERSIONID="v1.6.4.id2054"

_SET_TRAP_ERROR_() { # Run on script error.
	local RV="$?"
	printf "\\e[?25h\\n\\e[1;48;5;138m %s\\e[0m\\n" "$TA WARNING:  Generated script signal $RV near or at line number ${2:-} by \`${3:-}\`!"
	if [[ "$RV" = 4 ]] ; then
		printf "\\n\\e[1;48;5;139m %s\\e[0m\\n" "Ensure background data is not restricted.  Check the wireless connection."
	fi
	printf "\\n"
	exit 201
}

_SET_TRAP_EXIT_() { # Run on exit.
	local RV="$?"
	cd "$WDIR"
 	rm -rf "$TAMPDIR"
	if [[ "$RV" = 0 ]] ; then
		printf "\\e]2;%s\\007" "${0##*/} $ARGS: DONE 🏁 "
		printf "\\e[?25h\\a\\a\\e[0;32m%s \\a\\e[0m%s\\a\\e[1;34m: \\e[1;32m%s\\e[0m\\a\\a\\n\\n\\e[0m" "${0##*/} $ARGS" "$VERSIONID" "DONE 🏁 "
	else
		printf "\\e]2;%s\\007" "${0##*/} $ARGS [Exit Signal $RV]: DONE 🏁 "
		printf "\\e[?25h\\e[0;32m%s \\a\\a\\e[0m%s\\a\\e[1;34m: \\e[1;32m%s\\e[0m\\n\\n\\e[0m" "${0##*/} $ARGS" "$VERSIONID" "[Exit Signal $RV] DONE 🏁 "
	fi
	set +Eeuo pipefail 
	exit
}

_SET_TRAP_SIGNAL_() { # Run on signal.
	local RV="$?"
	printf "\\e[?25h\\n\\e[1;48;5;138m %s\\e[0m\\n" "$TA WARNING:  Signal $RV received near or at line number ${2:-} by \`${3:-}\`!"
 	exit 202 
}

_SET_TRAP_QUIT_() { # Run on quit.
	local RV="$?"
	printf "\\e[?25h\\e[1;7;38;5;0m%s\\e[0m\\n" "$TA WARNING:  Quit signal $RV received!"
 	exit 203 
}
# https://www.ibm.com/developerworks/aix/library/au-usingtraps/index.html
trap '_SET_TRAP_ERROR_ $? $LINENO $BASH_COMMAND' ERR 
trap _SET_TRAP_EXIT_ EXIT
trap '_SET_TRAP_SIGNAL_ $? $LINENO $BASH_COMMAND' HUP INT TERM 
trap _SET_TRAP_QUIT_ QUIT 
################################################################################
_ARG2DIR_() {  # Argument as ROOTDIR.
	ARG2="${@:2:1}"
	if [[ -z "${ARG2:-}" ]] 
	then
		ROOTDIR=/arch
		_PREPTERMUXARCH_
	else
		ROOTDIR=/"$ARG2" 
		_PREPTERMUXARCH_
	fi
}

_BSDTARIF_() {
	if [[ ! -x "$(command -v bsdtar)" ]] || [[ ! -x "$PREFIX"/bin/bsdtar ]] 
	then
		APTIN+="bsdtar "
		APTON+=(bsdtar)
	fi
}

_CHK_() {
	if "$PREFIX"/bin/applets/sha512sum -c termuxarchchecksum.sha512 1>/dev/null ; then
 		_CHKSELF_ "$@"
		printf "\\e[0;34m%s \\e[1;34m%s \\e[1;32m%s\\e[0m\\n" " 🕛 > 🕜" "$TA $VERSIONID integrity:" "OK"
	       	for AFILE in "${!AF[@]}" 
		do
		       	if [[ "${AF[$AFILE]}" != "${AF[7]}" ]] 
			then
				. "${AF[$AFILE]}" 
			fi
	       	done
	else
		_PRINT_SHA512SYSCHKER_
	fi
}

_CHKDWN_() {
	if "$PREFIX"/bin/applets/sha512sum -c setupTermuxArch.sha512 1>/dev/null 
	then
		printf "\\e[0;34m%s\\e[1;34m%s\\e[1;32m%s\\n\\n" " 🕛 > 🕐 " "$TA download: " "OK"
		proot --link2symlink -0 "$PREFIX"/bin/applets/tar xf setupTermuxArch.tar.gz 
	else
		_PRINT_SHA512SYSCHKER_
	fi
}

_CHKIDIR_() {
   	if [[ -f "$INSTALLDIR/$STARTBIN" ]] && [[ -f "$INSTALLDIR"/root/bin/tour ]] && [[ -f "$INSTALLDIR/sbin/apk"  || -f "$INSTALLDIR/usr/bin/apt" || -f "$INSTALLDIR/bin/pacman" ]] 
  	then 
  		printf "\\n"
		_PRINT_USAGE_ "$@"  
  		printf "\\n\\e[1;33m%s\\e[0;33m%s\\e[0m\\n\\n" "$TA WARNING!  " "The root directory structure is correct; Cannot continue ${0##*/} install!  See \`${0##*/} help\` and \`$STARTBIN help\` for options."
  		exit 204
  	fi
}

_CHKIROOST_() {
   	if [[ ! -f "$INSTALLDIR/$STARTBIN" ]] && [[ ! -f "$INSTALLDIR"/root/bin/tour ]] && [[ ! -f "$INSTALLDIR/sbin/apk"  || ! -f "$INSTALLDIR/usr/bin/apt" || ! -f "$INSTALLDIR/bin/pacman" ]] 
	then
		_PRINT_USAGE_ "$@"  
		printf "\\e[0;33m%s\\e[1;33m%s\\e[0;33m.\\e[0m\\n\\n" "$TA WARNING!  " "The root directory structure is incorrect; Cannot continue ${0##*/} refresh!  See \`${0##*/} help\` for more information"
		exit 205
	fi
}

_CHKSELF_() {
	if [[ -f "setupTermuxArch.tmp" ]] 
	then # compare the two versions:
		if [[ "$(<"${0##*/}")" != "$(<setupTermuxArch.tmp)" ]] # the two versions are not equal:
		then # copy the newer version to update:
			cp "${0##*/}" "$WDIR${0##*/}"
			chmod 700 "$WDIR${0##*/}"
			printf "\\e[0;32m%s\\e[1;34m: \\e[1;32mUPDATED\\n\\e[1;32mRESTART\\e[1;34m: \\e[0;32m%s %s \\n\\n\\e[0m"  "${0##*/}" "${0##*/}" "$ARGS"
#  			# .  "$WDIR${0##*/}" "$ARGS"
			exit 198
		fi
	fi
}

_DEPENDBP_() {
	if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX86_64" ]] 
	then
		_BSDTARIF_
		_PROOTIF_
	else
		_PROOTIF_
	fi
}

_DEPENDDM_() { # Checks and sets download manager. 
	for pkg in "${!ADT[@]}" 
	do
		if [[ -x "$PREFIX"/bin/"${ADT[$pkg]}" ]] 
		then
 			dm="$pkg" 
 			echo 
			echo "Found download tool: $pkg; Continuing…"
			break
		fi
	done
}

_DEPENDTM_() { # Checks and sets tar manager. 
	for pkg in "${!ATM[@]}" 
	do
		if [[ -x "$PREFIX"/bin/"${ATM[$pkg]}" ]] 
		then
 			tm="$pkg" 
 			echo 
			echo "Found tar tool: $pkg; Continuing…"
			break
		fi
	done
}

_DEPENDIFDM_() { # checks if download tool is set and sets install if available. 
 	for pkg in "${!ADT[@]}" # check from available toolset and set one for install if available on device. 
	do #	check for both set dm and if tool exists on device. 
 		if [[ "$dm" = "$pkg" ]] && [[ ! -x "$PREFIX"/bin/"${ADT[$pkg]}" ]] 
		then #	sets both download tool for install and exception check. 
 			APTIN+="$pkg "
			APTON+=("${ADT[$pkg]}")
 			echo 
			echo "Setting download tool \`$pkg\` for install; Continuing…"
 		fi
 	done
}

_DEPENDS_() { # Checks for missing commands.  
	printf "\\e[1;34mChecking prerequisites…\\n\\e[1;32m"
	ADT=([aria2]=aria2c [axel]=axel [curl]=curl [lftp]=lftpget [wget]=wget)
	ATM=([busybox]=applets/tar [tar]=tar [bsdtar]=bsdtar)
	if [[ "$dm" != "" ]] 
	then
		_DEPENDIFDM_
	fi
	if [[ "$dm" = "" ]] 
	then
		_DEPENDDM_
	fi
	# Sets default download tool if nothing else was found and set. 
	if [[ "$dm" = "" ]] 
	then
		DDM=curl # default download tool 
		dm="$DDM"
		APTIN+="$DDM "
		APTON+=("$DDM")
		printf "\\n\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;34m%s\\n\\n\\e[0;32m" "Setting download tool " "$APTIN" "as default; " "Continuing…"
	fi
	_DEPENDBP_ 
#	# Installs missing commands.  
	_TAPIN_ "$APTIN"
#	# Checks whether install missing commands was successful.  
 	_PECHK_ "${APTON[*]}"
	echo
	echo "Using $dm to manage downloads." 
	printf "\\n\\e[0;34m%s\\e[1;34m%s\\e[1;32m%s\\e[1;34m%s\\n\\n\\e[0;32m" " 🕛 > 🕧 " "Prerequisites: " "OK  " "Downloading $TA…"
}

_DEPENDSBLOCK_() {
	_DEPENDS_ 
	AF=([0]=archlinuxconfig.sh [1]=espritfunctions.sh [2]=getimagefunctions.sh [3]=knownconfigurations.sh [4]=maintenanceroutines.sh [5]=necessaryfunctions.sh [6]=printoutstatements.sh [7]=setupTermuxArch.sh)
 	LCW=0
	for AFFILE in "${!AF[@]}" 
	do # checks whether all files are present in working directory. 
	       	if [[ ! -f "${AF[$AFFILE]}" ]] 
		then
			LCW=1 # sets flag if any files are absent. 
		fi
	done
       	if [[ "$LCW" = 0 ]] # checks flag whether still set to 0, 
	then # load all files except this file.
	       	for AFILE in "${!AF[@]}" 
		do
		       	if [[ -f "${AF[$AFILE]}" ]] &&  [[ "${AF[$AFILE]}" != "${AF[7]}" ]] 
			then
				. "${AF[$AFILE]}" 
			fi
	       	done
	else
		cd "$TAMPDIR" 
		_DWNL_
		if [[ -f "$WDIR${AF[7]}" ]] 
		then
			cp "$WDIR${AF[7]}" setupTermuxArch.tmp
		fi
		_CHKDWN_
		_CHK_ "$@"
	fi
	if [[ "$OPT" = *bloom* ]] 
	then
		rm -f termuxarchchecksum.sha512 
	fi
	if [[ "$OPT" = *manual* ]] 
	then
		_MANUAL_
	fi 
}

_DWNL_() { # Downloads TermuxArch from Github.
	if [[ "$DFL" = "/gen" ]] 
	then # get development version from:
		FILE[sha]="https://raw.githubusercontent.com/sdrausty/gensTermuxArch/master/setupTermuxArch.sha512"
		FILE[tar]="https://raw.githubusercontent.com/sdrausty/gensTermuxArch/master/setupTermuxArch.tar.gz" 
	else # get stable version from:
		FILE[sha]="https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.sha512"
		FILE[tar]="https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.tar.gz" 
	fi
	if [[ "$dm" = aria2 ]] 
	then # use https://github.com/aria2/aria2
		"${ADT[aria2]}" -Z "${FILE[sha]}" "${FILE[tar]}"
	elif [[ "$dm" = axel ]] 
	then # use https://github.com/mopp/Axel
		"${ADT[axel]}" "${FILE[sha]}" 
		"${ADT[axel]}" "${FILE[tar]}"
	elif [[ "$dm" = curl ]] 
	then # use https://github.com/curl/curl	
		"${ADT[curl]}" "$DMVERBOSE" -OL "${FILE[sha]}" -OL "${FILE[tar]}"
	elif [[ "$dm" = wget ]] 
	then # use https://github.com/mirror/wget
		"${ADT[wget]}" "$DMVERBOSE" -N --show-progress "${FILE[sha]}" "${FILE[tar]}"
	else # use https://github.com/lavv17/lftp
		"${ADT[lftp]}" -c "${FILE[sha]}" "${FILE[tar]}"
	fi
	printf "\\n\\e[1;32m"
}

_PRINT_INTRO_INIT_() {
	_PREPTERMUXARCH_ "$@" 
	_CHKIDIR_
	printf "\033]2;%s\007" "bash ${0##*/} $ARGS 📲" 
	printf "\\n\\e[0;34m%s\\e[1;34m%s\\e[0;32m%s\\e[1;34m%s\`\\e[0;32m!!\\e[1;34m\`%s" " 🕛 > 🕛 " "$TA $VERSIONID shall attempt to install Linux in " "$INSTALLDIR" ".  Linux in Termux PRoot shall be available upon successful completion.  To run this BASH script again, use " ".  Ensure background data is not restricted.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
} 

_INTRO_INIT_() {
	_PRINT_INTRO_INIT_
	_DEPENDSBLOCK_ "$@" 
	if [[ "$OPT" = *flavors* ]] 
	then
		_OPTIONAL_SYSTEMS_ "$@" 
	else
	       	if [[ "$lcc" = "1" ]] 
		then
		       	loadimage "$@" 
		else
		       	_MAINBLOCK_
	       	fi
       	fi
}

_INTRO_BLOOM_() { # Bloom = `setupTermuxArch.sh manual verbose` 
	OPT+=bloom 
	printf "\033]2;%s\007" "bash ${0##*/} bloom 📲" 
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34m$TA $VERSIONID bloom option.  Run \\e[1;32mbash ${0##*/} help\\e[1;34m for additional information.  Ensure background data is not restricted.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	_DEPENDSBLOCK_ "$@" 
	_BLOOM_ 
}

_PRINT_INTRO_REFRESH_() {
	_PREPTERMUXARCH_ "$@" 
	_CHKIROOST_
	printf "\033]2;%s\007" "bash ${0##*/} refresh 📲" 
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34m$TA $VERSIONID shall refresh your TermuxArch files in \\e[0;32m$INSTALLDIR\\e[1;34m.  Ensure background data is not restricted.  Run \\e[0;32mbash ${0##*/} help\\e[1;34m for additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
} 

_INTRO_REFRESH_() {
	_PRINT_INTRO_REFRESH_ "$@" 
	_DEPENDSBLOCK_ "$@" 
	_REFRESHSYS_ "$@"
}

_INTRO_SYSINFO_() {
	_PREPTERMUXARCH_ "$@" 
	printf "\033]2;%s\007" "bash ${0##*/} sysinfo 📲" 
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34m$TA $VERSIONID shall create a system information file.  Ensure background data is not restricted.  Run \\e[0;32mbash ${0##*/} help \\e[1;34mfor additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	_DEPENDSBLOCK_ "$@" 
	_SYSINFO_ "$@" 
}

_NAME_INSTALLDIR_() {
	if [[ "$ROOTDIR" = "" ]] ; then
		ROOTDIR=arch
	fi
	INSTALLDIR="$(echo "$HOME/${ROOTDIR%/}" |sed 's#//*#/#g')"
}

_NAME_STARTARCH_() { # ${@%/} removes trailing slash
 	DARCH="$(echo "${ROOTDIR%/}" |sed 's#//*#/#g')"
	if [[ "$DARCH" = "/arch" ]] ; then
		AARCH=""
		STARTBI2=arch
	else
 		AARCH="$(echo "$DARCH" |sed 's/\//\+/g')"
		STARTBI2=arch
	fi
	declare -g STARTBIN=start"$STARTBI2$AARCH"
}

_OPT1_() { 
	if [[ -z "${2:-}" ]] || [[ "$OPT" = *install* ]] ; then
		_ARG2DIR_ "$@" 
	elif [[ "$2" = [Bb]* ]] ; then
		echo Setting mode to bloom. 
		_INTRO_BLOOM_ "$@"  
	elif [[ "$2" = [Dd]* ]] || [[ "$2" = [Ss]* ]] ; then
		echo Setting mode to sysinfo.
		shift 
		_ARG2DIR_ "$@" 
		_INTRO_SYSINFO_ "$@"  
	elif [[ "$2" = [Ff]* ]] ; then
		echo Setting mode to Linux Flavors.  THIS OPTION IS UNDER CONSTRUCTION!  
		OPT+=flavors
 		_OPT2_ "$@"  
		_PRINT_INTRO_INIT_
		_CHKIDIR_
		_DEPENDSBLOCK_ "$@" 
		_PRINT_DETECTED_SYSTEM_
		_OPTIONAL_SYSTEMS_ "$@" 
	elif [[ "$2" = [Ii]* ]] ; then
		echo Setting mode to install.
		shift
		_ARG2DIR_ "$@" 
		_INTRO_INIT_ "$@"  
	elif [[ "$2" = [Mm]* ]] ; then
		echo Setting mode to manual.
		OPT+=manual
 		_OPT2_ "$@"  
		_INTRO_INIT_ "$@"  
	elif [[ "$2" = [Oo]* ]] ; then
		echo Setting mode to option.  THIS OPTION IS UNDER CONSTRUCTION!  
		OPT+=option
		echo Setting mode to Linux Flavors.  THIS OPTION IS UNDER CONSTRUCTION!  
		OPT+=flavors
 		_OPT2_ "$@"  
		_PRINT_INTRO_INIT_
		_CHKIDIR_
		_DEPENDSBLOCK_ "$@" 
		_PRINT_DETECTED_SYSTEM_
		_OPTIONAL_SYSTEMS_ "$@" 
	elif [[ "${1//-}" = [Rr][Ee][Ff]* ]] ; then
		echo 
		echo Setting mode to refresh.
		shift
		_ARG2DIR_ "$@" 
		_INTRO_REFRESH_ "$@"  
	elif [[ "$2" = [Rr][Ee]* ]] ; then
		echo 
		echo Setting mode to refresh.
		shift 
		_ARG2DIR_ "$@" 
		_INTRO_REFRESH_ "$@"  
	elif [[ "$2" = [Rr]* ]] ; then
		LCR="1"
		printf "\\n\\e[1;32m%s\\e[1;34m: \\e[0;32m%s \`%s\` %s\\n\\e[0m" "Setting mode" "minimal refresh;  Use" "${0##*/} re[fresh]" "for full refresh."
		shift
		_ARG2DIR_ "$@" 
		_INTRO_REFRESH_ "$@"  
	else
		_ARG2DIR_ "$@" 
	fi
}

_OPT2_() { 
	if [[ -z "${3:-}" ]] ; then
		:
	elif [[ "$3" = [Ff]* ]] ; then
		echo Setting mode to Linux Flavors.  THIS OPTION IS UNDER CONSTRUCTION!  
		OPT+=flavors
		shift 2 
		_ARG2DIR_ "$@" 
		_PRINT_INTRO_INIT_
		_CHKIDIR_
		_DEPENDSBLOCK_ "$@" 
		_PRINT_DETECTED_SYSTEM_
		_OPTIONAL_SYSTEMS_ "$@" 
	elif [[ "$3" = [Ii]* ]] ; then
		echo Setting mode to install.
		shift 2 
		_ARG2DIR_ "$@" 
		_INTRO_INIT_ "$@"  
	elif [[ "${1//-}" = [Rr][Ee][Ff]* ]] ; then
		echo 
		echo Setting mode to refresh.
		shift 2 
		_ARG2DIR_ "$@" 
		_INTRO_REFRESH_ "$@"  
	elif [[ "$3" = [Rr][Ee]* ]] ; then
		echo 
		echo Setting mode to refresh.
		shift 2 
		_ARG2DIR_ "$@" 
		_INTRO_REFRESH_ "$@"  
	elif [[ "$3" = [Rr]* ]] ; then
		LCR="1"
		printf "\\n\\e[1;32m%s\\e[1;34m: \\e[0;32m%s \`%s\` %s\\n\\e[0m" "Setting mode" "minimal refresh;  Use" "${0##*/} re[fresh]" "for full refresh."
		shift 2 
		_ARG2DIR_ "$@" 
		_INTRO_REFRESH_ "$@"  
	else
		shift 
		_ARG2DIR_ "$@" 
		_INTRO_INIT_ "$@"  
	fi
}

_PECHK_() {
	if [[ "$APTON" != "" ]] 
	then 
		for CMD in "${!ADT[@]}" 
		do
		       	if [[ ! -x "$PREFIX"/bin/"${ADT[$CMD]}" ]] 
			then
			       	_PRINT_PE_ 
			fi 
		done
       	fi
}

_PREPTMPDIR_() { 
	mkdir -p "$INSTALLDIR/tmp"
	chmod 777 "$INSTALLDIR/tmp" ||:
	chmod +t "$INSTALLDIR/tmp"  ||:
 	TAMPDIR="$INSTALLDIR/tmp/setupTermuxArch$$"
	mkdir -p "$TAMPDIR" 
}

_PREPTERMUXARCH_() { 
	_NAME_INSTALLDIR_ 
	_NAME_STARTARCH_  
	_SET_ROOT_DIRECTORY_EXCEPTIONS_ "$@" 
	_PREPTMPDIR_
}

_PRINT_PE_() {
	printf "\\n\\e[7;1;31m%s\\e[0;1;32m %s\\n\\n\\e[0m" "PREREQUISITE EXCEPTION!" "RUN ${0##*/} $ARGS AGAIN…"
	printf "\\e]2;%s %s\\007" "RUN ${0##*/} $ARGS" "AGAIN…"
	exit 233
}

_PRINT_SHA512SYSCHKER_() {
	printf "\\n\\e[07;1m\\e[31;1m\\n%s \\e[34;1m\\e[30;1m%s \\n\\e[0;0m\\n" " 🔆 WARNING sha512sum mismatch!  Setup initialization mismatch!" "  Try again, initialization was not successful this time.  Wait a little while.  Then run \`bash ${0##*/}\` again…"
	printf "\033]2; Run `bash %s` again…\007" "${0##*/} $ARGS" 
	exit 
}

_PRINT_STARTBIN_USAGE_() {
	printf "\\n\\e[1;38;5;155m" 
 	_NAME_STARTARCH_ 
	if [[ -x "$(command -v "$STARTBIN")" ]] ; then
		echo "$STARTBIN" help 
		"$STARTBIN" help 
	fi
}

_PRINT_USAGE_() {
	printf "\\n\\e[1;33m %s     \\e[0;32m%s \\e[1;34m%s\\n" "HELP" "${0##*/} help" "shall output the help screen." 
	printf "\\n\\e[1;33m %s    \\e[0;32m%s \\e[1;34m%s\\n" "TERSE" "${0##*/} he[lp]" "shall output the terse help screen." 
	printf "\\n\\e[1;33m %s  \\e[0;32m%s \\e[1;34m%s\\n" "VERBOSE" "${0##*/} h" "shall output the verbose help screen." 
	printf "\\n\\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\n\\n%s \\e[0;32m%s\\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s\\e[1;34m%s\\n" "Usage information for" "${0##*/}" "$VERSIONID.  Arguments can abbreviated to one, two and three letters each; Two and three letter arguments are acceptable.  For example," "bash ${0##*/} cs" "shall use" "curl" "to download $TA and produce a" "setupTermuxArchSysInfo$STIME.log" "system information file." "User configurable variables are in" "setupTermuxArchConfigs.sh" ".  To create this file from" "kownconfigurations.sh" "in the working directory, run" "bash ${0##*/} manual" "to create and edit" "setupTermuxArchConfigs.sh" "." 
	printf "\\n\\e[1;33m %s\\e[1;34m  %s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s\\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s\\n" "INSTALL" "Run" "./${0##*/}" "without arguments in a bash shell to install Arch Linux in Termux.  " "bash ${0##*/} curl" "shall envoke" "curl" "as the download manager.  Copy" "knownconfigurations.sh" "to" "setupTermuxArchConfigs.sh" "with" "bash ${0##*/} manual" "to edit preferred CMIRROR site and to access more options.  After editing" "setupTermuxArchConfigs.sh" ", run" "bash ${0##*/}" "and" "setupTermuxArchConfigs.sh" "loads automatically from the working directory.  Change CMIRROR to desired geographic location to resolve download errors." 
 	printf "\\n\\e[1;33m %s    \\e[0;32m%s \\e[1;34m%s\\n" "PURGE" "${0##*/} purge" "shall uninstall Arch Linux from Termux." 
	printf "\\n\\e[1;33m %s  \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s\\e[1;34m%s \\n\\n" "SYSINFO" "${0##*/} sysinfo" "shall create" "setupTermuxArchSysInfo$STIME.log" "and populate it with system information.  Post this file along with detailed information at" "https://github.com/sdrausty/TermuxArch/issues" ".  If screenshots will help in resolving an issue better, include these along with information from the system information log file in a post as well." 
	if [[ "$lcc" = 1 ]] ; then
	printf "\\n\\e[1;38;5;149m" 
	awk 'NR>=600 && NR<=900'  "${0##*/}" | awk '$1 == "##"' | awk '{ $1 = ""; print }' | awk '1;{print ""}'
	fi
	_PRINT_STARTBIN_USAGE_
}

_PROOTIF_() {
	if [[ ! -x "$(command -v proot)" ]] ||  [[ ! -x "$PREFIX"/bin/proot ]] ; then
		APTIN+="proot "
		APTON+=(proot)
	fi
}

_RMARCH_() {
	_NAME_STARTARCH_ 
	_NAME_INSTALLDIR_
	while true; do
		printf "\\n\\e[1;30m"
		read -n 1 -p "Uninstall $INSTALLDIR? [Y|n] " RUANSWER
		if [[ "$RUANSWER" = [Ee]* ]] || [[ "$RUANSWER" = [Nn]* ]] || [[ "$RUANSWER" = [Qq]* ]] ; then
			break
		elif [[ "$RUANSWER" = [Yy]* ]] || [[ "$RUANSWER" = "" ]] ; then
			printf "\\e%s\\n" "[30mUninstalling $INSTALLDIR…"
			if [[ -e "$PREFIX/bin/$STARTBIN" ]] ; then
				rm -f "$PREFIX/bin/$STARTBIN" 
			else 
				printf "%s\\n" "Uninstalling $PREFIX/bin/$STARTBIN: nothing to do for $PREFIX/bin/$STARTBIN."
			fi
			if [[ -e "$HOME/bin/$STARTBIN" ]] ; then
				rm -f "$HOME/bin/$STARTBIN" 
			else 
				printf "%s\\n" "Uninstalling $HOME/bin/$STARTBIN: nothing to do for $HOME/bin/$STARTBIN."
			fi
			if [[ -d "$INSTALLDIR" ]] ; then
				_RMARCHRM_ 
			else 
				printf "%s\\n" "Uninstalling $INSTALLDIR: nothing to do for $INSTALLDIR."
			fi
			printf "%s\\e[1;32m%s\\n\\e[30m" "Uninstalling $INSTALLDIR: " "DONE"
			break
		else
			printf "\\e[1;33m\\n%s\\e[1;31m%s\\e[1;33m%s\\n\\n\\e[1;30m%s\\e[1;32m%s\\e[1;30m%s\\e[1;31m%s\\e[1;30m%s\\e[32m%s\\e[30m%s\\e[1;31m%s\\e[30m%s\\n" "Received answer " "$RUANSWER" "!" "Answer " "yes " "or " "no" " [" "Y" "|" "n" "]."
		fi
	done
	printf "\\e[0m\\n"
}

_RMARCHRM_() {
	_SET_ROOT_DIRECTORY_EXCEPTIONS_ 
	nice -n 19 rm -rf "${INSTALLDIR}" 2>/dev/null ||:
	nice -n 19 chmod -R 700 "${INSTALLDIR}" {} \; 2>/dev/null ||:
	nice -n 19 rm -rf "$INSTALLDIR" ||:
}

_RMARCHQ_() {
	if [[ -d "$INSTALLDIR" ]] ; then
		printf "\\n\\e[0;33m %s \\e[1;33m%s \\e[0;33m%s\\n\\n\\e[1;30m%s\\n" "$TA:" "DIRECTORY WARNING!  $INSTALLDIR/" "directory detected." "Purge $INSTALLDIR as requested?"
		_RMARCH_
	fi
}

_TAPIN_() {
	if [[ "$APTIN" != "" ]] ; then
		printf "\\n\\e[1;34mInstalling \\e[0;32m%s\\b\\e[1;34m…\\n\\n\\e[1;32m" "$APTIN"
		pkg install "$APTIN" -o APT::Keep-Downloaded-Packages="true" --yes 
		printf "\\n\\e[1;34mInstalling \\e[0;32m%s\\b\\e[1;34m: \\e[1;32mDONE\\n\\e[0m" "$APTIN"
	fi
}

_SET_ROOT_DIRECTORY_EXCEPTIONS_() {
	if [[ "$INSTALLDIR" = "$HOME" ]] || [[ "$INSTALLDIR" = "$HOME"/ ]] || [[ "$INSTALLDIR" = "$HOME"/.. ]] || [[ "$INSTALLDIR" = "$HOME"/../ ]] || [[ "$INSTALLDIR" = "$HOME"/../.. ]] || [[ "$INSTALLDIR" = "$HOME"/../../ ]] ; then
		printf  '\033]2;%s\007' "Rootdir exception.  Run bash ${0##*/} $ARGS again with different options…"	
		printf "\\n\\e[1;31m%s\\n\\n\\e[0m" "Rootdir exception.  Run the script $ARGS again with different options…"
		exit
	fi
}

_SET_ROOT_() {
	if [[ "$CPUABI" = "$CPUABIX86" ]] ; then
	#	ROOTDIR=/root.i686
		ROOTDIR=/arch
	elif [[ "$CPUABI" = "$CPUABIX86_64" ]] ; then
	#	ROOTDIR=/root.x86_64
		ROOTDIR=/arch
	else
		ROOTDIR=/arch
	fi
}

## User Information:  Configurable variables such as mirrors and download manager options are in `setupTermuxArchConfigs.sh`.  Working with `kownconfigurations.sh` in the working directory is simple.  `bash setupTermuxArch.sh manual` shall create `setupTermuxArchConfigs.sh` in the working directory for editing; See `setupTermuxArch.sh help` for more information.  
declare -A ADT		## Declare associative array for all available download tools. 
declare -A ATM		## Declare associative array for all available tar tools. 
declare -a ARGS="$@"	## Declare array for arguments as string.
declare -A ARGSA="$@"	## Declare associative array for arguments.
declare APTIN=""	## apt install string
declare APTON=""	## exception string
declare COMMANDIF=""
declare CPUABI=""
declare CPUABI5="armeabi"	## Used for development.
declare CPUABI7="armeabi-v7a"	## Used for development.
declare CPUABI8="arm64-v8a"	## Used for development.
declare CPUABIX86="x86"		## Used for development.
declare CPUABIX86_64="x86_64"	## Used for development.
declare DFL=""		## Used for development.  
declare DMVERBOSE="-q"	## -v for verbose download manager output from curl and wget;  for verbose output throughout runtime also change in `setupTermuxArchConfigs.sh` when using `setupTermuxArch.sh m[anual]`. 
declare ed=""
declare dm=""
declare FSTND=""
declare -A FILE
declare INSTALLDIR=""
declare lcc=""
declare lcp=""
declare OPT=""
declare -A OPTA=""
declare ROOTDIR=""
declare STI=""		## Used to generate pseudo random number.
declare STIME=""	## Used to generate pseudo random number.
declare -A SPECS_ARMV5L_
declare -A SPECS_ARMV7L_
declare -A SPECS_ARMV7LC_
declare -A SPECS_ARMV8L_
declare -A SPECS_X86_
declare -A SPECS_X86_64_
declare TA="ＴｅｒｍｕｘＡｒｃｈ"
declare WDIR="$PWD/"
if [[ -z "${TAMPDIR:-}" ]] ; then
	TAMPDIR=""
fi
_SET_ROOT_
## 📱 TERMUXARCH FEATURES INCLUDE: 
## 📲 Sets timezone and locales from device,
## 📲 Tests for correct OS,
COMMANDIF="$(command -v getprop)" ||:
if [[ "$COMMANDIF" = "" ]] 
then
	printf "\\n\\e[1;48;5;138m %s\\e[0m\\n\\n" "$TA WARNING: Run \`bash ${0##*/}\` and \`./${0##*/}\` from the BASH shell in the OS system in Termux, e.g., Amazon Fire, Android and Chromebook."
	exit
fi
## 📲 Generates pseudo random number to create uniq strings,
if [[ -r  /proc/sys/kernel/random/uuid ]] 
then
	STI="$(cat /proc/sys/kernel/random/uuid)"
	STIM="${STI//-}"	
	STIME="${STIM:0:3}"	
else
	STI="$(date +%s)" 
	STIME="$(echo "${STI:7:4}"|rev)" 
fi
ONES="$(date +%s)" 
ONESA="${ONES: -1}" 
STIME="$ONESA$STIME"
## 📲 Gets system information with builtin tools such as `getprop`,
CPUABI="$(getprop ro.product.cpu.abi)" 
## 📲 And all options are optional for install.  
## THESE OPTIONS ARE AVAILABLE FOR YOUR CONVENIENCE: 
## OPTIONS[a]: `setupTermuxArch.sh [HOW] [DO] [WHERE]`
## GRAMMAR[a]: `setupTermuxArch.sh [HOW] [DO] [WHERE]`
## OPTIONS[b]: `setupTermuxArch.sh [~/|./|/absolute/path/]image.tar.gz [WHERE]` 
## GRAMMAR[b]: `setupTermuxArch.sh [WHAT] [WHERE]`
## DEFAULTS ARE IMPLIED AND CAN BE OMITTED.  
## SYNTAX[1]: [HOW (aria2|axel|curl|lftp|wget (default1: present on system (default2: lftp)))]
## SYNTAX[2]: [DO (help|install|manual|purge|refresh|sysinfo (default: install))] 
## SYNTAX[3]: [WHERE (default: arch)]  Install in userspace, not external storage. 
## USAGE[1]: `setupTermuxArch.sh wget sysinfo` shall use wget as the download manager and produce a system information file in the working directory.  This can be abbreviated to `setupTermuxArch.sh ws` and `setupTermuxArch.sh w s`. 
## USAGE[2]: `setupTermuxArch.sh wget manual customdir` shall install the installation in customdir with wget and use manual mode during instalation. 
## USAGE[3]: `setupTermuxArch.sh wget refresh customdir` shall refresh this installation using wget as the download manager. 
## >>>>>>>>>>>>>>>>>>
## >> OPTION  HELP >>
## >>>>>>>>>>>>>>>>>>
## []  Run default Arch Linux install. 
if [[ -z "${1:-}" ]] 
then
	_INTRO_INIT_ 
## [./path/systemimage.tar.gz [customdir]]  Use path to system image file; install directory argument is optional. A systemimage.tar.gz file can be substituted for network install: `setupTermuxArch.sh ./[path/]systemimage.tar.gz` and `setupTermuxArch.sh /absolutepath/systemimage.tar.gz`. 
elif [[ "${ARGS:0:1}" = . ]] 
then
 	echo
 	echo Setting mode to copy system image.
 	lcc="1"
 	lcp="1"
 	_ARG2DIR_ "$@"  
  	_INTRO_INIT_ "$@" 
## [systemimage.tar.gz [customdir]]  Install directory argument is optional.  A systemimage.tar.gz file can substituted for network install.  
# elif [[ "${WDIR}${ARGS}" = *.tar.gz* ]] ; then
elif [[ "$ARGS" = *.tar.gz* ]]
then
	echo
	echo Setting mode to copy system image.
	lcc="1"
	lcp="0"
	_ARG2DIR_ "$@"  
	_INTRO_INIT_ "$@" 
## [axd|axs]  Get device system information with axel.
elif [[ "${1//-}" = [Aa][Xx][Dd]* ]] || [[ "${1//-}" = [Aa][Xx][Ss]* ]] 
then
	echo
	echo Getting device system information with axel.
	dm=axel
	shift
	_ARG2DIR_ "$@" 
	_INTRO_SYSINFO_ "$@" 
## [ax[el] [customdir]|axi [customdir]]  Install Arch Linux with axel.
elif [[ "${1//-}" = [Aa][Xx]* ]] || [[ "${1//-}" = [Aa][Xx][Ii]* ]] ; then
	echo
	echo Setting axel as download manager.
	dm=axel
	_OPT1_ "$@" 
	_INTRO_INIT_ "$@" 
## [ad|as]  Get device system information with aria2.
elif [[ "${1//-}" = [Aa][Dd]* ]] || [[ "${1//-}" = [Aa][Ss]* ]] ; then
	echo
	echo Getting device system information with aria2.
	dm=aria2
	shift
	_ARG2DIR_ "$@" 
	_INTRO_SYSINFO_ "$@" 
## [a[ria2c] [customdir]|ai [customdir]]  Install Arch Linux with aria2.
elif [[ "${1//-}" = [Aa]* ]] ; then
	echo
	echo Setting aria2 as download manager.
	dm=aria2
	_OPT1_ "$@" 
 	_INTRO_INIT_ "$@" 
## [b[loom]]  Create and run a local copy of TermuxArch in TermuxArchBloom.  Useful for running a customized setupTermuxArch.sh locally, for developing and hacking TermuxArch.  
elif [[ "${1//-}" = [Bb]* ]] ; then
	echo
	echo Setting mode to bloom. 
	_INTRO_BLOOM_ "$@"  
## [cd|cs]  Get device system information with curl.
elif [[ "${1//-}" = [Cc][Dd]* ]] || [[ "${1//-}" = [Cc][Ss]* ]] ; then
	echo
	dm=curl
	echo Getting device system information with curl.
	shift
	_ARG2DIR_ "$@" 
	_INTRO_SYSINFO_ "$@" 
## [ci [customdir]]  Install Arch Linux with curl.
elif [[ "${1//-}" = [Cc][Ii]* ]] 
then
	echo
	dm=curl
	echo Setting curl as download manager.
	OPT=install
	echo Setting mode to install.
	_OPT1_ "$@" 
	_INTRO_INIT_ "$@" 
## [c[url] [customdir]]  Install Arch Linux with curl.
elif [[ "${1//-}" = [Cc]* ]] 
then
	echo
	dm=curl
	echo Setting curl as download manager.
	_OPT1_ "$@" 
	_INTRO_INIT_ "$@" 
## [d[ebug]|s[ysinfo]]  Generate system information.
elif [[ "${1//-}" = [Dd]* ]] || [[ "${1//-}" = [Ss]* ]] ; then
	echo 
	echo Setting mode to sysinfo.
	shift
	_ARG2DIR_ "$@" 
	_INTRO_SYSINFO_ "$@" 
## [f[lavors]]  Choose a Linux flavor to install.  THIS OPTION IS UNDER CONSTRUCTION!  
elif [[ "${1//-}" = [Ff]* ]] ; then
	echo 
	echo Setting mode to Linux Flavors.  THIS OPTION IS UNDER CONSTRUCTION!  
	OPT=flavors
	_OPT1_ "$@" 
	_PRINT_INTRO_INIT_
	_CHKIDIR_
	_DEPENDSBLOCK_ "$@" 
	_PRINT_DETECTED_SYSTEM_
	_OPTIONAL_SYSTEMS_ "$@" 
## [he[lp]|?]  Display terse builtin help.
elif [[ "${1//-}" = [Hh][Ee]* ]] || [[ "${1//-}" = [?]* ]] ; then
	_ARG2DIR_ "$@" 
	_PRINT_USAGE_ "$@"  
## [h]  Display verbose builtin help.
elif [[ "${1//-}" = [Hh]* ]] ; then
	lcc="1"
	_ARG2DIR_ "$@" 
	_PRINT_USAGE_ "$@"  
## [i[nstall] [customdir]]  Install Arch Linux in a custom directory.  Instructions: Install in USERSPACE. $HOME is appended to installation directory. To install Arch Linux in $HOME/customdir use `bash setupTermuxArch.sh install customdir`. In bash shell use `./setupTermuxArch.sh install customdir`.  All options can be abbreviated to one, two and three letters.  Hence `./setupTermuxArch.sh install customdir` can be run as `./setupTermuxArch.sh i customdir` in BASH.
elif [[ "${1//-}" = [Ii]* ]] ; then
	echo
	echo Setting mode to install.
	_OPT1_ "$@" 
	_INTRO_INIT_ "$@"  
## [ld|ls]  Get device system information with lftp.
elif [[ "${1//-}" = [Ll][Dd]* ]] || [[ "${1//-}" = [Ll][Ss]* ]] ; then
	echo
	echo Getting device system information with lftp.
	dm=lftp
	shift
	_ARG2DIR_ "$@" 
	_INTRO_SYSINFO_ "$@" 
## [l[ftp] [customdir]]  Install Arch Linux with lftp.
elif [[ "${1//-}" = [Ll]* ]] ; then
	echo
	echo Setting lftp as download manager.
	dm=lftp
	_OPT1_ "$@" 
	_INTRO_INIT_ "$@" 
## [m[anual]]  Manual Arch Linux install, useful for resolving download issues.
elif [[ "${1//-}" = [Mm]* ]] ; then
	echo
	echo Setting mode to manual.
	OPT=manual
	_OPT1_ "$@" 
	_INTRO_INIT_ "$@"  
## [o[ption]]  Option under development.
elif [[ "${1//-}" = [Oo]* ]] ; then
	echo
	echo Setting mode to option.  THIS OPTION IS UNDER CONSTRUCTION!  
	OPT=option
	echo There are no new features being implemented at this time with this option.
	exit 231
# 	OPT=flavors
# 	_OPT1_ "$@" 
# 	_PRINT_INTRO_INIT_
# 	_CHKIDIR_
# 	_DEPENDSBLOCK_ "$@" 
# 	_PRINT_DETECTED_SYSTEM_
# 	_OPTIONAL_SYSTEMS_ "$@" 
## [p[urge] [customdir]]  Remove Arch Linux.
elif [[ "${1//-}" = [Pp]* ]] ; then
	echo 
	echo Setting mode to purge.
	_ARG2DIR_ "$@" 
	_RMARCHQ_
## [ref[resh] [customdir]]  Refresh the Arch Linux in Termux PRoot scripts created by TermuxArch and the installation itself.  Useful for refreshing the installation, keys, locales and the TermuxArch generated scripts to their newest versions.  
elif [[ "${1//-}" = [Rr][Ee][Ff]* ]] ; then
	echo 
	echo Setting mode to refresh.
	_ARG2DIR_ "$@" 
	_INTRO_REFRESH_ "$@"  
## [re [customdir]]  Refresh the Arch Linux in Termux PRoot scripts created by TermuxArch.  Useful for refreshing the TermuxArch generated scripts with user directories to their newest versions.  
elif [[ "${1//-}" = [Rr][Ee]* ]] ; then
	LCR="2"
	echo 
	echo Setting mode to minimal refresh with user directories.
	_ARG2DIR_ "$@" 
	_INTRO_REFRESH_ "$@"  
## [r [customdir]]  Refresh the Arch Linux in Termux PRoot scripts created by TermuxArch.  Useful for refreshing locales and the TermuxArch generated scripts to their newest versions.  
elif [[ "${1//-}" = [Rr]* ]] ; then
	LCR="1"
	printf "\\n\\e[1;32m%s\\e[1;34m: \\e[0;32m%s \`%s\` %s\\n\\e[0m" "Setting mode" "minimal refresh;  Use" "${0##*/} ref[resh]" "for full refresh."
	_ARG2DIR_ "$@" 
	_INTRO_REFRESH_ "$@"  
## [wd|ws]  Get device system information with wget.
elif [[ "${1//-}" = [Ww][Dd]* ]] || [[ "${1//-}" = [Ww][Ss]* ]] ; then
	echo
	echo Getting device system information with wget.
	dm=wget
	shift
	_ARG2DIR_ "$@" 
	_INTRO_SYSINFO_ "$@" 
## [w[get] [customdir]]  Install Arch Linux with wget.
elif [[ "${1//-}" = [Ww]* ]] ; then
	echo
	echo Setting wget as download manager.
	dm=wget
	_OPT1_ "$@" 
	_INTRO_INIT_ "$@"  
else
	_PRINT_USAGE_
fi

# EOF
