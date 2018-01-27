#!/data/data/com.termux/files/usr/bin/bash -e
# Copyright 2017 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You! 
################################################################################

bin=startarch
#flag="/scripts/files/experimental"
#flag="/scripts/files/stable"
flag=""

printoneoclock ()
{
	printf "If you do not see 🕐 one o'clock below, check your Internet connection and run this script again.  "

}


depends ()
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
	wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.tar.gz
	wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.md5 
	printf "\n"
	if md5sum -c setupTermuxArch.md5 ; then
	printf "\n 🕐 \033[36;1m< 🕛 \033[1;34mInstallation script download: \033[36;1mOK  \n\n\033[36;1m"
	bsdtar -xf setupTermuxArch.tar.gz
	rmds 
else
	rmds 
	printmd5syschkerror
fi
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

printmd5syschkerror ()
{
	printf "\033[07;1m\033[31;1m\n 🔆 ERROR md5sum mismatch!  Setup initialization mismatch!\033[36;1m  Update your copy of setupTermuxArch.sh.  If you have updated it, this kind of error can go away, sort of like magic.  Waiting a few minutes before executing again is recommended, especially if you are using a new copy from https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.sh on your system.  There are many reasons that generate checksum errors.  Proxies are one reason.  Mirroring and mirrors are another explanation for md5sum errors.  Either way this means,  \"Try again, initialization was not successful.\"  See https://sdrausty.github.io/TermuxArchPlus/md5sums for more information.  \n\n	Run setupTermuxArch.sh again. \033[31;1mExiting...  \n\033[0m"
	exit 
}

printtail ()
{
	printf "\n\033[0mThank you for using \033[1;32m\`setupTermuxArch.sh\`\033[0m 🏁  \n\n\033[0m"'\033]2;  Thank you for using `setupTermuxArch.sh` 📲  \007'
	exit
}

printusage ()
{
	printf "\n\n\033[1;34mUsage information for \033[1;32m\`setupTermuxArch.sh\`\033[1;34m.  You can abbreviate the argument to one letter:  \n\n\033[1;33mDEBUG\033[1;34m    Run \033[1;32m\`setupTermuxArch.sh --sysinfo\` \033[1;34mto create \033[1;32m\`setupTermuxArchDebug.log\`\033[1;34m and populate it with debug information.  Post this information along with detailed information about your issue at https://github.com/sdrausty/TermuxArch/issues.  If you think screenshots will help in resolving your issue better, include them in your post along with this log file.\n\n\033[1;33mHELP\033[1;34m     Run \033[1;32m\`setupTermuxArch.sh --help\` \033[1;34mto output this help screen.\n\n\033[1;33mINSTALL\033[1;34m  Run \033[1;32m\`setupTermuxArch.sh\`\033[1;34m without arguments in a bash shell to install Arch Linux in Termux.\n\n\033[1;33mPURGE\033[1;34m    Run \033[1;32m\`setupTermuxArch.sh --uninstall\` \033[1;34mto uninstall your Arch Linux installation from Termux.\n"
}

rmarch ()
{
	while true; do
	printf "\n\033[1;31m"
	read -p "Run purge to uninstall Arch Linux? [y|n]  " uanswer
	if [[ $uanswer = [Ee]* ]] || [[ $uanswer = [Nn]* ]] || [[ $uanswer = [Qq]* ]];then
		break
	elif [[ $uanswer = [Yy]* ]];then
	printf "\nUninstalling Arch Linux...  \033[1;32m\n"
	if [ -e $PREFIX/bin/$bin ] ;then
	       	rm $PREFIX/bin/$bin 
	else 
		printf "Uninstalling Arch Linux, nothing to do for $PREFIX/bin/$bin.\n"
       	fi
	if [ -d $HOME/arch ] ;then
		cd $HOME/arch
		rm -rf * 2>/dev/null||:
		find -type d -exec chmod 700 {} \; 2>/dev/null||:
		cd ..
		rm -rf $HOME/arch
	else 
		printf "Uninstalling Arch Linux, nothing to do for $HOME/arch.\n"
	fi
	printf "Uninstalling Arch Linux done.  \n"
	printtail
	else
		printf "\nYou answered \033[33;1m$uanswer\033[1;31m.\n\nAnswer \033[32mYes\033[1;31m or No. [\033[32my\033[1;31m|n]\n"
	fi
	done
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

sysinfo ()
{
	printf "\n\033[1;32m"
	printf "Begin setupTermuxArch debug information.\n\n" > setupTermuxArchDebug.log
	date >> setupTermuxArchDebug.log 
	for n in 0 1 2 3 4 5 
	do 
		echo "BASH_VERSINFO[$n] = ${BASH_VERSINFO[$n]}"  >> setupTermuxArchDebug.log
	done
	printf "\ncat /proc/cpuinfo results:\n\n" >> setupTermuxArchDebug.log
	cat /proc/cpuinfo >> setupTermuxArchDebug.log
	printf "\ndpkg --print-architecture result:\n\n" >> setupTermuxArchDebug.log
	dpkg --print-architecture >> setupTermuxArchDebug.log
	printf "\ngetprop ro.product.cpu.abi result:\n\n" >> setupTermuxArchDebug.log
	getprop ro.product.cpu.abi >> setupTermuxArchDebug.log
	printf "\ngetprop ro.product.device result:\n\n" >> setupTermuxArchDebug.log
	getprop ro.product.device >> setupTermuxArchDebug.log
	printf "\nDownload directory information results.\n\n" >> setupTermuxArchDebug.log
	ls -al ~/storage/downloads  2>>setupTermuxArchDebug.log >> setupTermuxArchDebug.log ||:
	ls -al ~/downloads 2>>setupTermuxArchDebug.log  >> setupTermuxArchDebug.log ||:
	if [ -d /sdcard/Download ]; then echo "/sdcard/Download exists"; else echo "/sdcard/Download not found"; fi >> setupTermuxArchDebug.log 
	if [ -d /storage/emulated/0/Download ]; then echo "/storage/emulated/0/Download exists"; else echo "/storage/emulated/0/Download not found"; fi >> setupTermuxArchDebug.log
	printf "\nuname -mo results:\n\n" >> setupTermuxArchDebug.log
	uname -mo >> setupTermuxArchDebug.log
	printf "\nEnd setupTermuxArch debug information.\n\nPost this information along with information regarding your issue at https://github.com/sdrausty/TermuxArch/issues.  This debugging information is found in $(pwd)/$(ls setupTermuxArchDebug.log).  If you think screenshots will help in resolving this matter better, include them in your post please.  " >> setupTermuxArchDebug.log
	cat setupTermuxArchDebug.log
}

# Begin
if [[ $1 = "" ]] || [[ $1 = [Ii]* ]] || [[ $1 = -[Ii]* ]] || [[ $1 = --[Ii]* ]];then
	# Main Block
	depends
	callsystem 
	$HOME/arch/root/bin/setupbin.sh ||: 
	termux-wake-unlock
	rm $HOME/arch/root/bin/setupbin.sh
	printfooter
	$HOME/arch/$bin ||: 
	printtail
	# End Main Block
elif [[ $1 = [Dd]* ]] || [[ $1 = -[Dd]* ]] || [[ $1 = --[Dd]* ]] || [[ $1 = [Ss]* ]] || [[ $1 = -[Ss]* ]] || [[ $1 = --[Ss]* ]];then
	sysinfo 
	printf "Submit this information if you plan to open up an issue at https://github.com/sdrausty/TermuxArch/issues to improve this installation script along with a screenshot of your topic.  \n"
	printtail
elif [[ $1 = [Hh]* ]] || [[ $1 = -[Hh]* ]] || [[ $1 = --[Hh]* ]]  || [[ $1 = [?]* ]] || [[ $1 = -[?]* ]] || [[ $1 = --[?]* ]];then
	printusage
	printtail
elif [[ $1 = [Pp]* ]] || [[ $1 = -[Pp]* ]] || [[ $1 = --[Pp]* ]] || [[ $1 = [Uu]* ]] || [[ $1 = -[Uu]* ]] || [[ $1 = --[Uu]* ]];then
	rmarch
	printtail
else
	printusage
	printtail
fi

