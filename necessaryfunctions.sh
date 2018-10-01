#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project. 
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# _STANDARD_="function name" && STANDARD="variable name" are under construction.
################################################################################

LC_TYPE=( "LANG" "LANGUAGE" "LC_ADDRESS" "LC_COLLATE" "LC_CTYPE" "LC_IDENTIFICATION" "LC_MEASUREMENT" "LC_MESSAGES" "LC_MONETARY" "LC_NAME" "LC_NUMERIC" "LC_PAPER" "LC_TELEPHONE" "LC_TIME" )

_ADDADDS_() {
	addREADME
	addae
	addauser
	addbash_logout 
	addbash_profile 
	addbashrc 
	addcdtd
	addcdth
	addcdtmp
	addch 
	adddfa
	addfbindexample
	addbinds
	addexd
	addfibs
	addga
	addgcl
	addgcm
	addgp
	addgpl
	addkeys
	addmotd
	addmoto
	addpc
	addpci
	addpcs
	addpcss
	addprofile 
	addresolvconf 
	addt 
	addtour
	addtrim 
	addyt
	addwe  
	addv 
}
	
_CALLSYSTEM_() {
	declare COUNTER=""
	if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX86_64" ]];then
		_GETIMAGE_
	else
		if [[ "$CMIRROR" = "os.archlinuxarm.org" ]] || [[ "$CMIRROR" = "mirror.archlinuxarm.org" ]]; then
			until _FTCHSTND_;do
				_FTCHSTND_ ||: 
				sleep 2
				printf "\\n"
				COUNTER=$((COUNTER + 1))
				if [[ "$COUNTER" = 4 ]];then 
					_PRINTMAX_ 
					exit
				fi
			done
		else
			_FTCHIT_
		fi
	fi
}

_COPYSTARTBIN2PATH_() {
	if [[ ":$PATH:" == *":$HOME/bin:"* ]] && [[ -d "$HOME"/bin ]]; then
		BPATH="$HOME"/bin
	else
		BPATH="$PREFIX"/bin
	fi
	cp "$INSTALLDIR/$STARTBIN" "$BPATH"
	printf "\\e[0;34m 🕛 > 🕦 \\e[1;32m$STARTBIN \\e[0mcopied to \\e[1m$BPATH\\e[0m.\\n\\n"
}

_DETECTSYSTEM_() {
	_PRINTDETECTEDSYSTEM_
	if [[ "$CPUABI" = "$CPUABI5" ]];then
		_ARMV5L_
	elif [[ "$CPUABI" = "$CPUABI7" ]];then
		_DETECTSYSTEM2_ 
	elif [[ "$CPUABI" = "$CPUABI8" ]];then
		_AARCH64_
	elif [[ "$CPUABI" = "$CPUABIX86" ]];then
		_I686_ 
	elif [[ "$CPUABI" = "$CPUABIX86_64" ]];then
		_X86_64_
	else
		_PRINTMISMATCH_ 
	fi
}

_DETECTSYSTEM2_() {
	if [[ "$(getprop ro.product.device)" == *_cheets ]];then
		armv7lChrome 
	else
		armv7lAndroid  
	fi
}

_KERNID_() {
	declare KID=""
	ur="$("$PREFIX"/bin/applets/uname -r)"
	declare -i KERNEL_VERSION="$(echo "$ur" |awk -F'.' '{print $1}')"
	declare -i MAJOR_REVISION="$(echo "$ur" |awk -F'.' '{print $2}')"
	declare -- TMP="$(echo "$ur" |awk -F'.' '{print $3}')"
	declare -- MINOR_REVISION="$(echo "${TMP:0:3}" |sed 's/[^0-9]*//g')"
	if [[ "$KERNEL_VERSION" -le 2 ]]; then
		KID=1
	else
		if [[ "$KERNEL_VERSION" -eq 3 ]]; then
			if [[ "$MAJOR_REVISION" -lt 2 ]]; then
				KID=1
			else
				if [[ "$MAJOR_REVISION" -eq 2 ]] && [[ "$MINOR_REVISION" -eq 0 ]]; then
					KID=1
				fi
			fi
		fi
	fi
}

_KERNID_ 

_MAINBLOCK_() { 
	_NAMESTARTARCH_ 
	_SPACEINFO_
	_PREPINSTALLDIR_
	_DETECTSYSTEM_ 
	_WAKEUNLOCK_ 
	_PRINTFOOTER_
	set +Eeuo pipefail
	"$INSTALLDIR/$STARTBIN" ||:
	set -Eeuo pipefail
	_PRINTSTARTBIN_USAGE_
	_PRINTFOOTER2_
	printf "\\n"
}

_MAKEFINISHSETUP_() {
	BINFNSTP=finishsetup.sh  
	_CFLHDR_ root/bin/"$BINFNSTP"
	if [[ -e "$HOME"/.bash_profile ]];then
		grep "proxy" "$HOME"/.bash_profile | grep "export" >> root/bin/"$BINFNSTP" 2>/dev/null ||:
	fi
	if [[ -e "$HOME"/.bashrc ]];then
		grep "proxy" "$HOME"/.bashrc  | grep "export" >> root/bin/"$BINFNSTP" 2>/dev/null ||:
	fi
	if [[ -e "$HOME"/.profile ]];then
		grep "proxy" "$HOME"/.profile | grep "export" >> root/bin/"$BINFNSTP" 2>/dev/null ||:
	fi
	if [[ "${LCR:-}" != 2 ]]
	then
		cat >> root/bin/"$BINFNSTP" <<- EOM
		printf "\\n\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n\\e[1;32m%s\\e[0;32m" "To generate locales in a preferred language use " "Settings > Language & Keyboard > Language " "in Android; Then run " "${0##*/} r " "for a quick system refresh; For full system refresh use ${0##*/} refresh." "==> " 
		locale-gen ||: 
		EOM
	fi
	if [[ -z "${LCR:-}" ]] 
	then
		cat >> root/bin/"$BINFNSTP" <<- EOM
		printf "\\n\\e[1;34m:: \\e[1;37mRemoving redundant packages for Termux PRoot installation…\\n" 
		EOM
		if [[ "$CPUABI" = "$CPUABI5" ]]
		then
			printf "pacman -Rc linux-armv5 linux-firmware --noconfirm --color=always 2>/dev/null ||:\\n" >> root/bin/"$BINFNSTP"
		elif [[ "$CPUABI" = "$CPUABI7" ]]
		then
			printf "pacman -Rc linux-armv7 linux-firmware --noconfirm --color=always 2>/dev/null ||:\\n" >> root/bin/"$BINFNSTP"
		elif [[ "$CPUABI" = "$CPUABI8" ]]
		then
			printf "pacman -Rc linux-aarch64 linux-firmware --noconfirm --color=always 2>/dev/null ||:\\n" >> root/bin/"$BINFNSTP"
		fi
		if [[ "$CPUABI" = "$CPUABIX86" ]];then
			printf "./root/bin/keys x86\\n" >> root/bin/"$BINFNSTP"
		elif [[ "$CPUABI" = "$CPUABIX86_64" ]];then
			printf "./root/bin/keys x86_64\\n" >> root/bin/"$BINFNSTP"
		else
			printf "./root/bin/keys\\n" >> root/bin/"$BINFNSTP"
		fi
		if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX86_64" ]]
		then
			printf "./root/bin/pci gzip sed \\n" >> root/bin/"$BINFNSTP"
		else
			printf "./root/bin/pci \\n" >> root/bin/"$BINFNSTP"
		fi
	fi
	cat >> root/bin/"$BINFNSTP" <<- EOM
	printf "\\n\\e[1;34m%s  \\e[0m" "🕛 > 🕤 Arch Linux in Termux is installed and configured 📲 " 
	printf "\\e]2;%s\\007" " 🕛 > 🕤 Arch Linux in Termux is installed and configured 📲 "
	EOM
	chmod 700 root/bin/"$BINFNSTP" 
}

_MAKESETUPBIN_() {
	_CFLHDR_ root/bin/setupbin.sh 
	cat >> root/bin/setupbin.sh <<- EOM
	set +Eeuo pipefail
	EOM
	echo "$PROOTSTMNT /root/bin/finishsetup.sh ||:" >> root/bin/setupbin.sh 
	cat >> root/bin/setupbin.sh <<- EOM
	set -Eeuo pipefail
	EOM
	chmod 700 root/bin/setupbin.sh
}

_MAKESTARTBIN_() {
	_CFLHDR_ "$STARTBIN" 
	printf "%s\\n" "${FLHDRP[@]}" >> "$STARTBIN"
	cat >> "$STARTBIN" <<- EOM
	COMMANDIF="\$(command -v getprop)" ||:
	if [[ "\$COMMANDIF" = "" ]] ; then
 		printf "\\n\\e[1;48;5;138m  %s\\e[0m\\n\\n" "\${0##*/} WARNING: Run \${0##*/} and $INSTALLDIR/\${0##*/} from the BASH shell in the OS system in Termux, e.g., Amazon Fire, Android and Chromebook."
		exit 202
	fi
	declare -g ar2ar="\${@:2}"
	declare -g ar3ar="\${@:3}"
	_PRINTUSAGE_() { 
	printf "\\n\\e[1;32m$STARTBIN\\e[0;32m: Start Arch Linux as root.  This account is reserved for system administration.\\n\\n\\e[1;32m$STARTBIN c[md] cmd\\e[0;32m: Run Arch Linux command from Termux as root user.\\n\\n\\e[1;32m$STARTBIN u[ser]|l[ogin] user\\e[0;32m: Login as user.  Use \\e[1;32m$STARTBIN addauser user \\e[0;32mfirst to create this user and user's home directory.\\n\\n\\e[1;32m$STARTBIN r[aw]\\e[0;32m: Construct the \\e[1;32m$STARTBIN \\e[0;32mproot statement from exec.../bin/.  For example \\e[1;32m$STARTBIN r su \\e[0;32mwill exec su in Arch Linux.\\n\\n\\e[1;32m$STARTBIN s[u] user cmd\\e[0;32m: Login as user and execute command.  Use \\e[1;32m$STARTBIN addauser user \\e[0;32mfirst to create this user and user's home directory.\\n\\n\\e[0m"'\033]2; TermuxArch '$STARTBIN' help 📲  \007' 
	}

	# [] Default Arch Linux in Termux PRoot root login.
	if [[ -z "\${1:-}" ]];then
		set +Eeuo pipefail
	EOM
		echo "$PROOTSTMNT /bin/bash -l ||: " >> "$STARTBIN"
	cat >> "$STARTBIN" <<- EOM
		set -Eeuo pipefail
		printf '\033]2; TermuxArch $STARTBIN 📲  \007'
	# [?|help] Displays usage information.
	elif [[ "\${1//-}" = [?]* ]] || [[ "\${1//-}" = [Hh]* ]] ; then
		_PRINTUSAGE_
	# [command ARGS] Execute a command in BASH as root.
	elif [[ "\${1//-}" = [Cc]* ]] ; then
		printf '\033]2; $STARTBIN command ARGS 📲  \007'
		touch $INSTALLDIR/root/.chushlogin
		set +Eeuo pipefail
	EOM
		echo "$PROOTSTMNT /bin/bash -lc \"\$ar2ar\" ||:" >> "$STARTBIN"
	cat >> "$STARTBIN" <<- EOM
		set -Eeuo pipefail
		printf '\033]2; $STARTBIN command ARGS 📲  \007'
		rm -f $INSTALLDIR/root/.chushlogin
	# [login user|login user [options]] Login as user [plus options].  Use \`addauser user\` first to create this user and user's home directory.
	elif [[ "\${1//-}" = [Ll]* ]] || [[ "\${1//-}" = [Uu]* ]] ; then
		printf '\033]2; $STARTBIN login user [options] 📲  \007'
		set +Eeuo pipefail
	EOM
		echo "$PROOTSTMNTU /bin/su - \"\$ar2ar\" ||:" >> "$STARTBIN"
	cat >> "$STARTBIN" <<- EOM
		set -Eeuo pipefail
		printf '\033]2; $STARTBIN login user [options] 📲  \007'
	# [raw ARGS] Construct the \`startarch\` proot statement.  For example \`startarch r su\` will exec su in Arch Linux.  See PROOTSTMNT for more options; share your thoughts at https://github.com/sdrausty/TermuxArch/issues and https://github.com/sdrausty/TermuxArch/pulls.
	elif [[ "\${1//-}" = [Rr]* ]] ; then
		printf '\033]2; $STARTBIN raw ARGS 📲  \007'
		set +Eeuo pipefail
	EOM
		echo "$PROOTSTMNT /bin/\"\$ar2ar\" ||:" >> "$STARTBIN"
	cat >> "$STARTBIN" <<- EOM
		set -Eeuo pipefail
		printf '\033]2; $STARTBIN raw ARGS 📲  \007'
	# [su user command] Login as user and execute command.  Use \`addauser user\` first to create this user and user's home directory.
	elif [[ "\${1//-}" = [Ss]* ]] ; then
		printf '\033]2; $STARTBIN su user command 📲  \007'
		if [[ "\$2" = root ]];then
			touch $INSTALLDIR/root/.chushlogin
		else
			touch $INSTALLDIR/home/"\$2"/.chushlogin
		fi
		set +Eeuo pipefail
	EOM
		echo "$PROOTSTMNTU /bin/su - \"\$2\" -c \"\$ar3ar\" ||:" >> "$STARTBIN"
	cat >> "$STARTBIN" <<- EOM
		set -Eeuo pipefail
		printf '\033]2; $STARTBIN su user command 📲  \007'
		if [[ "\$2" = root ]];then
			rm -f $INSTALLDIR/root/.chushlogin
		else
			rm -f $INSTALLDIR/home/"\$2"/.chushlogin
		fi
	else
		_PRINTUSAGE_
	fi
	EOM
	chmod 700 "$STARTBIN"
}

_MAKESYSTEM_() {
	_WAKELOCK_
	_CALLSYSTEM_
	_PRINTMD5CHECK_
	_MD5CHECK_
	_PRINTCU_ 
	rm -f "$INSTALLDIR"/*.tar.gz "$INSTALLDIR"/*.tar.gz.md5
	_PRINTDONE_ 
	_PRINTCONFIGUP_ 
	_TOUCHUPSYS_ 
}

_MD5CHECK_() {
	if "$PREFIX"/bin/applets/md5sum -c "$file".md5 1>/dev/null ; then
		_PRINTMD5SUCCESS_
		printf "\\e[0;32m"
		_PREPROOT_ ## & spinner "Unpacking" "$file…" 
	else
		rm -f "$INSTALLDIR"/*.tar.gz "$INSTALLDIR"/*.tar.gz.md5
		_PRINTMD5ERROR_
	fi
}

_OPTIONS_() {
## >>>>>>>>>>>>>>>>>>
## >> OPTION  HELP >>
## >>>>>>>>>>>>>>>>>>
## []  Run default Arch Linux install. 
if [[ -z "${1:-}" ]] ; then
	_PREPTERMUXARCH_ 
	intro "$@" 
## [./path/systemimage.tar.gz [customdir]]  Use path to system image file; install directory argument is optional. A systemimage.tar.gz file can be substituted for network install: `setupTermuxArch.sh ./[path/]systemimage.tar.gz` and `setupTermuxArch.sh /absolutepath/systemimage.tar.gz`. 
elif [[ "${ARGS:0:1}" = . ]] ; then
 	echo
 	echo Setting mode to copy system image.
 	lcc="1"
 	lcp="1"
 	_ARG2DIR_ "$@"  
 	intro "$@" 
## [systemimage.tar.gz [customdir]]  Install directory argument is optional.  A systemimage.tar.gz file can substituted for network install.  
# elif [[ "${WDIR}${ARGS}" = *.tar.gz* ]] ; then
elif [[ "$ARGS" = *.tar.gz* ]] ; then
	echo
	echo Setting mode to copy system image.
	lcc="1"
	lcp="0"
	_ARG2DIR_ "$@"  
	intro "$@" 
## [axd|axs]  Get device system information with `axel`.
elif [[ "${1//-}" = [Aa][Xx][Dd]* ]] || [[ "${1//-}" = [Aa][Xx][Ss]* ]] ; then
	echo
	echo Getting device system information with \`axel\`.
	dm=axel
	shift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [ax[el] [customdir]|axi [customdir]]  Install Arch Linux with `axel`.
elif [[ "${1//-}" = [Aa][Xx]* ]] || [[ "${1//-}" = [Aa][Xx][Ii]* ]] ; then
	echo
	echo Setting \`axel\` as download manager.
	dm=axel
	_OPT1_ "$@" 
	intro "$@" 
## [ad|as]  Get device system information with `aria2c`.
elif [[ "${1//-}" = [Aa][Dd]* ]] || [[ "${1//-}" = [Aa][Ss]* ]] ; then
	echo
	echo Getting device system information with \`aria2c\`.
	dm=aria2
	shift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [a[ria2c] [customdir]|ai [customdir]]  Install Arch Linux with `aria2c`.
elif [[ "${1//-}" = [Aa]* ]] ; then
	echo
	echo Setting \`aria2c\` as download manager.
	dm=aria2
	_OPT1_ "$@" 
	intro "$@" 
## [b[loom]]  Create and run a local copy of TermuxArch in TermuxArchBloom.  Useful for running a customized setupTermuxArch.sh locally, for developing and hacking TermuxArch.  
elif [[ "${1//-}" = [Bb]* ]] ; then
	echo
	echo Setting mode to bloom. 
	introbloom "$@"  
## [cd|cs]  Get device system information with `curl`.
elif [[ "${1//-}" = [Cc][Dd]* ]] || [[ "${1//-}" = [Cc][Ss]* ]] ; then
	echo
	echo Getting device system information with \`curl\`.
	dm=curl
	shift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [c[url] [customdir]|ci [customdir]]  Install Arch Linux with `curl`.
elif [[ "${1//-}" = [Cc][Ii]* ]] || [[ "${1//-}" = [Cc]* ]] ; then
	echo
	echo Setting \`curl\` as download manager.
	dm=curl
	_OPT1_ "$@" 
	intro "$@" 
## [d[ebug]|s[ysinfo]]  Generate system information.
elif [[ "${1//-}" = [Dd]* ]] || [[ "${1//-}" = [Ss]* ]] ; then
	echo 
	echo Setting mode to sysinfo.
	shift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [he[lp]|?]  Display terse builtin help.
elif [[ "${1//-}" = [Hh][Ee]* ]] || [[ "${1//-}" = [?]* ]] ; then
	_ARG2DIR_ "$@" 
	_PRINTUSAGE_ "$@"  
## [h]  Display verbose builtin help.
elif [[ "${1//-}" = [Hh]* ]] ; then
	lcc="1"
	_ARG2DIR_ "$@" 
	_PRINTUSAGE_ "$@"  
## [i[nstall] [customdir]]  Install Arch Linux in a custom directory.  Instructions: Install in USERSPACE. $HOME is appended to installation directory. To install Arch Linux in $HOME/customdir use `bash setupTermuxArch.sh install customdir`. In bash shell use `./setupTermuxArch.sh install customdir`.  All options can be abbreviated to one, two and three letters.  Hence `./setupTermuxArch.sh install customdir` can be run as `./setupTermuxArch.sh i customdir` in BASH.
elif [[ "${1//-}" = [Ii]* ]] ; then
	echo
	echo Setting mode to install.
	_OPT1_ "$@" 
	intro "$@"  
## [ld|ls]  Get device system information with `lftp`.
elif [[ "${1//-}" = [Ll][Dd]* ]] || [[ "${1//-}" = [Ll][Ss]* ]] ; then
	echo
	echo Getting device system information with \`lftp\`.
	dm=lftp
	shift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [l[ftp] [customdir]]  Install Arch Linux with `lftp`.
elif [[ "${1//-}" = [Ll]* ]] ; then
	echo
	echo Setting \`lftp\` as download manager.
	dm=lftp
	_OPT1_ "$@" 
	intro "$@" 
## [m[anual]]  Manual Arch Linux install, useful for resolving download issues.
elif [[ "${1//-}" = [Mm]* ]] ; then
	echo
	echo Setting mode to manual.
	OPT=manual
	_OPT1_ "$@" 
	intro "$@"  
## [o[ption]]  Option under development.
elif [[ "${1//-}" = [Oo]* ]] ; then
	echo
	echo Setting mode to option.
	lcc="1"
	_PRINTUSAGE_ "$@" 
# 	_OPT0_ "$@" 
## [p[urge] [customdir]]  Remove Arch Linux.
elif [[ "${1//-}" = [Pp]* ]] ; then
	echo 
	echo Setting mode to purge.
	_ARG2DIR_ "$@" 
	_RMARCHQ_
## [ref[resh] [customdir]]  Refresh the Arch Linux in Termux PRoot scripts created by TermuxArch and the installation itself.  Useful for refreshing the installation, kets, locales and the TermuxArch generated scripts to their newest versions.  
elif [[ "${1//-}" = [Rr][Ee][Ff]* ]] ; then
	echo 
	echo Setting mode to refresh.
	_ARG2DIR_ "$@" 
	introrefresh "$@"  
## [re [customdir]]  Refresh the Arch Linux in Termux PRoot scripts created by TermuxArch.  Useful for refreshing locales, the TermuxArch generated scripts with user directories to their newest versions.  
elif [[ "${1//-}" = [Rr][Ee]* ]] ; then
	LCR="2"
	echo 
	echo Setting mode to minimal refresh with user directories.
	_ARG2DIR_ "$@" 
	introrefresh "$@"  
## [r [customdir]]  Refresh the Arch Linux in Termux PRoot scripts created by TermuxArch.  Useful for refreshing locales and the TermuxArch generated scripts to their newest versions.  
elif [[ "${1//-}" = [Rr]* ]] ; then
	LCR="1"
	printf "\\n\\e[1;32m%s\\e[1;34m: \\e[0;32m%s \`%s\` %s\\n\\e[0m" "Setting mode" "minimal refresh;  Use" "${0##*/} ref[resh]" "for full refresh."
	_ARG2DIR_ "$@" 
	introrefresh "$@"  
## [wd|ws]  Get device system information with `wget`.
elif [[ "${1//-}" = [Ww][Dd]* ]] || [[ "${1//-}" = [Ww][Ss]* ]] ; then
	echo
	echo Getting device system information with \`wget\`.
	dm=wget
	shift
	_ARG2DIR_ "$@" 
	_INTROSYSINFO_ "$@" 
## [w[get] [customdir]]  Install Arch Linux with `wget`.
elif [[ "${1//-}" = [Ww]* ]] ; then
	echo
	echo Setting \`wget\` as download manager.
	dm=wget
	_OPT1_ "$@" 
	intro "$@"  
else
	_PRINTUSAGE_
fi
}

_PREPROOTDIR_() {
	cd "$INSTALLDIR"
	mkdir -p etc 
	mkdir -p var/binds 
	mkdir -p root/bin
	mkdir -p usr/bin
}

_PREPINSTALLDIR_() {
	_PREPROOTDIR_
	_SETLANGUAGE_
	_ADDADDS_
	_MAKEFINISHSETUP_
	_MAKESETUPBIN_ 
	_MAKESTARTBIN_ 
}

_PREPROOT_() {
	if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX86_64" ]];then
 		proot --link2symlink -0 bsdtar -xpf "$file" --strip-components 1  
	else
		proot --link2symlink -0 "$PREFIX"/bin/applets/tar -xpf "$file" 
	fi
}

_RUNFINISHSETUP_() {
	printf "\\e[0m"
	if [[ "$FSTND" ]]; then
		NMIR="$(echo "$NLCMIRROR" |awk -F'/' '{print $3}')"
		sed -e '/http\:\/\/mir/ s/^#*/# /' -i "$INSTALLDIR"/etc/pacman.d/mirrorlist
		sed -e "/$NMIR/ s/^# *//" -i "$INSTALLDIR"/etc/pacman.d/mirrorlist
	else
	if [[ "$ed" = "" ]];then
		_EDITORS_ 
	fi
	if [[ ! "$(sed 1q  "$INSTALLDIR"/etc/pacman.d/mirrorlist)" = "# # # # # # # # # # # # # # # # # # # # # # # # # # #" ]];then
		_EDITFILES_
	fi
		"$ed" "$INSTALLDIR"/etc/pacman.d/mirrorlist
	fi
	printf "\\n"
	"$INSTALLDIR"/root/bin/setupbin.sh ||:
}

_SETLANGUAGE_() { # This function uses device system settings to set locale.  To generate locales in a preferred language, you can use "Settings > Language & Keyboard > Language" in Android; Then run `setupTermuxArch.sh r for a quick system refresh.
	ULANGUAGE="unkown"
  	LANGIN=([0]="$(getprop user.language)")
	LANGIN+=([1]="$(getprop user.region)")
	LANGIN+=([2]="$(getprop persist.sys.country)")
	LANGIN+=([3]="$(getprop persist.sys.language)")
 	LANGIN+=([4]="$(getprop persist.sys.locale)")
  	LANGIN+=([5]="$(getprop ro.product.locale)")
	LANGIN+=([6]="$(getprop ro.product.locale.language)")
	LANGIN+=([7]="$(getprop ro.product.locale.region)")
	touch "$INSTALLDIR"/etc/locale.gen 
	ULANGUAGE="${LANGIN[0]:-unknown}_${LANGIN[1]:-unknown}"
       	if ! grep "$ULANGUAGE" "$INSTALLDIR"/etc/locale.gen 1>/dev/null ; then 
		ULANGUAGE="unknown"
       	fi 
 	if [[ "$ULANGUAGE" != *_* ]];then
 		ULANGUAGE="${LANGIN[3]:-unknown}_${LANGIN[2]:-unknown}"
 	       	if ! grep "$ULANGUAGE" "$INSTALLDIR"/etc/locale.gen 1>/dev/null ; then 
 			ULANGUAGE="unknown"
 	       	fi 
 	fi 
	for i in "${!LANGIN[@]}"; do
		if [[ "${LANGIN[i]}" = *-* ]];then
 	 		ULANGUAGE="${LANGIN[i]//-/_}"
			break
		fi
	done
 	if [[ "$ULANGUAGE" != *_* ]];then
 		ULANGUAGE="${LANGIN[6]:-unknown}_${LANGIN[7]:-unknown}"
 	       	if ! grep "$ULANGUAGE" "$INSTALLDIR"/etc/locale.gen 1>/dev/null ; then 
 			ULANGUAGE="unknown"
 	       	fi 
 	fi 
 	if [[ "$ULANGUAGE" != *_* ]];then
   		ULANGUAGE="en_US"
 	fi 
	printf "\\n\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n" "Setting locales to: " "Language " ">> $ULANGUAGE << " "Region"
}

_SETLOCALE_() { # This function uses device system settings to set locale.  To generate locales in a preferred language, you can use "Settings > Language & Keyboard > Language" in Android; Then run `setupTermuxArch.sh r for a quick system refresh.
	FTIME="$(date +%F%H%M%S)"
	echo "##  File locale.conf generated by setupTermuxArch.sh at" ${FTIME//-}. > etc/locale.conf 
	for i in "${!LC_TYPE[@]}"; do
	 	echo "${LC_TYPE[i]}"="$ULANGUAGE".UTF-8 >> etc/locale.conf 
	done
	sed -i "/\\#$ULANGUAGE.UTF-8 UTF-8/{s/#//g;s/@/-at-/g;}" etc/locale.gen 
}

_TOUCHUPSYS_() {
	addmotd
	_SETLOCALE_
	_RUNFINISHSETUP_
	rm -f root/bin/finishsetup.sh
	rm -f root/bin/setupbin.sh 
}

_WAKELOCK_() {
	_PRINTWLA_ 
	am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService > /dev/null
	_PRINTDONE_ 
}

_WAKEUNLOCK_() {
	_PRINTWLD_ 
	am startservice --user 0 -a com.termux.service_wake_unlock com.termux/com.termux.app.TermuxService > /dev/null
	_PRINTDONE_ 
}

# EOF
