#!/usr/bin/env bash
# Copyright 2017-2020 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project.
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################

BINFNSTP=finishsetup.bash
LC_TYPE=( "LANG" "LANGUAGE" "LC_ADDRESS" "LC_COLLATE" "LC_CTYPE" "LC_IDENTIFICATION" "LC_MEASUREMENT" "LC_MESSAGES" "LC_MONETARY" "LC_NAME" "LC_NUMERIC" "LC_PAPER" "LC_TELEPHONE" "LC_TIME" )

_ADDADDS_() {
	_ADDAUSER_
	_ADDMOTD_
	_ADDMOTO_
	_ADDREADME_
	_ADDaddresolvconf_
	_ADDae_
	_ADDbash_logout_
	_ADDbash_profile_
	_ADDbashrc_
	_ADDcdtd_
	_ADDcdth_
	_ADDcdtmp_
	_ADDch_
	_ADDcsystemctl_
	_ADDdfa_
	_ADDexd_
	_ADDfbindexample_
	_ADDfbinds_
	_ADDfibs_
	_ADDga_
	_ADDgcl_
	_ADDgcm_
	_ADDgp_
	_ADDgpl_
	_ADDinputrc
	_ADDkeys_
	_ADDmakefakeroot-tcp_
	_ADDmakeyay_
	_ADDpatchmakepkg_
	_ADDpc_
	_ADDpci_
	_ADDprofile_
	_ADDt_
	_ADDtour_
	_ADDtrim_
	_ADDv_
	_ADDwe_
	_ADDyt_
}

_CALLSYSTEM_() {
	declare COUNTER=""
	if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX86_64" ]]
	then
		_GETIMAGE_
	else
		if [[ "$CMIRROR" = "os.archlinuxarm.org" ]] || [[ "$CMIRROR" = "mirror.archlinuxarm.org" ]]
		then
			until _FTCHSTND_ || FRV="$?" && ([[ $FRV = 3 ]] || [[ $FRV = 22 ]]) && _PSGI1ESTRING_ "FRV=$FRV until _FTCHSTND_ necessaryfunctions.bash ${0##/*}' : Continuing..." && break
			do
				_FTCHSTND_ || CRV="$?" && _PSGI1ESTRING_ "CRV=$CRV _FTCHSTND_ necessaryfunctions.bash ${0##*/}"
				sleep 2
				printf "\\n"
				COUNTER=$((COUNTER + 1))
				if [[ "$COUNTER" = 9 ]]
				then
					_PRINTMAX_
					break
				fi
			done
		else
			_FTCHIT_
		fi
	fi
}

_COPYSTARTBIN2PATH_() {
	if [[ ":$PATH:" == *":$HOME/bin:"* ]] && [[ -d "$HOME"/bin ]]
	then
		BPATH="$HOME"/bin
	else
		BPATH="$PREFIX"/bin
	fi
	cp "$INSTALLDIR/$STARTBIN" "$BPATH"
	printf "\\e[0;34m%s\\e[1;34m%s\\e[1;32m%s\\e[1;34m%s\\e[1;37m%s\\e[0m.\\n\\n" " 🕛 > 🕦 " "File " "$STARTBIN " "copied to " "$BPATH"
}

_DETECTSYSTEM_() {
	_PRINTDETECTEDSYSTEM_
	if [[ "$CPUABI" = "$CPUABI5" ]]
	then
		_ARMV5L_
	elif [[ "$CPUABI" = "$CPUABI7" ]]
	then
		_DETECTSYSTEM7_
	elif [[ "$CPUABI" = "$CPUABI8" ]]
	then
		_DETECTSYSTEM64_
	elif [[ "$CPUABI" = "$CPUABIX86" ]]
	then
		_I686_
	elif [[ "$CPUABI" = "$CPUABIX86_64" ]]
	then
		_X86_64_
	else
		_PRINTMISMATCH_
	fi
}

_DETECTSYSTEM7_() {
	if [[ "$(getprop ro.product.device)" == *_cheets ]]
	then
		_ARMV7CHROME_
	else
		_ARMV7ANDROID_
	fi
}

_DETECTSYSTEM64_() {
	if [[ "$(getprop ro.product.device)" == *_cheets ]]
	then
		_AARCH64CHROME_
	else
		_AARCH64ANDROID_
	fi
}

_KERNID_() {
	declare KID=""
	ur="$(uname -r)"
	declare -i KERNEL_VERSION="$(awk -F'.' '{print $1}' <<< "$ur")"
	declare -i MAJOR_REVISION="$(awk -F'.' '{print $2}' <<< "$ur")"
	declare -- TMP="$(awk -F'.' '{print $3}' <<< "$ur")"
	declare -- MINOR_REVISION="$(sed 's/[^0-9]*//g' <<< "${TMP:0:3}")"
	if [[ "$KERNEL_VERSION" -le 2 ]]
	then
		KID=0
	else
		if [[ "$KERNEL_VERSION" -eq 3 ]]
		then
			if [[ "$MAJOR_REVISION" -lt 2 ]]
			then
				KID=0
			else
				if [[ "$MAJOR_REVISION" -eq 2 ]] && [[ "$MINOR_REVISION" -eq 0 ]]
				then
					KID=0
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
	"$INSTALLDIR/$STARTBIN" || _PRINTPROOTERROR_
	set -Eeuo pipefail
	_PRINTFOOTER2_
	_PRINTSTARTBIN_USAGE_
}

_DOPROXY_() {
	if [[ -e "$HOME"/.bash_profile ]]
	then
		grep "proxy" "$HOME"/.bash_profile | grep "export" >> root/bin/"$BINFNSTP" 2>/dev/null ||:
	fi
	if [[ -e "$HOME"/.bashrc ]]
	then
		grep "proxy" "$HOME"/.bashrc  | grep "export" >> root/bin/"$BINFNSTP" 2>/dev/null ||:
	fi
	if [[ -e "$HOME"/.profile ]]
	then
		grep "proxy" "$HOME"/.profile | grep "export" >> root/bin/"$BINFNSTP" 2>/dev/null ||:
	fi
}

_DOKEYS_() {
	if [[ "$CPUABI" = "$CPUABIX86" ]]
	then
		printf "./root/bin/keys x86\\n" >> root/bin/"$BINFNSTP"
	elif [[ "$CPUABI" = "$CPUABIX86_64" ]]
	then
		printf "./root/bin/keys x86_64\\n" >> root/bin/"$BINFNSTP"
	else
 		printf "./root/bin/keys\\n" >> root/bin/"$BINFNSTP"
	fi
}

_MAKEFINISHSETUP_() {
	_CFLHDR_ root/bin/"$BINFNSTP"
	[[ "${LCR:-}" -ne 1 ]] && LOCGEN="" 
	[[ "${LCR:-}" -ne 2 ]] && LOCGEN=""
	[[ -z "${LCR:-}" ]] && LOCGEN="printf \"\\e[1;32m%s\\e[0;32m\"  \"==> \" && locale-gen  ||:"
	cat >> root/bin/"$BINFNSTP" <<- EOM
	_PMFSESTRING_() { 
	printf "\\e[1;31m%s\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\n\\n" "Signal generated in '\$1' : Cannot complete task : " "Continuing...   To correct the error run " "setupTermuxArch.bash refresh" " to attempt to finish the autoconfiguration."
	printf "\\e[1;34m%s\\e[0;34m%s\\e[1;34m%s\\e[0;34m%s\\e[1;34m%s\\n\\n" "  If you find improvements for " "setupTermuxArch.bash" " and " "\$0" " please open an issue and accompanying pull request."
	}
	printf "\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n" "To generate locales in a preferred language use " "Settings > Language & Keyboard > Language " "in Android; Then run " "${0##*/} refresh" " for a full system refresh including locale generation; For quick refresh you can use " "${0##*/} r" ".  For a refresh with user directories " "${0##*/} re" " can be used."
   	$LOCGEN
	printf "\\n\\e[1;34m:: \\e[1;37m%s\\n" "Processing system for $NASVER $CPUABI, and removing redundant packages for Termux PRoot installation..."
	EOM
	_FIXOWNER_
	if [[ -z "${LCR:-}" ]] # is undefined
	then
		printf "%s\\n" "pacman -Syy || pacman -Syy || _PMFSESTRING_ \"pacman -Syy $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
		printf "%s\\n" "/root/bin/keys || _PMFSESTRING_ \"keys $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
		printf "%s\\n" "/root/bin/csystemctl.bash || _PMFSESTRING_ \"csystemctl.bash $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
	 	if [[ "$CPUABI" = "$CPUABI5" ]]
		then
	 		printf "%s\\n" "pacman -Rc linux-armv5 linux-firmware --noconfirm --color=always 2>/dev/null || _PMFSESTRING_ \"pacman -Rc linux-armv5 linux-firmware $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
	 	elif [[ "$CPUABI" = "$CPUABI7" ]]
		then
	 		printf "%s\\n" "pacman -Rc linux-armv7 linux-firmware --noconfirm --color=always 2>/dev/null || _PMFSESTRING_ \"pacman -Rc linux-armv7 linux-firmware $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
	 	elif [[ "$CPUABI" = "$CPUABI8" ]]
		then
	 		printf "%s\\n" "pacman -Rc linux-aarch64 linux-firmware --noconfirm --color=always 2>/dev/null || _PMFSESTRING_ \"pacman -Rc linux-aarch64 linux-firmware $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
	 	fi
		if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX86_64" ]]
		then
			printf "%s\\n" "pacman -Syu gzip patch sed sudo unzip --noconfirm --color=always 2>/dev/null || _PMFSESTRING_ \"pacman -Syu gzip patch sed sudo unzip $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
		else
			printf "%s\\n" "pacman -Syu patch sudo unzip --noconfirm --color=always 2>/dev/null || _PMFSESTRING_ \"pacman -Syu patch sudo unzip $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
		fi
	fi
	cat >> root/bin/"$BINFNSTP" <<- EOM
	printf "\\n\\e[1;34m%s  \\e[0m" "🕛 > 🕤 Arch Linux in Termux is installed and configured 📲  "
	printf "\\e]2;%s\\007" " 🕛 > 🕤 Arch Linux in Termux is installed and configured 📲"
	EOM
	chmod 700 root/bin/"$BINFNSTP"
}

_MAKESETUPBIN_() {
	_CFLHDR_ root/bin/setupbin.bash
	cat >> root/bin/setupbin.bash <<- EOM
	set +Eeuo pipefail
	EOM
	printf "%s\\n" "$PROOTSTMNT /root/bin/$BINFNSTP ||:" >> root/bin/setupbin.bash
	cat >> root/bin/setupbin.bash <<- EOM
	set -Eeuo pipefail
	EOM
	chmod 700 root/bin/setupbin.bash
}

_MAKESTARTBIN_() {
	_CFLHDR_ "$STARTBIN"
	printf "%s\\n" "${FLHDRP[@]}" >> "$STARTBIN"
	cat >> "$STARTBIN" <<- EOM
	COMMANDG="\$(command -v getprop)" ||:
	if [[ "\$COMMANDG" = "" ]] ; then
 		printf "\\n\\e[1;48;5;138mScript %s\\e[0m\\n\\n" "$STARTBIN \${0##*/} WARNING:  Run \${0##*/} and $INSTALLDIR/\${0##*/} from the BASH shell in Termux:  Exiting..."
		exit 202
	fi
	declare -g AR2AR="\${@:2}"
	declare -g ar3ar="\${@:3}"
	_PRINTUSAGE_() {
	printf "\\e]2;%s\\007" "TermuxArch $STARTBIN help 📲"
	printf "\\n\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN" ": Start Arch Linux as root.  This account is reserved for system administration."
	printf "\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN c[md] cmd" ": Run Arch Linux command from Termux as root user."
	printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN u[ser]|l[ogin] user" ": Login as user.  Use " "$STARTBIN c addauser user " "first to create this user and user's home directory."
	printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN r[aw]" ": Construct the " "$STARTBIN " "proot statement from exec.../bin/.  For example " "$STARTBIN r su " "will exec su in Arch Linux."
	printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n\\e[0m" "$STARTBIN s[u] user cmd" ": Login as user and execute command.  Use " "$STARTBIN c addauser user " "first to create this user and user's home directory."
	}

	# [] Default Arch Linux in Termux PRoot root login.
	if [[ -z "\${1:-}" ]];then
		set +Eeuo pipefail
	EOM
		printf "%s\\n" "$PROOTSTMNT /bin/bash -l ||: " >> "$STARTBIN"
	cat >> "$STARTBIN" <<- EOM
		set -Eeuo pipefail
		printf '\033]2; TermuxArch $STARTBIN 📲  \007'
	# [?|help] Displays usage information.
	elif [[ "\${1//-}" = [?]* ]] || [[ "\${1//-}" = [Hh]* ]] ; then
		_PRINTUSAGE_
	# [command ARGS] Execute a command in BASH as root.
	elif [[ "\${1//-}" = [Cc]* ]] ; then
		printf '\033]2; $STARTBIN command 📲  \007'
		touch $INSTALLDIR/root/.chushlogin
		set +Eeuo pipefail
	EOM
		printf "%s\\n" "$PROOTSTMNT /bin/bash -lc \"\$AR2AR\" ||:" >> "$STARTBIN"
	cat >> "$STARTBIN" <<- EOM
		set -Eeuo pipefail
		printf '\033]2; $STARTBIN command 📲  \007'
		rm -f $INSTALLDIR/root/.chushlogin
	# [login user|login user [options]] Login as user [plus options].  Use \`addauser user\` first to create this user and user's home directory.
	elif [[ "\${1//-}" = [Ll]* ]] || [[ "\${1//-}" = [Uu]* ]] ; then
		printf '\033]2; $STARTBIN login user [options] 📲  \007'
		set +Eeuo pipefail
	EOM
		printf "%s\\n" "$PROOTSTMNT /bin/su - \"\$AR2AR\" ||:" >> "$STARTBIN"
	cat >> "$STARTBIN" <<- EOM
		set -Eeuo pipefail
		printf '\033]2; $STARTBIN login user [options] 📲  \007'
	# [raw ARGS] Construct the \`startarch\` proot statement.  For example \`startarch r su\` will exec su in Arch Linux.  See PROOTSTMNT for more options; share your thoughts at https://github.com/sdrausty/TermuxArch/issues and https://github.com/sdrausty/TermuxArch/pulls.
	elif [[ "\${1//-}" = [Rr]* ]] ; then
		printf '\033]2; $STARTBIN raw ARGS 📲  \007'
		set +Eeuo pipefail
	EOM
		printf "%s\\n" "$PROOTSTMNT /bin/\"\$AR2AR\" ||:" >> "$STARTBIN"
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
		printf "%s\\n" "$PROOTSTMNT /bin/su - \"\$2\" -c \"\$ar3ar\" ||:" >> "$STARTBIN"
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
       	[[ "$KEEP" -ne 0 ]] && rm -f "$INSTALLDIR"/*.tar.gz "$INSTALLDIR"/*.tar.gz.md5 # set KEEP to 0 in file 'knownconfigurations.bash' after using either 'setupTermuxArch.bash bloom' or 'setupTermuxArch.bash manual' to keep the INSTALLDIR/*.tar.gz and INSTALLDIR/*.tar.gz.md5 files.
	_PRINTDONE_
	_PRINTCONFIGUP_
	_TOUCHUPSYS_
}

_MD5CHECK_() {
	if md5sum -c "$IFILE".md5 1>/dev/null
	then
		_PRINTMD5SUCCESS_
		printf "\\e[0;32m"
		_PREPROOT_ ## & spinner "Unpacking" "$IFILE..."
	else
		rm -f "$INSTALLDIR"/*.tar.gz "$INSTALLDIR"/*.tar.gz.md5
		_PRINTMD5ERROR_
	fi
}

_PREPROOTDIR_() {
	cd "$INSTALLDIR"
	[ ! -e etc ] &&	mkdir -p etc
	[ ! -e home ] && mkdir -p home
	[ ! -e root/bin ] && mkdir -p root/bin
	[ ! -e usr/bin ] && mkdir -p usr/bin
	[ ! -e var/binds ] && mkdir -p var/binds
}

_PREPINSTALLDIR_() {
	_PREPROOTDIR_
	_SETLANGUAGE_
	_ADDADDS_
	_DOPROXY_
	_MAKEFINISHSETUP_
	_MAKESETUPBIN_
	_MAKESTARTBIN_
}

_PREPROOT_() {
	if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX86_64" ]]
	then
 		proot --link2symlink -0 bsdtar -xpf "$IFILE" --strip-components 1
	else
 		proot --link2symlink -0 bsdtar -xpf "$IFILE"
	fi
}

_RUNFINISHSETUP_() {
	_SEDUNCOM_() {
			sed -i "/\/mirror.archlinuxarm.org/ s/^# *//" "$INSTALLDIR"/etc/pacman.d/mirrorlist || _PSGI1ESTRING_ "sed -i _SEDUNCOM_ necessaryfunctions.bash ${0##*/}" # sed replace a character in a matched line in place
	}
	printf "\\e[0m"
	if [[ "$FSTND" ]]
	then
		NMIR="$(awk -F'/' '{print $3}' <<< "$NLCMIRROR")"
		sed -i '/http\:\/\/mir/ s/^#*/# /' "$INSTALLDIR"/etc/pacman.d/mirrorlist
		# test if NMIR is in mirrorlist file
		if grep "$NMIR" "$INSTALLDIR"/etc/pacman.d/mirrorlist
		then
			printf "%s\\n" "Found server $NMIR in /etc/pacman.d/mirrorlist; Uncommenting $NMIR."
			sed -i "/$NMIR/ s/^# *//" "$INSTALLDIR"/etc/pacman.d/mirrorlist  || _SEDUNCOM_ || _PSGI1ESTRING_ "sed -i _RUNFINISHSETUP_ necessaryfunctions.bash ${0##*/}"
		else
			printf "%s\\n" "Did not find server $NMIR in /etc/pacman.d/mirrorlist; Adding $NMIR to file /etc/pacman.d/mirrorlist."
			printf "%s\\n" "Server = $NLCMIRROR/\$arch/\$repo" >> "$INSTALLDIR"/etc/pacman.d/mirrorlist
		fi
	else
		if [[ "$ed" = "" ]]
		then
			_EDITORS_
		fi
		if [[ ! "$(sed 1q  "$INSTALLDIR"/etc/pacman.d/mirrorlist)" = "# # # # # # # # # # # # # # # # # # # # # # # # # # #" ]]
		then
			_EDITFILES_
		fi
		"$ed" "$INSTALLDIR"/etc/pacman.d/mirrorlist
	fi
	printf "\\n"
	"$INSTALLDIR"/root/bin/setupbin.bash || _PRINTPROOTERROR_
}

_SETLANGUAGE_() { # This function uses device system settings to set locale.  To generate locales in a preferred language, you can use "Settings > Language & Keyboard > Language" in Android; Then run `setupTermuxArch.bash r for a quick system refresh.
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
       	if ! grep "$ULANGUAGE" "$INSTALLDIR"/etc/locale.gen 1>/dev/null
	then
		ULANGUAGE="unknown"
       	fi
 	if [[ "$ULANGUAGE" != *_* ]];then
 		ULANGUAGE="${LANGIN[3]:-unknown}_${LANGIN[2]:-unknown}"
 	       	if ! grep "$ULANGUAGE" "$INSTALLDIR"/etc/locale.gen 1>/dev/null
		then
 			ULANGUAGE="unknown"
 	       	fi
 	fi
	for i in "${!LANGIN[@]}"
	do
		if [[ "${LANGIN[i]}" = *-* ]]
		then
 	 		ULANGUAGE="${LANGIN[i]//-/_}"
			break
		fi
	done
 	if [[ "$ULANGUAGE" != *_* ]]
	then
 		ULANGUAGE="${LANGIN[6]:-unknown}_${LANGIN[7]:-unknown}"
 	       	if ! grep "$ULANGUAGE" "$INSTALLDIR"/etc/locale.gen 1>/dev/null ; then
 			ULANGUAGE="unknown"
 	       	fi
 	fi
 	if [[ "$ULANGUAGE" != *_* ]]
	then
   		ULANGUAGE="en_US"
 	fi
	printf "\\n\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n" "Setting locales to: " "Language " ">> $ULANGUAGE << " "Region"
}

_SETLOCALE_() { # This function uses device system settings to set locale.  To generate locales in a preferred language, you can use "Settings > Language & Keyboard > Language" in Android; Then run `setupTermuxArch.bash r for a quick system refresh.
	FTIME="$(date +%F%H%M%S)"
	printf "%s\\n" "##  File locale.conf generated by setupTermuxArch.bash at ${FTIME//-}." > etc/locale.conf
	for i in "${!LC_TYPE[@]}"
	do
	 	printf "%s\\n" "${LC_TYPE[i]}=$ULANGUAGE.UTF-8" >> etc/locale.conf
	done
	sed -i "/\\#$ULANGUAGE.UTF-8 UTF-8/{s/#//g;s/@/-at-/g;}" etc/locale.gen
}

_TOUCHUPSYS_() {
	_ADDMOTD_
	_PREPPACMANCONF_
	_SETLOCALE_
	_RUNFINISHSETUP_
	rm -f root/bin/$BINFNSTP
	rm -f root/bin/setupbin.bash
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
# necessaryfunctions.bash EOF
