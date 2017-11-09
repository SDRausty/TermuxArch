#!/bin/bash -e
# Website for this project at https://sdrausty.github.io/TermuxArch 
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You! 
# Copyright 2017 by SDRausty. All rights reserved.
# 🕧🕐🕜🕑🕝🕒🕞🕓🕟🕔🕠🕕🕡🕖🕢🕗🕣🕘🕤🕙🕥🕚🕦🕛
# Printout statement subroutines for `setupTermuxArch.sh`.
################################################################################

printdetectedsystem ()
{
	printf "\033[0m\n 🕜 \033[36;1m< 🕛 Detected $(uname -mo) Operating System.  \033[0m\n"
}

printdownloading ()
{
	printf "\033[0m\n 🕑 \033[36;1m<\033[0m 🕛 Now downloading \033[36;1m$file\033[0m and the corresponding checksum.  This may take a long time depending on your Internet speed.  \n\n"
}

printfooter()
{
	printf "\033[0m\n 🕙 \033[36;1m<\033[0m 🕛 Run \033[36;1mfinishsetup.sh\033[0m to continue the installation. Alternatively, go on with the installation by doing the following:\n\n	1) Run \033[36;1mlocale-gen\033[0m to generate the en_US.UTF-8 locale.  Edit \033[36;1m/etc/locale.gen \033[0mwith \033[36;1mnano\033[0m or \033[36;1mvi\033[0m specifing your preferred locale and run \033[36;1mlocale-gen\033[0m if you want other locales. See https://wiki.archlinux.org/index.php/Locale for more information.  \n\n	2) Adjust your \033[36;1m/etc/pacman.d/mirrorlist\033[0m file in accordance with your geographic location. Use \033[36;1mpacman -Syu\033[0m to update your Arch Linux in Termux distribution.  See https://wiki.archlinux.org/index.php/Pacman for more information.  \033[0m\n\n"
}

printmd5check ()
{
	printf "\033[0m\n 🕠 \033[36;1m<\033[0m 🕛 Checking download integrity with md5sum.  This may take a little while.  \n\n 🕕 \033[36;1m< 🕛 "
}

printmd5error ()
{
	printf "\033[07;1m\033[31;1m\n 🔆 ERROR md5sum mismatch! The download was corrupt! Removing failed download.\033[36;1m  Run setupTermuxArch.sh again!  See https://sdrausty.github.io/TermuxArchPlus/md5sums for more information.  This kind of error can go away, sort of like magic.  Waiting a few minutes before executing again is recommended. There are many reasons that generate checksum errors.  Proxies are one reason.  Mirroring and mirrors are another explaination for md5sum errors.  Either way it means this download was corrupt.  If this keeps repeating, please change your mirror with an editor like vi in \033[37;1mknownconfigurations.sh\033[36;1m.  See https://sdrausty.github.io/TermuxArchPlus/mirrors for more information.  \n\n	Run setupTermuxArch.sh again. \033[31;1mExiting...  \033[0m\n"
	exit 
}

printmd5success ()
{
	printf "\033[0m\n\033[36;1m 🕡 \033[36;1m< 🕛 Downloaded files integrity: OK  \n\n\033[0m 🕖 \033[36;1m<\033[0m 🕛 Now uncompressing \033[36;1m$file\033[0m.  \033[37;1mThis will take much longer!  Be patient.  \033[0m\n"
}

printmd5syschkerror ()
{
	printf "\033[07;1m\033[31;1m\n 🔆 ERROR md5sum mismatch!  Setup initialization mismatch!\033[36;1m  Update your copy of setupTermuxArch.sh.  If you have updated it, this kind of error can go away, sort of like magic.  Waiting a few minutes before executing again is recommended, especially if you are using a new copy from https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.sh on your system.  There are many reasons that generate checksum errors.  Proxies are one reason.  Mirroring and mirrors are another explaination for md5sum errors.  Either way this means,  \"Try again, initialization was not successful.\"  See https://sdrausty.github.io/TermuxArchPlus/md5sums for more information.  \n\n	Run setupTermuxArch.sh again. \033[31;1mExiting...  \033[0m\n"
	exit 
}

printmd5syschksuccess ()
{
	printf "\033[0m\n 🕐 \033[36;1m< 🕛 Installation script integrity: OK  \033[0m\n"
}

printmismatch ()
{
	printf "\033[07;1m\033[31;1m\n 🔆 ERROR Unknown configuration!  Did not find an architecture and operating system match in\033[37;1m knownconfigurations.sh\033[31;1m!  \033[36;1mDetected $(uname -mo).  There still is hope.  Check at http://mirror.archlinuxarm.org/os/ and https://www.archlinux.org/mirrors/ for other available images and see if any match your device.  If you find a match, then please \033[37;1msubmit a pull request\033[36;1m at https://github.com/sdrausty/TermuxArch/pulls with script modifications.  Alternatively, \033[37;1msubmit a modification request\033[36;1m at https://github.com/sdrausty/TermuxArch/issues if you find a configuration match.  Please include output from \033[37;1muname -mo\033[36;1m on the device in order to expand autodetection for \033[37;1msetupTermuxArch.sh\033[36;1m.  See https://sdrausty.github.io/TermuxArchPlus/Known_Configurations for more information.  \n\n	\033[36;1mRun setupTermuxArch.sh again. \033[31;1mExiting...  \033[0m\n"
	exit 
}

printtail ()
{
	printf "\033[0m\n 🕚 \033[36;1m<\033[0m 🕛 Use \033[36;1m./arch/$bin\033[0m from your \033[36;1m\$HOME\033[0m directory to launch Arch Linux in Termux for future sessions.  This can be abbreviated to, \033[36;1m\"!.\"\033[0m at the bash prompt after starting a session in Termux.  Alternatively copy \033[36;1m$bin\033[0m to your \033[36;1m\$PATH\033[0m which is, \033[36;1m\"$PATH\"\033[0m.  \n\n"
	copybin2path 
	printf "Thank you for using \033[36;1msetupTermuxArch.sh\033[0m to install Arch Linux in Termux🏁  \033[36;1mExiting...   \033[0m\n\n"'\033]2;  Thank you for using `setupTermuxArch.sh` to install Arch Linux in Termux 📲  \007'
}

