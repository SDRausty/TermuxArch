#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

bin=startarch
dfl="/gen"
dgfl0="2>/dev/null"
dgfl1="||:"
dm=curl
pvr=$(. setupTermuxArch.sh)

chk ()
{
	if md5sum -c termuxarchchecksum.md5 ; then
		chkself 
		. archsystemconfigs.sh
		. getimagefunctions.sh
		. knownconfigurations.sh
		. necessaryfunctions.sh
		. printoutstatements.sh
		. systemmaintenance.sh
		rmdsc 
		printf "\n\033[36;1m 🕜 < 🕛 \033[1;34mTermuxArch integrity: \033[36;1mOK  \n\033[0m"
	else
		rmdsc 
		printmd5syschker
	fi
}

chkdwn ()
{
	if md5sum -c setupTermuxArch.md5 ; then
		printf "\n 🕐 \033[36;1m< 🕛 \033[1;34mTermuxArch downloaded: \033[36;1mOK  \n\n\033[36;1m"
		bsdtar -xf setupTermuxArch.tar.gz
		rmds 
	else
		rmds 
		printmd5syschker
	fi
}

chkself ()
{
	if [ $pvr = $(. setupTermuxArch.sh) ];then
		:
	else
		. setupTermuxArch.sh
	fi
}


depends ()
{
	printf '\033]2;  Thank you for using `setupTermuxArch.sh` 📲 \007'"\n 🕛 \033[36;1m< 🕛 \033[1;34mTermuxArch will attempt to install Linux in Termux.  Arch Linux will be available upon successful completion.  Check the Internet connection if you do not see one o'clock 🕐 below.  \n"
	if [ -e $PREFIX/bin/bsdtar ] && [ -e $PREFIX/bin/curl ] && [ -e $PREFIX/bin/proot ] && [ -e $PREFIX/bin/wget ] ; then
		:
	else
		printf "\n\n\033[36;1m"
		apt-get -qq update && apt-get -qq upgrade -y
		apt-get -qq install bsdtar curl proot wget --yes 
	fi
	if [ -e $PREFIX/bin/bsdtar ] && [ -e $PREFIX/bin/curl ] && [ -e $PREFIX/bin/proot ] && [ -e $PREFIX/bin/wget ] ; then
		:
	else
		printf "\033[1;34m"  
		printf "Prerequisites exception.  Run the script again. "
		printf "\n\n\033[0m"
		exit
	fi
	printf "\n 🕧 \033[1;36m< 🕛 \033[1;34mPrerequisite packages: \033[36;1mOK  \n\n"
	dwnl
	chkdwn
	chk
}

dwnl ()
{
	if [[ $dm = wget ]];then
		wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master$flag/setupTermuxArch.tar.gz
		wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master$flag/setupTermuxArch.md5 
		printf "\n"
	else
		curl -q -O https://raw.githubusercontent.com/sdrausty/TermuxArch/master$dfl/setupTermuxArch.md5 -O https://raw.githubusercontent.com/sdrausty/TermuxArch/master$dfl/setupTermuxArch.tar.gz
		printf "\n"
	fi
}

mainblock ()
{ 
	depends
	callsystem 
	$HOME/arch/root/bin/setupbin.sh $dgfl1
	termux-wake-unlock
	rm $HOME/arch/root/bin/setupbin.sh
	printfooter
	$HOME/arch/$bin $dgfl1
	printtail
}

printmd5syschker ()
{
	printf "\033[07;1m\033[31;1m\n 🔆 ERROR md5sum mismatch!  Setup initialization mismatch!\033[36;1m  Update this copy of \`setupTermuxArch.sh\`.  If it is updated, this kind of error can go away, like magic.  Wait before executing again, especially if using a fresh copy from https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.sh on this system.  There are many reasons for checksum errors.  Proxies are one reason.  Mirroring and mirrors are another explanation for md5sum errors.  Either way this means,  \"Try again, initialization was not successful this time.\"  https://sdrausty.github.io/TermuxArchPlus/md5sums has more information.  \n\n	Execute \`bash setupTermuxArch.sh\` again. \033[31;1mExiting...  \n\033[0m"
	exit 
}

printtail ()
{
	printf "\n\033[0mThank you for using \033[1;32m\`setupTermuxArch.sh\`\033[0m 🏁  \n\n\033[0m"'\033]2;  Thank you for using `setupTermuxArch.sh`  🏁 \007'
	exit
}

printusage ()
{
	printf "\n\n\033[1;34mUsage information for \033[1;32m\`setupTermuxArch.sh\`\033[1;34m.  You can abbreviate the argument to one letter:  \n\n\033[1;33mDEBUG\033[1;34m    Use \033[1;32m\`setupTermuxArch.sh --sysinfo\` \033[1;34mto create \033[1;32m\`setupTermuxArchdebug.log\`\033[1;34m and populate it with debug information.  Post this information along with detailed information about your issue at https://github.com/sdrausty/TermuxArch/issues.  If you think screenshots will help in resolving the issue better, include them in a post along with this log file.\n\n\033[1;33mHELP\033[1;34m     Use \033[1;32m\`setupTermuxArch.sh --help\` \033[1;34mto output this help screen.\n\n\033[1;33mINSTALL\033[1;34m  Run \033[1;32m\`setupTermuxArch.sh\`\033[1;34m without arguments in a bash shell to install Arch Linux in Termux.\n\n\033[1;33mPURGE\033[1;34m    Use \033[1;32m\`setupTermuxArch.sh --uninstall\` \033[1;34mto uninstall an Arch Linux installation from Termux.\n"
	printtail
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

if [[ $1 = [Cc][Pp]* ]] || [[ $1 = -[Cc][Pp]* ]] || [[ $1 = --[Cc][Pp]* ]] || [[ $1 = [Cc][Uu]* ]] || [[ $1 = -[Cc][Uu]* ]] || [[ $1 = --[Cc][Uu]* ]];then
	depends
	rmarch
elif [[ $1 = [Cc][Dd]* ]] || [[ $1 = -[Cc][Dd]* ]] || [[ $1 = --[Cc][Dd]* ]] || [[ $1 = [Cc][Ss]* ]] || [[ $1 = -[Cc][Ss]* ]] || [[ $1 = --[Cc][Ss]* ]];then
	depends
	sysinfo 
elif [[ $1 = [Cc]* ]] || [[ $1 = -[Cc]* ]] || [[ $1 = --[Cc]* ]] || [[ $1 = [Cc][Ii]* ]] || [[ $1 = -[Cc][Ii]* ]] || [[ $1 = --[Cc][Ii]* ]];then
	mainblock
elif [[ $1 = [Dd]* ]] || [[ $1 = -[Dd]* ]] || [[ $1 = --[Dd]* ]] || [[ $1 = [Ss]* ]] || [[ $1 = -[Ss]* ]] || [[ $1 = --[Ss]* ]];then
	depends
	sysinfo 
elif [[ $1 = [Hh]* ]] || [[ $1 = -[Hh]* ]] || [[ $1 = --[Hh]* ]]  || [[ $1 = [?]* ]] || [[ $1 = -[?]* ]] || [[ $1 = --[?]* ]];then
	printusage
elif [[ $1 = [Pp]* ]] || [[ $1 = -[Pp]* ]] || [[ $1 = --[Pp]* ]] || [[ $1 = [Uu]* ]] || [[ $1 = -[Uu]* ]] || [[ $1 = --[Uu]* ]];then
	depends
	rmarch
elif [[ $1 = "" ]] || [[ $1 = [Ii]* ]] || [[ $1 = -[Ii]* ]] || [[ $1 = --[Ii]* ]];then
	mainblock
else
	printusage
fi
