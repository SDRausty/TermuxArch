#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project. 
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# _STANDARD_="function name" && STANDARD="variable name" are under construction.
################################################################################

addREADME() {
	_CFLHDR_ root/bin/README.md 
	cat > root/bin/README.md <<- EOM
	This directory contains shortcut commands that automate and ease using the command line.
	
	* Comments welcome at https://github.com/sdrausty/TermuxArch/issues ✍ 
	* Pull requests welcome at https://github.com/sdrausty/TermuxArch/pulls ✍ 
	EOM
}

addae() {
	_CFLHDR_ root/bin/ae "# Contributed by https://github.com/cb125" 
	cat >> root/bin/ae <<- EOM
	watch cat /proc/sys/kernel/random/entropy_avail
	EOM
	chmod 700 root/bin/ae 
}

addauser() { 
	_CFLHDR_ root/bin/addauser "# Add Arch Linux user."
	cat >> root/bin/addauser <<- EOM
	if [[ -z "\${1:-}" ]] ; then
		echo "Use: addauser username"
		exit 201
	else
		useradd "\$1"
		cp -r /root /home/"\$1"
		su - "\$1"
	fi
	EOM
	chmod 700 root/bin/addauser 
}

addbash_logout() {
	cat > root/.bash_logout <<- EOM
	if [ ! -e "\$HOME"/.hushlogout ] && [ ! -e "\$HOME"/.chushlogout ] ; then
		. /etc/moto
	fi
	EOM
}

addbash_profile() {
	cat > root/.bash_profile <<- EOM
	. "\$HOME"/.bashrc
	if [ ! -e "\$HOME"/.hushlogin ] && [ ! -e "\$HOME"/.chushlogin ] ; then
		. /etc/motd
	fi
	if [ -e "\$HOME"/.chushlogin ] ; then
		rm "\$HOME"/.chushlogin 
	fi
	PATH="\$HOME/bin:\$PATH"
	PS1="[\[\e[38;5;148m\]\u\[\e[1;0m\]\A\[\e[1;38;5;112m\]\W\[\e[0m\]]$ "
	export TZ="$(getprop persist.sys.timezone)"
	EOM
	for i in "${!LC_TYPE[@]}"; do
	 	printf "%s=\"%s\"\\n" "export ${LC_TYPE[i]}" "$ULANGUAGE.UTF-8" >> root/.bash_profile 
	done
	if [ -e "$HOME"/.bash_profile ] ; then
		grep proxy "$HOME"/.bash_profile |grep "export" >>  root/.bash_profile 2>/dev/null ||:
	fi
}

addbashrc() {
	cat > root/.bashrc <<- EOM
	alias c='cd .. && pwd'
	alias ..='cd ../.. && pwd'
	alias ...='cd ../../.. && pwd'
	alias ....='cd ../../../.. && pwd'
	alias .....='cd ../../../../.. && pwd'
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
	alias i='whoami'
	alias l='ls -alG'
	alias lr='ls -alR'
	alias ls='ls --color=always'
	alias p='pwd'
	alias pacman='pacman --color=always'
	alias q='logout'
	alias rf='rm -rf'
	EOM
	if [ -e "$HOME"/.bashrc ] ; then
		grep proxy "$HOME"/.bashrc | grep "export" >>  root/.bashrc 2>/dev/null ||:
	fi
}

addcdtd() { 
	_CFLHD_ root/bin/cdtd "# Usage: \`. cdtd\` the dot sources \`cdtd\` which makes this shortcut script work."
	cat > root/bin/cdtd <<- EOM
	#!/bin/env bash
	cd "$HOME/storage/downloads" && pwd
	EOM
	chmod 700 root/bin/cdtd 
}

addcdth() { 
	_CFLHD_ root/bin/cdth "# Usage: \`. cdth\` the dot sources \`cdth\` which makes this shortcut script work."
	cat > root/bin/cdth <<- EOM
	#!/bin/env bash
	cd "$HOME" && pwd
	EOM
	chmod 700 root/bin/cdth 
}

addcdtmp() { 
	_CFLHD_ root/bin/cdtmp "# Usage: \`. cdtmp\` the dot sources \`cdtmp\` which makes this shortcut script work."
	cat > root/bin/cdtmp <<- EOM
	#!/bin/env bash
	cd "$PREFIX/tmp" && pwd
	EOM
	chmod 700 root/bin/cdtmp 
}

addch() { 
	_CFLHDR_ root/bin/ch "# This script creates .hushlogin and .hushlogout files."
	cat >> root/bin/ch <<- EOM
	declare -a ARGS

	_TRPET_() { # on exit
		printf "\\e[?25h\\e[0m"
		set +Eeuo pipefail 
	 	_PRINTTAIL_ "\$ARGS[@]"  
	}
	
	_PRINTTAIL_() {
		printf "\\\\a\\\\n\\\\e[0m%s \\\\e[0;32m%s %s %s\\\\a\\\\e[1;34m: \\\\a\\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\a\\\\e[0m" "TermuxArch" "\$(basename "\$0")" "\$ARGS"  "\$VERSIONID" "DONE"
		printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0")"':DONE 📱 \007'
	}

	## ch begin ####################################################################

	if [[ -z "\${1:-}" ]] ; then
		ARGS=""
	else
		ARGS="\$@"
	fi

	printf "\\\\n\\\\e[1;32m==> \\\\e[1;37m%s \\\\e[1;32m%s %s %s\\\e[0m%s…\\\\n\\\\n" "Running" "TermuxArch \$(basename "\$0")" "\$ARGS" "\$VERSIONID"  

	if [[ -f "\$HOME"/.hushlogin ]] && [[ -f "\$HOME"/.hushlogout ]] ; then
		rm "\$HOME"/.hushlogin "\$HOME"/.hushlogout
		echo "Hushed login and logout: OFF"
	elif [[ -f "\$HOME"/.hushlogin ]] || [[ -f "\$HOME"/.hushlogout ]] ; then
		touch "\$HOME"/.hushlogin "\$HOME"/.hushlogout
		echo "Hushed login and logout: ON"
	else
		touch "\$HOME"/.hushlogin "\$HOME"/.hushlogout
		echo "Hushed login and logout: ON"
	fi
	EOM
	chmod 700 root/bin/ch 
}

addexd() {
	_CFLHDR_ root/bin/exd "# Usage: \`. exd\` the dot sources \`exd\` which makes this shortcut script work."
	cat >> root/bin/exd <<- EOM
	export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4712
	EOM
	chmod 700 root/bin/exd 
}

adddfa() {
	_CFLHDR_ root/bin/dfa
	cat >> root/bin/dfa <<- EOM
	units="\$(df 2>/dev/null | awk 'FNR == 1 {print \$2}')"
	USRSPACE="\$(df 2>/dev/null | grep "/data" | awk {'print \$4'})"
	printf "\e[0;33m%s\n\e[0m" "\$USRSPACE \$units of free user space is available on this device."
	EOM
	chmod 700 root/bin/dfa 
}

addfbindprocshmem() {
	_CFLHDRS_ var/binds/fbindprocshmem.prs  
	cat > var/binds/fbindprocshmem.prs  <<- EOM
	PROOTSTMNT+="-b $INSTALLDIR/var/binds/fbindprocshmem:/proc/shmem " 
	EOM
	cat > var/binds/fbindprocshmem <<- EOM
	------ Message Queues --------
	key        msqid      owner      perms      used-bytes   messages
	
	------ Shared Memory Segments --------
	key        shmid      owner      perms      bytes      nattch     status
	
	------ Semaphore Arrays --------
	key        semid      owner      perms      nsems
	EOM
}

_ADDfbindprocstat_() { # Chooses the appropriate four or eight processor stat file. 
	NESSOR="$(grep cessor /proc/cpuinfo)"
	NCESSOR="${NESSOR: -1}"
	if [[ "$NCESSOR" -le "3" ]] 2>/dev/null ; then
		_ADDfbindprocstat4_
	else
		_ADDfbindprocstat8_
	fi
}

_ADDfbindprocstat4_() {
	cat > var/binds/fbindprocstat <<- EOM
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

_ADDfbindprocstat6_() {
	cat > var/binds/fbindprocstat <<- EOM
	# cat /proc/stat
	cpu  148928556 146012 6648853 2086709554 4518337 0 1314039 293017 0 0
	cpu0 24948069 38092 1137251 347724817 1169568 0 30231 21138 0 0
	cpu1 16545576 29411 890111 356315677 971747 0 41593 115368 0 0
	cpu2 82009143 11955 2705377 286616379 473751 0 1239704 114343 0 0
	cpu3 9487436 29342 673090 364602319 631633 0 843 11690 0 0
	cpu4 6696319 23709 584149 367425424 501898 0 890 12546 0 0
	cpu5 9242011 13500 658872 364024935 769737 0 775 17929 0 0
	intr 3438098651 134 26 0 0 0 0 3 0 0 0 0 581717 74 0 0 3669554 0 0 0 0 0 0 0 0 0 150777509 19 0 843288252 7923 0 0 0 256 0 4 0 13323712 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	ctxt 1109789017
	btime 1499444193
	processes 6613836
	procs_running 3
	procs_blocked 0
	softirq 3644958646 1 2007831497 2340 995352344 1834998 0 97563 249921452 0 389918451
	EOM
}

_ADDfbindprocstat8_() {
	cat > var/binds/fbindprocstat <<- EOM
	cpu  10278859 1073916 12849197 97940412 70467 2636 323477 0 0 0
	cpu0 573749 46423 332546 120133 32 79 5615 0 0 0
	cpu1 489409 40445 325756 64094 0 59 5227 0 0 0
	cpu2 385758 36997 257949 50488114 40123 39 4021 0 0 0
	cpu3 343254 34729 227718 47025740 30205 20 2566 0 0 0
	cpu4 3063160 288232 4291656 58418 27 940 146236 0 0 0
	cpu5 2418517 277690 3105779 60431 48 751 67052 0 0 0
	cpu6 1671400 189460 2302016 61521 23 402 49717 0 0 0
	cpu7 1333612 159940 2005777 61961 9 346 43043 0 0 0
	intr 607306752 0 0 113 0 109 0 0 26 0 0 4 0 0 0 0 0 0 0 0 0 67750564 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 51073258 0 0 0 0 0 0 0 160 0 0 0 0 0 0 0 0 0 51831 2 5 0 24598 0 0 0 15239501 0 0 0 0 0 0 0 0 0 0 1125885 0 0 0 0 5966 3216 120 2 0 0 5990 0 24741 0 37 0 0 0 0 0 0 0 0 0 0 0 0 15262980 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 42742 16829690 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 19844763 0 8873762 0 0 0 0 0 0 0 0 6 0 0 0 49937 0 0 0 2768306 5 0 3364052 3700518 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 41435584 0 0 3939101 0 0 0 0 0 0 0 0 0 0 0 1894201 0 0 0 0 0 0 864195 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8961077 3996222 0 0 0 0 0 0 0 0 0 0 0 0 66386 0 0 0 0 0 0 87497 0 285431 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 11217187 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3578 0 0 0 0 0 301 300 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 117 14 0 0 0 0 0 95 0 0 0 0 0 0 0 27 0 2394 0 0 0 0 62 0 0 0 0 0 857124 0 1 0 0 0 0 20 3990685 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5021 481 4
	ctxt 1589697753
	btime 1528042653
	processes 1400085
	procs_running 5
	procs_blocked 0
	softirq 204699421 2536598 39636497 522981 4632002 29263706 104522 6736991 41332715 232221 79701188
	EOM
}

addfbindexample() {
	_CFLHDRS_ var/binds/fbindexample.prs "# To regenerate the start script use \`setupTermuxArch.sh re[fresh]\`.  Add as many proot statements as you want; The init script will parse this file at refresh.  Examples are included for convenience.  Usage: PROOTSTMNT+=\"-b host_path:guest_path \" The space before the last double quote is necessary." 
	cat >> var/binds/fbindexample.prs <<- EOM
	# PROOTSTMNT+="-b $INSTALLDIR/var/binds/fbindprocstat:/proc/stat " 
	# if [[ ! -r /dev/shm ]] ; then 
	# 		PROOTSTMNT+="-b $INSTALLDIR/tmp:/dev/shm " 
	# fi
	EOM
}

addbinds() { # Checks if /proc/stat is usable. 
	if [[ ! -r /proc/stat ]] ; then
		_ADDfbindprocstat_
	fi
}

addfibs() {
	_CFLHDR_ root/bin/fibs 
	cat >> root/bin/fibs  <<- EOM
	find /proc/ -name maps 2>/dev/null |xARGS awk '{print i\$6}' 2>/dev/null| grep '\.so' | sort | uniq
	EOM
	chmod 700 root/bin/fibs 
}

addga() {
	_CFLHDR_ root/bin/ga 
	cat >> root/bin/ga  <<- EOM
	if [ ! -e /usr/bin/git ] ; then
		pacman --noconfirm --color=always -S git
		git add .
	else
		git add .
	fi
	EOM
	chmod 700 root/bin/ga 
}

addgcl() {
	_CFLHDR_ root/bin/gcl 
	cat >> root/bin/gcl  <<- EOM
	if [ ! -e /usr/bin/git ] ; then
		pacman --noconfirm --color=always -S git 
		git clone "\$@"
	else
		git clone "\$@"
	fi
	EOM
	chmod 700 root/bin/gcl 
}

addgcm() {
	_CFLHDR_ root/bin/gcm 
	cat >> root/bin/gcm  <<- EOM
	if [ ! -e /usr/bin/git ] ; then
		pacman --noconfirm --color=always -S git 
		git commit
	else
		git commit
	fi
	EOM
	chmod 700 root/bin/gcm 
}

addgpl() {
	_CFLHDR_ root/bin/gpl 
	cat >> root/bin/gpl  <<- EOM
	if [ ! -e /usr/bin/git ] ; then
		pacman --noconfirm --color=always -S git 
		git pull
	else
		git pull
	fi
	EOM
	chmod 700 root/bin/gpl 
}

addgp() {
	_CFLHDR_ root/bin/gp "# git push https://username:password@github.com/username/repository.git master"
	cat >> root/bin/gp  <<- EOM
	if [ ! -e /usr/bin/git ] ; then
		pacman --noconfirm --color=always -S git 
		git push
	else
		git push
	fi
	EOM
	chmod 700 root/bin/gp 
}

addkeys() {
	_CFLHDR_ root/bin/keys 
	cat >> root/bin/keys <<- EOM
	declare -a KEYRINGS

	_TRPET_() { # on exit
		printf "\\e[?25h\\e[0m"
		set +Eeuo pipefail 
	 	_PRINTTAIL_ "\$KEYRINGS[@]"  
	}
	
	_GENEN_() { # This for loop generates entropy on device for \$t seconds.
		N=2 # Number of loop generations for generating entropy.
		T0=256 # Maximum number of seconds loop shall run unless keys completes earlier.
		T1=0.4
		for I in "\$(seq 1 "\$N")"; do
			"\$(nice -n 20 ls -alR / >/dev/null 2>/dev/null & sleep "\$T0" ; kill \$! 2>/dev/null)" 2>/dev/null &
			sleep "\$T1"
			"\$(nice -n 20 find / >/dev/null 2>/dev/null & sleep "\$T0" ; kill \$! 2>/dev/null)" 2>/dev/null &
			sleep "\$T1"
			"\$(nice -n 20 cat /dev/urandom >/dev/null 2>/dev/null & sleep "\$T0" ; kill \$! 2>/dev/null)" 2>/dev/null &
			sleep "\$T1"
		done
		disown
	}

	_PRINTTAIL_() {
		printf "\\\\a\\\\n\\\\e[0;32m%s %s %s\\\\a\\\\e[1;34m: \\\\a\\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\a\\\\e[0m" "TermuxArch \$(basename "\$0")" "\$ARGS" "\$VERSIONID" "DONE"
		printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0") \$ARGS"': DONE 📱 \007'
	}

	trap _TRPET_ EXIT
	## keys begin ##################################################################

	if [[ -z "\${1:-}" ]] ; then
		KEYRINGS[0]="archlinux-keyring"
		KEYRINGS[1]="archlinuxarm-keyring"
		KEYRINGS[2]="ca-certificates-utils"
	elif [[ "\$1" = x86 ]]; then
		KEYRINGS[0]="archlinux32-keyring-transition"
		KEYRINGS[1]="ca-certificates-utils"
	elif [[ "\$1" = x86_64 ]]; then
		KEYRINGS[0]="archlinux-keyring"
		KEYRINGS[1]="ca-certificates-utils"
	else
		KEYRINGS="\$@"
	fi
	ARGS="\${KEYRINGS[@]}"
	printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0") \$ARGS"' 📲 \007'
	printf "\\\\n\\\\e[1;32m==> \\\\e[1;37m%s \\\\e[0;32m%s \\\\e[1;32m%s %s \\\\e[0m%s…\\\\n" "Running" "TermuxArch" "\$(basename "\$0")" "\$ARGS" "\$VERSIONID"  
	mv usr/lib/gnupg/scdaemon{,_} 2>/dev/null ||: 
	printf "\n\e[0;34mWhen \e[0;37mgpg: Generating pacman keyring master key\e[0;34m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this part of the install procedure.  To generate as much entropy as possible quickly, watch and listen to a file on your device.  \n\nThe program \e[1;32mpacman-key\e[0;34m will want as much entropy as possible when generating keys.  Entropy is also created through tapping, sliding, one, two and more fingers tapping with short and long taps.  When \e[0;37mgpg: Generating pacman keyring master key\e[0;34m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Put even simpler, just do something on device.  Browsing files will create entropy on device.  Slowly swiveling the device in space and time will accelerate the installation process.  This method alone might not generate enough entropy (a measure of randomness in a closed system) for the process to complete quickly.  Use \e[1;32mbash ~${DARCH}/bin/we \e[0;34min a new Termux session to and watch entropy on device.\n\n\e[1;32m==>\e[0m Running \e[1mpacman-key --init\e[0;32m…\n"
	_GENEN_
	pacman-key --init ||: 
	chmod 700 /etc/pacman.d/gnupg
	pacman-key --populate ||: 
	printf "\n\e[1;32m==>\e[0m Running \e[1mpacman -S \$ARGS --noconfirm --color=always\e[0;32m…\n"
	pacman -S "\${KEYRINGS[@]}" --noconfirm --color=always ||: 
	printf "\n\e[0;34mWhen \e[1;37mAppending keys from archlinux.gpg\e[0;34m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this part of the install procedure.  To generate as much entropy as possible quickly, watch and listen to a file on your device.  \n\nThe program \e[1;32mpacman-key\e[0;34m will want as much entropy as possible when generating keys.  Entropy is also created through tapping, sliding, one, two and more fingers tapping with short and long taps.  When \e[1;37mAppending keys from archlinux.gpg\e[0;34m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Put even simpler, just do something on device.  Browsing files will create entropy on device.  Slowly swiveling the device in space and time will accelerate the installation process.  This method alone might not generate enough entropy (a measure of randomness in a closed system) for the process to complete quickly.  Use \e[1;32mbash ~${DARCH}/bin/we \e[0;34min a new Termux session to watch entropy on device.\n\n\e[1;32m==>\e[0m Running \e[1mpacman-key --populate\e[0;32m…\n"
	_GENEN_
	pacman-key --populate ||: 
	printf "\n\e[1;32m==>\e[0m Running \e[1mpacman -Ss keyring --color=always\e[0m…\n"
	pacman -Ss keyring --color=always ||: 
	EOM
	chmod 700 root/bin/keys 
}

addmotd() {
	cat > etc/motd  <<- EOM
	printf "\n\e[1;34mWelcome to Arch Linux in Termux!\nInstall a package: \e[0;34mpacman -S package\n\e[1;34mMore  information: \e[0;34mpacman -[D|F|Q|R|S|T|U]h\n\e[1;34mSearch   packages: \e[0;34mpacman -Ss query\n\e[1;34mUpgrade  packages: \e[0;34mpacman -Syu\n\n\e[1;34mChat: \e[0mwiki.termux.com/wiki/Community\n\e[1;34mHelp: \e[0;34minfo query \e[1;34mand \e[0;34mman query\n\e[1;34mIRC:  \e[0mwiki.archlinux.org/index.php/IRC_channel\n\n\e[0m"
	EOM
}

addmoto() {
	cat > etc/moto  <<- EOM
	printf "\n\e[1;34mShare Your Arch Linux in Termux Experience!\n\n\e[1;34mChat: \e[0mwiki.termux.com/wiki/Community\n\e[1;34mHelp: \e[0;34minfo query \e[1;34mand \e[0;34mman query\n\e[1;34mIRC:  \e[0mwiki.archlinux.org/index.php/IRC_channel\n\n\e[0m"
	EOM
}

addpc() { 
	_CFLHDR_ root/bin/pc "# Pacman install packages wrapper without system update."
	cat >> root/bin/pc  <<- EOM
	declare -g ARGS="\$@"

	_TRPET_() { # on exit
		printf "\\e[?25h\\e[0m"
		set +Eeuo pipefail 
	 	_PRINTTAIL_ "\$ARGS"  
	}
	
	_PRINTTAIL_() {
		printf "\\\\a\\\\n\\\\e[0;32m%s %s %s\\\\a\\\\e[1;34m: \\\\a\\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\a\\\\e[0m" "TermuxArch \$(basename "\$0")" "\$ARGS" "\$VERSIONID" "DONE"
		printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0") \$ARGS"' 📱 \007'
	}

	trap _TRPET_ EXIT
	## pc begin ####################################################################

	printf "\033]2;%s\007" " 🔑🗝 TermuxArch \$(basename "\$0") \$ARGS 📲 "
	printf "\\\\n\\\\e[1;32m==> \\\\e[1;37m%s \\\\e[0;32m%s \\\\e[1;32m%s %s \\\e[0m%s…\\\\n\\\\n" "Running" "TermuxArch" "\$(basename "\$0")" "\$ARGS" "\$VERSIONID"  
	if [[ -z "\${1:-}" ]] 
	then
	pacman -S --noconfirm --color=always 
	elif [[ "\$1" = "a" ]] 
	then
	pacman -S base base-devel "\${@:2}" --noconfirm --color=always 
	elif [[ "\$1" = "ae" ]] 
	then
	pacman -S base base-devel emacs "\${@:2}" --noconfirm --color=always 
	elif [[ "\$1" = "a8" ]] 
	then
	pacman -S base base-devel emacs jdk8-openjdk "\${@:2}" --noconfirm --color=always 
	else
	pacman -S "\$@" --noconfirm --color=always 
	fi
	EOM
	chmod 700 root/bin/pc 
}

addpci() { 
	_CFLHDR_ root/bin/pci "# Pacman install packages wrapper with system update."
	cat >> root/bin/pci  <<- EOM
	declare ARGS="\$@"

	_TRPET_() { # on exit
		printf "\\e[?25h\\e[0m"
		set +Eeuo pipefail 
	 	_PRINTTAIL_ "\$ARGS"  
	}
	
	_PRINTTAIL_() { 
		printf "\\\\a\\\\n\\\\e[0;32m%s %s %s\\\\a\\\\e[1;34m: \\\\a\\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\a\\\\e[0m" "TermuxArch \$(basename "\$0")" "\$ARGS" "\$VERSIONID" "DONE"
		printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0") \$ARGS"' 📱 \007'
	}

	trap _TRPET_ EXIT
	## pci begin ###################################################################

	printf "\\\\n\\\\e[1;32m==> \\\\e[1;37m%s \\\\e[1;32m%s %s %s \\\e[0m%s…\\\\n\\\\n" "Running" "TermuxArch \$(basename "\$0")" "\$ARGS" "\$VERSIONID"  
	if [[ -z "\${1:-}" ]] ; then
	pacman -Syu --noconfirm --color=always 
	elif [[ "\$1" = "e" ]] ; then
	pacman -Syu base base-devel emacs "\${@:2}" --noconfirm --color=always  
	elif [[ "\$1" = "e8" ]] ; then
	pacman -Syu base base-devel emacs jdk8-openjdk "\${@:2}" --noconfirm --color=always  
	elif [[ "\$1" = "e10" ]] ; then
	pacman -Syu base base-devel emacs jdk10-openjdk "\${@:2}" --noconfirm --color=always  
	else
	pacman -Syu "\$@" --noconfirm --color=always  
	fi
	EOM
	chmod 700 root/bin/pci 
}

addpcs() { 
	_CFLHDR_ root/bin/pcs "# Pacman install packages wrapper with system update."
	cat >> root/bin/pcs  <<- EOM
	declare ARGS="\$@"

	_TRPET_() { # on exit
		printf "\\e[?25h\\e[0m"
		set +Eeuo pipefail 
	 	_PRINTTAIL_ "\$ARGS"  
	}
	
	_PRINTTAIL_() { 
		printf "\\\\a\\\\n\\\\e[0;32m%s %s %s\\\\a\\\\e[1;34m: \\\\a\\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\a\\\\e[0m" "TermuxArch \$(basename "\$0")" "\$ARGS" "\$VERSIONID" "DONE"
		printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0") \$ARGS"' 📱 \007'
	}

	trap _TRPET_ EXIT
	## pci begin ###################################################################

	printf "\\\\n\\\\e[1;32m==> \\\\e[1;37m%s \\\\e[1;32m%s %s %s \\\e[0m%s…\\\\n\\\\n" "Running" "TermuxArch \$(basename "\$0")" "\$ARGS" "\$VERSIONID"  
	if [[ -z "\${1:-}" ]] ; then
	pacman -S --color=always 
	elif [[ "\$1" = "e" ]] ; then
	pacman -Syu base base-devel emacs "\${@:2}" --color=always  
	elif [[ "\$1" = "e8" ]] ; then
	pacman -Syu base base-devel emacs jdk8-openjdk "\${@:2}" --color=always  
	elif [[ "\$1" = "e10" ]] ; then
	pacman -Syu base base-devel emacs jdk10-openjdk "\${@:2}" --color=always  
	else
	pacman -Syu "\$@" --color=always  
	fi
	EOM
	chmod 700 root/bin/pcs 
}
	
addpcss() { 
	_CFLHDR_ root/bin/pcss "# Pacman install packages wrapper with system update."
	cat >> root/bin/pcss  <<- EOM
	declare ARGS="\$@"

	_TRPET_() { # on exit
		printf "\\e[?25h\\e[0m"
		set +Eeuo pipefail 
	 	_PRINTTAIL_ "\$ARGS"  
	}
	
	_PRINTTAIL_() { 
		printf "\\\\a\\\\n\\\\e[0;32m%s %s %s\\\\a\\\\e[1;34m: \\\\a\\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\a\\\\e[0m" "TermuxArch \$(basename "\$0")" "\$ARGS" "\$VERSIONID" "DONE"
		printf '\033]2;  🔑🗝 TermuxArch '"\$(basename "\$0") \$ARGS"' 📱 \007'
	}

	trap _TRPET_ EXIT
	## pci begin ###################################################################

	printf "\\\\n\\\\e[1;32m==> \\\\e[1;37m%s \\\\e[1;32m%s %s %s \\\e[0m%s…\\\\n\\\\n" "Running" "TermuxArch \$(basename "\$0")" "\$ARGS" "\$VERSIONID"  
	if [[ -z "\${1:-}" ]] ; then
	pacman -Ss --color=always 
	else
	pacman -Ss "\$@" --color=always  
	fi
	EOM
	chmod 700 root/bin/pcss 
}

addprofile() {
	cat > root/.profile <<- EOM
	. "\$HOME"/.bash_profile
	EOM
	if [ -e "$HOME"/.profile ] ; then
		grep "proxy" "$HOME"/.profile |grep "export" >>  root/.profile 2>/dev/null||:
	fi
}

addresolvconf() {
	mkdir -p run/systemd/resolve 	
	cat > run/systemd/resolve/resolv.conf <<- EOM
	nameserver 8.8.8.8
	nameserver 8.8.4.4
	EOM
}

addt() {
	_CFLHDR_ root/bin/t
	cat >> root/bin/t  <<- EOM
	if [ ! -e /usr/bin/tree ] ; then
		pacman --noconfirm --color=always -S tree 
		tree "\$@"
	else
		tree "\$@"
	fi
	EOM
	chmod 700 root/bin/t 
}

addthstartarch() {
	_CFLHDR_ root/bin/th"$STARTBIN" 
	cat >> root/bin/th"$STARTBIN" <<- EOM
	echo $STARTBIN help
	$STARTBIN help
	sleep 1
	echo $STARTBIN command "pwd && whoami"
	$STARTBIN command "pwd && whoami"
	sleep 1
	echo $STARTBIN login user 
	$STARTBIN login user ||:
	echo $STARTBIN raw su user -c "pwd && whoami"
	$STARTBIN raw su user -c "pwd && whoami"
	sleep 1
	echo $STARTBIN su user "pwd && whoami"
	$STARTBIN su user "pwd && whoami"
	echo th$STARTBIN done
	EOM
	chmod 700 root/bin/th"$STARTBIN"
}

addtour() {
	_CFLHDR_ root/bin/tour "# A short tour that shows a few of the new files in ths system." 
	cat >> root/bin/tour <<- EOM
	printf "\n\e[1;32m==> \e[1;37mRunning \e[1;32mls -R --color=always \$HOME \e[1;37m\n\n"
	sleep 1
	ls -R --color=always "\$HOME"
	sleep 4
	printf "\n\e[1;32m==> \e[1;37mRunning \e[1;32mcat \$HOME/.bash_profile\e[1;37m\n\n"
	sleep 1
	cat "\$HOME"/.bash_profile
	sleep 4
	printf "\n\e[1;32m==> \e[1;37mRunning \e[1;32mcat \$HOME/.bashrc\e[1;37m\n\n"
	sleep 1
	cat "\$HOME"/.bashrc
	sleep 4
	printf "\n\e[1;32m==> \e[1;37mRunning \e[1;32mcat \$HOME/bin/pci\e[1;37m\n\n"
	sleep 1
	cat "\$HOME"/bin/pci
	printf "\\e[1;32m\\n%s \\e[38;5;121m%s \\n\\n\\e[4;38;5;129m%s\\e[0m\\n\\n\\e[1;34m%s \\e[38;5;135m%s\\e[0m\\n\\n" "==>" "Short tour is complete; Scroll up if you wish to study the output.  Run this script again at a later time, and it might be surprising at how this environment changes over time. " "If you are new to *nix, http://tldp.org has documentation." "IRC: " "https://wiki.archlinux.org/index.php/IRC_channel"
	EOM
	chmod 700 root/bin/tour 
}

addtrim() {
	_CFLHDR_ root/bin/trim
	cat >> root/bin/trim <<- EOM
	printf "\\\\n\\\\e[1;32m==> \\\\e[1;0mRunning \$0 … \\\\e[0m\\\\n\\\\n" 
	echo [1/5] rm -rf /boot/
	rm -rf /boot/
	echo [2/5] rm -rf /usr/lib/firmware
	rm -rf /usr/lib/firmware
	echo [3/5] rm -rf /usr/lib/modules
	rm -rf /usr/lib/modules
	echo [4/5] pacman -Sc --noconfirm --color=always
	pacman -Sc --noconfirm --color=always
	echo [5/5] rm -f /var/cache/pacman/pkg/*xz
	rm -f /var/cache/pacman/pkg/*xz ||: 
	printf "\\\\n\\\\e[1;32mtrim: Done \\\\e[0m\\\\n\\\\n" 
	EOM
	chmod 700 root/bin/trim 
}

addv() {
	_CFLHDR_ root/bin/v
	cat >> root/bin/v  <<- EOM
	if [[ -z "\${1:-}" ]] ; then
		ARGS="."
	else
		ARGS="\$@"
	fi
	if [ ! -e /usr/bin/vim ] ; then
		pacman --noconfirm --color=always -S vim 
		vim "\$@"
	else
		vim "\$@"
	fi
	EOM
	chmod 700 root/bin/v 
}

addwe() { 
	_CFLHDR_ usr/bin/we "# Watch available entropy on device." "# cat /proc/sys/kernel/random/entropy_avail contributed by https://github.com/cb125"
	cat >> usr/bin/we <<- EOM

	i=1
	multi=16
	entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null) 

	printintro()
	{
		printf "\n\e[1;32mTermuxArch Watch Entropy:\n"'\033]2; TermuxArch Watch Entropy 📲  \007'
	}

	_PRINTTAIL_()
	{
		printf "\n\n\e[1;32mTermuxArch Watch Entropy 🏁 \n\n"'\033]2; TermuxArch Watch Entropy 🏁 \007'
	}

	_PRINTUSAGE_()
	{
		printf "\n\e[0;32mUsage:  \e[1;32mwe \e[0;32m Watch Entropy simple.\n\n	\e[1;32mwe sequential\e[0;32m Watch Entropy sequential.\n\n	\e[1;32mwe simple\e[0;32m Watch Entropy simple.\n\n	\e[1;32mwe verbose\e[0;32m Watch Entropy verbose.\n\n"'\033]2; TermuxArch Watch Entropy 📲  \007'
	}

	infif()
	{
		if [[ \$entropy0 = "inf" ]] || [[ \$entropy0 = "" ]] || [[ \$entropy0 = "0" ]] ; then
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
		if [[ \$commandif = "" ]] ; then
			abcif=\$(command -v bc) ||:
			if [[ \$abcif = "" ]] ; then
				printf "\e[1;34mInstalling \e[0;32mbc\e[1;34m…\n\n\e[1;32m"
				pacman -S bc --noconfirm --color=always
				printf "\n\e[1;34mInstalling \e[0;32mbc\e[1;34m: \e[1;32mDONE\n\e[0m"
			fi
		else
			tbcif=\$(command -v bc) ||:
			if [[ \$tbcif = "" ]] ; then
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
	if [[ -z "\${1:-}" ]] ; then
		printintro 
		entropysequential 
	elif [[ \$1 = [Ss][Ee]* ]] || [[ \$1 = -[Ss][Ee]* ]] || [[ \$1 = --[Ss][Ee]* ]] ; then
		printintro 
		entropysequential 
	# [we simple] Run simple watch entropy.
	elif [[ \$1 = [Ss]* ]] || [[ \$1 = -[Ss]* ]] || [[ \$1 = --[Ss]* ]] ; then
		printintro 
		entropysimple 
	# [we verbose] Run verbose watch entropy.
	elif [[ \$1 = [Vv]* ]] || [[ \$1 = -[Vv]* ]] || [[ \$1 = --[Vv]* ]] ; then
		printintro 
		bcif
		entropyverbose 
	# [] Run default watch entropy.
	elif [[ \$1 = "" ]] ; then
		printintro 
		entropysequential 
	else
		_PRINTUSAGE_
	fi
	_PRINTTAIL_ 
	EOM
	chmod 700 usr/bin/we 
}

addyt() {
	_CFLHDR_ root/bin/yt
	cat >> root/bin/yt  <<- EOM
	if [ ! -e /usr/bin/youtube-dl ] ; then
		pacman --noconfirm --color=always -S youtube-dl
		youtube-dl "\$@"
	else
		youtube-dl "\$@"
	fi
	EOM
	chmod 700 root/bin/yt 
}

# EOF
