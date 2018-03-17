#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

addae ()
{
	cat > root/bin/ae <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Contributed by https://github.com/cb125
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	watch cat /proc/sys/kernel/random/entropy_avail
	EOM
	chmod 770 root/bin/ae 
}

addauser ()
{
	# Add Arch Linux user.
	cat > root/bin/addauser <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	useradd \$1
	cp -r /root /home/\$1
	su - \$1
	EOM
	chmod 770 root/bin/addauser 
}

addauserps ()
{
	# Add Arch Linux user and create user login Termux startup script. 
	cat > root/bin/addauserps <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	useradd \$1
	cp -r /root /home/\$1
	su - \$1
	EOM
	echo "cat > $HOME/bin/${bin}user\$1 <<- EOM " >> root/bin/addauserps 
	cat >> root/bin/addauserps <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	unset LD_PRELOAD
	exec proot --kill-on-exit --link2symlink -0 -r $installdir -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/su - \$1 --login
	EOM
	echo EOM >> root/bin/addauserps 
	cat >> root/bin/addauserps <<- EOM
	chmod 770 $HOME/bin/${bin}user\$1
	EOM
	chmod 770 root/bin/addauserps 
}

addauserpsc ()
{
	# Add Arch Linux user and create user login Termux startup script. 
	cat > root/bin/addauserpsc <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	useradd \$1
	cp -r /root /home/\$1
	su - \$1
	EOM
	echo "cat > $HOME/bin/${bin}user\$1 <<- EOM " >> root/bin/addauserpsc 
	cat >> root/bin/addauserpsc <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	unset LD_PRELOAD
	exec proot --kill-on-exit --link2symlink -0 -r $installdir -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/su - \$1 --login
	EOM
	echo EOM >> root/bin/addauserpsc 
	cat >> root/bin/addauserpsc <<- EOM
	chmod 770 $HOME/bin/${bin}user\$1
	EOM
	chmod 770 root/bin/addauserpsc 
}

addbash_profile ()
{
	cat > root/.bash_profile <<- EOM
	PATH=\$HOME/bin:\$PATH
	. \$HOME/.bashrc
	PS1="[\A\[\033[0;32m\] \W \[\033[0m\]]\\$ "
	EOM
	if [ -e $HOME/.bash_profile ] ; then
		grep proxy $HOME/.bash_profile |grep "export" >>  root/.bash_profile 2>/dev/null||:
	fi
}

addbashrc ()
{
	cat > root/.bashrc <<- EOM
	if [ ! -e \$HOME/.hushlogin ] && [ ! -e \$HOME/.chushlogin ];then
		. /etc/motd
	fi
	if [ -e \$HOME/.chushlogin ];then
		rm \$HOME/.chushlogin
	fi
	alias c='cd .. && pwd'
	alias ..="cd ../.. && pwd"
	alias ...="cd ../../.. && pwd"
	alias ....="cd ../../../.. && pwd"
	alias .....="cd ../../../../.. && pwd"
	alias d='du -hs'
	alias e='logout'
	alias g='ga; gcm; gp'
	alias gca='git commit -a'
	alias gcam='git commit -am'
	#alias gp='git push https://username:password@github.com/username/repository.git master'
	alias h='history >> \$HOME/.historyfile'
	alias j='jobs'
	alias l='ls -alG'
	alias lr='ls -alR'
	alias ls='ls --color=always'
	alias p='pwd'
	alias pc='pacman --noconfirm --color=always'
	alias pci='pacman  --noconfirm --color=always -Syu'
	alias q='logout'
	alias rf='rm -rf'
	EOM
	if [ -e $HOME/.bashrc ] ; then
		grep proxy $HOME/.bashrc |grep "export" >>  root/.bashrc 2>/dev/null||:
	fi
}

addce ()
{
	cat > root/bin/ce <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	# Create entropy by doing things on device.
	################################################################################
	printf "\033[1;32m"'\033]2;  Thank you for using \`ce\` from TermuxArch 📲  \007'
	t=240
	for i in {1..5}; do
		\$(nice -n 20 find / -type f -exec cat {} \\; >/dev/null 2>/dev/null & sleep \$t ; kill \$! 2>/dev/null) &
		\$(nice -n 20 ls -alR / >/dev/null 2>/dev/null & sleep \$t ; kill \$! 2>/dev/null) &
		\$(nice -n 20 find / >/dev/null 2>/dev/null & sleep \$t ; kill \$! 2>/dev/null) &
		\$(nice -n 20 cat /dev/urandom >/dev/null & sleep \$t ; kill \$! 2>/dev/null) &
	done
	for i in {1..1200}; do
	#	printf "Available entropy reading \$i of \$t	"
		printf %b \$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null) " "
		sleep 0.2
	done
	EOM
	chmod 770 root/bin/ce 
}

addces ()
{
	cat > bin/ces<<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	# Create entropy Termux startup file.
	################################################################################
	unset LD_PRELOAD
	EOM
	if [[ "$kid" -eq 1 ]]; then
		cat >> bin/ces <<- EOM
		exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r $installdir -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM $installdir/root/bin/ce 
		EOM
	else
		cat >> bin/ces <<- EOM
		exec proot --kill-on-exit --link2symlink -0 -r $installdir -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM $installdir/root/bin/ce 
		EOM
	fi
	chmod 770 bin/ces 
}

adddfa ()
{
	cat > root/bin/dfa <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	units=\`df 2>/dev/null | awk 'FNR == 1 {print \$2}'\`
	usrspace=\`df 2>/dev/null | grep "/data" | awk {'print \$4'}\`
	printf "\033[0;33m\$usrspace \$units of free user space is available on this device.\n\033[0m"
	EOM
	chmod 770 root/bin/dfa 
}

addga ()
{
	cat > root/bin/ga  <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	if [ ! -e /usr/bin/git ] ; then
		pacman --noconfirm --color=always -Syu git
		git add .
	else
		git add .
	fi
	EOM
	chmod 770 root/bin/ga 
}

addgcl ()
{
	cat > root/bin/gcl  <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	if [ ! -e /usr/bin/git ] ; then
		pacman --noconfirm --color=always -Syu git 
		git clone \$@
	else
		git clone \$@
	fi
	EOM
	chmod 770 root/bin/gcl 
}

addgcm ()
{
	cat > root/bin/gcm  <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	if [ ! -e /usr/bin/git ] ; then
		pacman --noconfirm --color=always -Syu git 
		git commit
	else
		git commit
	fi
	EOM
	chmod 770 root/bin/gcm 
}

addgpl ()
{
	cat > root/bin/gpl  <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	if [ ! -e /usr/bin/git ] ; then
		pacman --noconfirm --color=always -Syu git 
		git pull
	else
		git pull
	fi
	EOM
	chmod 770 root/bin/gpl 
}

addgp ()
{
	cat > root/bin/gp  <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	# git push https://username:password@github.com/username/repository.git master
	################################################################################
	if [ ! -e /usr/bin/git ] ; then
		pacman --noconfirm --color=always -Syu git 
		git push
	else
		git push
	fi
	EOM
	chmod 700 root/bin/gp 
}

addmotd ()
{
	cat > etc/motd  <<- EOM
	printf "\033[1;34mWelcome to Arch Linux in Termux!  Enjoy!\nChat:    \033[0mhttps://gitter.im/termux/termux/\n\033[1;34mHelp:    \033[0;34minfo query \033[1;34mand \033[0;34mman query\n\033[1;34mPortal:  \033[0mhttps://wiki.termux.com/wiki/Community\n\n\033[1;34mInstall a package: \033[0;34mpacman -S package\n\033[1;34mMore  information: \033[0;34mpacman [-D|F|Q|R|S|T|U]h\n\033[1;34mSearch   packages: \033[0;34mpacman -Ss query\n\033[1;34mUpgrade  packages: \033[0;34mpacman -Syu\n\n\033[0m"
	EOM
}

addprofile ()
{
	cat > root/.profile <<- EOM
	. \$HOME/.bash_profile
	EOM
	if [ -e $HOME/.profile ] ; then
		grep "proxy" $HOME/.profile |grep "export" >>  root/.profile 2>/dev/null||:
	fi
}

addresolvconf ()
{
	rm etc/resolv* 2>/dev/null||:
	cat > etc/resolv.conf <<- EOM
	nameserver 8.8.8.8
	nameserver 8.8.4.4
	EOM
}

addt ()
{
	cat > root/bin/t  <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	if [ ! -e /usr/bin/tree ] ; then
		pacman --noconfirm --color=always -Syu tree 
		tree \$@
	else
		tree \$@
	fi
	EOM
	chmod 770 root/bin/t 
}

addtour ()
{
	cat > root/bin/tour <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	printf "\n\033[1;32m==> \033[1;37mRunning \033[1;32mlr ~\033[1;37m\n\n"
	ls -R --color=always ~
	sleep 1
	printf "\n\033[1;32m==> \033[1;37mRunning \033[1;32mt ~\033[1;37m\n\n"
	t ~
	sleep 1
	printf "\n\033[1;32m==> \033[1;37mRunning \033[1;32mcat ~/.bash_profile\033[1;37m\n\n"
	cat ~/.bash_profile
	sleep 1
	printf "\n\033[1;32m==> \033[1;37mRunning \033[1;32mcat ~/.bashrc\033[1;37m\n\n"
	cat ~/.bashrc
	sleep 1
	printf "\n\033[1;32m==> \033[1;37mShort tour is complete.  Run this script again at a later time and you might be surprised at how the environment changes.\n\n"
	EOM
	chmod 770 root/bin/tour 
}

addtrim ()
{
	:#trim system mv /boot /usr/
}

addv ()
{
	cat > root/bin/v  <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	if [ ! -e /usr/bin/vim ] ; then
		pacman --noconfirm --color=always -Syu vim 
		vim \$@
	else
		vim \$@
	fi
	EOM
	chmod 770 root/bin/v 
}

addwe ()
{
	cat > bin/we <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# cat /proc/sys/kernel/random/entropy_avail contributed by https://github.com/cb125
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	# Watch available entropy on device.
	################################################################################
	printf "\033[1;32m"'\033]2;  Thank you for using \`we\` from TermuxArch 📲  \007'
	commandif=\$( command -v bc ) ||:
	if [[ \$commandif = "" ]];then
		pacman --noconfirm --color=always -Syu bc
	fi
	for i in {1..4800}; do
		entropy1=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null) 
		printf %b "\033[1;32m\$entropy1" 
		sleep \$(dc 1 \$entropy1 / p)
		sleep 0.2
		entropy4=\$(cat /proc/sys/kernel/random/uuid 2>/dev/null) 
		printf %b "\033[0;32m\$entropy4" 
		sleep \$(dc 1 \$entropy1 / p)
		sleep 0.1
		printf %b "\033[1;32m\${i}e4800" 
		sleep \$(dc 1 \$entropy1 / p)
		sleep 0.2
		printf %b "\033[0;32m\$(dc 1 \$entropy1 / p)"
		sleep \$(dc 1 \$entropy1 / p)
		sleep 0.1
	done
	EOM
	chmod 770 bin/we 
}

addyt ()
{
	cat > root/bin/yt  <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	if [ ! -e /usr/bin/youtube-dl ] ; then
		pacman --noconfirm --color=always -Syu python-pip
		pip install youtube-dl
		youtube-dl \$@
	else
		youtube-dl \$@
	fi
	EOM
	chmod 770 root/bin/yt 
}

