#!/usr/bin/env bash
# Copyright 2017-2020 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project.
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################

_COPYIMAGE_() { # A systemimage.tar.gz file can be used: `setupTermuxArch.bash ./[path/]systemimage.tar.gz` and `setupTermuxArch.bash /absolutepath/systemimage.tar.gz`
 	CFILE="${1##/*/}"
	IFILE="${CFILE##*/}"
 	if [[ "$LCP" = "0" ]]
	then
		echo "Copying $1.md5 to $INSTALLDIR…"
		cp "$1".md5  "$INSTALLDIR"
		echo "Copying $1 to $INSTALLDIR…"
		cp "$1" "$INSTALLDIR"
 	elif [[ "$LCP" = "1" ]]
	then
		echo "Copying $1.md5 to $INSTALLDIR…"
		cp "$WDIR$1".md5  "$INSTALLDIR"
		echo "Copying $1 to $INSTALLDIR…"
		cp "$WDIR$1" "$INSTALLDIR"
 	fi
}

_FUNLCR2_() { # copy from root to home/USER
		VAR=($(ls home))
	for USER in ${VAR[@]}
	do
		if [[ "$USER" != alarm ]]
		then
			cp "$INSTALLDIR"/root/.bashrc "$INSTALLDIR"/home/$USER
			cp "$INSTALLDIR"/root/.bash_profile "$INSTALLDIR"/home/$USER
			cp "$INSTALLDIR"/root/.profile "$INSTALLDIR"/home/$USER
			cp "$INSTALLDIR"/root/bin/* "$INSTALLDIR"/home/$USER/bin
		       	ls "$INSTALLDIR"/home/$USER/.bashrc |cut -f7- -d /
		       	ls "$INSTALLDIR"/home/$USER/.bash_profile |cut -f7- -d /
		       	ls "$INSTALLDIR"/home/$USER/.profile |cut -f7- -d /
		       	ls "$INSTALLDIR"/home/$USER/bin/* |cut -f7- -d /
		fi
	done
}

_LOADIMAGE_() {
	_NAMESTARTARCH_
 	_SPACEINFO_
	printf "\\n"
	_WAKELOCK_
	_PREPINSTALLDIR_
  	_COPYIMAGE_ ## "$@" & spinner "Copying" "…"
	_PRINTMD5CHECK_
	_MD5CHECK_
	_PRINTCU_
	rm -f "$INSTALLDIR"/*.tar.gz "$INSTALLDIR"/*.tar.gz.md5
	_PRINTDONE_
	_PRINTCONFIGUP_
	_TOUCHUPSYS_
	printf "\\n"
	_WAKEUNLOCK_
	_PRINTFOOTER_
	set +Eeuo pipefail
	"$INSTALLDIR/$STARTBIN" ||:
	set -Eeuo pipefail
	_PRINTFOOTER2_
	_PRINTSTARTBIN_USAGE_
	exit
}

_REFRESHSYS_() { # refreshes installation
	printf '\033]2; setupTermuxArch.bash refresh 📲 \007'
 	_NAMESTARTARCH_
 	_SPACEINFO_
	cd "$INSTALLDIR"
	_SETLANGUAGE_
	_ADDADDS_
	_MAKEFINISHSETUP_
	_MAKESETUPBIN_
	_MAKESTARTBIN_
	_SETLOCALE_
	printf "\\n"
	_WAKELOCK_
	printf "\\n\\e[1;32m==> \\e[1;37m%s \\e[1;32m%s %s...\\n" "Running" "${0##*/}" "$ARGS"
	"$INSTALLDIR"/root/bin/setupbin.bash ||:
 	rm -f root/bin/finishsetup.bash
 	rm -f root/bin/setupbin.bash
	printf "\\e[1;34mThe following files have been updated to the newest version.\\n\\n\\e[0;32m"
	ls "$INSTALLDIR/$STARTBIN" |cut -f7- -d /
	ls "$INSTALLDIR"/bin/we |cut -f7- -d /
	ls "$INSTALLDIR"/root/.bashrc |cut -f7- -d /
	ls "$INSTALLDIR"/root/.bash_profile |cut -f7- -d /
	ls "$INSTALLDIR"/root/.profile |cut -f7- -d /
	ls "$INSTALLDIR"/root/bin/* |cut -f7- -d /
	if [[ "${LCR:-}" = 2 ]]
	then
	_FUNLCR2_
	fi
	printf "\\n"
	_WAKEUNLOCK_
	_PRINTFOOTER_
	set +Eeuo pipefail
	"$INSTALLDIR/$STARTBIN" ||:
	set -Eeuo pipefail
	_PRINTFOOTER2_
	_PRINTSTARTBIN_USAGE_
	exit
}

_SPACEINFO_() {
	declare SPACEMESSAGE=""
	units="$(df "$INSTALLDIR" 2>/dev/null | awk 'FNR == 1 {print $2}')"
	if [[ "$units" = Size ]] ; then
		_SPACEINFOGSIZE_
		printf "$SPACEMESSAGE"
	elif [[ "$units" = 1K-blocks ]] ; then
		_SPACEINFOKSIZE_
		printf "$SPACEMESSAGE"
	fi
}

_SPACEINFOGSIZE_() {
	_USERSPACE_
	if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX86_64" ]] ; then
		if [[ "$USRSPACE" = *G ]] ; then
			SPACEMESSAGE=""
		elif [[ "$USRSPACE" = *M ]] ; then
			usspace="${USRSPACE: : -1}"
			if [[ "$usspace" < "800" ]] ; then
				SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$USRSPACE of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for x86 and x86_64 is 800M of free user space.\\n\\e[0m"
			fi
		fi
	elif [[ "$USRSPACE" = *G ]] ; then
		usspace="${USRSPACE: : -1}"
		if [[ "$CPUABI" = "$CPUABI8" ]] ; then
			if [[ "$usspace" < "1.5" ]] ; then
				SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$USRSPACE of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\\n\\e[0m"
			else
				SPACEMESSAGE=""
			fi
		elif [[ "$CPUABI" = "$CPUABI7" ]] ; then
			if [[ "$usspace" < "1.23" ]] ; then
				SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$USRSPACE of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for armv7 is 1.23G of free user space.\\n\\e[0m"
			else
				SPACEMESSAGE=""
			fi
		else
			SPACEMESSAGE=""
		fi
	else
		SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$USRSPACE of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot is more than 1.5G for aarch64, more than 1.25G for armv7 and about 800M of free user space for x86 and x86_64 architectures.\\n\\e[0m"
	fi
}

_SPACEINFOQ_() {
	if [[ "$SUANSWER" != [Yy]* ]] ; then
		_SPACEINFO_
		if [[ -n "$SPACEMESSAGE" ]] ; then
			while true; do
				printf "\\n\\e[1;30m"
				read -n 1 -p "Continue with setupTermuxArch.bash? [Y|n] " SUANSWER
				if [[ "$SUANSWER" = [Ee]* ]] || [[ "$SUANSWER" = [Nn]* ]] || [[ "$SUANSWER" = [Qq]* ]] ; then
					printf "\\n"
					exit $?
				elif [[ "$SUANSWER" = [Yy]* ]] || [[ "$SUANSWER" = "" ]] ; then
					SUANSWER=yes
					printf "Continuing with setupTermuxArch.bash.\\n"
					break
				else
					printf "\\nYou answered \\e[33;1m$SUANSWER\\e[30m.\\n\\nAnswer \\e[32mYes\\e[30m or \\e[1;31mNo\\e[30m. [\\e[32my\\e[30m|\\e[1;31mn\\e[30m]\\n"
				fi
			done
		fi
	fi
}

_SPACEINFOKSIZE_() {
	_USERSPACE_
	if [[ "$CPUABI" = "$CPUABI8" ]] ; then
		if [[ "$USRSPACE" -lt "1500000" ]] ; then
			SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$USRSPACE $units of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\\n\\e[0m"
		else
			SPACEMESSAGE=""
		fi
	elif [[ "$CPUABI" = "$CPUABI7" ]] ; then
		if [[ "$USRSPACE" -lt "1250000" ]] ; then
			SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$USRSPACE $units of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for armv7 is 1.25G of free user space.\\n\\e[0m"
		else
			SPACEMESSAGE=""
		fi
	elif [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX86_64" ]] ; then
		if [[ "$USRSPACE" -lt "800000" ]] ; then
			SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$USRSPACE $units of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for x86 and x86_64 is 800M of free user space.\\n\\e[0m"
		else
			SPACEMESSAGE=""
		fi
	fi
}

_SYSINFO_() {
 	_NAMESTARTARCH_
	_SPACEINFO_
	printf "\\n\\e[1;32mGenerating TermuxArch system information; Please wait…\\n\\n"
	_SYSTEMINFO_ ## & spinner "Generating" "System Information…"
	printf "\\e[38;5;76m"
	cat "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "\\n\\e[1mThis information may be quite important when planning issue(s) at https://github.com/sdrausty/TermuxArch/issues with the hope of improving \`setupTermuxArch.bash\`;  Include input and output, along with screenshot(s) relavent to X, and similar.\\n\\n"
	exit
}

_SYSTEMINFO_ () {
	printf "Begin TermuxArch $VERSIONID system information.\\n" > "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "\\ndpkg --print-architecture result:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	dpkg --print-architecture >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "\\nuname -a results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	uname -a >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	for n in 0 1 2 3 4 5
	do
		echo "BASH_VERSINFO[$n] = ${BASH_VERSINFO[$n]}"  >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	done
	printf "\\ncat /proc/cpuinfo results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	cat /proc/cpuinfo >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "\\nDownload directory information results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	if [[ -d /sdcard/Download ]]; then echo "/sdcard/Download exists"; else echo "/sdcard/Download not found"; fi >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	if [[ -d /storage/emulated/0/Download ]]; then echo "/storage/emulated/0/Download exists"; else echo "/storage/emulated/0/Download not found"; fi >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	if [[ -d "$HOME"/downloads ]]; then echo "$HOME/downloads exists"; else echo "~/downloads not found"; fi >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	if [[ -d "$HOME"/storage/downloads ]]; then echo "$HOME/storage/downloads exists"; else echo "$HOME/storage/downloads not found"; fi >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "\\nDevice information results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	if [[ -e /dev/ashmem ]]; then echo "/dev/ashmem exists"; else echo "/dev/ashmem does not exist"; fi >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	if [[ -r /dev/ashmem ]]; then echo "/dev/ashmem is readable"; else echo "/dev/ashmem is not readable"; fi >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	if [[ -w /dev/ashmem ]]; then echo "/dev/ashmem is writable"; else echo "/dev/ashmem is not writable"; fi >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	if [[ -e /dev/shm ]]; then echo "/dev/shm exists"; else echo "/dev/shm does not exist"; fi >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	if [[ -r /dev/shm ]]; then echo "/dev/shm is readable"; else echo "/dev/shm is not readable"; fi >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	if [[ -e /proc/stat ]]; then echo "/proc/stat exits"; else echo "/proc/stat does not exit"; fi >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	if [[ -r /proc/stat ]]; then echo "/proc/stat is readable"; else echo "/proc/stat is not readable"; fi >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	[[ -e /sys/ashmem ]] && echo "/sys/ashmmem exists" || echo "/sys/ashmmem does not exist" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	[[ -r /sys/ashmmem ]] && echo "/sys/ashmmem is readable" || echo "/sys/ashmmem is not readable" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	[[ -e /sys/shm ]] && echo "/sys/shm exists" || echo "/sys/shm does not exist" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	[[ -r /sys/shm ]] && echo "/sys/shm is readable" || echo "/sys/shm is not readable" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
 	printf "\\ngetprop results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop gsm.sim.operator.iso-country]:" "[$(getprop gsm.sim.operator.iso-country)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop net.bt.name]:" "[$(getprop net.bt.name)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop net.dns1]:" "[$(getprop net.dns1)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop net.dns2]:" "[$(getprop net.dns2)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop net.dns3]:" "[$(getprop net.dns3)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop net.dns4]:" "[$(getprop net.dns4)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop persist.sys.locale]:" "[$(getprop persist.sys.locale)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.build.target_country]:" "[$(getprop ro.build.target_country)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.build.version.release]:" "[$(getprop ro.build.version.release)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.build.version.preview_sdk]:" "[$(getprop ro.build.version.preview_sdk)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.build.version.sdk]:" "[$(getprop ro.build.version.sdk)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.com.google.clientidbase]:" "[$(getprop ro.com.google.clientidbase)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.com.google.clientidbase.am]:" "[$(getprop ro.com.google.clientidbase.am)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.com.google.clientidbase.ms]:" "[$(getprop ro.com.google.clientidbase.ms)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.product.device]:" "[$(getprop ro.product.device)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.product.cpu.abi]:" "[$(getprop ro.product.cpu.abi)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.product.first_api_level]:" "[$(getprop ro.product.first_api_level)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.product.locale]:" "[$(getprop ro.product.locale)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.product.manufacturer]:" "[$(getprop ro.product.manufacturer)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "%s %s\\n" "[getprop ro.product.model]:" "[$(getprop ro.product.model)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "\\nDisk report $USRSPACE on /data $(date)\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "\\ndf $INSTALLDIR results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	df "$INSTALLDIR" >> "${WDIR}setupTermuxArchSysInfo$STIME".log 2>/dev/null ||:
	printf "\\ndf results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	df >> "${WDIR}setupTermuxArchSysInfo$STIME".log 2>/dev/null ||:
	printf "\\ndu -hs $INSTALLDIR results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	du -hs "$INSTALLDIR" >> "${WDIR}setupTermuxArchSysInfo$STIME".log 2>/dev/null ||:
	printf "\\nls -al $INSTALLDIR results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	ls -al "$INSTALLDIR" >> "${WDIR}setupTermuxArchSysInfo$STIME".log 2>/dev/null ||:
	printf "\\nEnd \`setupTermuxArchSysInfo$STIME.log\` $VERSIONID system information.\\n\\e[0m" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
	printf "\\nShare this information along with your issue at https://github.com/sdrausty/TermuxArch/issues; include input and output.  This file is found in \`""${WDIR}setupTermuxArchSysInfo$STIME.log\`.  If you think screenshots will help in a quicker resolution, include them in the post as well.  \\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
}

_USERSPACE_() {
	USRSPACE="$(df "$INSTALLDIR" 2>/dev/null | awk 'FNR == 2 {print $4}')"
	if [[ "$USRSPACE" = "" ]] ; then
		USRSPACE="$(df "$INSTALLDIR" 2>/dev/null | awk 'FNR == 3 {print $3}')"
	fi
}
# maintenanceroutines.bash EOF
