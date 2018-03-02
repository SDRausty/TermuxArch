#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

callsystem ()
{
	mkdir -p $HOME$rootdir
	cd $HOME$rootdir
	detectsystem
}

copybin2path ()
{
	if [[ ":$PATH:" == *":$HOME/bin:"* ]] && [ -d $HOME/bin ]; then
		BPATH=$HOME/bin
	else
		BPATH=$PREFIX/bin
	fi
	while true; do
	printf "\033[0;34m 🕛 > 🕚 \033[0mCopy \033[1m$bin\033[0m to \033[1m$BPATH\033[0m?  " 
	read -p "Answer yes or no [Y|n] " answer
	if [[ $answer = [Yy]* ]] || [[ $answer = "" ]];then
		cp $HOME$rootdir/$bin $BPATH
		printf "\n\033[0;34m 🕛 > 🕦 \033[0mCopied \033[1m$bin\033[0m to \033[1m$PREFIX/bin\033[0m.\n\n"
		break
	elif [[ $answer = [Nn]* ]] || [[ $answer = [Qq]* ]];then
		printf "\n"
		break
	else
		printf "\n\033[0;34m 🕛 > 🕚 \033[0mYou answered \033[33;1m$answer\033[0m.\n\n\033[0;34m 🕛 > 🕚 \033[0mAnswer yes or no [Y|n]\n\n"
	fi
	done
}

detectsystem ()
{
	printdetectedsystem
	if [ $(getprop ro.product.cpu.abi) = armeabi ];then
		armv5l
	elif [ $(getprop ro.product.cpu.abi) = armeabi-v7a ];then
		detectsystem2 
	elif [ $(getprop ro.product.cpu.abi) = arm64-v8a ];then
		aarch64
	elif [ $(getprop ro.product.cpu.abi) = x86 ];then
		i686 
	elif [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		x86_64
	else
		printmismatch 
	fi
}

detectsystem2 ()
{
	if [[ $(getprop ro.product.device) == *_cheets ]];then
		armv7lChrome 
	else
		armv7lAndroid  
	fi
}

mainblock ()
{ 
	rmarchq
	spaceinfoq
	callsystem 
	termux-wake-unlock
#	rm $HOME$rootdir/root/bin/setupbin.sh
	printfooter
	$HOME$rootdir/$bin 
}

makebin ()
{
	makestartbin 
	printconfigq 
	touchupsys 
}

makefinishsetup ()
{
	binfs=finishsetup.sh  
	cat > root/bin/$binfs <<- EOM
	#!/bin/bash -e
	EOM
	if [ -e $HOME/.bash_profile ]; then
		grep "proxy" $HOME/.bash_profile | grep "export" >>  root/bin/$binfs 2>/dev/null ||:
	fi
	if [ -e $HOME/.bashrc ]; then
		grep "proxy" $HOME/.bashrc  | grep "export" >>  root/bin/$binfs 2>/dev/null ||:
	fi
	if [ -e $HOME/.profile ]; then
		grep "proxy" $HOME/.profile | grep "export" >>  root/bin/$binfs 2>/dev/null ||:
	fi
	cat >> root/bin/$binfs <<- EOM
	printf "\n"
	if [ $(getprop ro.product.cpu.abi) = x86 ] || [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		pacman -Syu sed --noconfirm ||:
	else
		pacman -Syu --noconfirm ||:
	fi
	printf "\n"
	locale-gen ||:
	printf "\n"
	tzselect
	printf "\r"
	printf '\033]2; 🕛 > 🕙 Arch Linux in Termux is installed and configured.  📲  \007'
	EOM
	chmod 770 root/bin/finishsetup.sh 
}

makesetupbin ()
{
	cat > root/bin/setupbin.sh <<- EOM
	#!$PREFIX/bin/bash -e
	unset LD_PRELOAD
	exec proot --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin $HOME$rootdir/root/bin/finishsetup.sh
	EOM
	chmod 700 root/bin/setupbin.sh
}

makestartbin ()
{
	cat > $bin <<- EOM
	#!$PREFIX/bin/bash -e
	unset LD_PRELOAD
	exec proot --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
	EOM
	chmod 700 $bin
}

makesystem ()
{
	printwla 
	termux-wake-lock 
	printdone 
	if [ $(getprop ro.product.cpu.abi) = x86 ] || [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		getimage
	else
		if [ "$mirror" = "os.archlinuxarm.org" ] || [ "$mirror" = "mirror.archlinuxarm.org" ]; then
			ftchstnd 
		else
			ftchit
		fi
	fi
	printmd5check
	if md5sum -c $file.md5 1>/dev/null ; then
		printmd5success
		preproot 
	else
		rmarchrm 
		printmd5error
	fi
	rm *.tar.gz *.tar.gz.md5
	makebin 
}

preproot ()
{
	if [ $(du $HOME$rootdir/*z | awk {'print $1'}) -gt 112233 ];then
		if [ $(getprop ro.product.cpu.abi) = x86 ] || [ $(getprop ro.product.cpu.abi) = x86_64 ];then
			#cd $HOME
			#proot --link2symlink -0 $PREFIX/bin/applets/tar xf $HOME$rootdir$file 
			#cd $HOME$rootdir
			proot --link2symlink -0 bsdtar -xpf $file --strip-components 1 
		else
			proot --link2symlink -0 $PREFIX/bin/applets/tar xf $file 
		fi
	else
		printf "\n\n\033[1;31mDownload Exception!  Execute \033[0;32mbash setupTermuxArch.sh\033[1;31m again…\n"'\033]2;  Thank you for using setupTermuxArch.sh.  Execute `bash setupTermuxArch.sh` again…\007'
		exit
	fi
}

runfinishsetup ()
{
	if [[ $ed = "" ]];then
		editors 
	fi
	sed -i '1i# TermuxArch vi instructions:\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.\n# 18j then i will open insert mode in vi for the Geo-IP mirror.\n# Enter # to comment out this line.\n# Use ESC to return to command mode.\n# Long tap KEYBOARD in the side pane if you do not see ESC.\n#After locating a local mirror, use x to delete # uncommenting the mirror.\n# Choose only one mirror.\n# Use :x to save and finish your work.\n# ' $HOME$rootdir/etc/pacman.d/mirrorlist
	$ed $HOME$rootdir/etc/pacman.d/mirrorlist
	while true; do
		printf "\n\033[0;32mWould you like to run \033[1;32mlocale-gen\033[0;32m to generate the en_US.UTF-8 locale, or edit \033[1;32m/etc/locale.gen\033[0;32m specifying your preferred language(s) before running \033[1;32mlocale-gen\033[0;32m?  "
		read -p "Answer yes to run [Y|e] " ye
	if [[ $ye = [Yy]* ]] || [[ $ye = "" ]];then
		break
	elif [[ $ye = [Ee]* ]] || [[ $ye = [Nn]* ]];then
		$ed $HOME$rootdir/etc/locale.gen
		break
	else
		printf "\nYou answered \033[1;36m$ye\033[1;32m.\n"
		printf "\nAnswer yes to run [Y|e]\n"
	fi
	done
	$HOME$rootdir/root/bin/setupbin.sh 
}

runfinishsetupq ()
{
	while true; do
		printf "\n\033[0;32mWould you like to run \033[1;32mfinishsetup.sh\033[0;32m to complete the Arch Linux configuration and update now, or at a later time?  \033[1;32mNow is recommended\033[0;32m; "
		read -p "Answer yes to complete, or no for later [Y|n] " nl
	if [[ $nl = [Yy]* ]] || [[ $nl = "" ]];then
		runfinishsetup 
		break
	elif [[ $nl = [Nn]* ]];then
		printf "\n\033[0;32mSet the geographically nearby mirror in \033[1;32m/etc/pacman.d/mirrorlist\033[0;32m first.  Then use \033[1;32m$HOME$rootdir/root/bin/setupbin.sh\033[0;32m in Termux to run \033[1;32mfinishsetup.sh\033[0;32m or simply \033[1;32mfinishsetup.sh\033[0;32m in Arch Linux Termux PRoot."
		break
	else
		printf "\nYou answered \033[1;36m$nl\033[1;32m.\n"
		printf "\nAnswer yes to complete, or no for later [Y|n]\n"
	fi
	done
	printf "\n"
}

setlocalegen()
{
	if [ -e etc/locale.gen ]; then
		sed -i '/\#en_US.UTF-8 UTF-8/{s/#//g;s/@/-at-/g;}' etc/locale.gen 
	else
		cat >  etc/locale.gen <<- EOM
		en_US.UTF-8 UTF-8 
		EOM
	fi
}

touchupsys ()
{
	mkdir -p root/bin
	addauser
	addauserps
	addbash_profile 
	addbashrc 
	adddfa
	addga
	addgcl
	addgcm
	addgp
	addgpl
	addmotd
	addprofile 
	addresolvconf 
	addt 
	addyt 
	addv 
	setlocalegen
	makefinishsetup
	makesetupbin 
	runfinishsetupq
}

