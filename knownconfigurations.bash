#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
#  Running 'setupTermuxArch manual' will create 'setupTermuxArchConfigs.bash' from this file in the working directory.  Run 'setupTermuxArch' and file 'setupTermuxArchConfigs.bash' loads automatically once created, and file 'knownconfigurations.bash' is ignored at runtime; 'setupTermuxArch help' has additional information.  The mirror (information at https://wiki.archlinux.org/index.php/Mirrors and https://archlinuxarm.org/about/mirrors) can be changed to a desired geographic location in 'setupTermuxArchConfigs.bash' to resolve download, 404 and checksum issues should these take place.  User configurable variables are present in this file for your convenience:
## DM=aria2c		##  uncomment to use this download tool
## DM=axel 		##  uncomment to use this download tool
## DM=curl		##  uncomment to use this download tool
## DM=lftp 		##  uncomment to use this download tool
## DM=wget		##  uncomment to use this download tool
## DMVERBOSE="-v" 	##  uncomment for verbose download tool output with curl and wget;  For verbose output throughout runtime change this setting in file 'setupTermuxArch' also.
ECHOEXEC=""		##  insert 'echo' to suppress most 'pacman' instructions from 'keys' file during runtime
ECHOSYNC=""		##  insert 'echo' to only suppress 'pacman' syncing instructions from 'keys' file during runtime
KEEP=0			##  change to 1 to delete downloaded image;  Testing the installation process repeatedly can be made easier and lighter on your Internet bandwidth and SAR with 'KEEP=0' and this fragment of code  'mkdir ~/arch; cp ~/ArchLinux*.tar.gz* ~/arch/' and similar.  The variable KEEP when set to 0 (true) will keep the downloaded image and md5 files instead of deleting them for possible reuse.  The root file system image and md5 files can be saved and used again with subsequent installations.
USECACHEDIR=0		##  set to 0 in order to use cache directory;  This installation script uses a cache directory that can be used to cache all of the installation files in order to save wireless bandwidth upon subsequent reinstallation.  Variable `KEEP=0` should also be set to 0 in order to keep the downloaded image file and md5 files. The downloaded image and md5 files can be moved to CACHEDIR from INSTALLDIR/var/cache/pacman/pkg with the command 'trim' in order to avoid redownloading files in order to reinstall the Arch Linux system in Termux PRoot QEMU.
CACHLCTN="/storage/emulated/0"	##  change to external sdcard path if desired.
CACHEDIR="$CACHLCTN/Android/data/com.termux/files/cache/archlinux/$ARCTEVAR/"
PREFIXDATAFILES="$CACHLCTN/Android/data/com.termux/"
# KID=1			##  do not change, not user configurable;  Used for testing, timing and development.   For timing Arch Linux in PRoot, uncomment and then run script TermuxArch/scripts/frags/stdoutbench.sh in Arch Linux PRoot for timing Arch Linux in PRoot.
##  If there are system image files available not listed here please open an issue and a pull request.

_AARCH64ANDROID_() {
IFILE="ArchLinuxARM-aarch64-latest.tar.gz"
CMIRROR="os.archlinuxarm.org"
RPATH="os"
_MAKESYSTEM_
}

_AARCH64CHROME_() {
IFILE="ArchLinuxARM-aarch64-chromebook-latest.tar.gz"
CMIRROR="os.archlinuxarm.org"
RPATH="os"
_MAKESYSTEM_
}

_ARMV5L_() {
IFILE="ArchLinuxARM-armv5-latest.tar.gz"
CMIRROR="os.archlinuxarm.org"
RPATH="os"
_MAKESYSTEM_
}

_ARMV7ANDROID_() {
IFILE="ArchLinuxARM-armv7-latest.tar.gz"
CMIRROR="os.archlinuxarm.org"
RPATH="os"
_MAKESYSTEM_
}

_ARMV7CHROME_() {
IFILE="ArchLinuxARM-armv7-chromebook-latest.tar.gz"
CMIRROR="os.archlinuxarm.org"
RPATH="os"
_MAKESYSTEM_
}

##  Information at https://www.archlinux.org/news/phasing-out-i686-support/ and https://archlinux32.org/ regarding why i686 is currently frozen at release 2017.03.01-i686.
##  UPDATE: These topics have the most current information about Arch Linux 32 [Implementing QEMU #25](https://github.com/TermuxArch/TermuxArch/issues/25) and  [[SOLVED - Hurrah!] Upgrading from a truly ancient install.](https://bbs.archlinux32.org/viewtopic.php?id=2982)
_I686_() { # IFILE is read from md5sums.txt
CMIRROR="archive.archlinux.org"
RPATH="iso/2017.03.01"
_MAKESYSTEM_
}

_X86_64_() { # IFILE is read from md5sums.txt
CMIRROR="mirror.rackspace.com"
RPATH="archlinux/iso/latest"
_MAKESYSTEM_
}

##  Appending to the PRoot statement can be accomplished on the fly by creating a .prs file in the var/binds directory.  The format is straightforward, 'PROOTSTMNT+="option command "'.  The space is required before the last double quote.  Commands 'info proot' and 'man proot' have more information about what can be configured in a proot init statement.  If more suitable configurations are found, share them at https://github.com/TermuxArch/TermuxArch/issues to improve TermuxArch.  PRoot bind usage: PROOTSTMNT+="-b host_path:guest_path "  The space before the last double quote is necessary.

_PR00TSTRING_() { # construct the PRoot init statement
[[ -z "${QEMUCR:-}" ]] && CPUABI="$(getprop ro.product.cpu.abi)" && SYSVER="$(getprop ro.build.version.release)" && NASVER="$(getprop net.bt.name ) $SYSVER" || [[ $QEMUCR="0" ]] && SYSVER="$(getprop ro.build.version.release)" && NASVER="$(getprop net.bt.name) $SYSVER $(getprop ro.product.cpu.abi)" || _PSGI1ESTRING_ "CPUABI knownconfigurations.bash ${0##*/}"
PROOTSTMNT="exec proot "
if [[ -z "${KID:-}" ]]
then	# command 'grep -w KID *h' shows variable KID usage
PROOTSTMNT+="--kernel-release=$UNAMER "
elif [[ "$KID" = 0 ]]
then
PROOTSTMNT+="--kernel-release=4.14.16 "
else
PROOTSTMNT+=""
fi
PROOTSTMNT+="--kill-on-exit --sysvipc --link2symlink -i \"\$2:wheel\" -0 -r $INSTALLDIR "
if [[ "${QEMUCR:-}" == 0 ]]
then
PROOTSTMNT+="-q $PREFIX/bin/qemu-$ARCTEVAR "
fi
##  Function _PR00TSTRING_ which creates the PRoot init statement PROOTSTMNT uses associative arrays.  Page https://www.gnu.org/software/bash/manual/html_node/Arrays.html has information about BASH arrays and is also available at https://www.gnu.org/software/bash/manual/ this link.
declare -A PRSTARR # associative array
# populate writable binds
PRSTARR=([/dev/ashmem]=/dev/ashmem [/dev/kvm]=/dev/kvm [/dev/shm]=/dev/shm)
for PRBIND in ${!PRSTARR[@]}
do
if [[ -w "$PRBIND" ]]	# is writable
then	# add proot bind
PROOTSTMNT+="-b $PRBIND:$PRBIND "
fi
done
# populate readable binds
PRSTARR=(["$EXTERNAL_STORAGE"]="$EXTERNAL_STORAGE" ["$HOME"]="$HOME" ["$PREFIX"]="$PREFIX" [/apex/]=/apex/ [/data/dalvik-cache/]=/data/dalvik-cache/ [/dev/]=/dev/ [/dev/urandom]=/dev/random [/linkerconfig/ld.config.txt]=/linkerconfig/ld.config.txt [/plat_property_contexts]=/plat_property_contexts [/property_contexts]=/property_contexts [/proc/]=/proc/ [/proc/self/fd]=/dev/fd [/proc/self/fd/0]=/dev/stdin [/proc/self/fd/1]=/dev/stdout [/proc/self/fd/2]=/dev/stderr [/proc/stat]=/proc/stat [/property_contexts]=/property_contexts [/storage/]=/storage/ [/system/]=/system/ [/vendor/]=/vendor/)
for PRBIND in ${!PRSTARR[@]}
do
if [[ -r "$PRBIND" ]]	# is readable
then	# add proot bind
PROOTSTMNT+="-b $PRBIND:${PRSTARR[$PRBIND]} "
fi
done
[[ "$SYSVER" -ge 10 ]] && PROOTSTMNT+="-b /apex -b /storage -b /sys -b /system -b /vendor "
# populate NOT readable binds
PRSTARR=([/dev/]=/dev/ [/dev/ashmem]="$INSTALLDIR/tmp" [/dev/kvm]="$INSTALLDIR/var/binds/fbindkvm" [/dev/shm]="$INSTALLDIR/tmp" [/proc/loadavg]="$INSTALLDIR/var/binds/fbindprocloadavg" [/proc/pcidevices]="$INSTALLDIR/var/binds/fbindprocpcidevices" [/proc/shmem]="$INSTALLDIR/var/binds/fbindprocshmem" [/proc/stat]="$INSTALLDIR/var/binds/fbindprocstat" [/proc/uptime]="$INSTALLDIR/var/binds/fbindprocuptime" [/proc/vmstat]="$INSTALLDIR/var/binds/fbindprocvmstat" [/proc/version]="$INSTALLDIR/var/binds/fbindprocversion" [/sys/devices]="$INSTALLDIR/var/binds/fbindsysdevices")
for PRBIND in ${!PRSTARR[@]}
do
if [[ ! -r "$PRBIND" ]]	# is not readable
then	# add proot bind
PROOTSTMNT+="-b ${PRSTARR[$PRBIND]}:$PRBIND "
fi
done
# file var/binds/fbindexample.prs has examples
if [[ -n "$(ls -A "$INSTALLDIR"/var/binds/*.prs)" ]]
then
for PRSFILES in "$INSTALLDIR"/var/binds/*.prs
do
. "$PRSFILES"
done
fi
PROOTSTMNT+="-b /data/data/com.termux/files/usr/tmp:/tmp -w /root /usr/bin/env -i HOME=/root TERM=\"$TERM\" TMPDIR=/tmp ANDROID_DATA=/data "
PROOTSTMNTU="${PROOTSTMNT//HOME=\/root/HOME=\/home\/\$2}"
PROOTSTMNTU="${PROOTSTMNTU//-0 }"
PROOTSTMNTU="${PROOTSTMNTU//-w \/root/-w \/home\/\$2}" # PRoot user string with link2symlink option enabled
PROOTSTMNTEU="${PROOTSTMNTU//--link2symlink }" # PRoot user string with link2symlink option disabled
PROOTSTMNT="${PROOTSTMNT//-i \"\$2:wheel\" }" # PRoot root user string
}
_PR00TSTRING_
##  printf "\\n%s\\n" "PROOTSTMNT string [root]:" && printf "%s\\n\\n" "${PROOTSTMNT:-}" && printf "%s\\n" "PROOTSTMNTC string [root command]:" && printf "%s\\n\\n" "${PROOTSTMNTU:-}" && printf "%s\\n" "PROOTSTMNTEU string [elogin]:" && printf "%s\\n\\n" "${PROOTSTMNTU:-}" && printf "%s\\n" "PROOTSTMNTU string [login]:" && printf "%s\\n\\n" "${PROOTSTMNTU:-}" && printf "%s\\n" "PROOTSTMNTPRTR string [raw]:" && printf "%s\\n\\n" "${PROOTSTMNT:-}" && printf "%s\\n" "PROOTSTMNTPSLC string [su login command]:" && printf "%s\\n\\n" "${PROOTSTMNT:-}" && exit
##  The commands 'setupTermuxArch r[e[fresh]]' can be used to regenerate the start script to the newest version if there is a newer version published and can be customized as wanted.  Command 'setupTermuxArch refresh' will refresh the installation globally, including executing 'keys' and 'locales-gen' and backup user configuration files that were initially created and are refreshed.  The command 'setupTermuxArch re' will refresh the installation and update user configuration files and backup user configuration files that were initially created and are refreshed.  Command 'setupTermuxArch r' will only refresh the installation and update the root user configuration files and backup root user configuration files that were initially created and are refreshed.
# knownconfigurations.bash FE
