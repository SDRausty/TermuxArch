#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

addbash_profile ()
{
	cat > root/.bash_profile <<- EOM
	PATH=\$HOME/bin:\$PATH
	. \$HOME/.bashrc
	PS1="[\A\[\033[0;32m\] \W \[\033[0m\]]\\$ "
	EOM
	if [ ! -e $HOME/.bash_profile ] ; then
		:
	else
		grep proxy $HOME/.bash_profile |grep "export" >>  root/.bash_profile 2>/dev/null||:
	fi
}

addbashrc ()
{
	cat > root/.bashrc <<- EOM
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
	alias ls='ls --color=always'
	alias p='pwd'
	alias q='logout'
	alias rf='rm -rf'
	. /etc/motd
	EOM
	if [ ! -e $HOME/.bashrc ] ; then
		:
	else
		grep proxy $HOME/.bashrc |grep "export" >>  root/.bashrc 2>/dev/null||:
	fi
}

adddfa ()
{
	cat > root/bin/dfa <<- EOM
	#!/bin/bash -e
	units=\`df 2>/dev/null | awk 'FNR == 1 {print \$2}'\`
	usrspace=\`df 2>/dev/null | grep "/data" | awk {'print \$4'}\`
	printf "\033[0;33m\$usrspace \$units of free user space is available on this device.\n\033[0m"
	EOM
	chmod 770 root/bin/dfa 
}

addprofile ()
{
	cat > root/.profile <<- EOM
	. \$HOME/.bash_profile
	EOM
	if [ ! -e $HOME/.profile ] ; then
		:
	else
		grep "proxy" $HOME/.profile |grep "export" >>  root/.profile 2>/dev/null||:
	fi
}

addga ()
{
	cat > root/bin/ga  <<- EOM
	#!/bin/bash -e
	if [ ! -e /usr/bin/git ] ; then
		pacman -Syu git --noconfirm
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
	if [ ! -e /usr/bin/git ] ; then
		pacman -Syu git --noconfirm
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
	if [ ! -e /usr/bin/git ] ; then
		pacman -Syu git --noconfirm
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
	if [ ! -e /usr/bin/git ] ; then
		pacman -Syu git --noconfirm
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
	#git push https://username:password@github.com/username/repository.git master
	if [ ! -e /usr/bin/git ] ; then
		pacman -Syu git --noconfirm
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
	printf "\033[1;34mWelcome to Arch Linux in Termux!  Enjoy!\033[0m\033[1;34m
	
	Chat:    \033[0m\033[mhttps://gitter.im/termux/termux/\033[0m\033[1;34m
	Help:    \033[0m\033[34minfo <query> \033[0m\033[mand \033[0m\033[34mman <query> \033[0m\033[1;34m
	Portal:  \033[0m\033[mhttps://wiki.termux.com/wiki/Community\033[0m\033[1;34m
	
	Install a package: \033[0m\033[34mpacman -S <package>\033[0m\033[1;34m
	More  information: \033[0m\033[34mpacman [-D|F|Q|R|S|T|U] --help\033[0m\033[1;34m
	Search   packages: \033[0m\033[34mpacman -Ss <query>\033[0m\033[1;34m
	Upgrade  packages: \033[0m\033[34mpacman -Syu \n\033[0m"
	EOM
}

adtauser ()
{
	# add default Arch Termux user 
	cat > root/bin/adtauser <<- EOM
	useradd user
	cp -r /root /home/user
	su - user
	EOM
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
	if [ ! -e /usr/bin/tree ] ; then
		pacman -Syu tree --noconfirm
		tree \$@
	else
		tree \$@
	fi
	EOM
	chmod 770 root/bin/t 
}

addv ()
{
	cat > root/bin/v  <<- EOM
	#!/bin/bash -e
	if [ ! -e /usr/bin/vim ] ; then
		pacman -Syu vim --noconfirm
		vim \$@
	else
		vim \$@
	fi
	EOM
	chmod 770 root/bin/v 
}

addyt ()
{
	cat > root/bin/yt  <<- EOM
	#!/bin/bash -e
	if [ ! -e /usr/bin/youtube-dl ] ; then
		pacman -Syu python-pip --noconfirm
		pip install youtube-dl
		youtube-dl \$@
	else
		youtube-dl \$@
	fi
	EOM
	chmod 770 root/bin/yt 
}

makefinishsetup ()
{
	binfs=finishsetup.sh  
	cat > root/bin/$binfs <<- EOM
	#!/bin/bash -e
	EOM
	if [ -e $HOME/.bash_profile ]; then
	grep "proxy" $HOME/.bash_profile | grep "export" >>  root/bin/$binfs 2>/dev/null ||:
	else
		:
	fi
	if [ -e $HOME/.bashrc ]; then
	grep "proxy" $HOME/.bashrc  | grep "export" >>  root/bin/$binfs 2>/dev/null ||:
	else
		:
	fi
	if [ -e $HOME/.profile ]; then
	grep "proxy" $HOME/.profile | grep "export" >>  root/bin/$binfs 2>/dev/null ||:
	else
		:
	fi
	cat >> root/bin/$binfs <<- EOM
	if [ $(getprop ro.product.cpu.abi) = x86 ] || [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		pacman -Syu sed --noconfirm ||:
	else
		pacman -Syu --noconfirm ||:
	fi
	locale-gen
	printf '\033]2; 🕛 > 🕙 Arch Linux in Termux is installed and configured.  📲  \007'
	rm \$HOME/bin/finishsetup.sh 2>/dev/null ||:
	EOM
	chmod 770 root/bin/finishsetup.sh 
}

