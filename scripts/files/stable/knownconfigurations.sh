#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
# https://sdrausty.github.io/TermuxArch/README has information about this project.
# `bash setupTermuxArch.sh manual` shall create `setupTermuxArchConfigs.sh` from this file in your working directory.  Run `bash setupTermuxArch.sh` and `setupTermuxArchConfigs.sh` loads automaticaly.  `bash setupTermuxArch.sh help` has more information.  Change mirror to desired geographic location in `setupTermuxArchConfigs.sh` to resolve 404 and checksum errors.  The following user configurable variables are available in this file:   
################################################################################
# cmirror="http://mirror.archlinuxarm.org/"
cmirror="http://os.archlinuxarm.org/"
# dm=aria2c 
# dm=axel tba
# dm=lftp 
# dm=curl
# dm=wget
# dmverbose="-v"	# Uncomment for verbose download manager output;  for verbose output throughout runtime, change this setting setting in `setupTermuxArch.sh` also.  
koe=1

aarch64() {
	file=ArchLinuxARM-aarch64-latest.tar.gz
	mirror=os.archlinuxarm.org
	path=/os/
	makesystem 
}

armv5l() {
	file=ArchLinuxARM-armv5-latest.tar.gz
	mirror=os.archlinuxarm.org
	path=/os/
	makesystem 
}

armv7lAndroid () {
	file=ArchLinuxARM-armv7-latest.tar.gz 
	mirror=os.archlinuxarm.org
	path=/os/
	makesystem 
}

armv7lChrome() {
	file=ArchLinuxARM-armv7-chromebook-latest.tar.gz
	mirror=os.archlinuxarm.org
	path=/os/
	makesystem 
}

# Information at https://www.archlinux.org/news/phasing-out-i686-support/ and https://archlinux32.org/ regarding why i686 is currently frozen at release 2017.03.01-i686.  $file is read from md5sums.txt
i686() { 
	mirror=archive.archlinux.org
	path=/iso/2017.03.01/
	makesystem 
}

# $file is read from md5sums.txt
x86_64() { 
	mirror=mirror.rackspace.com
	path=/archlinux/iso/latest/
	makesystem 
}

# `info proot` and `man proot` have more information about what can be configured in a proot init statement.  `setupTermuxArch.sh manual refresh` shall refresh the installation globally.  If more suitable configurations are found, share them at https://github.com/sdrausty/TermuxArch/issues to improve TermuxArch.  
prs() { 
prootstmnt="exec proot "
if [[ -z "${kid:-}" ]];then
	prootstmnt+=""
elif [[ "$kid" ]]; then
 	prootstmnt+="--kernel-release=4.14.15 "
fi
if [[ "$koe" ]]; then
	prootstmnt+="--kill-on-exit "
fi
prootstmnt+="--link2symlink -0 -r $installdir -b \"\$ANDROID_DATA\" -b /dev/ -b \"\$EXTERNAL_STORAGE\" -b \"\$HOME\" -b /proc/ -b /storage/ -b /sys/ -w \"\$PWD\" /usr/bin/env -i HOME=/root TERM=$TERM "
# prootstmnt+="--link2symlink -0 -r $installdir -b \"\$ANDROID_DATA\" -b /dev/ -b \"\$EXTERNAL_STORAGE\" -b $installdir/var/fake_proc_shmem:/proc/shmem -b $installdir/var/fake_proc_stat:/proc/stat -b \"\$HOME\" -b /proc/ -b /storage/ -b /sys/ -w \"\$PWD\" /usr/bin/env -i HOME=/root TERM=$TERM "
}
prs 

# EOF
