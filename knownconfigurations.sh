#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project. 
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# _STANDARD_="function name" && STANDARD="variable name" are under construction.
################################################################################
# Running `setupTermuxArch.sh manual` shall create `setupTermuxArchConfigs.sh` from this file in the working directory.  Run `setupTermuxArch.sh` and `setupTermuxArchConfigs.sh` loads automaticaly and this file is ignored at runtime; `setupTermuxArch.sh help` has additional information.  Change mirror (https://wiki.archlinux.org/index.php/Mirrors and https://archlinuxarm.org/about/mirrors) to desired geographic location in `setupTermuxArchConfigs.sh` to resolve download, 404 and checksum issues.  The following user configurable variables are available in this file:   
# DMVERBOSE="-v" 	# Uncomment for verbose download tool output with curl and wget;  for verbose output throughout runtime, change this setting in `setupTermuxArch.sh` also.
# dm=aria2c		# Uncomment to use this download tool. 
# dm=axel 		# Uncomment to use this download tool.
# dm=curl		# Uncomment to use the curl download tool.
# dm=lftp 		# Uncomment to use this download tool.
# dm=wget		# Uncomment to use the wget download tool.
KOE=1

_AARCH64_() {
	file=ArchLinuxARM-aarch64-latest.tar.gz
	CMIRROR=os.archlinuxarm.org
	path=/os/
	_MAKESYSTEM_ 
}

_ARMV5L_() {
	file=ArchLinuxARM-armv5-latest.tar.gz
	CMIRROR=os.archlinuxarm.org
	path=/os/
	_MAKESYSTEM_ 
}

armv7lAndroid () {
	file=ArchLinuxARM-armv7-latest.tar.gz 
	CMIRROR=os.archlinuxarm.org
	path=/os/
	_MAKESYSTEM_ 
}

armv7lChrome() {
	file=ArchLinuxARM-armv7-chromebook-latest.tar.gz
	CMIRROR=os.archlinuxarm.org
	path=/os/
	_MAKESYSTEM_ 
}

# Information at https://www.archlinux.org/news/phasing-out-i686-support/ and https://archlinux32.org/ regarding why i686 is currently frozen at release 2017.03.01-i686.  $file is read from md5sums.txt

_I686_() { 
	CMIRROR=archive.archlinux.org
	path=/iso/2017.03.01/
	_MAKESYSTEM_ 
}

_X86_64_() { # $file is read from md5sums.txt
	CMIRROR=mirror.rackspace.com
	path=/archlinux/iso/latest/
	_MAKESYSTEM_ 
}

## To regenerate the start script use \`setupTermuxArch.sh re[fresh]\`.  An example is included for convenience.  Usage: PROOTSTMNT+=\"-b host_path:guest_path \" The space before the last double quote is necessary.  Appending to the PRoot statement can be accomplished on the fly by creating a *.prs file in /var/binds.  The format is straightforward, `PROOTSTMNT+="option command "`.  The space is required before the last double quote.  `info proot` and `man proot` have more information about what can be configured in a proot init statement.  `setupTermuxArch.sh manual refresh` will refresh the installation globally.  If more suitable configurations are found, share them at https://github.com/sdrausty/TermuxArch/issues to improve TermuxArch.  

_PR00TSTRING_() { 
PROOTSTMNT="exec proot "
if [[ -z "${KID:-}" ]] ; then
	PROOTSTMNT+=""
elif [[ "$KID" ]] ; then
 	PROOTSTMNT+="--kernel-release=4.14.15 "
fi
if [[ "${KOE:-}" ]] ; then
	PROOTSTMNT+="--kill-on-exit "
fi
PROOTSTMNT+="--link2symlink -0 -r $INSTALLDIR "
if [[ ! -r /dev/ashmem ]] ; then
	PROOTSTMNT+="-b $INSTALLDIR/tmp:/dev/ashmem " 
fi
if [[ ! -r /dev/shm ]] ; then
	PROOTSTMNT+="-b $INSTALLDIR/tmp:/dev/shm " 
fi
if [[ ! -r /proc/stat ]] ; then
	PROOTSTMNT+="-b $INSTALLDIR/var/binds/fbindprocstat:/proc/stat " 
fi
if [[ -n "$(ls -A "$INSTALLDIR"/var/binds/*.prs)" ]] ; then
    for PRSFILES in "$INSTALLDIR"/var/binds/*.prs ; do
      . "$PRSFILES"
    done
fi
PROOTSTMNT+="-b \"\$ANDROID_DATA\" -b /dev/ -b \"\$EXTERNAL_STORAGE\" -b \"\$HOME\" -b /proc/ -b /storage/ -b /sys/ -w \"\$PWD\" /usr/bin/env -i HOME=/root TERM=$TERM "
PROOTSTMNTU="${PROOTSTMNT//--link2symlink }"
}
_PR00TSTRING_

# EOF
