#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

chk ()
{
	if md5sum -c termuxarchchecksum.md5 1>/dev/null ; then
		chkself 
		ldconf
		. archsystemconfigs.sh
		. getimagefunctions.sh
		. necessaryfunctions.sh
		. printoutstatements.sh
		. systemmaintenance.sh
		rmdsc 
		printf "\n\033[36;1m 🕑 < 🕛 \033[1;34mTermuxArch "
		printf "v0.8 id097122283"
		printf " integrity: \033[36;1mOK\n\033[1;30m"
	else
		rmdsc 
		printmd5syschker
	fi
}

chkdwn ()
{
	if md5sum -c setupTermuxArch.md5 1>/dev/null ; then
		printf "\033[36;1m 🕐 < 🕛 \033[1;34mTermuxArch downloaded: \033[36;1mOK\n\033[36;1m"
		bsdtar -xf setupTermuxArch.tar.gz
		rmds 
	else
		rmds 
		printmd5syschker
	fi
}

chkself ()
{
	if [ -f "setupTermuxArch.tmp" ];then
		if [[ "$(<setupTermuxArch.sh)" != "$(<setupTermuxArch.tmp)" ]]; then
			printf "\n\033[32;1msetupTermuxArch.sh: UPDATED\nTermuxArch: RESTARTED\n\033[0m"
			. setupTermuxArch.sh $args
		fi
	fi
}

depends ()
{
	if [ ! -e $PREFIX/bin/bsdtar ] || [ ! -e $PREFIX/bin/curl ] || [ ! -e $PREFIX/bin/proot ] || [ ! -e $PREFIX/bin/wget ] ; then
		printf "\033[1;34mChecking prerequisites and upgrading Termux.\n\n\033[36;1m"
		apt-get update && apt-get upgrade -y
		apt-get install bsdtar curl proot wget --yes 
		printf "\n"
	fi
	if [ ! -e $PREFIX/bin/bsdtar ] || [ ! -e $PREFIX/bin/curl ] || [ ! -e $PREFIX/bin/proot ] || [ ! -e $PREFIX/bin/wget ] ; then
		printf "\n\033[1;36mPrerequisites exception.  Run the script again.\n\n\033[0m"
		exit
	fi
	printf "\n\n\033[1;36m 🕧 < 🕛 \033[1;34mPrerequisite packages: \033[36;1mOK\n\n"
}

dwnl ()
{
	if [[ $dm = wget ]];then
		wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master$dfl/setupTermuxArch.md5 
		wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master$dfl/setupTermuxArch.tar.gz
		printf "\n"
	else
		curl -q -O https://raw.githubusercontent.com/sdrausty/TermuxArch/master$dfl/setupTermuxArch.md5 -O https://raw.githubusercontent.com/sdrausty/TermuxArch/master$dfl/setupTermuxArch.tar.gz
		printf "\n"
	fi
}

intro ()
{
	printf '\033]2;  Thank you for using `bash setupTermuxArch.sh` 📲 \007'
	spaceinfo 
	printf "\n\033[36;1m 🕛 < 🕛 \033[1;34mTermuxArch will attempt to install Linux in Termux.  Arch Linux will be available upon successful completion.  Ensure background data is not restricted.  If you do not see one o'clock 🕐 below, check the wireless connection.  Run \033[36mbash setupTermuxArch.sh --help \033[34;1mfor additional information.  "
	depends 
	dwnl
	if [ -f "setupTermuxArch.sh" ];then
	cp setupTermuxArch.sh setupTermuxArch.tmp
	fi
	chkdwn
	chk
}

ldconf ()
{
	if [ -f "setupTermuxArchConfigs.sh" ];then
		. setupTermuxArchConfigs.sh
		printf "\n 🕜 \033[36;1m< 🕛 \033[1;32msetupTermuxArchConfigs.sh \033[1;34mloaded: \033[36;1mOK  \n\033[36;1m"
	else
		. knownconfigurations.sh
	fi
}

printmd5syschker ()
{
	printf "\033[07;1m\033[31;1m\n 🔆 ERROR md5sum mismatch!  Setup initialization mismatch!\033[36;1m  Update this copy of \`setupTermuxArch.sh\`.  If it is updated, this kind of error can go away, like magic.  Wait before executing again, especially if using a fresh copy from https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.sh on this system.  There are many reasons for checksum errors.  Proxies are one reason.  Mirroring and mirrors are another explanation for md5sum errors.   \"Try again, initialization was not successful this time.\"  For more md5sum error information see \`bash setupTermuxArch.sh --help\`.\n\n	Execute \`bash setupTermuxArch.sh\` again. \033[31;1mExiting...\n\033[0m"'\033]2;  Thank you for using setupTermuxArch.sh.  Execute \`bash setupTermuxArch.sh\` again.\007'
	exit 
}

printtail ()
{
	printf "\n\033[0mThank you for using \033[1;32msetupTermuxArch.sh\033[0m 🏁  \n\n\033[0m"'\033]2;  Thank you for using setupTermuxArch.sh  🏁 \007'
	exit
}

printusage ()
{
	printf "\n\n\033[1;34mUsage information for \033[1;32msetupTermuxArch.sh \033[1;34m"
		printf "v0.8 id097122283"
	printf ".  Arguments can abbreviated to one letter; Two letter arguments are acceptable.  For example, \033[1;32mbash setupTermuxArch.sh cs\033[1;34m will use \033[1;32mcurl\033[1;34m to download TermuxArch and produce the \033[1;32msetupTermuxArchdebug.log\033[1;34m file.\n\n\033[1;33mDEBUG\033[1;34m    Use \033[1;32msetupTermuxArch.sh --sysinfo \033[1;34mto create \033[1;32msetupTermuxArchdebug.log\033[1;34m and populate it with debug information.  Post this information along with detailed information about the issue at https://github.com/sdrausty/TermuxArch/issues.  If screenshots will help in resolving the issue better, include them in a post along with information from the debug log file.\n\n\033[1;33mHELP\033[1;34m     Use \033[1;32msetupTermuxArch.sh --help \033[1;34mto output this help screen.\n\n\033[1;33mINSTALL\033[1;34m  Run \033[1;32m./setupTermuxArch.sh\033[1;34m without arguments in a bash shell to install Arch Linux in Termux.  Use \033[1;32mbash setupTermuxArch.sh --curl \033[1;34mto envoke \033[1;32mcurl\033[1;34m as the download manager.  Copy \033[1;32mknownconfigurations.sh\033[1;34m to \033[1;32msetupTermuxArchConfigs.sh\033[1;34m with preferred mirror.  After editing \033[1;32msetupTermuxArchConfigs.sh\033[1;34m, run \033[1;32mbash setupTermuxArch.sh\033[1;34m and \033[1;32msetupTermuxArchConfigs.sh\033[1;34m loads automatically from the same directory.  Change mirror to desired geographic location to resolve download errors.\n\n\033[1;33mPURGE\033[1;34m    Use \033[1;32msetupTermuxArch.sh --uninstall\033[1;34m \033[1;34mto uninstall Arch Linux from Termux.\n"
}

rmdsc ()
{
	rm archsystemconfigs.sh
	rm getimagefunctions.sh
	rm knownconfigurations.sh
	rm necessaryfunctions.sh
	rm printoutstatements.sh
	rm setupTermuxArch.tmp
	rm systemmaintenance.sh
	rm termuxarchchecksum.md5
}

rmds ()
{
	rm setupTermuxArch.md5
	rm setupTermuxArch.tar.gz
}

spaceinfo ()
{
	usrspace=`df /data | awk '{print $4}' | sed '2q;d'`
	if [[ $usrspace = *G ]];then
		usspace="${usrspace: : -1}"
		if [ $(getprop ro.product.cpu.abi) = arm64-v8a ];then
			if [[ "$usspace" < "1.5" ]];then
				spaceMessage="\n\033[1;33mTermuxArch: FREE SPACE WARNING!  \033[36mStart thinking about cleaning out some stuff.  \033[1;33m$usrspace of free user space is available on this device.  \033[1;36mThe recommended minimum to install Arch Linux in Termux PRoot for aarch64 is 1.5G of free user space.\n\033[0m"
			else
				spaceMessage=""
			fi
		elif [ $(getprop ro.product.cpu.abi) = armeabi-v7a ];then
			if [[ "$usspace" < "1.25" ]];then
				spaceMessage="\n\033[1;33mTermuxArch: FREE SPACE WARNING!  \033[36mStart thinking about cleaning out some stuff.  \033[1;33m$usrspace of free user space is available on this device.  \033[1;36mThe recommended minimum to install Arch Linux in Termux PRoot for armv7 is 1.25G of free user space.\n\033[0m"
			else
				spaceMessage=""
			fi
		else
		spaceMessage=""
		fi
	else
		spaceMessage="\n\033[1;33mTermuxArch: FREE SPACE WARNING!  \033[36mStart thinking about cleaning out some stuff.  \033[1;33m$usrspace of free user space is available on this device.  \033[1;36mThe recommended minimum to install Arch Linux in Termux PRoot is more than 1.5G for aarch64, more than 1.25G for armv7 and more than 1G of free user space for all other architectures.\n\033[0m"
	fi
	printf "$spaceMessage"
	if [ -n "$spaceMessage" ];then
	while true; do
	printf "\n\033[1;30m"
	read -p "Continue with setupTermuxArch.sh? [y|n] " uanswer
	if [[ $uanswer = [Ee]* ]] || [[ $uanswer = [Nn]* ]] || [[ $uanswer = [Qq]* ]];then
		printtail
	elif [[ $uanswer = [Yy]* ]];then
	printf "Continuing with setupTermuxArch.sh.\n"
		break
	else
		printf "\nYou answered \033[33;1m$uanswer\033[30m.\n\nAnswer \033[32mYes\033[30m or \033[1;31mNo\033[30m. [\033[32my\033[30m|\033[1;31mn\033[30m]\n"
	fi
	done
	fi
}

# User configurable variables are in `setupTermuxArchConfigs.sh`.  Create this file from `kownconfigurations.sh` in the working directory.  

args=$@
bin=startarch
#dfl=/gen
#dm=curl
dm=wget
dmverbose="-q"
#dmverbose="-v"


if [[ $1 = [Cc][Pp]* ]] || [[ $1 = -[Cc][Pp]* ]] || [[ $1 = --[Cc][Pp]* ]] || [[ $1 = [Cc][Uu]* ]] || [[ $1 = -[Cc][Uu]* ]] || [[ $1 = --[Cc][Uu]* ]];then
	dm=curl
	intro 
	rmarch
elif [[ $1 = [Cc][Dd]* ]] || [[ $1 = -[Cc][Dd]* ]] || [[ $1 = --[Cc][Dd]* ]] || [[ $1 = [Cc][Ss]* ]] || [[ $1 = -[Cc][Ss]* ]] || [[ $1 = --[Cc][Ss]* ]];then
	dm=curl
	intro 
	sysinfo 
elif [[ $1 = [Cc]* ]] || [[ $1 = -[Cc]* ]] || [[ $1 = --[Cc]* ]] || [[ $1 = [Cc][Ii]* ]] || [[ $1 = -[Cc][Ii]* ]] || [[ $1 = --[Cc][Ii]* ]];then
	dm=curl
	intro 
	mainblock
elif [[ $1 = [Ww][Pp]* ]] || [[ $1 = -[Ww][Pp]* ]] || [[ $1 = --[Ww][Pp]* ]] || [[ $1 = [Ww][Uu]* ]] || [[ $1 = -[Ww][Uu]* ]] || [[ $1 = --[Ww][Uu]* ]];then
	dm=wget
	intro 
	rmarch
elif [[ $1 = [Ww][Dd]* ]] || [[ $1 = -[Ww][Dd]* ]] || [[ $1 = --[Ww][Dd]* ]] || [[ $1 = [Ww][Ss]* ]] || [[ $1 = -[Ww][Ss]* ]] || [[ $1 = --[Ww][Ss]* ]];then
	dm=wget
	intro 
	sysinfo 
elif [[ $1 = [Ww]* ]] || [[ $1 = -[Ww]* ]] || [[ $1 = --[Ww]* ]] || [[ $1 = [Ww][Ii]* ]] || [[ $1 = -[Ww][Ii]* ]] || [[ $1 = --[Ww][Ii]* ]];then
	dm=wget
	intro 
	mainblock
elif [[ $1 = [Dd]* ]] || [[ $1 = -[Dd]* ]] || [[ $1 = --[Dd]* ]] || [[ $1 = [Ss]* ]] || [[ $1 = -[Ss]* ]] || [[ $1 = --[Ss]* ]];then
	intro 
	sysinfo 
elif [[ $1 = [Hh]* ]] || [[ $1 = -[Hh]* ]] || [[ $1 = --[Hh]* ]]  || [[ $1 = [?]* ]] || [[ $1 = -[?]* ]] || [[ $1 = --[?]* ]];then
	printusage
elif [[ $1 = [Pp]* ]] || [[ $1 = -[Pp]* ]] || [[ $1 = --[Pp]* ]] || [[ $1 = [Uu]* ]] || [[ $1 = -[Uu]* ]] || [[ $1 = --[Uu]* ]];then
	intro 
	rmarch
elif [[ $1 = "" ]] || [[ $1 = [Ii]* ]] || [[ $1 = -[Ii]* ]] || [[ $1 = --[Ii]* ]];then
	intro 
	mainblock
else
	printusage
fi
printtail 
