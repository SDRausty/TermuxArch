#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
# 🕧🕐🕜🕑🕝🕒🕞🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕥🕚🕦🕛
# Printout statement subroutines for `setupTermuxArch.sh`.
################################################################################

printcontacting () {
 	printf '\033]2;  🕛 > 🕞 Contacting worldwide mirror…\007'"\033[0;34m 🕛 > 🕞 \033[1;34mContacting worldwide mirror \033[0;32m$cmirror\033[1;34m: "
}

printcu () {
	printf "\n\033[0;34m 🕛 > 🕘 \033[1;34mCleaning up installation files: "'\033]2; 🕛 > 🕙 Cleaning up installation files: \007'
}

printdetectedsystem () {
	printf "\n\033[0;34m 🕛 > 🕝 \033[1;34mDetected $(uname -m) " 
	if [[ $(getprop ro.product.device) == *_cheets ]];then
		printf "Chromebook.\n\n\033[0m"
	else
		printf "$(uname -o) operating system.\n\n\033[0m"
	fi
}

printdone () {
	printf "\033[1;32mDONE  \033[0m\n\n"
}

printwla () {
	printf "\033[0;34m 🕛 > 🕒 \033[1;34mActivating termux-wake-lock: "'\033]2; 🕛 > 🕒 Activating termux-wake-lock: OK\007'
}

printwld () {
	printf "\033[0;34m 🕛 > 🕙 \033[1;34mReleasing termux-wake-lock: "'\033]2; 🕛 > 🕙 Releasing termux-wake-lock: OK\007'
}

printdownloadingx86 () {
	printf "\n\033[0;34m 🕛 > 🕞 \033[0;34mDownloading checksum from \033[0;32mhttp://$mirror\033[0;34m…\n\n\033[0;32m"'\033]2; 🕛 > 🕞 Downloading the Arch Linux system image checksum…  \007'
}

printdownloadingx86two () {
	printf "\033[0;34m 🕛 > 🕓 \033[0;34mDownloading \033[0;32m$file \033[0;34mfrom \033[0;32mhttp://$mirror\033[0;34m…  \033[1;37mThis may take a long time pending connection.\n\n\033[0;32m"'\033]2; 🕛 > 🕓 Downloading the Arch Linux system image file…  \007'
}

printdownloadingftch () {
	printf "\033[0;34m 🕛 > 🕓 \033[1;34mDownloading the checksum file and \033[1;34m$file \033[1;34mfrom the geographically local mirror \033[1;32m$nmirror\033[1;34m.  If contact with the local mirror is not successful, run \033[1;32mbash \033[0;32msetupTermuxArch.sh\033[1;34m again.  Should the worldwide mirror not provide another geographically nearby server after a couple of attempts, use \033[1;32mbash \033[0;32msetupTermuxArch.sh manual \033[1;34mafter locating a local mirror from the Internet; See \033[1;32mbash \033[0;32msetupTermuxArch.sh help \033[1;34mfor additional options.  \033[1;37mDownload of $file pending Internet connection:\n\n\033[0;32m"'\033]2; 🕛 > 🕓 Downloading the checksum and Arch Linux system image file…  \007'
}

printdownloadingftchit () {
	printf "\033[0;34m 🕛 > 🕓 \033[0;34mDownloading the checksum file and \033[0;32m$file \033[0;34m from \033[0;32mhttp://$mirror\033[0;34m…  \033[1;37mThis may take a long time pending connection.\n\n\033[0;32m"'\033]2; 🕛 > 🕓 Downloading the checksum and Arch Linux system image file…  \007'
}

printconfigq () {
	printf "\033[0;34m 🕛 > 🕤 \033[1;34mArch Linux in Termux PRoot is installed.  Configuring and updating Arch Linux 📲"'\033]2; 🕛 > 🕤 Arch Linux is installed!  Configuring and updating Arch Linux 📲 \007'
}

printmd5check () {
	printf "\n\033[0;34m 🕛 > 🕠 \033[1;34mChecking download integrity with Termux busybox md5sum.  \033[37;1mThis may take a little while:\n\n\033[1;33m"
}

printmd5error () {
	printf "\n\033[07;1m\033[31;1m 🔆 WARNING md5sum mismatch! The download failed and was removed!\033[34;1m\033[30;1m  Run \`bash setupTermuxArch.sh\` again.  See \`bash setupTermuxArch.sh help\` to resolve md5sum errors.  This kind of error can go away, like magic.  Waiting before executing again is recommended.  There are many reasons for checksum errors.  Proxies are one explaination.  Mirroring and mirrors are another explaination for md5sum errors.  Interrupted download is one more reason.  If this keeps repeating, copy \`knownconfigurations.sh\` to \`setupTermuxArchConfigs.sh\` with preferred mirror.  After editing \`setupTermuxArchConfigs.sh\`, run \`bash setupTermuxArch.sh\` and \`setupTermuxArchConfigs.sh\` loads automaticaly from the same directory.  Change mirror to desired geographic location to resolve md5sum errors.\n\nUser configurable variables are in \`setupTermuxArchConfigs.sh\`.  Create this file from \`kownconfigurations.sh\` in the working directory.  Use \`bash setupTermuxArch.sh manual\` to create and edit \`setupTermuxArchConfigs.sh\`.\n\n	Run \`bash setupTermuxArch.sh\` again…\n\033[0;0m\n"'\033]2;  Thank you for using setupTermuxArch.sh.  Run `bash setupTermuxArch.sh` again…\007'
	exit 
}

printmd5success () {
 	printf '\033]2;  🕛 > 🕡 Uncompressing the image file.  This will take a long time; Be patient.\007'"\033[0;34m 🕛 > 🕕 \033[1;34mSystem image file download integrity: \033[1;32mOK\n\n\033[0;34m 🕛 > 🕡 \033[1;34mUncompressing $file into $installdir.  The option to create Arch Linux system users will be available through \033[1;32maddauser \033[1;34mand \033[1;32maddauserps\033[1;34m.  Arch Linux user login from Termux with \033[1;32m$startbin \033[1;34mis now implemented.  See \033[0;36mAbility for Scripts to Launch Commands for Arch Linux in Termux PRoot on Device\033[1;34m https://github.com/sdrausty/TermuxArch/issues/54 for more information about these brand new options.  Additional features of TermuxArch are also listed at https://github.com/sdrausty/TermuxArch/releases.\n\nWhile waiting, you can use \033[0;36mdf\033[1;34m, \033[0;36mdu -hs\033[1;34m, \033[0;36mhtop\033[1;34m, \033[0;36mps\033[1;34m, \033[0;36mtop\033[1;34m and \033[0;36mwatch\033[1;34m in a new Termux session to watch the uncompressing while the session completes.  Use \033[0;36minfo query \033[1;34mand \033[0;36mman query \033[1;34mto learn more about your Linux system in the palm of your hand.  See The Linux Documentation Project http://tldp.org to learn more about Linux and CLI commands.  \033[1;37mUncompressing \033[37m$file\033[1;37m will take a long time; Be patient:\n\033[0m"
}

printmismatch () {
	printf "\n\033[07;1m\033[31;1m 🔆 ERROR Unknown configuration!  Did not find an architecture and operating system match in\033[37;1m knownconfigurations.sh\033[31;1m!  \033[36;1mDetected $(uname -mo).  There still is hope.  Check at http://mirror.archlinuxarm.org/os/ and https://www.archlinux.org/mirrors/ for other available images and see if any match the device.  If you find a match, then please \033[37;1msubmit a pull request\033[36;1m at https://github.com/sdrausty/TermuxArch/pulls with script modifications.  Alternatively, \033[37;1msubmit a modification request\033[36;1m at https://github.com/sdrausty/TermuxArch/issues if you find a configuration match.  Include output from \033[37;1muname -mo\033[36;1m on the device in order to expand autodetection for \033[37;1msetupTermuxArch.sh\033[36;1m.  See https://sdrausty.github.io/docs/TermuxArch/Known_Configurations for more information.\n\n	\033[36;1mRun setupTermuxArch.sh again…\n\033[0m"'\033]2;  Thank you for using setupTermuxArch.sh.  Run `bash setupTermuxArch.sh` again…\007'
	exit 
}

printfooter () {
	printf "\033[0;34m 🕛 > 🕥 \033[1;34mUse \033[1;32m$startbin\033[1;34m to launch Arch Linux in Termux PRoot.  Alternatively, run \033[1;32m~$printrootdir/$startbin \033[1;34min a BASH shell to start Arch Linux in Termux PRoot for future sessions also.\033[0m\n\n"'\033]2;  Thank you for using `setupTermuxArch.sh` to install Arch Linux in Termux 📲  \007'
	copystartbin2path
	printf "\033[0;32m 🕛 = 🕛 \033[1;34mInformation about \033[0;36m\"Starting Arch Linux from Termux?\"\033[1;34m at \033[1;34mhttps://github.com/sdrausty/TermuxArch/issues/25\033[1;34m.  Use \033[1;32mtour\033[1;34m to run a short tour, and get to know the new Arch Linux in Termux PRoot environment you just set up better.  If there was more than one error during the update procedure and you would like to refresh the installation, use \033[1;32msetupTermuxArch.sh refresh\033[1;34m.  This will update and recreate the configuration provided.  Use the TermuxArch command \033[1;32mkeys \033[1;34mto install and generate Arch Linux keyring keys.\n"
	printfooter2
	printf "\n"
}

printfooter2 () {
	printf "\n\033[1;34mArch Linux in Termux PRoot is installed in $installdir.  This project is in active development and contributions are welcome; See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS for information.  The documentation repository for TermuxArch https://sdrausty.github.io/TermuxArch/docs/ is a Termux Arch submodule that is located at https://github.com/sdrausty/docsTermuxArch.  Pull requests and contributions through the issues pages are open to improve the ux and this Termux PRoot installation script.\n\nUse \033[1;32m~$printrootdir/$startbin \033[1;34mand \033[1;32m$startbin \033[1;34min a BASH shell to launch Arch Linux in Termux PRoot for future sessions.  See https://wiki.archlinux.org/index.php/IRC_channel for available Arch Linux IRC channels.\n\033[0m"
}

printrootdirfunction () {
	declare -g printrootdir=$(echo ${rootdir%/} |sed s#//*#/#g)
}

printrootdirfunction ret
