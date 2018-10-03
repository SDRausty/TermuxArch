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

_EXAMPLE_() { # Match the architecture on the device with one of the functions below. This example function is a guide for filling out the functions below.  
	STYPE=md5sum #( "" md5sum sha256sum sha512sum )
	SRMFILE=ArchLinuxARM-armv7-latest.tar.gz.md5
	file=ArchLinuxARM-armv7-latest.tar.gz
	CMIRROR=os.archlinuxarm.org
	path=/os/
	_MAKESYSTEM_ 
}

_AARCH64_() {
	STYPE="${SPECS_ARMV8L_[STYPE]}"
	SRMFILE="${SPECS_ARMV8L_[SFNM]}"
	file="${SPECS_ARMV8L_[FILE]}"
	CMIRROR="${SPECS_ARMV8L_[SITE]}"
	path="${SPECS_ARMV8L_[RPATH]}"
	_MAKESYSTEM_ 
}

_ARMV5L_() {
	STYPE="${SPECS_ARMV5L_[STYPE]}"
	SRMFILE="${SPECS_ARMV5L_[SFNM]}"
	file="${SPECS_ARMV5L_[FILE]}"
	CMIRROR="${SPECS_ARMV5L_[SITE]}"
	path="${SPECS_ARMV5L_[RPATH]}"
	_MAKESYSTEM_ 
}

armv7lAndroid () {
	STYPE="${SPECS_ARMV7L_[STYPE]}"
	SRMFILE="${SPECS_ARMV7L_[SFNM]}"
	file="${SPECS_ARMV7L_[FILE]}"
	CMIRROR="${SPECS_ARMV7L_[SITE]}"
	path="${SPECS_ARMV7L_[RPATH]}"
	_MAKESYSTEM_ 
}

armv7lChrome() {
	STYPE="${SPECS_ARMV7LC_[STYPE]}"
	SRMFILE="${SPECS_ARMV7LC_[SFNM]}"
	file="${SPECS_ARMV7LC_[FILE]}"
	CMIRROR="${SPECS_ARMV7LC_[SITE]}"
	path="${SPECS_ARMV7LC_[RPATH]}"
	_MAKESYSTEM_ 
}

_X86_() { # $file is read from md5sums.txt
	STYPE="${SPECS_X86_[STYPE]}"
	SRMFILE="${SPECS_X86_[SFNM]}"
	CMIRROR="${SPECS_X86_[SITE]}"
	path="${SPECS_X86_[RPATH]}"
	_MAKESYSTEM_ 
}

_X86_64_() { # $file is read from md5sums.txt
	STYPE="${SPECS_X86_64_[STYPE]}"
	SRMFILE="${SPECS_X86_64_[SFNM]}"
	CMIRROR="${SPECS_X86_64_[SITE]}"
	path="${SPECS_X86_64_[RPATH]}"
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
