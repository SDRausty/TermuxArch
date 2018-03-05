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
	printf "\033[0;34m 🕛 > 🕚 \033[0mCopy \033[1m$bin\033[0m to \033[1m$BPATH\033[0m?  "'\033]2; 🕛 > 🕚 Copy to $PATH [Y|n]?\007'
	read -p "Answer yes or no [Y|n] " answer
	if [[ $answer = [Yy]* ]] || [[ $answer = "" ]];then
		cp $HOME$rootdir/$bin $BPATH
		printf "\n\033[0;34m 🕛 > 🕦 \033[0mCopied \033[1m$bin\033[0m to \033[1m$BPATH\033[0m.\n\n"
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

lkernid ()
{
	ur="$($PREFIX/bin/applets/uname -r)"
	declare -g kid=0
	declare -i KERNEL_VERSION=$(echo $ur |awk -F'.' '{print $1}')
	declare -i MAJOR_REVISION=$(echo $ur |awk -F'.' '{print $2}')
	declare -- tmp=$(echo $ur |awk -F'.' '{print $3}')
	declare -i MINOR_REVISION=$(echo ${tmp:0:3} |sed 's/[^0-9]*//g')
	if [ "$KERNEL_VERSION" -le 2 ]; then
		kid=1
	else
		if [ "$KERNEL_VERSION" -eq 3 ]; then
			if [ "$MAJOR_REVISION" -lt 2 ]; then
				kid=1
			else
				if [ "$MAJOR_REVISION" -eq 2 ] && [ $MINOR_REVISION -eq 0 ]; then
					kid=1
				fi
			fi
		fi
	fi
}

lkernid

mainblock ()
{ 
	rmarchq
	spaceinfoq
	callsystem 
	printwld 
	termux-wake-unlock
	printdone 
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
	t=240
	printf "\n"
	if [ $(getprop ro.product.cpu.abi) = x86 ] || [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		pacman -Syu sed --noconfirm ||: 
		mv /usr/lib/gnupg/scdaemon{,_} ||: 
		rm -rf /etc/pacman.d/gnupg ||: 
		for i in {1..4}; do
			\$(nice -n 20 find / -type f -exec cat {} \\; >/dev/null 2>/dev/null & sleep \$t ; kill \$!) &
			\$(nice -n 20 ls -alR / >/dev/null 2>/dev/null & sleep \$t ; kill \$!) &
			\$(nice -n 20 find / >/dev/null 2>/dev/null & sleep \$t ; kill \$!) &
			\$(nice -n 20 cat /dev/urandom >/dev/null & sleep \$t ; kill \$!) &
		done
		pacman-key --init ||: 
		echo disable-scdaemon > /etc/pacman.d/gnupg/gpg-agent.conf ||: 
		printf "\n\033[0;32m"
		pacman -S archlinux-keyring --noconfirm ||: 
		printf "\n\033[0;32m"
		pacman-key --populate archlinux ||: 
	else
		pacman -Syu --noconfirm ||: 
		mv /usr/lib/gnupg/scdaemon{,_} ||: 
		rm -rf /etc/pacman.d/gnupg ||: 
		for i in {1..4}; do
			\$(nice -n 20 find / -type f -exec cat {} \\; >/dev/null 2>/dev/null & sleep \$t ; kill \$!) &
			\$(nice -n 20 ls -alR / >/dev/null 2>/dev/null & sleep \$t ; kill \$!) &
			\$(nice -n 20 find / >/dev/null 2>/dev/null & sleep \$t ; kill \$!) &
			\$(nice -n 20 cat /dev/urandom >/dev/null & sleep \$t ; kill \$!) &
		done
		pacman-key --init ||: 
		echo disable-scdaemon > /etc/pacman.d/gnupg/gpg-agent.conf ||: 
		printf "\n\033[0;32m"
		pacman -S archlinux-keyring --noconfirm ||: 
		printf "\n\033[0;32m"
		pacman-key --populate archlinux ||: 
	fi
	printf "\n\033[0;32m"
	locale-gen ||:
	printf "\n"
	tzselect
	printf '\033]2; 🕛 > 🕙 Arch Linux in Termux is installed and configured.  📲  \007'
	EOM
	chmod 770 root/bin/finishsetup.sh 
}

makesetupbin ()
{
	cat > root/bin/setupbin.sh <<- EOM
	#!$PREFIX/bin/bash -e
	unset LD_PRELOAD
	EOM
	if [[ "$kid" -eq 1 ]]; then
		cat >> root/bin/setupbin.sh <<- EOM
		exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin $HOME$rootdir/root/bin/finishsetup.sh ||:
		EOM
	else
		cat >> root/bin/setupbin.sh <<- EOM
		exec proot --kill-on-exit --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin $HOME$rootdir/root/bin/finishsetup.sh ||:
		EOM
	fi
	chmod 700 root/bin/setupbin.sh
}

makestartbin ()
{
	cat > $bin <<- EOM
	#!$PREFIX/bin/bash -e
	unset LD_PRELOAD
	EOM
	if [[ "$kid" -eq 1 ]]; then
		cat >> $bin <<- EOM
		exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login ||:
		EOM
	else
		cat >> $bin <<- EOM
		exec proot --kill-on-exit --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login ||:
		EOM
fi
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
	printcu 
	rm *.tar.gz *.tar.gz.md5
	printdone 
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
	sed -i -e 1,4d $HOME$rootdir/etc/pacman.d/mirrorlist
	sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vi instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 16j then i opens edit mode for the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC.\n# Tap ESC to return to command mode in vi, i for insert.\n# Use CTRL+d and CTRL+b to find your local mirror.\n# Tap x to delete # uncommenting your local mirror.\n# Choose only one mirror.  Use :x to save your work.\n# Geo-IP mirror		end G		top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' $HOME$rootdir/etc/pacman.d/mirrorlist
	printf "\033[0m"
	$ed $HOME$rootdir/etc/pacman.d/mirrorlist
	while true; do
	sleep 1
	printf "\n\033[0;34mWhen \033[1;32mgpg: Generating pacman keyring master key\033[0;34m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this stage of the install procedure.  To generate as much entropy as possible quickly, watch and listen to a file from a file manager on your device.  To generate entropy, we want randomness.  \n"
	sleep 8
	printf "\nThe programs \033[1;34mpacman\033[0;34m and \033[1;34mpacman-key\033[0;34m will want as much as possible when employing keys.  Entropy is also created through tapping, sliding, one, two and more fingers tapping and short and long taps…  This method might not generate enough entropy for the process to complete quickly.  When \033[1;32mgpg: Generating pacman keyring master key\033[0;34m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Put even simpler, just do something on device.  Browsing files in a file manager is an example of generating entropy.\n"
	sleep 16
	printf "\n\033[0;32mThe final question before updating your Arch Linux system is about languages.  Would you like to run \033[1;32mlocale-gen\033[0;32m to generate the English en_US.UTF-8 locale?  You can edit \033[1;32m/etc/locale.gen\033[0;32m with your preferred language(s) before running \033[1;32mlocale-gen\033[0;32m.  "
	sleep 8
	read -p "Answer yes to run \`locale-gen\` [Y|e] " ye
	if [[ $ye = [Yy]* ]] || [[ $ye = "" ]];then
		break
	elif [[ $ye = [Ee]* ]] || [[ $ye = [Nn]* ]];then
		printf "\033[0m"
		$ed $HOME$rootdir/etc/locale.gen
		sleep 1
		break
	else
		printf "\nYou answered \033[1;36m$ye\033[1;32m.\n"
		sleep 1
		printf "\nAnswer yes to run, or edit to edit the file [Y|e]\n"
	fi
	done
	$HOME$rootdir/root/bin/setupbin.sh 
}

runfinishsetupq ()
{
	while true; do
		printf "\n\033[0;32mWould you like to run \033[1;32mfinishsetup.sh\033[0;32m to complete the Arch Linux configuration and update now, or at a later time?  \033[1;32mNow is recommended.  \033[0;32m"
		read -p "Answer yes to complete the Arch Linux configuration and update now; Or answer no for later [Y|n] " nl
	if [[ $nl = [Yy]* ]] || [[ $nl = "" ]];then
		runfinishsetup 
		break
	elif [[ $nl = [Nn]* ]];then
		printf "\n\033[0;32mSet the geographically nearby mirror in \033[1;32m/etc/pacman.d/mirrorlist\033[0;32m first.  Then use \033[1;32m$HOME$rootdir/root/bin/setupbin.sh\033[0;32m in Termux to run \033[1;32mfinishsetup.sh\033[0;32m or simply \033[1;32mfinishsetup.sh\033[0;32m in Arch Linux Termux PRoot to complete the Arch Linux configuration and update."
		break
	else
		printf "\nYou answered \033[1;36m$nl\033[1;32m.\n"
		sleep 1
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
	addae
	addauser
	addauserps
	addbash_profile 
	addbashrc 
	addce 
	addces
	adddfa
	addga
	addgcl
	addgcm
	addgp
	addgpl
	addkeys 
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

