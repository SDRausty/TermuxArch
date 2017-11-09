#!/bin/bash -e
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
# Copyright 2017 by SDRausty. All rights reserved.
# Detected configurations. Change mirror to your desired geographic location.
# Please add configurations to this list if you find one that is not listed.
################################################################################

aarch64 ()
{
	file=ArchLinuxARM-aarch64-latest.tar.gz
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

armv8l ()
{
	file=ArchLinuxARM-aarch64-latest.tar.gz
	mirror=os.archlinuxarm.org
	path=/os/
	makesystem 
}

i686 ()
{
	# i686 is frozen at this release. See https://www.archlinux.org/news/phasing-out-i686-support/
	file=archlinux-bootstrap-2017.03.01-i686.tar.gz
	mirror=archive.archlinux.org
	path=/iso/2017.03.01/
	makesystem 
}

x86_64 ()
{
	# Wants to download latest file..
	file=archlinux-bootstrap-2017.11.01-x86_64.tar.gz
	mirror=mirrors.evowise.com
	path=/archlinux/iso/latest
	makesystem 
}

