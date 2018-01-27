#!/data/data/com.termux/files/usr/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You! 
################################################################################

checksetupTermuxArch()
{
if md5sum -c termuxarchchecksum.md5 ; then
	. archsystemconfigs.sh
	. knownconfigurations.sh
	. necessaryfunctions.sh
	. printoutstatements.sh
	rmdsc 
	printf "\n\033[36;1m 🕜 < 🕛 \033[1;34mInstallation script integrity: \033[36;1mOK  \n\033[0m"
else
	rmdsc 
	printmd5syschkerror
fi
}

checksetupTermuxArchdownload ()
{
if md5sum -c setupTermuxArch.md5 ; then
	printf "\n 🕐 \033[36;1m< 🕛 \033[1;34mInstallation script download: \033[36;1mOK  \n\n\033[36;1m"
	bsdtar -xf setupTermuxArch.tar.gz
	rmds 
else
	rmds 
	printmd5syschkerror
fi
}

depends ()
{
	installtermuxdepends
	downloadtargz
	checksetupTermuxArchdownload
	checksetupTermuxArch
}

downloadtargz ()
{
	wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.tar.gz
	wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.md5 
	printf "\n"
}

installtermuxdepends()
{
	printf '\033]2;  Thank you for using `setupTermuxArch.sh` 📲 \007'"\n 🕛 \033[36;1m< 🕛 \033[1;34mThis setup script will attempt to set Arch Linux up in your Termux environment.  When successfully completed, you will be enjoying the bash prompt in Arch Linux in Termux on your smartphone or tablet. "
	printoneoclock
if [ -e $PREFIX/bin/bsdtar ] && [ -e $PREFIX/bin/proot ] && [ -e $PREFIX/bin/wget ] ; then
	printf "Termux package requirements for Arch Linux: \033[36;1mOK  \n\n"
else
	printf "\n\n\033[36;1m"
	apt-get -qq update && apt-get -qq upgrade -y
	apt-get -qq install bsdtar proot wget --yes 
fi
if [ -e $PREFIX/bin/bsdtar ] && [ -e $PREFIX/bin/proot ] && [ -e $PREFIX/bin/wget ] ; then
	:
else
	printf "\033[1;34m"  
	printoneoclock
	printf "\n\n\033[0m"
	exit
fi
	printf "\n 🕧 < 🕛 \033[1;34mTermux package requirements for Arch Linux: \033[36;1mOK  \n\n"
}

mainblock ()
{ 
	depends
	callsystem 
	$HOME/arch/root/bin/setupbin.sh ||: 
	termux-wake-unlock
	rm $HOME/arch/root/bin/setupbin.sh
	printfooter
	$HOME/arch/$bin ||: 
	printtail
}

printmd5syschkerror ()
{
	printf "\033[07;1m\033[31;1m\n 🔆 ERROR md5sum mismatch!  Setup initialization mismatch!\033[36;1m  Update your copy of setupTermuxArch.sh.  If you have updated it, this kind of error can go away, sort of like magic.  Waiting a few minutes before executing again is recommended, especially if you are using a new copy from https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.sh on your system.  There are many reasons that generate checksum errors.  Proxies are one reason.  Mirroring and mirrors are another explanation for md5sum errors.  Either way this means,  \"Try again, initialization was not successful.\"  See https://sdrausty.github.io/TermuxArchPlus/md5sums for more information.  \n\n	Run setupTermuxArch.sh again. \033[31;1mExiting...  \n\033[0m"
	exit 
}

printoneoclock ()
{
	printf "If you do not see 🕐 one o'clock below, check your Internet connection and run this script again.  "
}

printtail ()
{
	printf "\n\033[0mThank you for using \033[1;32m\`setupTermuxArch.sh\`\033[0m 🏁  \n\n\033[0m"'\033]2;  Thank you for using `setupTermuxArch.sh`  🏁 \007'
	exit
}

printusage ()
{
	printf "\n\n\033[1;34mUsage information for \033[1;32m\`setupTermuxArch.sh\`\033[1;34m.  You can abbreviate the argument to one letter:  \n\n\033[1;33mDEBUG\033[1;34m    Run \033[1;32m\`setupTermuxArch.sh --sysinfo\` \033[1;34mto create \033[1;32m\`setupTermuxArchDebug.log\`\033[1;34m and populate it with debug information.  Post this information along with detailed information about your issue at https://github.com/sdrausty/TermuxArch/issues.  If you think screenshots will help in resolving your issue better, include them in your post along with this log file.\n\n\033[1;33mHELP\033[1;34m     Run \033[1;32m\`setupTermuxArch.sh --help\` \033[1;34mto output this help screen.\n\n\033[1;33mINSTALL\033[1;34m  Run \033[1;32m\`setupTermuxArch.sh\`\033[1;34m without arguments in a bash shell to install Arch Linux in Termux.\n\n\033[1;33mPURGE\033[1;34m    Run \033[1;32m\`setupTermuxArch.sh --uninstall\` \033[1;34mto uninstall your Arch Linux installation from Termux.\n"
}

rmdsc ()
{
	rm archsystemconfigs.sh
	rm knownconfigurations.sh
	rm necessaryfunctions.sh
	rm printoutstatements.sh
	rm termuxarchchecksum.md5
}

rmds ()
{
	rm setupTermuxArch.md5
	rm setupTermuxArch.tar.gz
}

bin=startarch
downloadmethod=wget

if [[ $1 = "" ]] || [[ $1 = [Ii]* ]] || [[ $1 = -[Ii]* ]] || [[ $1 = --[Ii]* ]];then
	mainblock
elif [[ $1 = [Cc]* ]] || [[ $1 = -[Cc]* ]] || [[ $1 = --[Cc]* ]];then
	downloadmethod=curl
	mainblock
elif [[ $1 = [Dd]* ]] || [[ $1 = -[Dd]* ]] || [[ $1 = --[Dd]* ]] || [[ $1 = [Ss]* ]] || [[ $1 = -[Ss]* ]] || [[ $1 = --[Ss]* ]];then
	depends
	sysinfo 
	printtail
elif [[ $1 = [Hh]* ]] || [[ $1 = -[Hh]* ]] || [[ $1 = --[Hh]* ]]  || [[ $1 = [?]* ]] || [[ $1 = -[?]* ]] || [[ $1 = --[?]* ]];then
	printusage
	printtail
elif [[ $1 = [Pp]* ]] || [[ $1 = -[Pp]* ]] || [[ $1 = --[Pp]* ]] || [[ $1 = [Uu]* ]] || [[ $1 = -[Uu]* ]] || [[ $1 = --[Uu]* ]];then
	depends
	rmarch
	printtail
else
	printusage
	printtail
fi

