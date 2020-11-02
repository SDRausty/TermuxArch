#!/usr/bin/env bash
# Copyright 2017-2020 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project.
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
##  Running 'setupTermuxArch manual' will create 'setupTermuxArchConfigs.bash' from this file in the working directory.  Run 'setupTermuxArch' and file 'setupTermuxArchConfigs.bash' loads automaticaly once created, and this file is ignored at runtime; 'setupTermuxArch help' has additional information.  The mirror (information at https://wiki.archlinux.org/index.php/Mirrors and https://archlinuxarm.org/about/mirrors) can be changed to a desired geographic location in 'setupTermuxArchConfigs.bash' to resolve download, 404 and checksum issues should these take place.  User configurable variables are present in this file for your convenience:
# DMVERBOSE="-v" 	##  uncomment for verbose download tool output with curl and wget;  For verbose output throughout runtime change this setting in file 'setupTermuxArch' also.
ECHOEXEC=""		##  insert 'echo' to supress most 'pacman' instructions from 'keys' file during runtime
ECHOSYNC=""		##  insert 'echo' to only supress 'pacman' syncing instructions from 'keys' file during runtime
# DM=aria2c		##  uncomment to use this download tool
# DM=axel 		##  uncomment to use this download tool
# DM=curl		##  uncomment to use this download tool
# DM=lftp 		##  uncomment to use this download tool
# DM=wget		##  uncomment to use this download tool
KEEP=1			##  change to 0 to keep downloaded image;  Testing the installation process repeatedly can be made easier and lighter on your Internet bandwith and SAR with 'KEEP=0' and this fragment of code  'mkdir ~/arch; cp ~/ArchLinux*.tar.gz* ~/arch/' and similar.  The variable KEEP when changed to 0 (true) will keep the downloaded image and md5 files instead of deleting them for later reuse if desired.  The root file system image and md5 files can be saved and used again on subsequent installs when testing the install feature with this and similar fragments of code.
KOE=0			##  do not change, not user configurable;  Was previously used for testing, and variable KOE lingers here for retesting if desired.  Change to 1 to change the proot init statement.
# KID=1			##  do not change, not user configurable;  Used for testing, timing and development.   For timing Arch Linux in PRoot, uncomment and then run script TermuxArch/scripts/frags/stdoutbench.sh in Arch Linux PRoot for timing Arch Linux in PRoot if desired.
##  If there are system image files available not listed here, and if there are system image file worldwide mirrors available not listed here, please open an issue and a pull request.
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
##  Update: https://github.com/TermuxArch/TermuxArch/issues/25 Implementing QEMU #25 20201001 and https://github.com/TermuxArch/TermuxArch/issues/25 Implementing QEMU #25 20201001.
_I686_() { # IFILE is read from md5sums.txt
# CMIRROR="archive.archlinux32.org"
# RPATH="iso/latest"
# updating from 20170301 version does not work as of 2020 as Arch Linux 32 was updated beyondvthe currently publish root system file.
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
[[ -z "${QEMUCR:-}" ]] && CPUABI="$(getprop ro.product.cpu.abi)" && SYSVER="$(getprop ro.build.version.release)" && NASVER="$(getprop net.bt.name ) $SYSVER" || [[ $QEMUCR="0" ]] && SYSVER="$(getprop ro.build.version.release)" && NASVER="$(getprop net.bt.name) $(getprop ro.product.cpu.abi) $SYSVER" || _PSGI1ESTRING_ "CPUABI knownconfigurations.bash ${0##*/}"
PROOTSTMNT="exec proot "
if [[ -z "${KID:-}" ]]
then	# command 'grep -w KID *h' shows variable KID usage
PROOTSTMNT+="--kernel-release=$(uname -r)-generic "
elif [[ "$KID" = 0 ]]
then
PROOTSTMNT+="--kernel-release=4.14.15-generic "
else
PROOTSTMNT+=""
fi
if [[ "$KOE" = 0 ]]
then
PROOTSTMNT+="--kill-on-exit "
fi
PROOTSTMNT+="--link2symlink -i \"\$AR2AR:wheel\" -0 -r $INSTALLDIR "
# file var/binds/fbindexample.prs has a few more examples
if [[ -n "$(ls -A "$INSTALLDIR"/var/binds/*.prs)" ]]
then
for PRSFILES in "$INSTALLDIR"/var/binds/*.prs
do
. "$PRSFILES"
done
fi
if [[ -z "${QEMUCR:-}" ]]
then
:
else [[ "$QEMUCR" == 0 ]]
PROOTSTMNT+="-q $PREFIX/bin/qemu-$ARCHITEC "
fi
[[ "$SYSVER" -ge 10 ]] && PROOTSTMNT+="-b /apex:/apex "
##  Function _PR00TSTRING_ which creates the PRoot init statement PROOTSTMNT uses associative arrays.  Page https://www.gnu.org/software/bash/manual/html_node/Arrays.html has information about BASH arrays and is also available at https://www.gnu.org/software/bash/manual/ this link.
declare -A PRSTARR # associative array
# populate writable binds
PRSTARR=([/dev/ashmem]=/dev/ashmem [/dev/shm]=/dev/shm)
for PRBIND in ${!PRSTARR[@]}
do
if [[ -w "$PRBIND" ]]	# is writable
then	# add proot bind
PROOTSTMNT+="-b $PRBIND:$PRBIND "
fi
done
# populate readable binds
PRSTARR=([/dev/]=/dev/ [/dev/urandom]=/dev/random ["$EXTERNAL_STORAGE"]="$EXTERNAL_STORAGE" ["$HOME"]="$HOME" ["$PREFIX"]="$PREFIX" [/proc/]=/proc/ [/proc/self/fd]=/dev/fd [/proc/stat]=/proc/stat [/property_contexts]=/property_contexts [/storage/]=/storage/ [/sys/]=/sys/ [/system/]=/system/ [/vendor/]=/vendor/)
for PRBIND in ${!PRSTARR[@]}
do
if [[ -r "$PRBIND" ]]	# is readable
then	# add proot bind
PROOTSTMNT+="-b $PRBIND:${PRSTARR[$PRBIND]} "
fi
done
# populate NOT readable binds
PRSTARR=([/dev/]=/dev/ [/dev/ashmem]="$INSTALLDIR/tmp" [/dev/shm]="$INSTALLDIR/tmp" [/proc/stat]="$INSTALLDIR/var/binds/fbindprocstat" [/sys/]=/sys/ [/proc/uptime]="$INSTALLDIR/var/binds/fbindprocuptime")
for PRBIND in ${!PRSTARR[@]}
do
if [[ ! -r "$PRBIND" ]]	# is not readable
then	# add proot bind
PROOTSTMNT+="-b ${PRSTARR[$PRBIND]}:$PRBIND "
fi
done
PROOTSTMNT+="-w /root /usr/bin/env -i HOME=/root TERM=\"$TERM\" TMPDIR=/tmp ANDROID_DATA=/data " # create PRoot user string
PROOTSTMNTUUUU="${PROOTSTMNT//HOME=\/root/HOME=\/home\/\$AR2AR}" # create PRoot user string
PROOTSTMNTUUU="${PROOTSTMNTUUUU//-0 }"
PROOTSTMNTUU="${PROOTSTMNTUUU//-w \/root/-w \/home\/\$AR2AR}" # create PRoot user string with link2symlink option enabled
PROOTSTMNTU="${PROOTSTMNTUU//--link2symlink }" # create PRoot user string with link2symlink option disabled
PROOTSTMNT="${PROOTSTMNT//-i \"\$AR2AR:wheel\" }" # create PRoot root user string
}
_PR00TSTRING_
##  uncomment the next line to test function _PR00TSTRING_
#   printf "%s\\n" "$PROOTSTMNT" && printf "%s\\n" "$PROOTSTMNTU" && printf "%s\\n" "$PROOTSTMNTUU" && exit
##  The commands 'setupTermuxArch r[e[fresh]]' can be used to regenerate the start script to the newest version if there is a newer version published and can be customized as wanted.  Command 'setupTermuxArch refresh' will refresh the installation globally, including excecuting 'keys' and 'locales-gen' and backup user configuration files that were initially created and are refreshed.  The command 'setupTermuxArch re' will refresh the installation and update user configuration files and backup user configuration files that were initially created and are refreshed.  Command 'setupTermuxArch r' will only refresh the installation and update the root user configuration files and backup root user configuration files that were initially created and are refreshed.
# knownconfigurations.bash EOF
