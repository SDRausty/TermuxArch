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

#dm=curl
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
	# i686 is frozen at release 2017.03.01-i686. See https://www.archlinux.org/news/phasing-out-i686-support/ for more information.  Inquire at https://archlinux32.org/ for updates.   
	#file=archlinux-bootstrap-2017.03.01-i686.tar.gz
	mirror=archive.archlinux.org
	path=/iso/2017.03.01/
	makesystem 
}

x86_64 ()
{
	#file=archlinux-bootstrap-2018.02.01-x86_64.tar.gz
	mirror=mirror.rackspace.com
	path=/archlinux/iso/latest/
	makesystem 
}
