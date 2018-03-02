#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

spaceinfo ()
{
	units=`df 2>/dev/null | awk 'FNR == 1 {print $2}'`
	if [[ $units = Size ]];then
		spaceinfogsize 
		printf "$spaceMessage"
	elif [[ $units = 1K-blocks ]];then
		spaceinfoksize 
		printf "$spaceMessage"
	fi
}

spaceinfogsize ()
{
	usrspace=`df /data 2>/dev/null | awk 'FNR == 2 {print $4}'`
	if [ $(getprop ro.product.cpu.abi) = x86 ] || [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		if [[ $usrspace = *G ]];then 
			spaceMessage=""
		elif [[ $usrspace = *M ]];then
			usspace="${usrspace: : -1}"
			if [[ "$usspace" < "800" ]];then
				spaceMessage="\n\033[0;33mTermuxArch: \033[1;33mFREE SPACE WARNING!  \033[1;30mStart thinking about cleaning out some stuff.  \033[33m$usrspace of free user space is available on this device.  \033[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for x86 and x86_64 is 800M of free user space.\n\033[0m"
			fi
		fi
	elif [[ $usrspace = *G ]];then
		usspace="${usrspace: : -1}"
		if [ $(getprop ro.product.cpu.abi) = arm64-v8a ];then
			if [[ "$usspace" < "1.5" ]];then
				spaceMessage="\n\033[0;33mTermuxArch: \033[1;33mFREE SPACE WARNING!  \033[1;30mStart thinking about cleaning out some stuff.  \033[33m$usrspace of free user space is available on this device.  \033[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\n\033[0m"
			else
				spaceMessage=""
			fi
		elif [ $(getprop ro.product.cpu.abi) = armeabi-v7a ];then
			if [[ "$usspace" < "1.23" ]];then
				spaceMessage="\n\033[0;33mTermuxArch: \033[1;33mFREE SPACE WARNING!  \033[1;30mStart thinking about cleaning out some stuff.  \033[33m$usrspace of free user space is available on this device.  \033[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for armv7 is 1.23G of free user space.\n\033[0m"
			else
				spaceMessage=""
			fi
		else
			spaceMessage=""
		fi
	else
		spaceMessage="\n\033[0;33mTermuxArch: \033[1;33mFREE SPACE WARNING!  \033[1;30mStart thinking about cleaning out some stuff.  \033[33m$usrspace of free user space is available on this device.  \033[1;30mThe recommended minimum to install Arch Linux in Termux PRoot is more than 1.5G for aarch64, more than 1.25G for armv7 and about 800M of free user space for x86 and x86_64 architectures.\n\033[0m"
	fi
}

spaceinfoq ()
{
	if [[ $suanswer != [Yy]* ]];then
		spaceinfo
		if [ -n "$spaceMessage" ];then
			while true; do
				printf "\n\033[1;30m"
				read -p "Continue with setupTermuxArch.sh? [Y|n] " suanswer
				if [[ $suanswer = [Ee]* ]] || [[ $suanswer = [Nn]* ]] || [[ $suanswer = [Qq]* ]];then
					printtail
				elif [[ $suanswer = [Yy]* ]] || [[ $suanswer = "" ]];then
					suanswer=yes
					printf "Continuing with setupTermuxArch.sh.\n"
					break
				else
					printf "\nYou answered \033[33;1m$suanswer\033[30m.\n\nAnswer \033[32mYes\033[30m or \033[1;31mNo\033[30m. [\033[32my\033[30m|\033[1;31mn\033[30m]\n"
				fi
			done
		fi
	fi
}

spaceinfoksize ()
{
	usrspace=`df 2>/dev/null | grep "/data"| awk 'NR==1' | awk {'print $4'}`
	if [ $(getprop ro.product.cpu.abi) = arm64-v8a ];then
		if [[ "$usrspace" -lt "1500000" ]];then
			spaceMessage="\n\033[0;33mTermuxArch: \033[1;33mFREE SPACE WARNING!  \033[1;30mStart thinking about cleaning out some stuff.  \033[33m$usrspace $units of free user space is available on this device.  \033[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\n\033[0m"
		else
			spaceMessage=""
		fi
	elif [ $(getprop ro.product.cpu.abi) = armeabi-v7a ];then
		if [[ "$usrspace" -lt "1250000" ]];then
			spaceMessage="\n\033[0;33mTermuxArch: \033[1;33mFREE SPACE WARNING!  \033[1;30mStart thinking about cleaning out some stuff.  \033[33m$usrspace $units of free user space is available on this device.  \033[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for armv7 is 1.25G of free user space.\n\033[0m"
		else
			spaceMessage=""
		fi
	elif [ $(getprop ro.product.cpu.abi) = x86 ] || [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		if [[ "$usrspace" -lt "800000" ]];then
			spaceMessage="\n\033[0;33mTermuxArch: \033[1;33mFREE SPACE WARNING!  \033[1;30mStart thinking about cleaning out some stuff.  \033[33m$usrspace $units of free user space is available on this device.  \033[1;30mThe recommended minimum to install Arch Linux in Termux PRoot for x86 and x86_64 is 800M of free user space.\n\033[0m"
		else
			spaceMessage=""
		fi
	fi
}
spaceinfo 
