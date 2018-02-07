#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
# Detected configurations. Change mirror to your desired geographic location.
# Please add configurations to this list if you find one that is not listed.
################################################################################

aarch64 ()
{
	file=ArchLinuxARM-aarch64-latest.tar.gz
	mirror=mirror.archlinuxarm.org
	path=/os/
	makesystem 
}

armv5l ()
{
	file=ArchLinuxARM-armv5-latest.tar.gz
	mirror=mirror.archlinuxarm.org
	path=/os/
	makesystem 
}

armv7lAndroid  ()
{
	file=ArchLinuxARM-armv7-latest.tar.gz 
	mirror=mirror.archlinuxarm.org
	path=/os/
	makesystem 
}

armv7lChrome ()
{
	file=ArchLinuxARM-armv7-chromebook-latest.tar.gz
	mirror=mirror.archlinuxarm.org
	path=/os/
	makesystem 
}

i686 ()
{
	# i686 is frozen at release 2017.03.01-i686. See https://www.archlinux.org/news/phasing-out-i686-support/ for more information.  Inquire at https://archlinux32.org/ for updates.   
	file=archlinux-bootstrap-2017.03.01-i686.tar.gz
	mirror=archive.archlinux.org
	path=/iso/2017.03.01/
	makesystem 
}

x86_64 ()
{
	# x86_64 downloads the latest file automatically.  $file is unnecessary for download.
	mirror=mirrors.evowise.com
	path=/archlinux/iso/latest/
	makesystem 
}
