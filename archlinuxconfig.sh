#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

addREADME() {
	cat > root/bin/README.md <<- EOM
	This directory contains shortcut commands to automate and ease using the command line in Arch Linux in Termux PRoot.
	
	* Comments are welcome at https://github.com/sdrausty/TermuxArch/issues ✍ 
	* Pull requests are welcome at https://github.com/sdrausty/TermuxArch/pulls ✍ 
	
	Thank you for making this project work better, and please contribute 🔆 

	EOM
}

addae() {
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

addauser() { # Add Arch Linux user.
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

addauserps() { # Add Arch Linux user and create user login Termux startup script. 
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

addauserpsc() { # Add Arch Linux user and create user login Termux startup script. 
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

addbash_logout() {
	cat > root/.bash_logout <<- EOM
	if [ ! -e \$HOME/.hushlogout ] && [ ! -e \$HOME/.chushlogout ];then
		. /etc/moto
	fi
	EOM
}

addbash_profile() {
	cat > root/.bash_profile <<- EOM
	if [ ! -e \$HOME/.hushlogin ] && [ ! -e \$HOME/.chushlogin ];then
		. /etc/motd
	fi
	if [ -e \$HOME/.chushlogin ];then
		rm \$HOME/.chushlogin 
	fi
	PATH=\$HOME/bin:\$PATH
	. \$HOME/.bashrc
	PS1="[\A\[\033[0;32m\] \W \[\033[0m\]]\\$ "
	export TZ="$(getprop persist.sys.timezone)"
	export LANG="$_LANGUAGE.UTF-8"
	EOM
	if [ -e "$HOME"/.bash_profile ] ; then
		grep proxy "$HOME"/.bash_profile |grep "export" >>  root/.bash_profile 2>/dev/null||:
	fi
}

addbashrc() {
	cat > root/.bashrc <<- EOM
	alias c='cd .. && pwd'
	alias ..="cd ../.. && pwd"
	alias ...="cd ../../.. && pwd"
	alias ....="cd ../../../.. && pwd"
	alias .....="cd ../../../../.. && pwd"
	alias d='du -hs'
	alias e='logout'
	alias egrep='egrep --color=always'
	alias f='fgrep --color=always'
	alias g='ga; gcm; gp'
	alias gca='git commit -a'
	alias gcam='git commit -am'
	#alias gp='git push https://username:password@github.com/username/repository.git master'
	alias grep='grep --color=always'
	alias h='history >> \$HOME/.historyfile'
	alias j='jobs'
	alias l='ls -alG'
	alias lr='ls -alR'
	alias ls='ls --color=always'
	alias p='pwd'
	alias pacman='pacman --color=always'
	alias pcs='pacman -S --color=always'
	alias pcss='pacman -Ss --color=always'
	alias q='logout'
	alias rf='rm -rf'
	EOM
	if [ -e "$HOME"/.bashrc ] ; then
		grep proxy "$HOME"/.bashrc |grep "export" >>  root/.bashrc 2>/dev/null||:
	fi
}

addcdtd() {
	cat > root/bin/cdtd <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	# Usage: \`. cdtd\`  The dot sources \`cdtd\` which makes this shortcut script work.
	################################################################################
	cd /data/data/com.termux/files/home/storage/downloads && pwd
	EOM
	chmod 770 root/bin/cdtd 
}

addcdth() {
	cat > root/bin/cdth <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	# Usage: \`. cdth\`  The dot sources \`cdth\` which makes this shortcut script work. 
	################################################################################
	cd /data/data/com.termux/files/home && pwd
	EOM
	chmod 770 root/bin/cdth 
}

addch() { # Creates .hushlogin and .hushlogout file
	cat > root/bin/ch <<- EOM
	#!/bin/env bash
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	set -Eeou pipefail 
	declare -a args
versionid="v1.6"


	finishe() { # on exit
		printf "\\e[?25h\\e[0m"
		set +Eeuo pipefail 
	 	printtail "\$args[@]"  
	}
	
	finisher() { # on script signal
		printf "\\n\\e[?25h\\e[0m%s\\n" "TermuxArch \$(basename "\$0") warning." 
	 	set +Eeuo pipefail 
	 	echo "\$?" 
	 	exit "\$?" 
	}
	
	finishs() { # on signal
		printf "\\n\\e[?25h\\e[0m%s\\n" "TermuxArch \$(basename "\$0") warning.  Signal caught!"
		set +Eeuo pipefail 
	 	echo "\$?" 
	 	exit "\$?" 
	}
	
	printtail() {
		printf "\\\\a\\\\n\\\\e[0m%s \\\\e[0;32m%s %s %s\\\\a\\\\e[1;34m: \\\\a\\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\a\\\\e[0m" "TermuxArch" "\$(basename "\$0")" "\$args"  "\$versionid" "DONE"
		printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0")"':DONE 📱 \007'
	}

	trap finisher ERR
	trap finishe EXIT
	trap finishs INT TERM 
	## ch begin ####################################################################

	if [[ -z "\${1:-}" ]];then
		args=""
	else
		args="\$@"
	fi

	printf "\\\\n\\\\e[1;32m==> \\\\e[1;37m%s \\\\e[1;32m%s %s %s\\\e[0m%s\\\\b…\\\\n\\\\n" "Running" "TermuxArch \$(basename "\$0")" "\$args" "\$versionid"  

	touch \$HOME/.hushlogin \$HOME/.hushlogout
	ls \$HOME/.hushlogin \$HOME/.hushlogout
	EOM
	chmod 770 root/bin/ch 
}

addexd() {
	cat > root/bin/exd <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4712
	EOM
	chmod 770 root/bin/exd 
}

adddfa() {
	cat > root/bin/dfa <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	units=\`df 2>/dev/null | awk 'FNR == 1 {print \$2}'\`
	usrspace=\`df 2>/dev/null | grep "/data" | awk {'print \$4'}\`
	printf "\e[0;33m\$usrspace \$units of free user space is available on this device.\n\e[0m"
	EOM
	chmod 770 root/bin/dfa 
}

addfake_proc_shmem() {
	cat > var/fake_proc_shmem <<- EOM
	------ Message Queues --------
	key        msqid      owner      perms      used-bytes   messages
	
	------ Shared Memory Segments --------
	key        shmid      owner      perms      bytes      nattch     status
	
	------ Semaphore Arrays --------
	key        semid      owner      perms      nsems
	EOM
}

addfake_proc_stat() {
	cat > var/fake_proc_stat <<- EOM
	cpu  4232003 351921 6702657 254559583 519846 1828 215588 0 0 0
	cpu0 1595013 127789 2759942 61446568 310224 1132 92124 0 0 0
	cpu1 1348297 91900 1908179 63099166 110243 334 78861 0 0 0
	cpu2 780526 73446 1142504 64682755 61240 222 32586 0 0 0
	cpu3 508167 58786 892032 65331094 38139 140 12017 0 0 0
	intr 182663754 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 23506963 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 13479102 0 0 0 0 0 0 0 108 0 0 0 0 0 0 0 0 0 178219 72133 5 0 1486834 0 0 0 8586048 0 0 0 0 0 0 0 0 0 0 2254 0 0 0 0 29 3 7501 38210 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4610975 0 0 0 0 0 1 0 78471 0 0 0 0 0 0 0 0 0 0 0 0 0 0 305883 0 15420 0 3956500 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8937474 0 943938 0 0 0 0 0 0 0 0 0 0 0 0 12923 0 0 0 34931 5 0 2922124 848989 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 12502497 0 0 3270275 0 0 0 0 0 0 0 0 0 0 0 1002881 0 0 0 0 0 0 17842 0 44011 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1975390 0 0 0 0 0 0 0 0 0 0 0 0 4968 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1340 2 762 0 0 0 50 42 0 27 82 0 0 0 0 14 28 0 0 0 0 14277 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1974794 0 142 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 367 81
	ctxt 473465697
	btime 1533498667
	processes 800170
	procs_running 2
	procs_blocked 0
	softirq 71223290 12005 18257219 222294 2975533 4317 4317 7683319 19799901 40540 22223845
	EOM
}

addfibs() {
	cat > root/bin/fibs  <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	find /proc/ -name maps 2>/dev/null |xargs awk '{print i\$6}' 2>/dev/null| grep '\.so' | sort | uniq
	EOM
	chmod 770 root/bin/fibs 
}

addga() {
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

addgcl() {
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

addgcm() {
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

addgpl() {
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

addgp() {
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

addkeys() {
	cat > root/bin/keys <<- EOM
	#!/bin/env bash 
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	set -Eeou pipefail 
	shopt -s nullglob globstar

	declare -a keyrings
versionid="v1.6"


	finishe() { # on exit
		printf "\\e[?25h\\e[0m"
		set +Eeuo pipefail 
	 	printtail "\$keyrings[@]"  
#  	 	echo "[ \$0 done (\$?) ]" 
	}
	
	finisher() { # on script signal
		printf "\\n\\e[?25h\\e[0m%s\\n" "TermuxArch \$(basename "\$0") warning." 
	 	set +Eeuo pipefail 
	 	echo "\$?" 
	 	exit "\$?" 
	}
	
	finishs() { # on signal
		printf "\\n\\e[?25h\\e[0m%s\\n" "TermuxArch \$(basename "\$0") warning.  Signal caught!"
		set +Eeuo pipefail 
	 	echo "\$?" 
	 	exit "\$?" 
	}
	
	genen() { # This for loop generates entropy on device for \$t seconds.
		n=2 # Number of loop generations for generating entropy.
		t=256 # Maximum number of seconds loop shall run unless keys completes earlier.
		for i in "\$(seq 1 "\$n")"; do
			"\$(nice -n 20 find / -type f -exec cat {} \; >/dev/null 2>/dev/null & sleep "\$t" ; kill \$! 2>/dev/null)" 2>/dev/null &
			sleep 0.2
			"\$(nice -n 20 ls -alR / >/dev/null 2>/dev/null & sleep "\$t" ; kill \$! 2>/dev/null)" 2>/dev/null &
			sleep 0.2
			"\$(nice -n 20 find / >/dev/null 2>/dev/null & sleep "\$t" ; kill \$! 2>/dev/null)" 2>/dev/null &
			sleep 0.2
			"\$(nice -n 20 cat /dev/urandom >/dev/null 2>/dev/null & sleep "\$t" ; kill \$! 2>/dev/null)" 2>/dev/null &
			sleep 0.2
		done
	}

	printtail() {
		printf "\\\\a\\\\n\\\\e[0;32m%s %s %s\\\\a\\\\e[1;34m: \\\\a\\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\a\\\\e[0m" "TermuxArch \$(basename "\$0")" "\$args" "\$versionid" "DONE"
		printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0") \$args"': DONE 📱 \007'
	}

	trap finisher ERR
	trap finishe EXIT
	trap finishs INT TERM 
	## keys begin ##################################################################

	if [[ -z "\${1:-}" ]];then
	keyrings[0]="archlinux-keyring"
	keyrings[1]="archlinuxarm-keyring"
	elif [[ "\$1" = x86 ]]; then
	keyrings[0]="archlinux32-keyring-transition"
	elif [[ "\$1" = x86_64 ]]; then
	keyrings[0]="archlinux-keyring"
	else
	keyrings="\$@"
	fi
	args="\${keyrings[@]}"
	printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0") \$args"' 📲 \007'
	printf "\\\\n\\\\e[1;32m==> \\\\e[1;37m%s \\\\e[0;32m%s \\\\e[1;32m%s %s \\\\e[0m%s…\\\\n" "Running" "TermuxArch" "\$(basename "\$0")" "\$args" "\$versionid"  
	mv usr/lib/gnupg/scdaemon{,_} 2>/dev/null ||: 
	printf "\n\e[0;34mWhen \e[0;37mgpg: Generating pacman keyring master key\e[0;34m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this part of the install procedure.  To generate as much entropy as possible quickly, watch and listen to a file on your device.  \n\nThe program \e[1;32mpacman-key\e[0;34m will want as much entropy as possible when generating keys.  Entropy is also created through tapping, sliding, one, two and more fingers tapping with short and long taps.  When \e[0;37mgpg: Generating pacman keyring master key\e[0;34m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Put even simpler, just do something on device.  Browsing files will create entropy on device.  Slowly swiveling the device in space and time will accelerate the installation process.  This method alone might not generate enough entropy (a measure of randomness in a closed system) for the process to complete quickly.  Use \e[1;32mbash ~${darch}/bin/we \e[0;34min a new Termux session to and watch entropy on device.\n\n\e[1;32m==>\e[0m Running \e[1mpacman-key --init\e[0;32m…\n"
	genen
	pacman-key --init 2>/dev/null ||: 
	chmod 700 /etc/pacman.d/gnupg
	printf "\n\e[1;32m==>\e[0m Running \e[1mpacman -S \$args --noconfirm --color=always\e[0;32m…\n"
	pacman -S "\${keyrings[@]}" --noconfirm --color=always ||: 
	genen
	printf "\n\e[0;34mWhen \e[1;37mAppending keys from archlinux.gpg\e[0;34m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this part of the install procedure.  To generate as much entropy as possible quickly, watch and listen to a file on your device.  \n\nThe program \e[1;32mpacman-key\e[0;34m will want as much entropy as possible when generating keys.  Entropy is also created through tapping, sliding, one, two and more fingers tapping with short and long taps.  When \e[1;37mAppending keys from archlinux.gpg\e[0;34m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Put even simpler, just do something on device.  Browsing files will create entropy on device.  Slowly swiveling the device in space and time will accelerate the installation process.  This method alone might not generate enough entropy (a measure of randomness in a closed system) for the process to complete quickly.  Use \e[1;32mbash ~${darch}/bin/we \e[0;34min a new Termux session to watch entropy on device.\n\n\e[1;32m==>\e[0m Running \e[1mpacman-key --populate\e[0;32m…\n"
	pacman-key --populate ||: 
	printf "\n\e[1;32m==>\e[0m Running \e[1mpacman -Ss keyring --color=always\e[0m…\n"
	pacman -Ss keyring --color=always ||: 
	EOM
	chmod 770 root/bin/keys 
}

addmotd() {
	cat > etc/motd  <<- EOM
	printf "\n\e[1;34mWelcome to Arch Linux in Termux!\nInstall a package: \e[0;34mpacman -S package\n\e[1;34mMore  information: \e[0;34mpacman -[D|F|Q|R|S|T|U]h\n\e[1;34mSearch   packages: \e[0;34mpacman -Ss query\n\e[1;34mUpgrade  packages: \e[0;34mpacman -Syu\n\n\e[1;34mChat: \e[0mwebchat.freenode.net/ #termux\n\e[1;34mHelp: \e[0;34minfo query \e[1;34mand \e[0;34mman query\n\e[1;34mIRC:  \e[0mwiki.archlinux.org/index.php/IRC_channel\n\n\e[0m"
	EOM
}

addmoto() {
	cat > etc/moto  <<- EOM
	printf "\n\e[1;34mShare Your Arch Linux in Termux Experience!\n\n\e[1;34mChat: \e[0mwebchat.freenode.net/ #termux\n\e[1;34mHelp: \e[0;34minfo query \e[1;34mand \e[0;34mman query\n\e[1;34mIRC:  \e[0mwiki.archlinux.org/index.php/IRC_channel\n\n\e[0m"
	EOM
}

addpc() { # pacman install packages shortcut
	cat > root/bin/pc  <<- EOM
	#!/bin/env bash 
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	set -Eeou pipefail 
	shopt -s nullglob globstar

	declare -g args="\$@"
versionid="v1.6"


	finishe() { # on exit
		printf "\\e[?25h\\e[0m"
		set +Eeuo pipefail 
	 	printtail "\$args"  
#  	 	echo "[ \$0 done (\$?) ]" 
	}
	
	finisher() { # on script signal
		printf "\\n\\e[?25h\\e[0mTermuxArch pc warning.  \\n"
	 	set +Eeuo pipefail 
	 	echo "\$?" 
	 	exit "\$?" 
	}
	
	finishs() { # on signal
		printf "\\n\\e[?25h\\e[0mTermuxArch pc warning.  Signal caught!\\n"
		set +Eeuo pipefail 
	 	echo "\$?" 
	 	exit "\$?" 
	}
	
	printtail() {
		printf "\\\\a\\\\n\\\\e[0;32m%s %s %s\\\\a\\\\e[1;34m: \\\\a\\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\a\\\\e[0m" "TermuxArch \$(basename "\$0")" "\$args" "\$versionid" "DONE"
		printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0") \$args"' 📱 \007'
	}

	trap finisher ERR
	trap finishe EXIT
	trap finishs INT TERM 
	## pc begin ####################################################################

	printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0") \$args"' 📲 \007'
	printf "\\\\n\\\\e[1;32m==> \\\\e[1;37m%s \\\\e[0;32m%s \\\\e[1;32m%s %s \\\e[0m%s…\\\\n\\\\n" "Running" "TermuxArch" "\$(basename "\$0")" "\$args" "\$versionid"  
	if [[ -z "\${1:-}" ]];then
	pacman --noconfirm --color=always -S 
	elif [[ "\$1" = "a" ]];then
	pacman --noconfirm --color=always -S base base-devel "\${@:2}" 
	elif [[ "\$1" = "ae" ]];then
	pacman --noconfirm --color=always -S base base-devel emacs "\${@:2}" 
	elif [[ "\$1" = "a8" ]];then
	pacman --noconfirm --color=always -S base base-devel emacs jdk8-openjdk "\${@:2}" 
	else
	pacman --noconfirm --color=always -S "\$@" 
	fi
	EOM
	chmod 700 root/bin/pc 
}

addpci() { # system update with pacman install packages shortcut 
	cat > root/bin/pci  <<- EOM
	#!/bin/env bash 
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	set -Eeuo pipefail 
	shopt -s nullglob globstar

	declare args="\$@"
versionid="v1.6"


	finishe() { # on exit
		printf "\\e[?25h\\e[0m"
		set +Eeuo pipefail 
	 	printtail "\$args"  
	}
	
	finisher() { # on script signal
		printf "\\n\\e[?25h\\e[0mTermuxArch pci warning.  \\n"
	 	set +Eeuo pipefail 
	 	printf "[ \$(basename "\$0") done ("\$?") ]\n" 
	 	exit \$? 
	}
	
	finishs() { # on signal
		printf "\\n\\e[?25h\\e[0mTermuxArch pci warning.  Signal caught!\\n"
		set +Eeuo pipefail 
	 	printf "[ \$(basename "\$0") done ("\$?") ]\n" 
	 	exit \$? 
	}
	
	printtail() { 
		printf "\\\\a\\\\n\\\\e[0;32m%s %s %s\\\\a\\\\e[1;34m: \\\\a\\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\a\\\\e[0m" "TermuxArch \$(basename "\$0")" "\$args" "\$versionid" "DONE"
		printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0") \$args"' 📱 \007'
	}

	trap finishe EXIT
	trap finisher ERR
	trap finisher QUIT
	trap finishs INT TERM 
	## pci begin ###################################################################

	printf "\\\\n\\\\e[1;32m==> \\\\e[1;37m%s \\\\e[1;32m%s %s %s \\\e[0m%s…\\\\n\\\\n" "Running" "TermuxArch \$(basename "\$0")" "\$args" "\$versionid"  
	if [[ -z "\${1:-}" ]];then
	pacman --noconfirm --color=always -Syu
	elif [[ \$1 = "e" ]];then
	pacman --noconfirm --color=always -Syu base base-devel emacs "\${@:2}" 
	elif [[ \$1 = "e8" ]];then
	pacman --noconfirm --color=always -Syu base base-devel emacs jdk8-openjdk "\${@:2}" 
	elif [[ \$1 = "e10" ]];then
	pacman --noconfirm --color=always -Syu base base-devel emacs jdk10-openjdk "\${@:2}" 
	else
	pacman --noconfirm --color=always -Syu "\$@" 
	fi
	EOM
	chmod 700 root/bin/pci 
}

addprofile() {
	cat > root/.profile <<- EOM
	. \$HOME/.bash_profile
	EOM
	if [ -e "$HOME"/.profile ] ; then
		grep "proxy" "$HOME"/.profile |grep "export" >>  root/.profile 2>/dev/null||:
	fi
}

addresolvconf() {
	rm etc/resolv* 2>/dev/null||:
	cat > etc/resolv.conf <<- EOM
	nameserver 8.8.8.8
	nameserver 8.8.4.4
	EOM
}

addt() {
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

addthstartarch() {
	cat > root/bin/th"$startbin" <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	echo $startbin help
	$startbin help
	sleep 1
	echo $startbin command "pwd && whoami"
	$startbin command "pwd && whoami"
	sleep 1
	echo $startbin login user 
	$startbin login user ||:
	echo $startbin raw su user -c "pwd && whoami"
	$startbin raw su user -c "pwd && whoami"
	sleep 1
	echo $startbin su user "pwd && whoami"
	$startbin su user "pwd && whoami"
	echo th$startbin done
	EOM
	chmod 770 root/bin/th"$startbin"
}

addtour() {
	cat > root/bin/tour <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	printf "\n\e[1;32m==> \e[1;37mRunning \e[1;32mls -R --color=always \$HOME \e[1;37m\n\n"
	ls -R --color=always \$HOME
	printf "\n\e[1;32m==> \e[1;37mRunning \e[1;32msleep 4 \$HOME \e[1;37m\n\n"
	sleep 4
	printf "\n\e[1;32m==> \e[1;37mRunning \e[1;32mcat \$HOME/.bash_profile\e[1;37m\n\n"
	cat \$HOME/.bash_profile
	printf "\n\e[1;32m==> \e[1;37mRunning \e[1;32msleep 8 \$HOME \e[1;37m\n\n"
	sleep 8
	printf "\n\e[1;32m==> \e[1;37mRunning \e[1;32mcat \$HOME/.bashrc\e[1;37m\n\n"
	cat \$HOME/.bashrc
	printf "\n\e[1;32m==> \e[1;37mRunning \e[1;32msleep 4 \$HOME \e[1;37m\n\n"
	sleep 4
	printf "\n\e[1;32m==> \e[1;37mRunning \e[1;32mcat \$HOME/bin/pci\e[1;37m\n\n"
	cat \$HOME/bin/pci
	printf "\n\e[1;32m==> \e[1;37mShort tour is complete; Run this script again at a later time, and it might be surprising at how this environment changes over time.  If you are new to *nix, see http://tldp.org for documentation.  \e[1;34mIRC:  \e[0mhttps://wiki.archlinux.org/index.php/IRC_channel\n\n"
	EOM
	chmod 770 root/bin/tour 
}

addtrim() {
	cat > root/bin/trim <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	printf "\\\\n\\\\e[1;32m==> \\\\e[1;0mRunning \$0 … \\\\e[0m\\\\n\\\\n" 
	EOM
 	if [[ "$cpuabi" = "$cpuabi5" ]];then
 		printf "pacman -Rc linux-armv5 linux-firmware --noconfirm --color=always 2>/dev/null ||:\\n" >> root/bin/trim
 	elif [[ "$cpuabi" = "$cpuabi7" ]];then
 		printf "pacman -Rc linux-armv7 linux-firmware --noconfirm --color=always 2>/dev/null ||:\\n" >> root/bin/trim 
 	elif [[ "$cpuabi" = "$cpuabi8" ]];then
 		printf "pacman -Rc linux-aarch64 linux-firmware --noconfirm --color=always 2>/dev/null ||:\\n" >> root/bin/trim 
 	fi
	cat >> root/bin/trim <<- EOM
	echo [1/5] rm -rf /boot/
	rm -rf /boot/
	echo [2/5] rm -rf /usr/lib/firmware
	rm -rf /usr/lib/firmware
	echo [3/5] rm -rf /usr/lib/modules
	rm -rf /usr/lib/modules
	echo [4/5] pacman -Sc --noconfirm --color=always
	pacman -Sc --noconfirm --color=always
	echo [5/5] rm /var/cache/pacman/pkg/*xz
	rm /var/cache/pacman/pkg/*xz ||: 
	printf "\\\\n\\\\e[1;32mtrim: Done \\\\e[0m\\\\n\\\\n" 
	EOM
	chmod 770 root/bin/trim 
}

addv() {
	cat > root/bin/v  <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	set -Eeou pipefail 
	shopt -s nullglob globstar

	if [[ -z "\${1:-}" ]];then
		args="."
	else
		args="\$@"
	fi
	if [ ! -e /usr/bin/vim ] ; then
		pacman --noconfirm --color=always -Syu vim 
		vim \$args
	else
		vim \$args
	fi
	EOM
	chmod 770 root/bin/v 
}

addwe() {
	cat > root/bin/we <<- EOM
	#!/bin/bash -e
	# Watch available entropy on device.
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	# cat /proc/sys/kernel/random/entropy_avail contributed by https://github.com/cb125
	################################################################################

	i=1
	multi=16
	entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null) 

	printintro()
	{
		printf "\n\e[1;32mTermuxArch Watch Entropy:\n"'\033]2; TermuxArch Watch Entropy 📲  \007'
	}

	printtail()
	{
		printf "\n\n\e[1;32mTermuxArch Watch Entropy 🏁 \n\n"'\033]2; TermuxArch Watch Entropy 🏁 \007'
	}

	printusage()
	{
		printf "\n\e[0;32mUsage:  \e[1;32mwe \e[0;32m Watch Entropy simple.\n\n	\e[1;32mwe sequential\e[0;32m Watch Entropy sequential.\n\n	\e[1;32mwe simple\e[0;32m Watch Entropy simple.\n\n	\e[1;32mwe verbose\e[0;32m Watch Entropy verbose.\n\n"'\033]2; TermuxArch Watch Entropy 📲  \007'
	}

	infif()
	{
		if [[ \$entropy0 = "inf" ]] || [[ \$entropy0 = "" ]] || [[ \$entropy0 = "0" ]];then
			entropy0=1000
			printf "\e[1;32m∞^∞infifinfif2minfifinfifinfifinfif∞=1\e[0;32minfifinfifinfifinfif\e[0;32m∞==0infifinfifinfifinfif\e[0;32minfifinfifinfif∞"
		fi
	}

	en0=\$((\${entropy0}*\$multi))

	esleep()
	{
		int=\$(echo "\$i/\$entropy0" | bc -l)
		for i in {1..5}; do
			if (( \$(echo "\$int > 0.1"|bc -l) ));then
				tmp=\$(echo "\${int}/100" | bc -l)
				int=\$tmp
			fi
			if (( \$(echo "\$int > 0.1"|bc -l) ));then
				break
			fi
		done
	}

	1sleep()
	{
		sleep 0.1
	}
	
	bcif()
	{
		commandif=\$(command -v getprop) ||:
		if [[ \$commandif = "" ]];then
			abcif=\$(command -v bc) ||:
			if [[ \$abcif = "" ]];then
				printf "\e[1;34mInstalling \e[0;32mbc\e[1;34m…\n\n\e[1;32m"
				pacman -Syu bc --noconfirm --color=always
				printf "\n\e[1;34mInstalling \e[0;32mbc\e[1;34m: \e[1;32mDONE\n\e[0m"
			fi
		else
			tbcif=\$(command -v bc) ||:
			if [[ \$tbcif = "" ]];then
				printf "\e[1;34mInstalling \e[0;32mbc\e[1;34m…\n\n\e[1;32m"
				pkg install bc --yes
				printf "\n\e[1;34mInstalling \e[0;32mbc\e[1;34m: \e[1;32mDONE\n\e[0m"
			fi
		fi
	}

	entropysequential()
	{
	printf "\n\e[1;32mWatch Entropy Sequential:\n\n"'\033]2; Watch Entropy Sequential 📲  \007'
	for i in \$(seq 1 \$en0); do
		entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null) 
		infif 
		printf "\e[1;30m \$en0 \e[0;32m\$i \e[1;32m\${entropy0}\n"
		1sleep 
	done
	}

	entropysimple()
	{
	printf "\n\e[1;32mWatch Entropy Simple:\n\n"'\e]2; Watch Entropy Simple 📲  \007'
	for i in \$(seq 1 \$en0); do
		entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null) 
		infif 
		printf "\e[1;32m\${entropy0} " 
		1sleep 
	done
	}

	entropyverbose()
	{
	printf "\n\e[1;32mWatch Entropy Verbose:\n\n"'\033]2; Watch Entropy Verbose 📲  \007'
	for i in \$(seq 1 \$en0); do
		entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null) 
		infif 
		printf "\e[1;30m \$en0 \e[0;32m\$i \e[1;32m\${entropy0} \e[0;32m#E&&√♪"
		esleep 
		sleep \$int
		entropy1=\$(cat /proc/sys/kernel/random/uuid 2>/dev/null) 
		infif 
		printf "\$entropy1" 
		esleep 
		sleep \$int
		printf "&&π™♪&##|♪FLT" 
		esleep 
		sleep \$int
		printf "\$int♪||e"
		esleep 
		sleep \$int
	done
	}

	# [we sequential] Run sequential watch entropy.
	if [[ \$1 = [Ss][Ee]* ]] || [[ \$1 = -[Ss][Ee]* ]] || [[ \$1 = --[Ss][Ee]* ]];then
		printintro 
		entropysequential 
	# [we simple] Run simple watch entropy.
	elif [[ \$1 = [Ss]* ]] || [[ \$1 = -[Ss]* ]] || [[ \$1 = --[Ss]* ]];then
		printintro 
		entropysimple 
	# [we verbose] Run verbose watch entropy.
	elif [[ \$1 = [Vv]* ]] || [[ \$1 = -[Vv]* ]] || [[ \$1 = --[Vv]* ]];then
		printintro 
		bcif
		entropyverbose 
	# [] Run default watch entropy.
	elif [[ \$1 = "" ]];then
		printintro 
		entropysequential 
	else
		printusage
	fi
	printtail 
	EOM
	chmod 770 root/bin/we 
}

addyt() {
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

# EOF
