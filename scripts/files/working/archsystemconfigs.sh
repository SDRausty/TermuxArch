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
	echo "cat > $HOME/bin/startarchuser\$1 <<- EOM " >> root/bin/addauserps 
	cat >> root/bin/addauserps <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	unset LD_PRELOAD
	exec proot --kill-on-exit --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/su - \$1 --login
	EOM
	echo EOM >> root/bin/addauserps 
	cat >> root/bin/addauserps <<- EOM
	chmod 770 $HOME/bin/startarchuser\$1
	EOM
	chmod 770 root/bin/addauserps 
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
	alias q='logout'
	alias rf='rm -rf'
	. /etc/motd
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
	for i in {1..2}; do
		nice -n 20 ls -alR / > /dev/null &
		nice -n 20 find / > /dev/null &
	done
	nice -n 20 ls -alR / &
	EOM
	chmod 770 root/bin/ce 
}
addces ()
{
	cat > ces<<- EOM
	#!$PREFIX/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	# Create entropy Termux startup file.
	################################################################################
	unset LD_PRELOAD
	EOM
	if [[ "$kid" -eq 1 ]]; then
		cat >> ces <<- EOM
		exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin $rootdir/root/bin/ce ||:
		EOM
	else
		cat >> ces <<- EOM
		exec proot --kill-on-exit --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin $rootdir/root/bin/ce ||:
		EOM
	fi
	chmod 770 ces 
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
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
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
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
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
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
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
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	# git push https://username:password@github.com/username/repository.git master
	################################################################################
	if [ ! -e /usr/bin/git ] ; then
		pacman -Syu git --noconfirm
		git push
	else
		git push
	fi
	EOM
	chmod 700 root/bin/gp 
}

addkeys ()
{
	cat > root/bin/addkeys <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Contributors to this code are https://github.com/bambooeater, https://github.com/EsdrasTarsis and https://github.com/michalbednarski 
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	printf "\n\033[0;32mTermuxArch addkeys $versionidb.  \033[0;32mWhen \033[1;32mgpg: Generating pacman keyring master key\033[0;32m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this stage of the install procedure.  To generate as much entropy as possible quickly, watch and listen to a file from a file manager on your device.  To generate entropy, we want randomness.  \n\nThe programs \033[1;32mpacman\033[0;32m and \033[1;32mpacman-key\033[0;32m will want as much as possible when employing keys.  Entropy is also created through tapping, sliding, two and more finger tapping and long taps…  This method might not generate enough entropy for the process to complete quickly.  When \033[1;32mgpg: Generating pacman keyring master key\033[0;32m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Or put even simpler, just do something and device.  Browsing files in a file manager is an example of generating entropy.\n\nWould you like to run \033[1;32mlocale-gen\033[0;32m to generate the en_US.UTF-8 locale, or edit \033[1;32m/etc/locale.gen\033[0;32m specifying your preferred language(s) before running \033[1;32mlocale-gen\033[0;32m?  "
	mv /usr/lib/gnupg/scdaemon{,_} ||:
	rm -rf /etc/pacman.d/gnupg ||:
	pacman-key --init 
	echo disable-scdaemon > /etc/pacman.d/gnupg/gpg-agent.conf 
	if [ $(getprop ro.product.cpu.abi) = x86 ] ;then
		pacman -S archlinux32-keyring-transition --noconfirm 
	else
		pacman -S archlinux-keyring --noconfirm 
	fi
	pacman-key --populate archlinux 
	EOM
	chmod 700 root/bin/addkeys
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
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
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
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
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

