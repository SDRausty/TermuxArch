#!/usr/bin/env bash
# Copyright 2017-2020 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project.
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
# Running `setupTermuxArch.bash manual` will create `setupTermuxArchConfigs.bash` from this file in the working directory.  Run `setupTermuxArch.bash` and `setupTermuxArchConfigs.bash` loads automaticaly and this file is ignored at runtime; `setupTermuxArch.bash help` has additional information.  Change mirror (https://wiki.archlinux.org/index.php/Mirrors and https://archlinuxarm.org/about/mirrors) to desired geographic location in `setupTermuxArchConfigs.bash` to resolve download, 404 and checksum issues.  The following user configurable variables are available in this file:
# DMVERBOSE="-v" 	# Uncomment for verbose download tool output with curl and wget;  for verbose output throughout runtime, change this setting in `setupTermuxArch.bash` also.
# DM=aria2c		# Uncomment to use this download tool.
# DM=axel 		# Uncomment to use this download tool.
# DM=curl		# Uncomment to use the curl download tool.
# DM=lftp 		# Uncomment to use this download tool.
# DM=wget		# Uncomment to use the wget download tool.
KOE=0
KEEP=1

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

# Function _PR00TSTRING_ which creates the PRoot init statement uses associative arrays.  Page https://www.gnu.org/software/bash/manual/html_node/Arrays.html has information about BASH arrays and is also available at https://www.gnu.org/software/bash/manual/ this link.
# To regenerate the start script use `setupTermuxArch.bash re[fresh]`.  An example is included for convenience.  Usage: PROOTSTMNT+="-b host_path:guest_path " The space before the last double quote is necessary.
# Appending to the PRoot statement can be accomplished on the fly by creating a *.prs file in /var/binds.  The format is straightforward, `PROOTSTMNT+="option command "`.  The space is required before the last double quote.  Commands `info proot` and `man proot` have more information about what can be configured in a proot init statement.  The command `setupTermuxArch.bash manual refresh` will refresh the installation globally.  The command `setupTermuxArch.bash manual re` will refresh the installation and update locales.  If more suitable configurations are found, share them at https://github.com/TermuxArch/TermuxArch/issues to improve TermuxArch.

_PR00TSTRING_() { # construct proot init statements
	PROOTSTMNT="exec proot "
       	if [[ -z "${KID:-}" ]]
	then
	       	PROOTSTMNT+=""
       	elif [[ "$KID" ]]
	then
	       	PROOTSTMNT+="--kernel-release=4.14.15 "
       	fi
       	if [[ "$KOE" = 0 ]]
	then
	       	PROOTSTMNT+="--kill-on-exit "
       	fi
       	PROOTSTMNT+="--link2symlink -0 -r $INSTALLDIR "
	# file INSTALLDIR/var/binds/fbindexample.prs has examples
       	if [[ -n "$(ls -A "$INSTALLDIR"/var/binds/*.prs)" ]]
	then
	       	for PRSFILES in "$INSTALLDIR"/var/binds/*.prs
		do
		       	. "$PRSFILES"
	       	done
	fi
	PROOTSTMNT+="-b /dev/ashmem:/dev/shm "
	[[ "$(getprop ro.build.version.release)" -ge 10 ]] && PROOTSTMNT+="-b /apex:/apex "
	declare -A PRSTARR # associative array
	# populate writable binds
	PRSTARR=([/dev/ashmem]=/dev/ashmem [/dev/shm]=/dev/shm)
	for ISRD in ${!PRSTARR[@]}
	do
	       	if [[ -w "$ISRD" ]]	# writable
		then	# add proot bind
		       	PROOTSTMNT+="-b $ISRD:${PRSTARR[$ISRD]} "
		fi
	done
	# populate readable binds
 	PRSTARR=([/dev/]=/dev/ ["$EXTERNAL_STORAGE"]="$EXTERNAL_STORAGE" ["$HOME"]="$HOME" ["$PREFIX"]="$PREFIX" [/proc/]=/proc/ [/proc/stat]=/proc/stat [/property_contexts]=/property_contexts [/storage/]=/storage/ [/sys/]=/sys/ [/system/]=/system/ [/vendor/]=/vendor/)
	for ISRD in ${!PRSTARR[@]}
	do
	       	if [[ -r "$ISRD" ]]	# readble
		then	# add proot bind
		       	PROOTSTMNT+="-b $ISRD:$ISRD "
		fi
	done
	# populate NOT readable binds
	PRSTARR=([/dev/]=/dev/ [/dev/ashmem]="$INSTALLDIR/tmp" [/proc/stat]="$INSTALLDIR/var/binds/fbindprocstat")
	for ISRD in ${!PRSTARR[@]}
	do
	       	if [[ ! -r "$ISRD" ]]	# not readble
		then	# add proot bind
		       	PROOTSTMNT+="-b ${PRSTARR[$ISRD]}:$ISRD "
		fi
	done
	PROOTSTMNT+="-w \"\$PWD\" /usr/bin/env -i HOME=/root TERM=\"\$TERM\" ANDROID_DATA=/data " # create PRoot root user string
	PROOTSTMNTU="${PROOTSTMNT//--link2symlink }" # create PRoot user string
}
_PR00TSTRING_
# uncomment the next two lines to test function _PR00TSTRING_
# printf "%s\\n" "$PROOTSTMNT"
# exit
# knownconfigurations.bash EOF
