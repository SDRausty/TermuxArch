#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project. 
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
################################################################################
# Running `setupTermuxArch.sh manual` shall create `setupTermuxArchConfigs.sh` from this file in the working directory.  Run `setupTermuxArch.sh` and `setupTermuxArchConfigs.sh` loads automaticaly and this file is ignored at runtime; `setupTermuxArch.sh help` has additional information.  Change mirror (https://wiki.archlinux.org/index.php/Mirrors and https://archlinuxarm.org/about/mirrors) to desired geographic location in `setupTermuxArchConfigs.sh` to resolve download, 404 and checksum issues.  The following user configurable variables are available in this file:   
# Change DMVERBOSE in `setupTermuxArch.sh` for verbose output throughout runtime.
# DMVERBOSE="-v" 	# Uncomment for verbose output with curl and wget.
# dm=aria2c		# Uncomment to use aria2 as the download tool.
# dm=axel 		# Uncomment to use lftp as the download tool.
# dm=curl		# Uncomment to use curl as the download tool.
# dm=lftp 		# Uncomment to use lftp as the download tool.
# dm=wget		# Uncomment to use wget as the download tool.
# _EXAMPLE_() {		# Match the architecture on the device with one of the functions below. This is a guide for filling out the functions below.  Alternatively, use the matrices below the functions, and fill th out instead.  
# 	STYPE=md5sum # ( "" md5sum sha256sum sha512sum )
# 	SRMFILE=ArchLinuxARM-armv7-latest.tar.gz.md5
# 	file=ArchLinuxARM-armv7-latest.tar.gz
# 	CMIRROR=os.archlinuxarm.org
# 	path=/os/
# 	_MAKESYSTEM_ 
# }

_AARCH64_() {
	PRTCL="${SPECS_ARMV8L_[PROTOCOL]}"
	STYPE="${SPECS_ARMV8L_[STYPE]}"
	SRMFILE="${SPECS_ARMV8L_[SFNM]}"
	file="${SPECS_ARMV8L_[FILE]}"
	CMIRROR="${SPECS_ARMV8L_[SITE]}"
	path="${SPECS_ARMV8L_[RPATH]}"
	_MAKESYSTEM_ 
}

_ARMV5L_() {
	PRTCL="${SPECS_ARMV5L_[PROTOCOL]}"
	STYPE="${SPECS_ARMV5L_[STYPE]}"
	SRMFILE="${SPECS_ARMV5L_[SFNM]}"
	file="${SPECS_ARMV5L_[FILE]}"
	CMIRROR="${SPECS_ARMV5L_[SITE]}"
	path="${SPECS_ARMV5L_[RPATH]}"
	_MAKESYSTEM_ 
}

armv7lAndroid () {
	PRTCL="${SPECS_ARMV7L_[PROTOCOL]}"
	STYPE="${SPECS_ARMV7L_[STYPE]}"
	SRMFILE="${SPECS_ARMV7L_[SFNM]}"
	file="${SPECS_ARMV7L_[FILE]}"
	CMIRROR="${SPECS_ARMV7L_[SITE]}"
	path="${SPECS_ARMV7L_[RPATH]}"
	_MAKESYSTEM_ 
}

armv7lChrome() {
	PRTCL="${SPECS_ARMV7LC_[PROTOCOL]}"
	STYPE="${SPECS_ARMV7LC_[STYPE]}"
	SRMFILE="${SPECS_ARMV7LC_[SFNM]}"
	file="${SPECS_ARMV7LC_[FILE]}"
	CMIRROR="${SPECS_ARMV7LC_[SITE]}"
	path="${SPECS_ARMV7LC_[RPATH]}"
	_MAKESYSTEM_ 
}

_X86_() { # Information at https://www.archlinux.org/news/phasing-out-i686-support/ and https://archlinux32.org/ regarding why X86 is currently frozen at release 2017.03.01-i686.  $file is read from md5sums.txt 
	PRTCL="${SPECS_X86_[PROTOCOL]}"
	STYPE="${SPECS_X86_[STYPE]}"
	SRMFILE="${SPECS_X86_[SFNM]}"
	file="${SPECS_X86_[FILE]}"
	CMIRROR="${SPECS_X86_[SITE]}"
	path="${SPECS_X86_[RPATH]}"
	_MAKESYSTEM_ 
}

_X86_64_() { # $file is read from md5sums.txt
	PRTCL="${SPECS_X86_64_[PROTOCOL]}"
	STYPE="${SPECS_X86_64_[STYPE]}"
	SRMFILE="${SPECS_X86_64_[SFNM]}"
	file="${SPECS_X86_64_[FILE]}"
	CMIRROR="${SPECS_X86_64_[SITE]}"
	path="${SPECS_X86_64_[RPATH]}"
	_MAKESYSTEM_ 
}

CSYSTEM="Arch Linx"
# Match the architecture in the device with one of the matrices below.  
SPECS_ARMV8L_=( [DIST]="$CSYSTEM" [FILE]="ArchLinuxARM-aarch64-latest.tar.gz" [PROTOCOL]="https" [RPATH]="/os/" [SITE]="os.archlinuxarm.org" [SFNM]="ArchLinuxARM-aarch64-latest.tar.gz.md5" [STYPE]="md5sum" )
SPECS_ARMV5L_=( [DIST]="$CSYSTEM" [FILE]="ArchLinuxARM-armv5-latest.tar.gz" [PROTOCOL]="https" [RPATH]="/os/" [SITE]="os.archlinuxarm.org" [SFNM]="ArchLinuxARM-armv5-latest.tar.gz.md5" [STYPE]="md5sum" )
SPECS_ARMV7L_=( [DIST]="$CSYSTEM" [FILE]="ArchLinuxARM-armv7-latest.tar.gz" [PROTOCOL]="https" [RPATH]="/os/" [SITE]="os.archlinuxarm.org" [SFNM]="ArchLinuxARM-armv7-latest.tar.gz.md5" [STYPE]="md5sum" )
SPECS_ARMV7LC_=( [DIST]="$CSYSTEM" [FILE]="ArchLinuxARM-armv7-chromebook-latest.tar.gz" [PROTOCOL]="https" [RPATH]="/os/" [SITE]="os.archlinuxarm.org" [SFNM]="ArchLinuxARM-armv7-chromebook-latest.tar.gz.md5sum" [STYPE]="md5sum" )
SPECS_X86_=( [DIST]="$CSYSTEM" [FILE]="" [PROTOCOL]="https" [RPATH]="/iso/2017.03.01/" [SITE]="archive.archlinux.org" [SFNM]="md5sums.txt" [STYPE]="md5sum" )
SPECS_X86_64_=( [DIST]="$CSYSTEM" [FILE]="" [PROTOCOL]="https" [RPATH]="/archlinux/iso/latest/" [SITE]="mirror.rackspace.com" [SFNM]="md5sums.txt" [STYPE]="md5sum" )
## To regenerate the start script use \`setupTermuxArch.sh re[fresh]\`.  An example is included for convenience.  Usage: PROOTSTMNT+=\"-b host_path:guest_path \" The space before the last double quote is necessary.  Appending to the PRoot statement can be accomplished on the fly by creating a *.prs file in /var/binds.  The format is straightforward, `PROOTSTMNT+="option command "`.  The space is required before the last double quote.  `info proot` and `man proot` have more information about what can be configured in a proot init statement.  `setupTermuxArch.sh manual refresh` will refresh the installation globally.  Share more suitable configurations at https://github.com/sdrausty/TermuxArch/issues to improve TermuxArch.
_PR00TSTRING_() { 
PROOTSTMNT="exec proot "
if [[ -z "${KID:-}" ]] ; then
	PROOTSTMNT+=""
elif [[ "$KID" ]] ; then
 	PROOTSTMNT+="--kernel-release=4.14.15 "
fi
PROOTSTMNT+="--kill-on-exit --link2symlink -0 -r $INSTALLDIR "
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
PROOTSTMNT+="-b /dev/ -b /proc/ -b /storage/ -b /sys/ -w "/" /usr/bin/env -i HOME=/root TERM=$TERM "
PROOTSTMNTU="${PROOTSTMNT//--link2symlink }"
}
_PR00TSTRING_

# EOF
