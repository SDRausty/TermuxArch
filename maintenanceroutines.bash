#!/usr/bin/env bash
# Copyright 2017-2020 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project.
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################

_COPYIMAGE_() { # A systemimage.tar.gz file can be used: `setupTermuxArch ./[path/]systemimage.tar.gz` and `setupTermuxArch /absolutepath/systemimage.tar.gz`
if [[ "$LCP" = "0" ]]
then
printf "%s\n" "Copying $GFILE.md5 to $INSTALLDIR..."
cp "$GFILE".md5  "$INSTALLDIR"
printf "%s\n" "Copying $GFILE to $INSTALLDIR..."
cp "$GFILE" "$INSTALLDIR"
elif [[ "$LCP" = "1" ]]
then
printf "%s\n" "Copying $GFILE.md5 to $INSTALLDIR..."
cp "$WDIR$GFILE".md5  "$INSTALLDIR"
printf "%s\n" "Copying $GFILE to $INSTALLDIR..."
cp "$WDIR$GFILE" "$INSTALLDIR"
fi
GFILE="${GFILE##/*/}"
IFILE="${GFILE##*/}"
}

_DOFUNLCR2_() {
BKPDIR="$INSTALLDIR/var/backups/${INSTALLDIR##*/}/home/$USER"
_BKPTHF_() { # backup the user files
[[ ! -d "$BKPDIR/" ]] && mkdir -p "$BKPDIR/"
cd "$INSTALLDIR/home/$USER"
[[ -f $1 ]] && printf "\\e[1;32m==>\\e[0;32m %s" "File $1 backed up to /${INSTALLDIR##*/}/$1.$SDATE.bkp" && cp "$1" "$BKPDIR/$1.$SDATE.bkp" || _PSGI1ESTRING_ "cp '$1' if found maintenanceroutines.bash ${0##*/}"
}
if [ -d "$INSTALLDIR/home" ]
then
if [[ "$USER" != alarm ]]
then
export "$USER"
cp "$INSTALLDIR/root/bin/"* "$INSTALLDIR/home/$USER/bin/"
printf "\\n\\e[0;32mCopied files from \\e[0;32m%s to \\e[1;32m%s\\e[0;32m:\\e[0m\\n" "/${INSTALLDIR##*/}/root/bin/" "/${INSTALLDIR##*/}/home/$USER/bin/"
DOFLIST=(.bash_profile .bashrc .gitconfig .vimrc)
for DOFLNAME in "${DOFLIST[@]}"
do
_BKPTHF_ "$DOFLNAME"
cp "$INSTALLDIR/root/$DOFLNAME" "$INSTALLDIR/home/$USER/"
printf "\\n\\e[0;32mCopied file %s to \\e[1;32m%s\\e[0;32m.\\e[0m\\n" "/${INSTALLDIR##*/}/root/$DOFLNAME" "/${INSTALLDIR##*/}/home/$USER/$DOFLNAME"
done
fi
fi
cd "$INSTALLDIR/root"
}

_DOTHRF_() { # do the root user files
[[ -f $1 ]] && (printf "\\e[1;32m%s\\e[0;32m%s\\e[0m\\n" "==>" " cp $1 /var/backups/${INSTALLDIR##*/}/$1.$SDATE.bkp" && cp "$1" "$INSTALLDIR/var/backups/${INSTALLDIR##*/}/$1.$SDATE.bkp") || printf "%s" "copy file '$1' if found : file not found : continuing : "
}

_FUNLCR2_() { # copy from root to home/USER
export FLCRVAR=($(ls "$INSTALLDIR/home/"))
for USER in ${FLCRVAR[@]}
do
_DOFUNLCR2_
done
}

_LOADIMAGE_() {
_NAMESTARTARCH_
_SPACEINFO_
printf "\\n"
_WAKELOCK_
_PREPINSTALLDIR_
_COPYIMAGE_
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
"$INSTALLDIR/$STARTBIN" || _PRINTPROOTERROR_
set -Eeuo pipefail
_PRINTFOOTER2_
_PRINTSTARTBIN_USAGE_
exit
}

_FIXOWNER_() { # fix owner of INSTALLDIR/home/USER, PR9 by @petkar
_DOFIXOWNER_() {
printf "\\e[1;32m%s\\e[0m\\n" "Adjusting ownership and permissions..."
FXARR="$(ls "$INSTALLDIR/home")"
for USER in ${FXARR[@]}
do
if [[ "$USER" != alarm ]]
then
$STARTBIN c "chmod 777 $INSTALLDIR/home/$USER"
$STARTBIN c "chown -R $USER:$USER $INSTALLDIR/home/$USER"
fi
done
}
_DOFIXOWNER_ || _PSGI1ESTRING_ "_DOFIXOWNER_ maintenanceroutines.bash ${0##*/}"
}

_REFRESHSYS_() { # refresh installation
printf '\033]2; setupTermuxArch refresh 📲 \007'
_NAMESTARTARCH_
_SPACEINFO_
cd "$INSTALLDIR"
_SETLANGUAGE_
_PREPROOTDIR_ || _PSGI1ESTRING_ "_PREPROOTDIR_ _REFRESHSYS_ maintenanceroutines.bash ${0##*/}"
_ADDADDS_
_MAKEFINISHSETUP_
_MAKESETUPBIN_
_MAKESTARTBIN_
_SETLOCALE_
printf "\\n"
_WAKELOCK_
printf "\\e[1;32m==> \\e[1;37m%s \\e[1;32m%s %s...\\n" "Running" "${0##*/}" "$ARGS"
"$INSTALLDIR"/root/bin/setupbin.bash || _PRINTPROOTERROR_
rm -f root/bin/finishsetup.bash
rm -f root/bin/setupbin.bash
printf "\\n\\e[1;32mFiles updated to the newest version $VERSIONID:\\n\\e[0;32m"
ls "$INSTALLDIR/$STARTBIN" | cut -f7- -d /
ls "$INSTALLDIR"/bin/we | cut -f7- -d /
ls "$INSTALLDIR"/root/.bashrc | cut -f7- -d /
ls "$INSTALLDIR"/root/.bash_profile | cut -f7- -d /
ls "$INSTALLDIR"/root/.vimrc | cut -f7- -d /
ls "$INSTALLDIR"/root/.gitconfig | cut -f7- -d /
ls "$INSTALLDIR"/root/bin/* | cut -f7- -d /
if [[ "${LCR:-}" = 2 ]]
then
_FUNLCR2_
fi
printf "\\n"
_WAKEUNLOCK_
_PRINTFOOTER_
set +Eeuo pipefail
"$STARTBIN" || _PRINTPROOTERROR_
set -Eeuo pipefail
_PRINTFOOTER2_
_PRINTSTARTBIN_USAGE_
exit
}

_SPACEINFO_() {
declare SPACEMESSAGE=""
units="$(df "$INSTALLDIR" 2>/dev/null | awk 'FNR == 1 {print $2}')"
if [[ "$units" = Size ]]
then
_SPACEINFOGSIZE_
printf "$SPACEMESSAGE"
elif [[ "$units" = 1K-blocks ]]
then
_SPACEINFOKSIZE_
printf "$SPACEMESSAGE"
fi
}

_SPACEINFOGSIZE_() {
_USERSPACE_
if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX86_64" ]] || [[ "$CPUABI" = i386 ]]
then
if [[ "$USRSPACE" = *G ]]
then
SPACEMESSAGE=""
elif [[ "$USRSPACE" = *M ]]
then
usspace="${USRSPACE: : -1}"
if [[ "$usspace" < "800" ]]
then
SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$USRSPACE of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for x86 and x86_64 is 800M of free user space.\\n\\e[0m"
fi
fi
elif [[ "$USRSPACE" = *G ]]
then
usspace="${USRSPACE: : -1}"
if [[ "$CPUABI" = "$CPUABI8" ]]
then
if [[ "$usspace" < "1.5" ]]
then
SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  \\e[33m$USRSPACE of free user space is available on this device.  \\e[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\\n\\e[0m"
else
SPACEMESSAGE=""
fi
elif [[ "$CPUABI" = "$CPUABI7" ]]
then
if [[ "$usspace" < "1.23" ]]
then
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

_SPACEINFOKSIZE_() {
_USERSPACE_
if [[ "$CPUABI" = "$CPUABI8" ]]
then
if [[ "$USRSPACE" -lt "1500000" ]]
then
SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  There is \\e[33m$USRSPACE $units of free user space \\e[1;30mavailable on this device.  The recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\\n\\e[0m"
else
SPACEMESSAGE=""
fi
elif [[ "$CPUABI" = "$CPUABI7" ]]
then
if [[ "$USRSPACE" -lt "1250000" ]]
then
SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  There is \\e[33m$USRSPACE $units of free user space \\e[1;30mavailable on this device.  The recommended minimum to install Arch Linux in Termux PRoot for armv7 is 1.25G of free user space.\\n\\e[0m"
else
SPACEMESSAGE=""
fi
elif [[ "$CPUABI" = "$CPUABIX86_64" ]] || [[ "$CPUABI" = i386 ]]
then
if [[ "$USRSPACE" -lt "800000" ]]
then
SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  There is \\e[33m$USRSPACE $units of free user space \\e[1;30mavailable on this device.  The recommended minimum to install Arch Linux in Termux PRoot for x86_64 is 800M of free user space.\\n\\e[0m"
else
SPACEMESSAGE=""
fi
elif [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "i386" ]]
then
if [[ "$USRSPACE" -lt "600000" ]]
then
SPACEMESSAGE="\\n\\e[0;33mTermuxArch: \\e[1;33mFREE SPACE WARNING!  \\e[1;30mStart thinking about cleaning out some stuff.  There is \\e[33m$USRSPACE $units of free user space \\e[1;30mavailable on this device.  The recommended minimum to install Arch Linux in Termux PRoot for $CPUABI x86 is 600M of free user space.\\n\\e[0m"
else
SPACEMESSAGE=""
fi
fi
}

_SYSINFO_() {
_NAMESTARTARCH_
_SPACEINFO_
printf "\\n\\e[1;32mGenerating TermuxArch system information; Please wait...\\n\\n"
_SYSTEMINFO_ ## & spinner "Generating" "System Information..."
printf "\\e[38;5;76m"
cat "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "\\n\\e[1mThis information may be quite important when planning issue(s) at https://github.com/sdrausty/TermuxArch/issues with the hope of improving \`setupTermuxArch\`;  Include input and output, along with screenshot(s) relavent to X, and similar.\\n\\n"
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
printf "%s\n" "BASH_VERSINFO[$n] = ${BASH_VERSINFO[$n]}"  >> "${WDIR}setupTermuxArchSysInfo$STIME".log
done
printf "\\ncat /proc/cpuinfo results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
cat /proc/cpuinfo >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "\\nDownload directory information results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -d /sdcard/Download ]] && printf "%s\n" "/sdcard/Download exists" || printf "%s\n" "/sdcard/Download not found" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -d /storage/emulated/0/Download ]] && printf "%s\n" "/storage/emulated/0/Download exists" || printf "%s\n" "/storage/emulated/0/Download not found" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -d "$HOME"/downloads ]] && printf "%s\n" "$HOME/downloads exists" || printf "%s\n" "~/downloads not found" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -d "$HOME"/storage/downloads ]] && printf "%s\n" "$HOME/storage/downloads exists" || printf "%s\n" "$HOME/storage/downloads not found" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "\\nDevice information results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -e /dev/ashmem ]] && printf "%s\n" "/dev/ashmem exists" || printf "%s\n" "/dev/ashmem does not exist" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -r /dev/ashmem ]] && printf "%s\n" "/dev/ashmem is readable" || printf "%s\n" "/dev/ashmem is not readable" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -w /dev/ashmem ]] && printf "%s\n" "/dev/ashmem is writable" || printf "%s\n" "/dev/ashmem is not writable" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -e /dev/shm ]] && printf "%s\n" "/dev/shm exists" || printf "%s\n" "/dev/shm does not exist" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -r /dev/shm ]] && printf "%s\n" "/dev/shm is readable" || printf "%s\n" "/dev/shm is not readable" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -e /proc/stat ]] && printf "%s\n" "/proc/stat exits" || printf "%s\n" "/proc/stat does not exit" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -r /proc/stat ]] && printf "%s\n" "/proc/stat is readable" || printf "%s\n" "/proc/stat is not readable">> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -e /sys/ashmem ]] && printf "%s\n" "/sys/ashmmem exists" || printf "%s\n" "/sys/ashmmem does not exist" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -r /sys/ashmmem ]] && printf "%s\n" "/sys/ashmmem is readable" || printf "%s\n" "/sys/ashmmem is not readable" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -e /sys/shm ]] && printf "%s\n" "/sys/shm exists" || printf "%s\n" "/sys/shm does not exist" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
[[ -r /sys/shm ]] && printf "%s\n" "/sys/shm is readable" || printf "%s\n" "/sys/shm is not readable" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "\\ngetprop results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "%s %s\\n" "[getprop gsm.sim.operator.iso-country]:" "[$(getprop gsm.sim.operator.iso-country)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "%s %s\\n" "[getprop net.bt.name]:" "[$(getprop net.bt.name)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "%s %s\\n" "[getprop net.dns1]:" "[$(getprop net.dns1)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "%s %s\\n" "[getprop net.dns2]:" "[$(getprop net.dns2)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "%s %s\\n" "[getprop net.dns3]:" "[$(getprop net.dns3)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "%s %s\\n" "[getprop net.dns4]:" "[$(getprop net.dns4)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "%s %s\\n" "[getprop persist.sys.locale]:" "[$(getprop persist.sys.locale)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "%s %s\\n" "[getprop ro.build.target_country]:" "[$(getprop ro.build.target_country)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "%s %s\\n" "[getprop ro.build.version.release]:" "[$SYSVER(getprop ro.build.version.release)]" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
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
printf "\\n%s\\n" "Disk report $USRSPACE on /data $(date)\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "\\n%s\\n" "df $INSTALLDIR results:\\n\\n" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
df "$INSTALLDIR" >> "${WDIR}setupTermuxArchSysInfo$STIME".log 2>/dev/null ||:
printf "\\n%s\\n\\n" "df results:" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
df >> "${WDIR}setupTermuxArchSysInfo$STIME".log 2>/dev/null ||:
printf "\\n%s\\n\\n" "du -hs $INSTALLDIR results:" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
du -hs "$INSTALLDIR" >> "${WDIR}setupTermuxArchSysInfo$STIME".log 2>/dev/null ||:
printf "\\n%s\\n\\n" "ls -al $INSTALLDIR results:" >> "${WDIR}setupTermuxArchSysInfo$STIME".log
ls -al "$INSTALLDIR" >> "${WDIR}setupTermuxArchSysInfo$STIME".log 2>/dev/null ||:
printf "\\n%s\\e[0m\\n" "End \`setupTermuxArchSysInfo$STIME.log\` $VERSIONID system information." >> "${WDIR}setupTermuxArchSysInfo$STIME".log
printf "%s\\n" "Share along with an issue and pull request at https://github.com/TermuxArch/TermuxArch/issues; include input and output.  This file is found in \`""${WDIR}setupTermuxArchSysInfo$STIME.log\`.  If you think screenshots will help in a quicker resolution, include them as well." >> "${WDIR}setupTermuxArchSysInfo$STIME".log
}

_USERSPACE_() {
USRSPACE="$(df "$INSTALLDIR" 2>/dev/null | awk 'FNR == 2 {print $4}')"
if [[ "$USRSPACE" = "" ]]
then
USRSPACE="$(df "$INSTALLDIR" 2>/dev/null | awk 'FNR == 3 {print $3}')"
fi
}
# maintenanceroutines.bash EOF
