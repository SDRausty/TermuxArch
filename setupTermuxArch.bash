#!/usr/bin/env bash
# copyright 2017-2020 (c) by SDRausty, all rights reserved, see LICENSE
# hosting termuxarch.github.io/TermuxArch courtesy pages.github.com
# https://termuxarch.github.io/TermuxArch/CONTRIBUTORS thank you for helping
# command 'setupTermuxArch h[elp]' has information how to use this file
################################################################################
IFS=$'\n\t'
set -Eeuo pipefail
shopt -s nullglob globstar
unset LD_PRELOAD
VERSIONID=2.0.75
## INIT FUNCTIONS ##############################################################
_STRPERROR_() { # run on script error
	local RV="$?"
	printf "\\e[?25h\\n\\e[1;48;5;138m %s\\e[0m\\n" "TermuxArch WARNING:  Generated script signal ${RV:-unknown} near or at line number ${1:-unknown} by '${2:-command}'!"
	if [[ "$RV" = 4 ]]
	then
		printf "\\n\\e[1;48;5;139m %s\\e[0m\\n" "Ensure background data is not restricted.  Check the wireless connection."
	fi
	printf "\\n"
	exit 201
}

_STRPEXIT_() { # run on exit
	local RV="$?"
 	rm -rf "$TAMPDIR"
	sleep 0.04
	if [[ "$RV" = 0 ]]
	then
		printf "\\e[0;32m%s %s \\e[0m$VERSIONID\\e[1;34m: \\e[1;32m%s\\e[0m\\n\\n\\e[0m" "${0##*/}" "$ARGS" "DONE 🏁 "
		printf "\\e]2; %s: %s \\007" "${0##*/} $ARGS" "DONE 🏁 "
	else
		printf "\\e[0;32m%s %s \\e[0m$VERSIONID\\e[1;34m: \\e[1;32m%s %s\\e[0m\\n\\n\\e[0m" "${0##*/}" "$ARGS" "[Exit Signal $RV]" "DONE 🏁 "
		printf "\033]2; %s: %s %s \\007" "${0##*/} $ARGS" "[Exit Signal $RV]" "DONE 🏁 "
	fi
	printf "\\e[?25h\\e[0m"
	set +Eeuo pipefail
	exit
}

_STRPSIGNAL_() { # run on signal
	printf "\\e[?25h\\e[1;7;38;5;0mTermuxArch WARNING:  Signal $? received!\\e[0m\\n"
 	rm -rf "$TAMPDIR"
 	exit 211
}

_STRPQUIT_() { # run on quit
	printf "\\e[?25h\\e[1;7;38;5;0mTermuxArch WARNING:  Quit signal $? received!\\e[0m\\n"
 	exit 221
}

trap '_STRPERROR_ $LINENO $BASH_COMMAND $?' ERR
trap _STRPEXIT_ EXIT
trap _STRPSIGNAL_ HUP INT TERM
trap _STRPQUIT_ QUIT

_ARG2DIR_() {  # argument as ROOTDIR
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

_CHK_() {
	if sha512sum -c termuxarchchecksum.sha512
	then
		printf "\\n"
		_CHKSELF_
		printf "\\e[0;34m%s \\e[1;34m%s \\e[1;32m%s\\e[0m\\n" " 🕛 > 🕜" "TermuxArch $VERSIONID integrity:" "OK"
		_COREFILESLOAD_
	else
		printf "\\n"
		_PRINTSHA512SYSCHKER_
	fi
}

_CHKDWN_() {
	if sha512sum -c setupTermuxArch.sha512 1>/dev/null
	then
		printf "\\e[0;34m%s\\e[1;34m%s\\e[1;32m%s\\n\\n" " 🕛 > 🕐 " "TermuxArch download: " "OK"
		bsdtar -xpf setupTermuxArch.tar.gz
	else
		_PRINTSHA512SYSCHKER_
	fi
}
# compare versions of files setupTermuxArch.{bash,sh} and the newest update
_CHKSELF_() {	# compare file setupTermuxArch.bash and the file being used
	if [[ "$(<$TAMPDIR/setupTermuxArch.bash)" != "$(<$WFILE)" ]] # files differ
	then	# copy the newest version of file setupTermuxArch.bash and update
		cd "${WFILE%/*}"
		if _COREFILES_	# core files are found
		then
			: # do nothing
		else	# unset functions and variables
			unset -f $(grep \_\( "$WFILE"|cut -d"(" -f 1|sort -u|sed ':a;N;$!ba;s/\n/ /g')
			NNVAR="$(grep '="' "$WFILE"|grep -v -e \] -e ARGS -e TAMPDIR -e WFILE|grep -v +|sed 's/declare -a//g'|sed 's/declare//g'|sed 's/export//g'|sed -e "s/[[:space:]]\+//g"|cut -d"=" -f 1|sort -u)"
			for NNSET in $NNVAR
			do
				unset "$NNSET"
			done
			# copy newest version to update working file
			cp "$TAMPDIR/setupTermuxArch.bash" "$WFILE"
 			rm -rf "$TAMPDIR"
			printf "\\e[0;32m%s\\e[1;34m: \\e[1;32mUPDATED\\n\\e[1;32mRESTARTED\\e[1;34m: \\e[0;32m%s %s \\n\\n\\e[0m"  "${0##*/}" "${0##*/}" "$ARGS"
			# restart install with the newest updated version
			. "$WFILE" "$ARGS"
		fi
	fi
	cd "$TAMPDIR"
}

_COREFILES_() {
	[[ -f archlinuxconfig.bash ]] && [[ -f espritfunctions.bash ]] && [[ -f getimagefunctions.bash ]] && [[ -f knownconfigurations.bash ]] && [[ -f maintenanceroutines.bash ]] && [[ -f necessaryfunctions.bash ]] && [[ -f printoutstatements.bash ]] && [[ -f setupTermuxArch.bash ]]
}

_COREFILESDO_() {
	if _COREFILES_
	then
		_COREFILESLOAD_
	else
		cd "$TAMPDIR"
		_DWNL_
		_CHKDWN_
		_CHK_ "$@"
	fi
}

_COREFILESLOAD_() {
	. archlinuxconfig.bash
	. espritfunctions.bash
	. getimagefunctions.bash
	. knownconfigurations.bash
	. maintenanceroutines.bash
	. necessaryfunctions.bash
	. printoutstatements.bash
	if [[ "$OPT" = MANUAL ]]
	then
		_MANUAL_
	fi
	if [[ "$OPT" = BLOOM ]]
	then
		rm -f termuxarchchecksum.sha512
	fi
}

_DEPENDDM_() { # checks and sets download manager
	for PKG in "${!ADM[@]}"
	do
		if [[ -x $(command -v "${ADM[$PKG]}") ]]
		then
 			DM="$PKG"
			printf "\\nFound download tool '%s': Continuing...\\n" "$PKG"
			break
		fi
	done
}

_DEPENDTM_() { # checks and sets tar manager: depreciated
	for PKG in "${!ATM[@]}"
	do
		if [[ -x $(command -v "${ATM[$PKG]}") ]]
		then
 			tm="$PKG"
			printf "\\nFound tar tool '%s': Continuing...\\n" "$PKG"
			break
		fi
	done
}

_DEPENDIFDM_() { # checks if download tool is set and sets install if available
 	for PKG in "${!ADM[@]}" # checks from available toolset and sets one for install if available
	do #	checks for both set DM and if tool exists on device.
 		if [[ "$DM" = "$PKG" ]] && [[ ! -x $(command -v "${ADM[$PKG]}") ]]
		then #	sets both download tool for install and exception check.
 			APTIN+="$PKG "
			printf "\\nSetting download tool '%s' for install: Continuing...\\n" "$PKG"
 		fi
 	done
}

_DEPENDS_() { # checks for missing commands
	printf "\\e[1;34mChecking prerequisites...\\n\\e[1;32m"
	ADM=([aria2]=aria2c [axel]=axel [curl]=curl [lftp]=lftpget [wget]=wget)
	ATM=([bsdtar]=bsdtar)
	if [[ "$DM" != "" ]]
	then
		_DEPENDIFDM_
	fi
	if [[ "$DM" = "" ]]
	then
		_DEPENDDM_
	fi
	# Sets and installs lftp if nothing else was found, installed and set.
	if [[ "$DM" = "" ]]
	then
		DM=lftp
		APTIN+="lftp "
		printf "Setting download tool 'lftp' for install: Continuing...\\n"
	fi
#	# Installs missing commands.
	for PKG in "${PKGS[@]}"
	do
		COMMANDP="$(command -v "$PKG")" || printf "Command %s not found: Continuing...\\n" "$PKG" # test if command exists
		COMMANDPF="${COMMANDP##*/}"
		if [[ "$COMMANDPF" != "$PKG" ]]
		then
			_INPKGS_
		fi
	done
	printf "\\nUsing %s to manage downloads.\\n" "${DM:-lftp}"
	printf "\\n\\e[0;34m 🕛 > 🕧 \\e[1;34mPrerequisites: \\e[1;32mOK  \\e[1;34mDownloading TermuxArch...\\n\\n\\e[0;32m"
}

_DEPENDSBLOCK_() {
	_DEPENDS_ || printf "%s\\n" "signal received _DEPENDS_ _DEPENDSBLOCK_ ${0##*/}"
	if [[ $DIRLCR == 0 ]]
	then
		cd "${WFILE%/*}" 
		_COREFILESDO_
	else
		_COREFILESDO_
	fi
}

_DWNL_() { # download TermuxArch from Github
	if [[ "$DFL" = "/gen" ]]
	then # get development version from:
		FILE[sha]="https://raw.githubusercontent.com/TermuxArch/gensTermuxArch/master/setupTermuxArch.sha512"
		FILE[tar]="https://raw.githubusercontent.com/TermuxArch/gensTermuxArch/master/setupTermuxArch.tar.gz"
	else # get stable version from:
		FILE[sha]="https://raw.githubusercontent.com/TermuxArch/TermuxArch/master/setupTermuxArch.sha512"
		FILE[tar]="https://raw.githubusercontent.com/TermuxArch/TermuxArch/master/setupTermuxArch.tar.gz"
	fi
	if [[ "$DM" = aria2 ]]
	then # use https://github.com/aria2/aria2
		"${ADM[aria2]}" -Z "${FILE[sha]}" "${FILE[tar]}"
	elif [[ "$DM" = axel ]]
	then # use https://github.com/mopp/Axel
		"${ADM[axel]}" -a "${FILE[sha]}"
		"${ADM[axel]}" -a "${FILE[tar]}"
	elif [[ "$DM" = curl ]]
	then # use https://github.com/curl/curl
		"${ADM[curl]}" "$DMVERBOSE" -O {"${FILE[sha]},${FILE[tar]}"}
	elif [[ "$DM" = wget ]]
	then # use https://github.com/mirror/wget
		"${ADM[wget]}" "$DMVERBOSE" -N --show-progress "${FILE[sha]}" "${FILE[tar]}"
	else # use https://github.com/lavv17/lftp
		"${ADM[lftp]}" -c "${FILE[sha]}" "${FILE[tar]}"
	fi
	printf "\\n\\e[1;32m"
}

_INTRO_() {
	printf "\033]2;%s\007" "bash ${0##*/} $ARGS 📲"
	_SETROOT_EXCEPTION_
	if [[ -d "$INSTALLDIR" ]] && [[ -d "$INSTALLDIR"/root/bin ]] && [[ -d "$INSTALLDIR"/var/binds ]] && [[ -f "$INSTALLDIR"/bin/we ]] && [[ -f "$INSTALLDIR"/usr/bin/env ]]
	then
		printf "\\n\\e[0;33m%s\\e[1;33m%s\\e[0;33m.\\e[0m\\n\\n" "TermuxArch WARNING!  " "The root directory structure is correct; Cannot continue ${0##*/} install!  See '${0##*/} help' and '$STARTBIN help' for more information"
		exit 205
	fi
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mＴｅｒｍｕｘＡｒｃｈ %s will attempt to install Linux in \\e[0;32m%s\\e[1;34m.  Arch Linux in Termux PRoot will be available upon successful completion.  To run this BASH script again, use '!!'.  Ensure background data is not restricted.  Check the wireless connection if you do not see one o'clock 🕐 below.  \\e[0;34m" "$VERSIONID" "$INSTALLDIR"
	_DEPENDSBLOCK_ "$@"
	if [[ "$LCC" = "1" ]]
	then
		_LOADIMAGE_ "$@"
	else
		_MAINBLOCK_
	fi
}

_INTROBLOOM_() { # BLOOM = setupTermuxArch manual verbose
	OPT=BLOOM
	printf "\033]2;%s\007" "bash ${0##*/} bloom 📲"
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mＴｅｒｍｕｘＡｒｃｈ $VERSIONID bloom option.  Run \\e[1;32mbash ${0##*/} help \\e[1;34mfor additional information.  Ensure background data is not restricted.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	_PREPTERMUXARCH_
	_DEPENDSBLOCK_ "$@"
	_BLOOM_
}

_INPKGS_() {
	if [[ "$COMMANDIF" = au ]]
	then
		au "${PKGS[@]}" || printf "\\e[1;38;5;117m%s\\e[0m\\n" "$STRING2"
	else
		apt install "${PKGS[@]}" --yes || printf "\\e[1;37;5;116m%s\\e[0m\\n" "$STRING2"
	fi
}

_INTROSYSINFO_() {
	printf "\033]2;%s\007" "bash ${0##*/} sysinfo 📲"
	_SETROOT_EXCEPTION_
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mTermuxArch $VERSIONID will create a system information file.  Ensure background data is not restricted.  Run \\e[0;32mbash ${0##*/} help \\e[1;34mfor additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	_DEPENDSBLOCK_ "$@"
	_SYSINFO_ "$@"
}

_INTROREFRESH_() {
	printf '\033]2;  bash setupTermuxArch.bash refresh 📲 \007'
	_SETROOT_EXCEPTION_
	if [[ ! -d "$INSTALLDIR" ]] || [[ ! -d "$INSTALLDIR"/root/bin ]] || [[ ! -d "$INSTALLDIR"/var/binds ]] || [[ ! -f "$INSTALLDIR"/bin/we ]] || [[ ! -f "$INSTALLDIR"/usr/bin/env ]]
	then
		printf "\\n\\e[0;33m%s\\e[1;33m%s\\e[0;33m.\\e[0m\\n\\n" "ＴｅｒｍｕｘＡｒｃｈ WARNING!  " "The root directory structure is incorrect; Cannot continue ${0##*/} refresh!  See '${0##*/} help' and '$STARTBIN help' for more information"
		if [[ -d "$INSTALLDIR"/tmp ]]
		then	# check for superfluous tmp directory
			DIRCHECK=0
			DIRNAME=(dev etc home opt proc root sys usr var)
			for IDIRNAME in ${DIRNAME[@]}
			do
				if [[ ! -d "$INSTALLDIR/$IDIRNAME" ]]
				then
					DIRCHECK=1
				fi
			done
		fi
		if [[ "$DIRCHECK" -eq 1 ]]
		then	# delete superfluous tmp dir
			rm -rf "$INSTALLDIR"/tmp
			rm -rf "$INSTALLDIR"
		fi
		exit 204
	fi
	printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mＴｅｒｍｕｘＡｒｃｈ $VERSIONID will refresh your TermuxArch files in \\e[0;32m~/${INSTALLDIR##*/}\\e[1;34m.  Ensure background data is not restricted.  Run \\e[0;32mbash ${0##*/} help \\e[1;34mfor additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	_DEPENDSBLOCK_ "$@"
	_REFRESHSYS_ "$@"
}

_LOADCONF_() {
	if [[ -f "${WDIR}setupTermuxArchConfigs.bash" ]]
	then
		. "${WDIR}setupTermuxArchConfigs.bash"
		_PRINTCONFLOADED_
	else
		. knownconfigurations.bash
	fi
}

_MANUAL_() {
	printf '\033]2; bash setupTermuxArch.bash manual 📲 \007'
	_EDITORS_
	if [[ -f "${WDIR}setupTermuxArchConfigs.bash" ]]
	then
		"$ed" "${WDIR}setupTermuxArchConfigs.bash"
		_LOADCONF_
	else
		cp knownconfigurations.bash "${WDIR}setupTermuxArchConfigs.bash"
 		sed -i "7s/.*/\# The architecture of this device is $CPUABI; Adjust configurations in the appropriate section.  Change CMIRROR (https:\/\/wiki.archlinux.org\/index.php\/Mirrors and https:\/\/archlinuxarm.org\/about\/mirrors) to desired geographic location to resolve 404 and checksum issues.  /" "${WDIR}setupTermuxArchConfigs.bash"
		"$ed" "${WDIR}setupTermuxArchConfigs.bash"
		. "${WDIR}setupTermuxArchConfigs.bash"
		_PRINTCONFLOADED_
	fi
}

_NAMEINSTALLDIR_() {
	if [[ "$ROOTDIR" = "" ]]
	then
		ROOTDIR=arch
	fi
	INSTALLDIR="$(printf "%s\\n" "$HOME/${ROOTDIR%/}" | sed 's#//*#/#g')"
}

_NAMESTARTARCH_() {
 	DARCH="$(printf "%s\\n" "${ROOTDIR%/}" | sed 's#//*#/#g')" # ${@%/} removes trailing slash
	if [[ "$DARCH" = "/arch" ]]
	then
		AARCH=""
		STARTBI2=arch
	else
 		AARCH="$(printf "%s\\n" "$DARCH" | sed 's/\//\+/g')"
		STARTBI2=arch
	fi
	declare -g STARTBIN=start"$STARTBI2$AARCH"
}

_OPT1_() {
	if [[ -z "${2:-}" ]]
	then
		_ARG2DIR_ "$@"
	elif [[ "$2" = [Bb]* ]]
	then
		printf "%s\\n" "Setting mode to bloom."
		_INTROBLOOM_ "$@"
	elif [[ "$2" = [Dd]* ]] || [[ "$2" = [Ss]* ]]
	then
		printf "%s\\n" "Setting mode to sysinfo."
		shift
		_ARG2DIR_ "$@"
		_INTROSYSINFO_ "$@"
	elif [[ "$2" = [Ii]* ]]
	then
		printf "%s\\n" "Setting mode to install."
		shift
		_ARG2DIR_ "$@"
	elif [[ "$2" = [Mm]* ]]
	then
		printf "%s\\n" "Setting mode to manual."
		OPT=MANUAL
 		_OPT2_ "$@"
	elif [[ "$2" = [Rr][Ee][Ff]* ]]
	then
		printf "\\n%s\\n" "Setting mode to refresh."
		shift
		_ARG2DIR_ "$@"
		_INTROREFRESH_ "$@"
	elif [[ "$2" = [Rr][Ee]* ]]
	then
		export LCR="2"
		printf "\\n%s\\n" "Setting mode to minimal refresh and refresh user directories."
		shift
		_ARG2DIR_ "$@"
		_INTROREFRESH_ "$@"
	elif [[ "$2" = [Rr]* ]]
	then
		export LCR="1"
		printf "\\n\\e[1;32m%s\\e[1;34m: \\e[0;32m%s '%s' %s\\n\\e[0m" "Setting mode" "minimal refresh;  Use" "${0##*/} re[fresh]" "for full refresh."
		shift
		_ARG2DIR_ "$@"
		_INTROREFRESH_ "$@"
	else
		_ARG2DIR_ "$@"
	fi
}

_OPT2_() {
	if [[ -z "${3:-}" ]]
	then
		shift
		_ARG2DIR_ "$@"
		_INTRO_ "$@"
	elif [[ "$3" = [Ii]* ]]
	then
		printf "%s\\n" "Setting mode to install."
		shift 2
		_ARG2DIR_ "$@"
		_INTRO_ "$@"
	elif [[ "$3" = [Rr][Ee][Ff]* ]]
	then
		printf "\\n%s\\n" "Setting mode to refresh."
		_ARG2DIR_ "$@"
		_INTROREFRESH_ "$@"
	elif [[ "$3" = [Rr][Ee]* ]]
	then
		export LCR="2"
		printf "\\n%s\\n" "Setting mode to minimal refresh and refresh user directories."
		shift 2
		_ARG2DIR_ "$@"
		_INTROREFRESH_ "$@"
	elif [[ "$3" = [Rr]* ]]
	then
		export LCR="1"
		printf "\\n\\e[1;32m%s\\e[1;34m: \\e[0;32m%s '%s' %s\\n\\e[0m" "Setting mode" "minimal refresh;  Use" "${0##*/} re[fresh]" "for full refresh."
		shift 2
		_ARG2DIR_ "$@"
		_INTROREFRESH_ "$@"
	else
		shift
		_ARG2DIR_ "$@"
		_INTRO_ "$@"
	fi
}

_PREPTMPDIR_() {
	[[ ! -d "$INSTALLDIR/tmp" ]] && mkdir -p "$INSTALLDIR/tmp" && chmod 777 "$INSTALLDIR/tmp" && chmod +t "$INSTALLDIR/tmp"
 	TAMPDIR="$INSTALLDIR/tmp/setupTermuxArch$$"
	[[ ! -d "$TAMPDIR" ]] && mkdir -p "$TAMPDIR"
}

_PREPTERMUXARCH_() {
	_NAMEINSTALLDIR_
	_NAMESTARTARCH_
	_PREPTMPDIR_ || printf "%s\\n" "signal received _PREPTMPDIR_ _PREPTERMUXARCH_ ${0##*/}"
}

_PRINTCONFLOADED_() {
	printf "\\n\\e[0;34m%s \\e[1;34m%s \\e[0;32m%s\\e[1;32m%s \\e[1;34m%s \\e[1;32m%s\\n" " 🕛 > 🕑" "TermuxArch configuration" "$WDIR" "setupTermuxArchConfigs.bash" "loaded:" "OK"
}

_PRINTSHA512SYSCHKER_() {
	printf "\\n\\e[07;1m\\e[31;1m\\n%s \\e[34;1m\\e[30;1m%s \\n\\e[0;0m\\n" " 🔆 WARNING sha512sum mismatch!  Setup initialization mismatch!" "  Try again, initialization was not successful this time.  Wait a little while.  Then run 'bash setupTermuxArch.bash' again..."
	printf '\033]2; Run bash setupTermuxArch.bash %s again...\007' "$ARGS"
	exit
}

_PRINTSTARTBIN_USAGE_() {
	printf "\\e[1;38;5;155m"
 	_NAMESTARTARCH_
	if [[ -x "$(command -v "$STARTBIN")" ]]
	then
		printf "%s\\n" "$STARTBIN help"
		"$STARTBIN" help
	fi
}

_PRINTUSAGE_() {
	printf "\\n\\e[1;32m %s     \\e[1;32m%s \\e[0;32m%s\\n" "HELP" "${0##*/} help" "will output the help screen."
	printf "\\n\\e[1;32m %s    \\e[1;32m%s \\e[0;32m%s\\n" "TERSE" "${0##*/} he[lp]" "will output the terse help screen."
	printf "\\n\\e[1;32m %s  \\e[1;32m%s \\e[0;32m%s\\n" "VERBOSE" "${0##*/} h" "will output the verbose help screen."
	printf "\\n\\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\n\\n%s \\e[1;32m%s\\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s\\e[0;32m%s\\n" "Usage information for" "${0##*/}" "$VERSIONID.  Arguments can abbreviated to one, two and three letters each; Two and three letter arguments are acceptable.  For example," "bash ${0##*/} cs" "will use" "curl" "to download TermuxArch and produce a" "setupTermuxArchSysInfo$STIME.log" "system information file." "User configurable variables are in" "setupTermuxArchConfigs.bash" ".  To create this file from" "kownconfigurations.bash" "in the working directory, run" "bash ${0##*/} manual" "to create and edit" "setupTermuxArchConfigs.bash" "."
	printf "\\n\\e[1;32m %s\\e[0;32m  %s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s\\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s \\e[0;32m%s\\n" "INSTALL" "Run" "./${0##*/}" "without arguments in a bash shell to install Arch Linux in Termux.  " "bash ${0##*/} curl" "will envoke" "curl" "as the download manager.  Copy" "knownconfigurations.bash" "to" "setupTermuxArchConfigs.bash" "with" "bash ${0##*/} manual" "to edit preferred CMIRROR site and to access more options.  After editing" "setupTermuxArchConfigs.bash" ", run" "bash ${0##*/}" "and" "setupTermuxArchConfigs.bash" "loads automatically from the working directory.  Change CMIRROR to desired geographic location to resolve download errors."
 	printf "\\n\\e[1;32m %s    \\e[1;32m%s \\e[0;32m%s\\n" "PURGE" "${0##*/} purge" "will uninstall Arch Linux from Termux."
	printf "\\n\\e[1;32m %s  \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s \\e[0;32m%s \\e[1;32m%s\\e[0;32m%s \\n\\n" "SYSINFO" "${0##*/} sysinfo" "will create file" "setupTermuxArchSysInfo$STIME.log" "and populate it with system information.  Post this file along with detailed information at" "https://github.com/TermuxArch/TermuxArch/issues" ".  If screenshots will help in resolving an issue better, include these along with information from the system information log file in a post as well."
	if [[ "$LCC" = 1 ]]
	then
	printf "\\n\\e[1;38;5;150m"
	awk 'NR>=600 && NR<=900'  "${0##*/}" | awk '$1 == "##"' | awk '{ $1 = ""; print }' | awk '1;{print ""}'
	fi
	printf "\\n"
	_PRINTSTARTBIN_USAGE_
}

_RMARCH_() {
	_NAMESTARTARCH_
	_NAMEINSTALLDIR_
	while true; do
		printf "\\n\\e[1;30m"
		read -n 1 -p "Uninstall $INSTALLDIR? [Y|n] " RUANSWER
		if [[ "$RUANSWER" = [Ee]* ]] || [[ "$RUANSWER" = [Nn]* ]] || [[ "$RUANSWER" = [Qq]* ]]
		then
			break
		elif [[ "$RUANSWER" = [Yy]* ]] || [[ "$RUANSWER" = "" ]]
		then
			printf "\\e[30mUninstalling $INSTALLDIR...\\n"
			if [[ -e "$PREFIX/bin/$STARTBIN" ]]
			then
				rm -f "$PREFIX/bin/$STARTBIN"
			else
				printf "Uninstalling $PREFIX/bin/$STARTBIN: nothing to do for $PREFIX/bin/$STARTBIN.\\n"
			fi
			if [[ -e "$HOME/bin/$STARTBIN" ]]
			then
				rm -f "$HOME/bin/$STARTBIN"
			else
				printf "Uninstalling $HOME/bin/$STARTBIN: nothing to do for $HOME/bin/$STARTBIN.\\n"
			fi
			if [[ -d "$INSTALLDIR" ]]
			then
				_RMARCHRM_
			else
				printf "Uninstalling $INSTALLDIR: nothing to do for $INSTALLDIR.\\n"
			fi
			printf "Uninstalling $INSTALLDIR: \\e[1;32mDone\\n\\e[30m"
			break
		else
			printf "\\nYou answered \\e[33;1m$RUANSWER\\e[30m.\\n\\nAnswer \\e[32mYes\\e[30m or \\e[1;31mNo\\e[30m. [\\e[32my\\e[30m|\\e[1;31mn\\e[30m]\\n"
		fi
	done
	printf "\\e[0m\\n"
}

_RMARCHRM_() {
	_SETROOT_EXCEPTION_
	rm -rf "${INSTALLDIR:?}"/* 2>/dev/null ||:
	find  "$INSTALLDIR" -type d -exec chmod 700 {} \; 2>/dev/null ||:
	rm -rf "$INSTALLDIR" 2>/dev/null ||:
}

_RMARCHQ_() {
	if [[ -d "$INSTALLDIR" ]]
	then
		printf "\\n\\e[0;33m %s \\e[1;33m%s \\e[0;33m%s\\n\\n\\e[1;30m%s\\n" "TermuxArch:" "DIRECTORY WARNING!  $INSTALLDIR/" "directory detected." "Purge $INSTALLDIR as requested?"
		_RMARCH_
	fi
}

_SETROOT_EXCEPTION_() {
	if [[ "$INSTALLDIR" = "$HOME" ]] || [[ "$INSTALLDIR" = "$HOME"/ ]] || [[ "$INSTALLDIR" = "$HOME"/.. ]] || [[ "$INSTALLDIR" = "$HOME"/../ ]] || [[ "$INSTALLDIR" = "$HOME"/../.. ]] || [[ "$INSTALLDIR" = "$HOME"/../../ ]]
	then
		printf  '\033]2;%s\007' "Rootdir exception.  Run bash setupTermuxArch.bash $ARGS again with different options..."
		printf "\\n\\e[1;31m%s\\n\\n\\e[0m" "Rootdir exception.  Run the script $ARGS again with different options..."
		exit
	fi
}

## User Information:  Configurable variables such as mirrors and download manager options are in 'setupTermuxArchConfigs.bash'.  Working with 'kownconfigurations.bash' in the working directory is simple.  'bash setupTermuxArch.bash manual' will create 'setupTermuxArchConfigs.bash' in the working directory for editing; See 'setupTermuxArch.bash help' for more information.
declare -A ADM		## Declare associative array for all available download tools.
declare -A ATM		## Declare associative array for all available tar tools.
declare -a ARGS="$@"	## Declare arguments as string.
declare APTIN=""	## apt install string
declare COMMANDIF=""
declare COMMANDR
declare COMMANDG=""
declare STRING1
declare STRING2
declare CPUABI=""
declare CPUABI5="armeabi"	## Used for development;  The command 'getprop ro.product.cpu.abi' can be used to ascertain the device architecture.  Matching an alternate CPUABI* will install an alternate architecture on device.  The original device architecture must be changed to something else so it does not match.  This is usefull with QEMU to install and run alternate architectures on device.
declare CPUABI7="armeabi-v7a"	## Used for development.
declare CPUABI8="arm64-v8a"	## Used for development.
declare CPUABIX86="x86"		## Used for development.
declare CPUABIX86_64="x86_64"	## Used for development.
declare DFL=""		## Used for development.
declare DMVERBOSE="-q"	## -v for verbose download manager output from curl and wget;  for verbose output throughout runtime also change in 'setupTermuxArchConfigs.bash' when using 'setupTermuxArch.bash m[anual]'.
declare ed=""
declare DIRLCR=""
declare DM=""
declare FSTND=""
declare -A FILE
declare INSTALLDIR=""
declare LCC=""
declare LCP=""
declare OPT=""
declare ROOTDIR=""
declare WFILE=""
declare WDIR=""
declare STI=""		## Generates pseudo random number.
declare STIME=""	## Generates pseudo random number.
if [[ -z "${TAMPDIR:-}" ]]
then
	TAMPDIR=""
fi
ROOTDIR=/arch
STRING1="COMMAND 'au' enables rollback, available at https://wae.github.io/au/ IS NOT FOUND: Continuing... "
STRING2="Cannot update 'setupTermuxArch.bash' prerequisite: Continuing..."
## TERMUXARCH FEATURES INCLUDE:
## 1) Creates aliases and commands which aid in using the command line, and also help to access more advanced features easily.  The HOME and HOME/bin directories have more details about this feature.
## 2) Sets timezone and locales from device,
## 3) Tests for correct OS,
COMMANDG="$(command -v getprop)" ||:
if [[ "$COMMANDG" = "" ]]
then
	printf "\\n\\e[1;48;5;138m %s\\e[0m\\n\\n" "TermuxArch WARNING: Run 'bash ${0##*/}' and './${0##*/}' from the BASH shell in in Termux: exiting..."
	exit
fi
COMMANDR="$(command -v au)" || COMMANDR="$(command -v apt)"
COMMANDIF="${COMMANDR##*/}"
## 4) Generates pseudo random number to create uniq strings,
if [[ -r  /proc/sys/kernel/random/uuid ]]
then
	STIME="$(cat /proc/sys/kernel/random/uuid)"
	STIME="${STIME//-}"
	STIME="${STIME:0:3}"
else
	STIME="$(date +%s)"
	STIME="$(printf "%s" "${STIME:7:4}" | rev)"
fi
ONESA="$(date +%s)"
ONESA="${ONESA: -1}"
PKGS=(bsdtar proot)
STIME="$ONESA$STIME"
## 5) Gets device information via 'getprop',
CPUABI="$(getprop ro.product.cpu.abi)"
SYSVER="$(getprop ro.build.version.release)"
NASVER="$(getprop net.bt.name ) $SYSVER"
WDIR="$PWD/"
WFILE="$0"
[[ "${WFILE%/*}" != "$WDIR" ]] && [[ "${WFILE%/*}" != "${0##*/}" ]] && DIRLCR=0
## 6) And all options are optional for install.
## THESE OPTIONS ARE AVAILABLE FOR YOUR CONVENIENCE:
## DEFAULTS ARE IMPLIED AND CAN BE OMITTED.
## GRAMMAR[a]: 'setupTermuxArch.bash [HOW] [DO] [WHERE]'
## OPTIONS[a]: 'setupTermuxArch.bash [HOW] [DO] [WHERE]'
## SYNTAX[1]: [HOW (aria2|axel|curl|lftp|wget (default1: present on system (default2: lftp)))]
## SYNTAX[2]: [DO (help|install|manual|purge|refresh|sysinfo (default: install))]
## SYNTAX[3]: [WHERE (default: arch)]  Install in userspace, not external storage.
## GRAMMAR[b]: 'setupTermuxArch.bash [WHAT] [WHERE]'
## OPTIONS[b]: 'setupTermuxArch.bash [~/|./|/absolute/path/]image.tar.gz [WHERE]'
## USAGE[1]: 'setupTermuxArch.bash wget sysinfo' will use wget as the download manager and produce a system information file in the working directory.  This can be abbreviated to 'setupTermuxArch.bash ws' and 'setupTermuxArch.bash w s'.
## USAGE[2]: 'setupTermuxArch.bash wget manual customdir' will install the installation in customdir with wget and use manual mode during instalation.
## USAGE[3]: 'setupTermuxArch.bash wget refresh customdir' will refresh this installation using wget as the download manager.
## >>>>>>>>>>>>>>>>>>
## >> OPTION  HELP >>
## >>>>>>>>>>>>>>>>>>
## []  Run default Arch Linux install.
if [[ -z "${1:-}" ]]
then
	_PREPTERMUXARCH_
	_INTRO_ "$@"
## [./path/systemimage.tar.gz [customdir]]  Install directory argument is optional.  Network install can be substituted by copying systemimage.tar.gz and systemimage.tar.gz.md5 files with 'setupTermuxArch.bash ./[path/]systemimage.tar.gz' and 'setupTermuxArch.bash /absolutepath/systemimage.tar.gz'.
elif [[ "${ARGS:0:1}" = . ]]
then
 	printf "\\n%s\\n" "Setting mode to copy system image."
 	GFILE="$1"
 	LCC="1"
 	LCP="1"
 	_ARG2DIR_ "$@"
 	_INTRO_ "$@"
## [systemimage.tar.gz [customdir]]  Install directory argument is optional.  Network install can be substituted by copying systemimage.tar.gz and systemimage.tar.gz.md5 files with 'setupTermuxArch.bash systemimage.tar.gz'.
elif [[ "$ARGS" = *.tar.gz* ]]
then
 	printf "\\n%s\\n" "Setting mode to copy system image."
 	GFILE="$1"
	LCC="1"
	LCP="0"
	_ARG2DIR_ "$@"
	_INTRO_ "$@"
## [axd|axs]  Get device system information with 'axel'.
elif [[ "${1//-}" = [Aa][Xx][Dd]* ]] || [[ "${1//-}" = [Aa][Xx][Ss]* ]]
then
	printf "\\nGetting device system information with 'axel'.\\n"
	DM=axel
	shift
	_ARG2DIR_ "$@"
	_INTROSYSINFO_ "$@"
## [ax[el] [customdir]|axi [customdir]]  Install Arch Linux with 'axel'.
elif [[ "${1//-}" = [Aa][Xx]* ]] || [[ "${1//-}" = [Aa][Xx][Ii]* ]]
then
	printf "\\nSetting 'axel' as download manager.\\n"
	DM=axel
	_OPT1_ "$@"
	_INTRO_ "$@"
## [ad|as]  Get device system information with 'aria2c'.
elif [[ "${1//-}" = [Aa][Dd]* ]] || [[ "${1//-}" = [Aa][Ss]* ]]
then
	printf "\\nGetting device system information with 'aria2c'.\\n"
	DM=aria2
	shift
	_ARG2DIR_ "$@"
	_INTROSYSINFO_ "$@"
## [a[ria2c] [customdir]|ai [customdir]]  Install Arch Linux with 'aria2c'.
elif [[ "${1//-}" = [Aa]* ]]
then
	printf "\\nSetting 'aria2c' as download manager.\\n"
	DM=aria2
	_OPT1_ "$@"
	_INTRO_ "$@"
## [b[loom]]  Create and run a local copy of TermuxArch in TermuxArchBloom.  Useful for running a customized setupTermuxArch.bash locally, for developing and hacking TermuxArch.
elif [[ "${1//-}" = [Bb]* ]]
then
	printf "\\nSetting mode to bloom. \\n"
	_INTROBLOOM_ "$@"
## [cd|cs]  Get device system information with 'curl'.
elif [[ "${1//-}" = [Cc][Dd]* ]] || [[ "${1//-}" = [Cc][Ss]* ]]
then
	printf "\\nGetting device system information with 'curl'.\\n"
	DM=curl
	shift
	_ARG2DIR_ "$@"
	_INTROSYSINFO_ "$@"
## [c[url] [customdir]|ci [customdir]]  Install Arch Linux with 'curl'.
elif [[ "${1//-}" = [Cc][Ii]* ]] || [[ "${1//-}" = [Cc]* ]]
then
	printf "\\nSetting 'curl' as download manager.\\n"
	DM=curl
	_OPT1_ "$@"
	_INTRO_ "$@"
## [d[ebug]|s[ysinfo]]  Generate system information.
elif [[ "${1//-}" = [Dd]* ]] || [[ "${1//-}" = [Ss]* ]]
then
	printf "\\nSetting mode to sysinfo.\\n"
	shift
	_ARG2DIR_ "$@"
	_INTROSYSINFO_ "$@"
## [he[lp]|?]  Display terse builtin help.
elif [[ "${1//-}" = [Hh][Ee]* ]] || [[ "${1//-}" = [?]* ]]
then
	_ARG2DIR_ "$@"
	_PRINTUSAGE_ "$@"
## [h]  Display verbose builtin help.
elif [[ "${1//-}" = [Hh]* ]]
then
	LCC="1"
	_ARG2DIR_ "$@"
	_PRINTUSAGE_ "$@"
## [i[nstall] [customdir]]  Install Arch Linux in a custom directory.  Instructions: Install in userspace.  The HOME directory is appended to the installation directory.  To install Arch Linux in HOME/customdir use 'bash setupTermuxArch.bash install customdir'.  In the BASH shell you can use './setupTermuxArch.bash install customdir'.  All options can be abbreviated to one, two and three letters.  Hence './setupTermuxArch.bash install customdir' can be run as './setupTermuxArch.bash i customdir' in BASH.
elif [[ "${1//-}" = [Ii]* ]]
then
	printf "\\nSetting mode to install.\\n"
	_OPT1_ "$@"
	_INTRO_ "$@"
## [ld|ls]  Get device system information with 'lftp'.
elif [[ "${1//-}" = [Ll][Dd]* ]] || [[ "${1//-}" = [Ll][Ss]* ]]
then
	printf "\\nGetting device system information with 'lftp'.\\n"
	DM=lftp
	shift
	_ARG2DIR_ "$@"
	_INTROSYSINFO_ "$@"
## [l[ftp] [customdir]]  Install Arch Linux with 'lftp'.
elif [[ "${1//-}" = [Ll]* ]]
then
	printf "\\nSetting 'lftp' as download manager.\\n"
	DM=lftp
	_OPT1_ "$@"
	_INTRO_ "$@"
## [m[anual]]  Manual Arch Linux install, useful for resolving download issues.
elif [[ "${1//-}" = [Mm]* ]]
then
	printf "\\nSetting mode to manual.\\n"
	OPT=MANUAL
	_OPT1_ "$@"
	_INTRO_ "$@"
## [o[ption]]  Option under development.
elif [[ "${1//-}" = [Oo]* ]]
then
	printf "\\nSetting mode to option.\\n"
	LCC="1"
	_PRINTUSAGE_ "$@"
## [p[urge] [customdir]]  Remove Arch Linux.
elif [[ "${1//-}" = [Pp]* ]]
then
	printf "\\nSetting mode to purge.\\n"
	_ARG2DIR_ "$@"
	_RMARCHQ_
## [ref[resh] [customdir]]  Refresh the Arch Linux in Termux PRoot scripts created by TermuxArch and the installation itself.  Useful for refreshing the installation, the root user's home directory, user home directories and the TermuxArch generated scripts to their newest version and also runs keys and generates locales.
elif [[ "${1//-}" = [Rr][Ee][Ff]* ]]
then
	printf "\\nSetting mode to refresh.\\n"
	_ARG2DIR_ "$@"
	_INTROREFRESH_ "$@"
## [re [customdir]]  Refresh the Arch Linux in Termux PRoot scripts created by TermuxArch.  Useful for refreshing the root user's home directory and user home directories and the TermuxArch generated scripts to their newest version.
elif [[ "${1//-}" = [Rr][Ee] ]]
then
	export LCR="2"
	printf "\\nSetting mode to minimal refresh and refresh user directories.\\n"
	_ARG2DIR_ "$@"
	_INTROREFRESH_ "$@"
## [r [customdir]]  Refresh the Arch Linux in Termux PRoot scripts created by TermuxArch.  Useful for refreshing the root user's home directory and the TermuxArch generated scripts to their newest version.
elif [[ "${1//-}" = [Rr] ]]
then
	export LCR="1"
	printf "\\n\\e[1;32m%s\\e[1;34m: \\e[0;32m%s '%s' %s\\n\\e[0m" "Setting mode" "minimal refresh;  Use" "${0##*/} re[fresh]" "for full refresh."
	_ARG2DIR_ "$@"
	_INTROREFRESH_ "$@"
## [wd|ws]  Get device system information with 'wget'.
elif [[ "${1//-}" = [Ww][Dd]* ]] || [[ "${1//-}" = [Ww][Ss]* ]]
then
	printf "\\nGetting device system information with 'wget'.\\n"
	DM=wget
	shift
	_ARG2DIR_ "$@"
	_INTROSYSINFO_ "$@"
## [w[get] [customdir]]  Install Arch Linux with 'wget'.
elif [[ "${1//-}" = [Ww]* ]]
then
	printf "\\nSetting 'wget' as download manager.\\n"
	DM=wget
	_OPT1_ "$@"
	_INTRO_ "$@"
else
	_PRINTUSAGE_
fi
## File 'updateTermuxArch.bash' will execute 'git pull' and populate git repository modules, and file 'updateTermuxArch.bash' can also be run directly in a PRoot environment.  File 'updateTermuxArch.bash's functions are not related to unrelated updating functions run by commands 'setupTermuxArch r[e[fresh]]' which have completely different update functions.
## Files 'setupTermuxArch{.bash,.sh}' are held for backward compatibility;  Please reference file 'setupTermuxArch' as the chosen install file if help be through sharing insight about this Arch Linux in a Termux PRoot container project which can be used on a smartphone.  File 'setupTermuxArch' is the earmarked install file name for this project.  File 'setupTermuxArch' downloads as file 'setupTermuxArch.bin' through the Internet browsers into the Android Downloads folder on smartphone, and can be directly installed from there with this command 'bash ~/storage/downloads/setupTermuxArch' which will also checks if there is a newer version since the time it was download.
# The name of file 'setupTermuxArch' in the EOF line at the end of this file is to assist scripts 'setupTermuxArch[.{bash,bin,sh}]' when if they selfupdate to the latest version when the user runs them.  These files will not selfupdate to the most recent version published if they are used inside their git repository;  In this case 'git pull' or 'updateTermuxArch.bash' can be employed to update to the newest published version:
## A very hardy thank you to contributors who are helping to make this open source project better!  Thank you very much!
# setupTermuxArch EOF
