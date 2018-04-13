#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

callsystem ()
{
	mkdir -p $installdir
	cd $installdir
	detectsystem ret 
}

copystartbin2path ()
{
	if [[ ":$PATH:" == *":$HOME/bin:"* ]] && [ -d $HOME/bin ]; then
		BPATH=$HOME/bin
	else
		BPATH=$PREFIX/bin
	fi
	cp $installdir/$startbin $BPATH
	printf "\033[0;34m 🕛 > 🕦 \033[1;32m$startbin \033[0mcopied to \033[1m$BPATH\033[0m.\n\n"
}

copystartbin2pathq ()
{
	while true; do
	printf "\033[0;34m 🕛 > 🕚 \033[0mCopy \033[1m$startbin\033[0m to \033[1m$BPATH\033[0m?  "'\033]2; 🕛 > 🕚 Copy to $PATH [Y|n]?\007'
	read -p "Answer yes or no [Y|n] " answer
	if [[ $answer = [Yy]* ]] || [[ $answer = "" ]];then
		cp $installdir/$startbin $BPATH
		printf "\n\033[0;34m 🕛 > 🕦 \033[0mCopied \033[1m$startbin\033[0m to \033[1m$BPATH\033[0m.\n\n"
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
	if [ $cpuabi = $cpuabi5 ];then
		armv5l
	elif [ $cpuabi = $cpuabi7 ];then
		detectsystem2 
	elif [ $cpuabi = $cpuabi8 ];then
		aarch64
	elif [ $cpuabi = $cpuabix86 ];then
		i686 
	elif [ $cpuabi = $cpuabix8664 ];then
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

editfiles ()
{
	if [[ ${ceds[$i]} = "applets/vi" ]];then
		sed -i -e 1,4d $installdir/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vi instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local mirror.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local mirror.\n# Choose only one mirror.  Use :x to save your work.\n# Comment out the Geo-IP mirror	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' $installdir/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vi instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' $installdir/etc/locale.gen
	elif [[ ${ceds[$i]} = "vim" ]];then
		sed -i -e 1,4d $installdir/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local mirror.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local mirror.\n# Choose only one mirror.  Use :x to save your work.\n#Comment out the Geo-IP mirror	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' $installdir/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' $installdir/etc/locale.gen
	elif [[ ${ceds[$i]} = "nvim" ]];then
		sed -i -e 1,4d $installdir/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch neovim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local mirror.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local mirror.\n# Choose only one mirror.  Use :x to save your work.\n# Comment out the Geo-IP mirror	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' $installdir/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch neovim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' $installdir/etc/locale.gen
	else
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch edit instructions:	 Locate the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Choose only one mirror.\n# Delete # to uncomment your local mirror.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' $installdir/etc/pacman.d/mirrorlist
	fi
}
	
lkernid ()
{
	ur="$($PREFIX/bin/applets/uname -r)"
	declare -g kid=0
	declare -i KERNEL_VERSION=$(echo $ur |awk -F'.' '{print $1}')
	declare -i MAJOR_REVISION=$(echo $ur |awk -F'.' '{print $2}')
	declare -- tmp=$(echo $ur |awk -F'.' '{print $3}')
	declare -- MINOR_REVISION=$(echo ${tmp:0:3} |sed 's/[^0-9]*//g')
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
lkernid ret

mainblock ()
{ 
	namestartarch 
	nameinstalldir
	spaceinfoq
	callsystem 
	printwld 
	termux-wake-unlock
	printdone 
	printfooter
	$installdir/$startbin ||:
	printfooter2
}

makefinishsetup ()
{
	binfnstp=finishsetup.sh  
	cat > root/bin/$binfnstp <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	EOM
	if [ -e $HOME/.bash_profile ]; then
		grep "proxy" $HOME/.bash_profile | grep "export" >>  root/bin/$binfnstp 2>/dev/null ||:
	fi
	if [ -e $HOME/.bashrc ]; then
		grep "proxy" $HOME/.bashrc  | grep "export" >>  root/bin/$binfnstp 2>/dev/null ||:
	fi
	if [ -e $HOME/.profile ]; then
		grep "proxy" $HOME/.profile | grep "export" >>  root/bin/$binfnstp 2>/dev/null ||:
	fi
	cat >> root/bin/$binfnstp <<- EOM
	if [ \$cpuabi = \$cpuabix86 ] || [ \$cpuabi = \$cpuabix8664 ];then
		pacman -Syu sed --noconfirm --color always ||: 
	else
		pacman -Syu --noconfirm --color always ||: 
	fi
	printf "\n\033[1;32m==> \033[0m"
	locale-gen ||:
	printf "\n"
	printf '\033]2; 🕛 > 🕤 Arch Linux in Termux is installed and configured 📲 \007'
	EOM
	chmod 770 root/bin/finishsetup.sh 
}

makesetupbin ()
{
	cat > root/bin/setupbin.sh <<- EOM
	#!$PREFIX/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	unset LD_PRELOAD
	EOM
	echo "$prootstmnt /root/bin/finishsetup.sh||:" >> root/bin/setupbin.sh 
	chmod 700 root/bin/setupbin.sh
}

makestartbin ()
{
	cat > $startbin <<- EOM
	#!$PREFIX/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	unset LD_PRELOAD
	printusage () {
		printf "\n\033[0;32mUsage:  \033[1;32m$startbin \033[0;32mStart Arch Linux as root.  This account should only be reserved for system administration.\n\n	\033[1;32m$startbin command command \033[0;32mRun Arch Linux command from Termux as root user.\n\n	\033[1;32m$startbin login user \033[0;32mLogin as user.  Use \033[1;32maddauser user \033[0;32mfirst to create a user and the user's home directory.\n\n	\033[1;32m$startbin raw \033[0;32mConstruct the \033[1;32mstartarch \033[0;32mproot statement.  For example \033[1;32mstartarch raw su - user \033[0;32mwill login to Arch Linux as user.  Use \033[1;32maddauser user \033[0;32mfirst to create a user and the user's home directory.\n\n	\033[1;32m$startbin su user command \033[0;32mLogin as user and execute command.  Use \033[1;32maddauser user \033[0;32mfirst to create a user and the user's home directory.\n\n\033[0m"'\033]2; TermuxArch '$startbin' help 📲  \007'
	}

	# [?|help] Displays usage information. .
	if [[ \$1 = [?]* ]] || [[ \$1 = -[?]* ]] || [[ \$1 = --[?]* ]] || [[ \$1 = [Hh]* ]] || [[ \$1 = -[Hh]* ]] || [[ \$1 = --[Hh]* ]];then
		printusage
	# [command args] Execute a command in BASH as root.
	elif [[ \$1 = [Cc]* ]] || [[ \$1 = -[Cc]* ]] || [[ \$1 = --[Cc]* ]];then
		printf '\033]2; '$startbin' command args 📲  \007'
		touch $installdir/root/.chushlogin
	EOM
		echo "$prootstmnt /bin/bash -lc \"\${@:2}\"" >> $startbin
	cat >> $startbin <<- EOM
		printf '\033]2; '$startbin' command args 📲  \007'
		rm $installdir/root/.chushlogin
	# [login user|login user [options]] Login as user [plus options].  Use \`addauser user\` first to create this user and the user's home directory.
	elif [[ \$1 = [Ll]* ]] || [[ \$1 = -[Ll]* ]] || [[ \$1 = --[Ll]* ]] ;then
		printf '\033]2; '$startbin' login user [options] 📲  \007'
	EOM
		echo "$prootstmnt /bin/su - \"\${@:2}\"" >> $startbin
	cat >> $startbin <<- EOM
		printf '\033]2; '$startbin' login user [options] 📲  \007'
	# [raw args] Construct the \`startarch\` proot statement.  For example \`startarch r su - archuser\` will login as user archuser.  Use \`addauser archuser\` first to create this user and the user home directory.
	elif [[ \$1 = [Rr]* ]] || [[ \$1 = -[Rr]* ]] || [[ \$1 = --[Rr]* ]];then
		printf '\033]2; '$startbin' raw args 📲  \007'
	EOM
		echo "$prootstmnt  /bin/\"\${@:2}\"" >> $startbin
	cat >> $startbin <<- EOM
		printf '\033]2; '$startbin' raw args 📲  \007'
	# [su user command] Login as user and execute command.  Use \`addauser user\` first to create this user and the user's home directory.
	elif [[ \$1 = [Ss]* ]] || [[ \$1 = -[Ss]* ]] || [[ \$1 = --[Ss]* ]];then
		printf '\033]2; '$startbin' su user command 📲  \007'
		if [[ \$2 = root ]];then
			touch $installdir/root/.chushlogin
		else
			touch $installdir/home/\$2/.chushlogin
		fi
	EOM
		echo "$prootstmnt /bin/su - \$2 -c \"\${@:3}\"" >> $startbin
	cat >> $startbin <<- EOM
		printf '\033]2; '$startbin' su user command 📲  \007'
		if [[ \$2 = root ]];then
			rm $installdir/root/.chushlogin
		else
			rm $installdir/home/\$2/.chushlogin
		fi
	# [] Default Arch Linux in Termux PRoot root login.
	elif [[ \$1 = "" ]];then
	EOM
		echo "$prootstmnt /bin/bash -l " >> $startbin
	cat >> $startbin <<- EOM
		printf '\033]2; TermuxArch '$startbin' 📲  \007'
	else
		printusage
	fi
	EOM
	chmod 700 $startbin
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
			until ftchstnd;do
				ftchstnd ret||: 
				sleep 2
				printf "\n"
				COUNTER=$((COUNTER + 1))
				if [ $COUNTER = 12 ];then 
					exit
				fi
			done
		else
			ftchit
		fi
	fi
	printmd5check
	if $PREFIX/bin/applets/md5sum -c $file.md5 1>/dev/null ; then
		printmd5success
		preproot 
	else
		rmarchrm 
		printmd5error
	fi
	printcu 
	rm *.tar.gz *.tar.gz.md5
	printdone 
	makestartbin 
	printconfigq 
	touchupsys 
}

preproot ()
{
	if [ $(du $installdir/*z | awk {'print $1'}) -gt 112233 ];then
		if [ $(getprop ro.product.cpu.abi) = x86 ] || [ $(getprop ro.product.cpu.abi) = x86_64 ];then
			#cd $HOME
			#proot --link2symlink -0 $PREFIX/bin/applets/tar xf $installdir$file 
			#cd $installdir
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
	if [[ ! $(sed 1q  $installdir/etc/pacman.d/mirrorlist) = "# # # # # # # # # # # # # # # # # # # # # # # # # # #" ]];then
		editfiles
	fi
	printf "\033[0m"
	if [ $fstnd ]; then
		nmir=$(echo $nmirror |awk -F'/' '{print $3}')
		sed -e '/http\:\/\/mir/ s/^#*/# /' -i $installdir/etc/pacman.d/mirrorlist
		sed -e "/$nmir/ s/^# *//" -i $installdir/etc/pacman.d/mirrorlist
	else
		$ed $installdir/etc/pacman.d/mirrorlist
	fi
	printf "\n"
	$installdir/root/bin/setupbin.sh 
}

addlangq () {	
	while true; do
	printf "\033[1;34m  Add languages to the Arch Linux system? To edit \033[1;32m/etc/locale.gen\033[1;34m for your preferred language(s) before running \033[1;32mlocale-gen\033[1;34m choose edit.  Would you like to run \033[1;32mlocale-gen\033[1;34m with the English en_US.UTF-8 locale only?  "
	read -p "Answer yes to generate the English en_US.UTF-8 locale only [Y|e] " ye
	if [[ $ye = [Yy]* ]] || [[ $ye = "" ]];then
		break
	elif [[ $ye = [Ee]* ]] || [[ $ye = [Nn]* ]];then
		printf "\033[0m"
		$ed $installdir/etc/locale.gen
		sleep 1
		break
	else
		printf "\nYou answered \033[1;36m$ye\033[1;32m.\n"
		sleep 1
		printf "\nAnswer yes to run, or edit to edit the file [Y|e]\n"
	fi
	done
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
		printf "\n\033[0;32mSet the geographically nearby mirror in \033[1;32m/etc/pacman.d/mirrorlist\033[0;32m first.  Then use \033[1;32m$installdir/root/bin/setupbin.sh\033[0;32m in Termux to run \033[1;32mfinishsetup.sh\033[0;32m or simply \033[1;32mfinishsetup.sh\033[0;32m in Arch Linux Termux PRoot to complete the Arch Linux configuration and update."
		break
	else
		printf "\nYou answered \033[1;36m$nl\033[1;32m.\n"
		sleep 1
		printf "\nAnswer yes to complete, or no for later [Y|n]\n"
	fi
	done
	printf "\n"
}

setlocaleconf ()
{
	if ! grep en_US etc/locale.conf 2>/dev/null ; then
		echo LANG=en_US.UTF-8 >> etc/locale.conf 
	fi
}

setlocalegen ()
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
	addauserpsc
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
	addpc
	addpci
	addprofile 
	addresolvconf 
	addt 
	addtour
	addtrim 
	addyt
	addwe  
	addv 
	setlocalegen
	setlocaleconf 
	makefinishsetup
	makesetupbin 
	runfinishsetup
	rm root/bin/finishsetup.sh
	rm root/bin/setupbin.sh 
}

