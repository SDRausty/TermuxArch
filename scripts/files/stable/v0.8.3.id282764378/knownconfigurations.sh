#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
# https://sdrausty.github.io/TermuxArch/README has information about this project.
# Please add configurations to this list if you find one that is not listed.
# Copy this file to `setupTermuxArchConfigs.sh` with prefered parameters.
# Run `bash setupTermuxArch.sh` and `setupTermuxArchConfigs.sh` loads automaticaly.
# Change mirror to desired geographic location to resolve 404 and md5sum errors.
# User configurable variables are in `setupTermuxArchConfigs.sh`.
# Create this file from `kownconfigurations.sh` in the working directory.
################################################################################

dm=curl
#dm=wget
dmverbose="-q"
#dmverbose="-v"

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
	# Information at https://www.archlinux.org/news/phasing-out-i686-support/ and at https://archlinux32.org/ as to why i686 is currently frozen at release 2017.03.01-i686.
	# $file is read from md5sums.txt
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
