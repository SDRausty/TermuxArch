#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
# https://sdrausty.github.io/TermuxArch/README has information about this project.
# Create `setupTermuxArchConfigs.sh` from this file in your working directory by using `bash setupTermuxArch.sh manual`.
# Run `bash setupTermuxArch.sh` and `setupTermuxArchConfigs.sh` loads automaticaly.
# See `bash setupTermuxArch.sh help` for more information.  
# Change mirror to desired geographic location in `setupTermuxArchConfigs.sh` to resolve 404 and checksum errors.
# The following user configurable variables are available in this file:
################################################################################
cmirror="http://mirror.archlinuxarm.org/"
#cmirror="http://os.archlinuxarm.org/"
#dm=curl
#dm=wget
#dmverbose="-q"
#dmverbose="-v"
prootops="--kill-on-exit"
prootopskid="--kernel-release=4.14.15"
prootopsaliases="-b /data -b /storage -b /sdcard"
#exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r $installdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" $installdir/root/bin/finishsetup.sh 

aarch64 ()
{
	file=ArchLinuxARM-aarch64-latest.tar.gz
	mirror=os.archlinuxarm.org
	path=/os/
	makesystem 
}

armv5l ()
{
	file=ArchLinuxARM-armv5-latest.tar.gz
	mirror=os.archlinuxarm.org
	path=/os/
	makesystem 
}

armv7lAndroid  ()
{
	file=ArchLinuxARM-armv7-latest.tar.gz 
	mirror=os.archlinuxarm.org
	path=/os/
	makesystem 
}

armv7lChrome ()
{
	file=ArchLinuxARM-armv7-chromebook-latest.tar.gz
	mirror=os.archlinuxarm.org
	path=/os/
	makesystem 
}

i686 ()
{
	# Information at https://www.archlinux.org/news/phasing-out-i686-support/ and https://archlinux32.org/ regarding why i686 is currently frozen at release 2017.03.01-i686.  $file is read from md5sums.txt
	mirror=archive.archlinux.org
	path=/iso/2017.03.01/
	makesystem 
}

x86_64 ()
{
	# $file is read from md5sums.txt
	mirror=mirror.rackspace.com
	path=/archlinux/iso/latest/
	makesystem 
}
