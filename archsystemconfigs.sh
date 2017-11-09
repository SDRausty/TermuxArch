#!/bin/bash -e
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
# Copyright 2017 by SDRausty. All rights reserved.
################################################################################

startbin ()
{
	cat > $bin <<- EOM
	#!/bin/sh -e
	unset LD_PRELOAD
	exec proot --link2symlink -0 -r $HOME/arch/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
	EOM
	chmod 700 $bin
}

startbininit ()
{
	cat > $bin <<- EOM
	export LD_PRELOAD=$PREFIX/lib/libtermux-exec.so
	#!/bin/sh -e
	unset LD_PRELOAD
	exec proot --link2symlink -0 -r $HOME/arch/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
	EOM
	chmod 700 $bin
}

bashrc ()
{
	cat > root/.bashrc <<- EOM
	alias c='cd .. && pwd'
	alias ..="cd ../.. && pwd"
	alias ...="cd ../../.. && pwd"
	alias ....="cd ../../../.. && pwd"
	alias .....="cd ../../../../.. && pwd"
	alias d='du -hs'
	alias e='exit'
	alias g='ga; gcm; gp'
	alias ga='git add . '
	alias gca='git commit -a'
	alias gcam='git commit -am'
	alias gcm='git commit'
	alias gcl='git clone'
	alias gpl='git pull'
	alias gp='git push'
	#alias gp='git push https://username:password@github.com/username/repository.git master'
	alias h='history >> ~/.historyfile'
	alias j='jobs'
	alias l='ls -al'
	alias p='pwd'
	alias q='exit'
	alias rf='rm -rf'
	EOM
}

bash_profile ()
{
	touch root/.bash_profile 
}

finishsetup ()
{
	cat > root/bin/finishsetup.sh  <<- EOM
	#!/bin/bash -e 
	printf "\n\033[32;1m"
	while true; do
	read -p "Would you like to use nano or vi? (n|v)?"  nv
	if [[ \$nv = [Nn]* ]];then
		ed=nano
		break
	elif [[ \$nv = [Vv]* ]];then
		ed=vi
		break
	else
		printf "\nYou answered \033[36;1m\$nv\033[32;1m.\n"
		printf "\nAnswer nano or vi (n|v).\n\n"
	fi
	done
	\$ed /etc/locale.gen
	locale-gen
	\$ed /etc/pacman.d/mirrorlist
	pacman -Syu
	printf "\nUse \033[36;1mexit\033[32;1m to conclude this installation.\033[0m\n\n"
	rm \$HOME/bin/finishsetup.sh 2>/dev/null||:
	EOM
	chmod 700 root/bin/finishsetup.sh 
}

