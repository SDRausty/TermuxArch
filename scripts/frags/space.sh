#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

spaceinfo ()
{
	usrspace=`df /data | awk {'print $4'} | sed '2q;d'`
	if [[ $usrspace = *G ]];then
		usspace="${usrspace: : -1}"
		if [ $(getprop ro.product.cpu.abi) = arm64-v8a ];then
			if [[ "$usspace" < "1.5" ]];then
				spaceMessage="\n\033[0;33mTermuxArch: \033[1;33mFREE SPACE WARNING!  \033[1;30mStart thinking about cleaning out some stuff.  \033[33m$usrspace of free user space is available on this device.  \033[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\n\033[0m"
			else
				spaceMessage=""
			fi
		elif [ $(getprop ro.product.cpu.abi) = armeabi-v7a ];then
			if [[ "$usspace" < "1.25" ]];then
				spaceMessage="\n\033[0;33mTermuxArch: \033[1;33mFREE SPACE WARNING!  \033[1;30mStart thinking about cleaning out some stuff.  \033[33m$usrspace of free user space is available on this device.  \033[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for armv7 is 1.25G of free user space.\n\033[0m"
			else
				spaceMessage=""
			fi
		else
		spaceMessage=""
		fi
	else
		spaceMessage="\n\033[0;33mTermuxArch: \033[1;33mFREE SPACE WARNING!  \033[1;30mStart thinking about cleaning out some stuff.  \033[33m$usrspace of free user space is available on this device.  \033[1;30mThe recommended minimum to install Arch Linux in Termux PRoot is more than 1.5G for aarch64, more than 1.25G for armv7 and more than 1G of free user space for all other architectures.\n\033[0m"
	fi
	printf "$spaceMessage"
}

spaceinfo
