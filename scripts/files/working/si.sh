#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

spaceinfo ()
{
mntspace=`df /data | awk '{print $4}' | sed '2q;d'`
if [[ $mntspace = *G ]] || [[ $mntspace = *T ]];then
	spaceMessage=""
	echo $mntspace
	echo 0
else
	spaceMessage="Warning!  Start thinking about cleaning out some stuff.  The user space on this device is just $mntspace.  This is below the recommended amount of free space to install Arch Linux in Termux PRoot."
	echo $mntspace
	echo 1
fi
}
spaceinfo 
	echo $mntspace
	echo 2
