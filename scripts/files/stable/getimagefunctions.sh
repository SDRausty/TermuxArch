#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

adjustmd5file ()
{
	if [ $(getprop ro.product.cpu.abi) = x86_64 ] || [ $(getprop ro.product.cpu.abi) = x86 ];then
		if [[ $dm = wget ]];then 
			wget -N --show-progress http://$mirror${path}md5sums.txt
		else
			curl -q --fail --retry 4 -O -L http://$mirror${path}md5sums.txt
		fi
		filename=$(ls *tar.gz)
		sed '2q;d' md5sums.txt > $filename.md5
		rm md5sums.txt
	else
		if [[ $dm = wget ]];then 
			wget -N --show-progress http://$mirror$path$file.md5 
		else
			curl -q --fail --retry 4 -O -L http://$mirror$path$file.md5
		fi
	fi
}

detectsystem ()
{
	spaceinfo
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

detectsystem2p ()
{
	if [[ $(getprop ro.product.device) == *_cheets ]];then
	printf "Chromebook.  "
	else
	printf "$(uname -o) operating system.  "
	fi
}

getimage ()
{
	if [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		if [[ $dm = wget ]];then 
			# Get latest image for x86_64 via `wget` wants refinement.  Continue is not implemented. 
			wget -A tar.gz -m -nd -np http://$mirror$path
		else
			# The `curl` self-updating code is unknown at present.
			printf "\nDefaulting to \`wget\` for x86_64 system image download.  \n"
			wget -A tar.gz -m -nd -np http://$mirror$path
		fi
	else
		if [[ $dm = wget ]];then 
			wget -c --show-progress http://$mirror$path$file 
		else
			curl -q -C - --fail --retry 4 -O -L http://$mirror$path$file
		fi
	fi
}

makesystem ()
{
	printdownloading 
	termux-wake-lock 
	adjustmd5file
	getimage
	printmd5check
	if md5sum -c $file.md5 ; then
		printmd5success
		preproot 
	else
		rm -rf $HOME/arch
		printmd5error
	fi
	rm *.tar.gz *.tar.gz.md5
	makebin 
}

preproot ()
{
	if [ $(du ~/arch/*z | awk {'print $1}') -gt 112233 ];then
		if [ $(getprop ro.product.cpu.abi) = x86_64 ] || [ $(getprop ro.product.cpu.abi) = x86 ];then
			proot --link2symlink -0 bsdtar -xpf $file --strip-components 1 2>/dev/null||:
		else
			proot --link2symlink -0 bsdtar -xpf $file ||:
		fi
	else
		printf "\n\nDownload Exception!  Exiting!\n\n"
		exit
	fi
}
