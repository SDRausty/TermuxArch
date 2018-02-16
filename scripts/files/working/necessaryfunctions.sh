#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

callsystem ()
{
	mkdir -p $HOME/arch
	cd $HOME/arch
	detectsystem
}

copybin2path ()
{
	printf " 🕚 \033[36;1m<\033[0m 🕛 "
	while true; do
	read -p "Copy $bin to your \$PATH? [y|n] " answer
	if [[ $answer = [Yy]* ]];then
		cp $HOME/arch/$bin $PREFIX/bin
		printf "\n 🕦 \033[36;1m<\033[0m 🕛 Copied \033[32;1m$bin\033[0m to \033[1;34m$PREFIX/bin\033[0m.\n\n"
		break
	elif [[ $answer = [Nn]* ]];then
		printf "\n"
		break
	elif [[ $answer = [Qq]* ]];then
		printf "\n"
		break
	else
		printf "\n 🕚 \033[36;1m<\033[0m 🕛 You answered \033[33;1m$answer\033[0m.\n"
		printf "\n 🕚 \033[36;1m<\033[0m 🕛 Answer Yes or No (y|n).\n\n"
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
	$HOME/arch/root/bin/setupbin.sh 
	termux-wake-unlock
	rm $HOME/arch/root/bin/setupbin.sh
	printfooter
	$HOME/arch/$bin 
}

makebin ()
{
	makestartbin 
	printconfigq 
	touchupsys 
}

makesetupbin ()
{
	cat > root/bin/setupbin.sh <<- EOM
	#!/data/data/com.termux/files/usr/bin/bash -e
	unset LD_PRELOAD
	exec proot --link2symlink -0 -r $HOME/arch/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin $HOME/arch/root/bin/finishsetup.sh
	EOM
	chmod 700 root/bin/setupbin.sh
}

makestartbin ()
{
	cat > $bin <<- EOM
	#!/data/data/com.termux/files/usr/bin/bash -e
	unset LD_PRELOAD
	exec proot --link2symlink -0 -r $HOME/arch/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
	EOM
	chmod 700 $bin
}

makesystem ()
{
	printdownloading 
	termux-wake-lock 
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
	if md5sum -c $file.md5 ; then
		printmd5success
		preproot 
	else
		rmarchc 
		printmd5error
	fi
	rm *.tar.gz *.tar.gz.md5
	makebin 
}

preproot ()
{
	if [ $(du ~/arch/*z | awk {'print $1'}) -gt 112233 ];then
		if [ $(getprop ro.product.cpu.abi) = x86 ] || [ $(getprop ro.product.cpu.abi) = x86_64 ];then
			proot --link2symlink -0 bsdtar -xpf $file --strip-components 1 

		else
			proot --link2symlink -0 bsdtar -xpf $file 
		fi
	else
		printf "\n\n\033[1;31mDownload Exception!  Exiting...\n"
		exit
	fi
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
	printf "\n\033[0;32m"
	if [[ $ed = "" ]];then
		edq
	fi
	while true; do
		read -p "Would you like to run \`locale-gen\` to generate the en_US.UTF-8 locale, or would you like to edit \`/etc/locale.gen\` specifying your preferred language\(s\) before running \`locale-gen\`?  Answer run or edit [r|e]. " ye
	if [[ $ye = [Rr]* ]];then
		break
	elif [[ $ye = [Ee]* ]];then
		$ed $HOME/arch/etc/locale.gen
		break
	else
		printf "\nYou answered \033[36;1m$ye\033[32;1m.\n"
		printf "\nAnswer run or edit (Rr|Ee).  \n\n"
	fi
	done
	$ed $HOME/arch/etc/pacman.d/mirrorlist
	makefinishsetup
	makesetupbin 
}

