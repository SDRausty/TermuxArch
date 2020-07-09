#!/usr/bin/env bash
# Copyright 2017-2020 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project. 
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
################################################################################
# Running `setupTermuxArch.bash manual` shall create `setupTermuxArchConfigs.bash` from this file in the working directory.  Run `setupTermuxArch.bash` and `setupTermuxArchConfigs.bash` loads automaticaly and this file is ignored at runtime; `setupTermuxArch.bash help` has additional information.  Change mirror (https://wiki.archlinux.org/index.php/Mirrors and https://archlinuxarm.org/about/mirrors) to desired geographic location in `setupTermuxArchConfigs.bash` to resolve download, 404 and checksum issues.  The following user configurable variables are available in this file:   
# DMVERBOSE="-v" 	# Uncomment for verbose download tool output with curl and wget;  for verbose output throughout runtime, change this setting in `setupTermuxArch.bash` also.
# DM=aria2c		# Uncomment to use this download tool. 
# DM=axel 		# Uncomment to use this download tool.
# DM=curl		# Uncomment to use the curl download tool.
# DM=lftp 		# Uncomment to use this download tool.
# DM=wget		# Uncomment to use the wget download tool.
KOE=1

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

# Information at https://www.archlinux.org/news/phasing-out-i686-support/ and https://archlinux32.org/ regarding why i686 is currently frozen at release 2017.03.01-i686.  $IFILE is read from md5sums.txt

_I686_() { 
	CMIRROR="archive.archlinux.org"
	RPATH="iso/2017.03.01"
	_MAKESYSTEM_ 
}

_X86_64_() { # $IFILE is read from md5sums.txt
	CMIRROR="mirror.rackspace.com"
	RPATH="archlinux/iso/latest"
	_MAKESYSTEM_ 
}

## To regenerate the start script use \`setupTermuxArch.bash re[fresh]\`.  An example is included for convenience.  Usage: PROOTSTMNT+=\"-b host_path:guest_path \" The space before the last double quote is necessary.  Appending to the PRoot statement can be accomplished on the fly by creating a *.prs file in /var/binds.  The format is straightforward, `PROOTSTMNT+="option command "`.  The space is required before the last double quote.  `info proot` and `man proot` have more information about what can be configured in a proot init statement.  `setupTermuxArch.bash manual refresh` will refresh the installation globally.  If more suitable configurations are found, share them at https://github.com/TermuxArch/TermuxArch/issues to improve TermuxArch.  

_PR00TSTRING_() { 
	PROOTSTMNT="exec proot " # The space before the last double quote is necessary.
       	if [[ -z "${KID:-}" ]]
	then
	       	PROOTSTMNT+=""
       	elif [[ "$KID" ]]
	then
	       	PROOTSTMNT+="--kernel-release=4.14.15 "
       	fi
       	if [[ "${KOE:-}" ]]
	then
	       	PROOTSTMNT+="--kill-on-exit "
       	fi
       	PROOTSTMNT+="--link2symlink -0 -r $INSTALLDIR "
	# file var/binds/fbindexample.prs has examples
       	if [[ -n "$(ls -A "$INSTALLDIR"/var/binds/*.prs)" ]]
	then
	       	for PRSFILES in "$INSTALLDIR"/var/binds/*.prs
		do
		       	. "$PRSFILES"
	       	done
	fi
	declare -A PRSTARR
	PRSTARR=([/dev/ashmem]=$INSTALLDIR/tmp [/dev/shm]=$INSTALLDIR/tmp [/proc/stat]=$INSTALLDIR/var/binds/fbindprocstat )
	for ISRD in ${!PRSTARR[@]}
	do
	       	if [[ ! -r "$ISRD" ]]	# not readble
		then	# add proot bind
		       	PROOTSTMNT+="-b ${PRSTARR[$ISRD]}:$ISRD " 
		fi
	done
	declare -A PRSTRARR
	PRSTRARR=(["$ANDROID_DATA"]="$ANDROID_DATA" ["$EXTERNAL_STORAGE"]="$EXTERNAL_STORAGE" ["$HOME"]="$HOME" ["$PREFIX"]="$PREFIX" ["/proc/"]="/proc/" ["/storage/"]="/storage/" ["/sys/"]="/sys/" ["/system/"]="/system/" )
	for ISRD in ${!PRSTRARR[@]}
	do
	       	if [[ -r "$ISRD" ]]	# readble
		then	# add proot bind
		       	PROOTSTMNT+="-b ${PRSTRARR[$ISRD]}:$ISRD " 
		fi
	done
	PROOTSTMNT+="-b /proc/self/fd/0:/dev/stdin "
	PROOTSTMNT+="-b /proc/self/fd/1:/dev/stdout "
	PROOTSTMNT+="-b /proc/self/fd/2:/dev/stderr "
	PROOTSTMNT+="-b /dev/ -w \"\$PWD\" /usr/bin/env -i HOME=/root TERM=\"\$TERM\" "
	PROOTSTMNTU="${PROOTSTMNT//--link2symlink }"
}
_PR00TSTRING_
# knownconfigurations.bash EOF
