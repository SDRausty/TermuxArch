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
		if [[ $opt = manual ]];then
			omanual
		else 
			ldconf
		fi
		. archsystemconfigs.sh
		. getimagefunctions.sh
		. necessaryfunctions.sh
		. printoutstatements.sh
		. systemmaintenance.sh
		if [[ $opt = bloom ]];then
			rm termuxarchchecksum.md5
		else 
			rmdsc 
		fi
		if [ -f "setupTermuxArch.tmp" ];then
			rm setupTermuxArch.tmp
		fi
		printf "\n\033[36;1m 🕑 < 🕛 \033[1;34mTermuxArch $versionid integrity: \033[32;1mOK\n\033[1;30m"
	else
		rmdsc 
		printmd5syschker
	fi
}

chkdwn ()
{
	if md5sum -c setupTermuxArch.md5 1>/dev/null ; then
		printf "\033[36;1m 🕐 < 🕛 \033[1;34mTermuxArch $versionid download: \033[1;32mOK\n\033[0;32m"
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
			printf "\n\033[0;32msetupTermuxArch.sh: \033[1;32mUPDATED\n\033[0;32mTermuxArch: \033[1;32mRESTARTED\n\033[0m"
			rm setupTermuxArch.tmp
			. setupTermuxArch.sh $args
		fi
	fi
}

depends ()
{
	if [ ! -e $PREFIX/bin/bsdtar ] || [ ! -e $PREFIX/bin/curl ] || [ ! -e $PREFIX/bin/proot ] ; then
		printf "\033[1;34mChecking prerequisites and upgrading Termux.\n\n\033[0m"
		apt-get update && apt-get upgrade -y
		apt-get install bsdtar curl proot wget --yes 
		printf "\n"
	fi
	if [[ $dm = wget ]];then
		if [ ! -e $PREFIX/bin/wget ] ; then
			apt-get install wget --yes 
		fi
	fi
	if [ ! -e $PREFIX/bin/bsdtar ] || [ ! -e $PREFIX/bin/curl ] || [ ! -e $PREFIX/bin/proot ] ; then
		printf "\n\033[1;31mPrerequisites exception.  Run the script again.\n\n\033[0m"
		exit
	fi
	if [[ $dm = wget ]];then
		if [ ! -e $PREFIX/bin/wget ] ; then
			printf "\n\033[1;31mPrerequisites exception.  Run the script again.\n\n\033[0m"
			exit
		fi
	fi
	printf "\n\n\033[1;36m 🕧 < 🕛 \033[1;34mPrerequisite packages: \033[1;32mOK\n\n\033[0;32m"
}

dependsblock ()
{
	depends 
	dwnl
	if [ -f "setupTermuxArch.sh" ];then
	cp setupTermuxArch.sh setupTermuxArch.tmp
	fi
	chkdwn
	chk
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

edq ()
{
	printf "\n\033[0;32m"
	while true; do
		if [[ $opt = bloom ]] || [[ $opt = manual ]];then
	read -p "Do you want to use \`nano\` or \`vi\` to edit [n|v]? "  nv
		else 
	read -p "Do you want to use \`nano\` or \`vi\` to edit your Arch Linux configuration files [n|v]? "  nv
		fi
	if [[ $nv = [Nn]* ]];then
		ed=nano
		apt-get -qq install nano --yes 
		break
	elif [[ $nv = [Vv]* ]];then
		ed=vi
		break
	else
		printf "\nYou answered \033[36;1m$nv\033[32;1m.\n"
		printf "\nAnswer nano or vi (n|v).  \n\n"
	fi
		printf "\nYou answered \033[36;1m$nv\033[32;1m.\n"
	done	
	printf "\n"
}

intro ()
{
	printf '\033]2;  Thank you for using `bash setupTermuxArch.sh` 📲 \007'
	rmarchq
	spaceinfoq
	printf "\n\033[36;1m 🕛 < 🕛 \033[1;34msetupTermuxArch will attempt to install Linux in Termux.  Arch Linux will be available upon successful completion.  Ensure background data is not restricted.  Run \033[0;32mbash setupTermuxArch.sh --help \033[34;1mfor additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock 
}

introbloom ()
{
	printf '\033]2;  Thank you for using `bash setupTermuxArch.sh --bloom` 📲 \007'
	spaceinfo
	printf "\n\033[36;1m 🕛 < 🕛 \033[1;34msetupTermuxArch $versionid bloom option.  Run \033[1;32mbash setupTermuxArch.sh --help \033[34;1mfor additional information.  Ensure background data is not restricted.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
}

introdebug ()
{
	printf '\033]2;  Thank you for using `bash setupTermuxArch.sh --sysinfo` 📲 \007'
	spaceinfo
	printf "\n\033[36;1m 🕛 < 🕛 \033[1;34msetupTermuxArch $versionid will create a system information file.  Ensure background data is not restricted.  Run \033[0;32mbash setupTermuxArch.sh --help \033[1;34mfor additional information.  Check the wireless connection if you do not see one o'clock 🕐 below.  "
	dependsblock 
}

ldconf ()
{
	if [ -f "setupTermuxArchConfigs.sh" ];then
		. setupTermuxArchConfigs.sh
		printf "\n 🕜 \033[36;1m< 🕛 \033[0;34mTermuxArch configuration \033[0;32m$(pwd)/\033[1;32msetupTermuxArchConfigs.sh \033[1;34mloaded: \033[32;1mOK  \n\033[0m"
	else
		. knownconfigurations.sh
	fi
}

obloom ()
{
	opt=bloom 
	introbloom 
	if [ -d $HOME/TermuxArchBloom ];then 
		rmbloomq 
	fi
	if [ ! -d $HOME/TermuxArchBloom ];then 
		mkdir $HOME/TermuxArchBloom
	fi
	cd $HOME/TermuxArchBloom
	printf "\033[1;34mTermuxArch Bloom option via \033[1;32msetupTermuxArch.sh --bloom\033[0m  📲 \n\n\033[0m"'\033]2;  Thank you for using TermuxArch Bloom option via `setupTermuxArch.sh --bloom` 📲 \007'
	ls -al
	printf "\n"
	pwd
	dependsblock 
	ls -al
	printf "\n\033[1;34mUse \033[1;32mcd ~/TermuxArchBloom\033[0m to continue.\n\n\033[0m"'\033]2;  Thank you for using TermuxArch Bloom option via `setupTermuxArch.sh --bloom` 📲 \007'
}

obloomdependsblock ()
{
	introbloom 
	cd $HOME/TermuxArchBloom
	printf "\033[1;34mTermuxArch Bloom option via \033[1;32mbash setupTermuxArch.sh --run\033[0m  📲 \n\n\033[0m"'\033]2;  Thank you for using TermuxArch Bloom option via `bash setupTermuxArch.sh --run` 📲 \007'
	ls -al
	printf "\n"
	pwd
	. archsystemconfigs.sh
	. getimagefunctions.sh
	. knownconfigurations.sh
	. necessaryfunctions.sh
	. printoutstatements.sh
	. systemmaintenance.sh
	printf "\n\033[36;1m 🕑 < 🕛 \033[1;34mTermuxArch $versionid integrity: \033[32;1mOK\n\033[1;30m"
	mainblock
}

omanual ()
{
	edq
	if [ -f "setupTermuxArchConfigs.sh" ];then
		$ed setupTermuxArchConfigs.sh
		. setupTermuxArchConfigs.sh
		printf "\n 🕜 \033[36;1m< 🕛 \033[0;34mTermuxArch configuration \033[0;32m$(pwd)/\033[1;32msetupTermuxArchConfigs.sh \033[1;34mloaded: \033[32;1mOK  \n\033[36;1m"
	else
		cp knownconfigurations.sh setupTermuxArchConfigs.sh
		$ed setupTermuxArchConfigs.sh
		. setupTermuxArchConfigs.sh
		printf "\n 🕜 \033[36;1m< 🕛 \033[0;34mTermuxArch configuration \033[0;32m$(pwd)/\033[1;32msetupTermuxArchConfigs.sh \033[1;34mloaded: \033[32;1mOK  \n\033[36;1m"
	fi
}

printmd5syschker ()
{
	printf "\033[07;1m\033[31;1m\n 🔆 ERROR md5sum mismatch!  Setup initialization mismatch!\033[36;1m  Update this copy of \`setupTermuxArch.sh\`.  If it is updated, this kind of error can go away, like magic.  Wait before executing again, especially if using a fresh copy from https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.sh on this system.  There are many reasons for checksum errors.  Proxies are one reason.  Mirroring and mirrors are another explanation for md5sum errors.   \"Try again, initialization was not successful this time.\"  For more md5sum error information see \`bash setupTermuxArch.sh --help\`.\n\n	Execute \`bash setupTermuxArch.sh\` again. \033[31;1mExiting...\n\033[0m"'\033]2;  Thank you for using setupTermuxArch.sh.  Execute `bash setupTermuxArch.sh` again.\007'
	exit 
}

printtail ()
{
	printf "\n\033[0mThank you for using \033[1;32msetupTermuxArch.sh\033[0m 🏁  \n\n\033[0m"'\033]2;  Thank you for using setupTermuxArch.sh  🏁 \007'
	exit
}

printusage ()
{
	printf "\n\n\033[1;34mUsage information for \033[1;32msetupTermuxArch.sh \033[1;34m$versionid.  Arguments can abbreviated to one letter; Two letter arguments are acceptable.  For example, \033[1;32mbash setupTermuxArch.sh cs\033[1;34m will use \033[1;32mcurl\033[1;34m to download TermuxArch and produce a \033[1;32msetupTermuxArchdebug$ntime.log\033[1;34m file.\n\nUser configurable variables are in \033[1;32msetupTermuxArchConfigs.sh\033[1;34m.  Create this file from \033[1;32mkownconfigurations.sh\033[1;34m in the working directory.  Use \033[1;32mbash setupTermuxArch.sh --manual\033[1;34m to create and edit \033[1;32msetupTermuxArchConfigs.sh\033[1;34m.\n\n\033[1;33mDEBUG\033[1;34m    Use \033[1;32msetupTermuxArch.sh --sysinfo \033[1;34mto create \033[1;32msetupTermuxArchdebug.log\033[1;34m and populate it with debug information.  Post this information along with detailed information about the issue at https://github.com/sdrausty/TermuxArch/issues.  If screenshots will help in resolving the issue better, include them in a post along with information from the debug log file.\n\n\033[1;33mHELP\033[1;34m     Use \033[1;32msetupTermuxArch.sh --help \033[1;34mto output this help screen.\n\n\033[1;33mINSTALL\033[1;34m  Run \033[1;32m./setupTermuxArch.sh\033[1;34m without arguments in a bash shell to install Arch Linux in Termux.  Use \033[1;32mbash setupTermuxArch.sh --curl \033[1;34mto envoke \033[1;32mcurl\033[1;34m as the download manager.  Copy \033[1;32mknownconfigurations.sh\033[1;34m to \033[1;32msetupTermuxArchConfigs.sh\033[1;34m with preferred mirror.  After editing \033[1;32msetupTermuxArchConfigs.sh\033[1;34m, run \033[1;32mbash setupTermuxArch.sh\033[1;34m and \033[1;32msetupTermuxArchConfigs.sh\033[1;34m loads automatically from the same directory.  Change mirror to desired geographic location to resolve download errors.\n\n\033[1;33mPURGE\033[1;34m    Use \033[1;32msetupTermuxArch.sh --uninstall\033[1;34m \033[1;34mto uninstall Arch Linux from Termux.\n"
}

rmarch ()
{
	while true; do
	printf "\n\033[1;30m"
	read -p "Uninstall Arch Linux? [y|n] " uanswer
	if [[ $uanswer = [Ee]* ]] || [[ $uanswer = [Nn]* ]] || [[ $uanswer = [Qq]* ]];then
		break
	elif [[ $uanswer = [Yy]* ]];then
	printf "\033[30mUninstalling Arch Linux...\n"
	if [ -e $PREFIX/bin/$bin ] ;then
	       	rm $PREFIX/bin/$bin 
	else 
		printf "Uninstalling Arch Linux, nothing to do for $PREFIX/bin/$bin.\n"
       	fi
	if [ -d $HOME/arch ] ;then
		rmarchc 
	else 
		printf "Uninstalling Arch Linux, nothing to do for $HOME/arch.\n"
	fi
	printf "Uninstalling Arch Linux done.\n"
	break
	else
		printf "\nYou answered \033[33;1m$uanswer\033[30m.\n\nAnswer \033[32mYes\033[30m or \033[1;31mNo\033[30m. [\033[32my\033[30m|\033[1;31mn\033[30m]\n"
	fi
	done
}

rmarchc ()
{
	cd $HOME/arch
	rm -rf * 2>/dev/null ||:
	find -type d -exec chmod 700 {} \; 2>/dev/null ||:
	cd ..
	rm -rf $HOME/arch 2>/dev/null ||:
}

rmarchq ()
{
	if [ -d $HOME/arch ] ;then
		printf "\n\033[0;33mTermuxArch: \033[1;33mDIRECTORY WARNING!  $HOME/arch/ \033[0;33mdirectory detected.  \033[1;30mTermux Arch installation will continue.  \033[0;33mInstalling into a clean directory is recommended.  \033[1;30mUninstalling before continuing is suggested.\n"
		rmarch
	fi
}

rmbloom ()
{
	while true; do
	printf "\n\033[1;30m"
	read -p "Uninstall $HOME/TermuxArchBloom? [y|n] " uanswer
	if [[ $uanswer = [Ee]* ]] || [[ $uanswer = [Nn]* ]] || [[ $uanswer = [Qq]* ]];then
		break
	elif [[ $uanswer = [Yy]* ]];then
	printf "\033[30mUninstalling $HOME/TermuxArchBloom...\n"
	if [ -d $HOME/TermuxArchBloom ] ;then
		rm -rf $HOME/TermuxArchBloom 
	else 
		printf "Uninstalling $HOME/TermuxArchBloom, nothing to do for $HOME/arch.\n"
	fi
	printf "Uninstalling $HOME/TermuxArchBloom done.\n"
	break
	else
		printf "\nYou answered \033[33;1m$uanswer\033[30m.\n\nAnswer \033[32mYes\033[30m or \033[1;31mNo\033[30m. [\033[32my\033[30m|\033[1;31mn\033[30m]\n"
	fi
	done
}

rmbloomq ()
{
	if [ -d $HOME/TermuxArchBloom ] ;then
		printf "\n\n\033[0;33mTermuxArch: \033[1;33mDIRECTORY WARNING!  $HOME/TermuxArchBloom/ \033[0;33mdirectory detected.  \033[1;30mTermux Arch will continue.\n"
		rmbloom
	fi
}

rmdsc ()
{
	rm archsystemconfigs.sh
	rm getimagefunctions.sh
	rm knownconfigurations.sh
	rm necessaryfunctions.sh
	rm printoutstatements.sh
	rm systemmaintenance.sh
	rm termuxarchchecksum.md5
}

rmds ()
{
	rm setupTermuxArch.md5
	rm setupTermuxArch.tar.gz
}

runobloom ()
{
	if [ -d $HOME/TermuxArchBloom ];then 
		opt=bloom
		obloomdependsblock 
	else
		dependsblock
		obloom 
	fi
}

spaceinfo ()
{
	usrspace=`df /data | awk '{print $4'} | sed '2q;d'`
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

spaceinfoq ()
{
	spaceinfo
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

# User configurable variables are in `setupTermuxArchConfigs.sh`.  To create this file from `kownconfigurations.sh` in the working directory use `bash setupTermuxArch.sh --manual` to create and edit `setupTermuxArchConfigs.sh`.  See `bash setupTermuxArch.sh --help` for more information. 

args=$@
bin=startarch
#dfl=/gen
dm=curl
#dm=wget
dmverbose=""
#dmverbose="-v"
ntime=`date +%N`
versionid="v0.8.1 id502434699"

if [[ $1 = [Cc][Dd]* ]] || [[ $1 = -[Cc][Dd]* ]] || [[ $1 = --[Cc][Dd]* ]] || [[ $1 = [Cc][Ss]* ]] || [[ $1 = -[Cc][Ss]* ]] || [[ $1 = --[Cc][Ss]* ]];then
	dm=curl
	introdebug 
	sysinfo 
elif [[ $1 = [Cc]* ]] || [[ $1 = -[Cc]* ]] || [[ $1 = --[Cc]* ]] || [[ $1 = [Cc][Ii]* ]] || [[ $1 = -[Cc][Ii]* ]] || [[ $1 = --[Cc][Ii]* ]];then
	dm=curl
	intro 
	mainblock
elif [[ $1 = [Ww][Dd]* ]] || [[ $1 = -[Ww][Dd]* ]] || [[ $1 = --[Ww][Dd]* ]] || [[ $1 = [Ww][Ss]* ]] || [[ $1 = -[Ww][Ss]* ]] || [[ $1 = --[Ww][Ss]* ]];then
	dm=wget
	introdebug 
	sysinfo 
elif [[ $1 = [Ww]* ]] || [[ $1 = -[Ww]* ]] || [[ $1 = --[Ww]* ]] || [[ $1 = [Ww][Ii]* ]] || [[ $1 = -[Ww][Ii]* ]] || [[ $1 = --[Ww][Ii]* ]];then
	dm=wget
	intro 
	mainblock
elif [[ $1 = [Bb]* ]] || [[ $1 = -[Bb]* ]] || [[ $1 = --[Bb]* ]] ;then
	dependsblock
	obloom
elif [[ $1 = [Dd]* ]] || [[ $1 = -[Dd]* ]] || [[ $1 = --[Dd]* ]] || [[ $1 = [Ss]* ]] || [[ $1 = -[Ss]* ]] || [[ $1 = --[Ss]* ]];then
	introdebug 
	sysinfo 
elif [[ $1 = [Hh]* ]] || [[ $1 = -[Hh]* ]] || [[ $1 = --[Hh]* ]]  || [[ $1 = [?]* ]] || [[ $1 = -[?]* ]] || [[ $1 = --[?]* ]];then
	printusage
elif [[ $1 = [Mm]* ]] || [[ $1 = -[Mm]* ]] || [[ $1 = --[Mm]* ]] ;then
	opt=manual
	intro 
	mainblock
elif [[ $1 = [Pp]* ]] || [[ $1 = -[Pp]* ]] || [[ $1 = --[Pp]* ]] || [[ $1 = [Uu]* ]] || [[ $1 = -[Uu]* ]] || [[ $1 = --[Uu]* ]];then
	rmarch
elif [[ $1 = [Rr]* ]] || [[ $1 = -[Rr]* ]] || [[ $1 = --[Rr]* ]] ;then
	runobloom 
elif [[ $1 = "" ]] || [[ $1 = [Ii]* ]] || [[ $1 = -[Ii]* ]] || [[ $1 = --[Ii]* ]];then
	intro 
	mainblock
else
	printusage
fi
printtail 
