#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

echoSpecialParameters () {
	# 3.2.5 Special parameters based on https://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html
	printf "\\n\\nSpecial BASH Variables\\n\\nCharacter	Definition \\n\\n"
	echo "\$* expands to the positional parameters, starting from one. When the expansion occurs within double quotes, it expands to a single word with the value of each parameter separated by the first character of the IFS special variable."
	echo "$*"
	echo "\$@ expands to the positional parameters, starting from one. When the expansion occurs within double quotes, each parameter expands to a separate word."
	echo "$@"
	echo "\$# expands to the number of positional parameters in decimal."
	echo $#
	echo "\$? expands to the exit status of the most recently executed foreground pipeline."
	echo $?
	echo "\$- a hyphen expands to the current option flags as specified upon invocation, by the set built-in command, or those set by the shell itself (such as the -i)."
	echo $-
	echo "\$\$ expands to the process ID of the shell."
	echo $$
	echo "\$! expands to the process ID of the most recently executed background (asynchronous) command."
	echo $!
	echo "\$0 expands to the name of the shell or shell script."
	echo "$0"
	echo "\$_ the underscore variable is set at shell startup and contains the absolute file name of the shell or script being executed as passed in the argument list. Subsequently, it expands to the last argument to the previous command, after expansion. It is also set to the full pathname of each command executed and placed in the environment exported to that command. When checking mail, this parameter holds the name of the mail file."
	echo "$_"
	printf "\\nNote	\$\* vs. \$\@\\n\\nThe implementation of "\$\*" has always been a problem and realistically should have been replaced with the behavior of "\$\@". In almost every case where coders use "\$\*", they mean "\$\@". "\$\*" Can cause bugs and even security holes in your software.\\n\\n\\e[3mBased on https://www.tldp.org/LDP/Bash-Beginners-Guide/html/sect_03_02.html\\n\\n\\e[0m"
}

sysinfo () {
	spaceinfo
	printf "\\n\\e[1;32m"
	printf "Begin setupTermuxArch debug information.\\n" > setupTermuxArchDebug"$stime".log
	printf "\\n\`termux-info\` results:\\n\\n" >> setupTermuxArchDebug"$stime".log
	termux-info >> setupTermuxArchDebug"$stime".log
	printf "\\nDisk report $usrspace on /data $(date)\\n\\n" >> setupTermuxArchDebug"$stime".log 
	for n in 0 1 2 3 4 5 
	do 
		echo "BASH_VERSINFO[$n] = ${BASH_VERSINFO[$n]}"  >> setupTermuxArchDebug"$stime".log
	done
	printf "\\ncat /proc/cpuinfo results:\\n\\n" >> setupTermuxArchDebug"$stime".log
	cat /proc/cpuinfo >> setupTermuxArchDebug"$stime".log
	printf "\\ndpkg --print-architecture result:\\n\\n" >> setupTermuxArchDebug"$stime".log
	dpkg --print-architecture >> setupTermuxArchDebug"$stime".log
	printf "\\ngetprop ro.product.cpu.abi result:\\n\\n" >> setupTermuxArchDebug"$stime".log
	getprop ro.product.cpu.abi >> setupTermuxArchDebug"$stime".log
	printf "\\ngetprop ro.product.device result:\\n\\n" >> setupTermuxArchDebug"$stime".log
	getprop ro.product.device >> setupTermuxArchDebug"$stime".log
	printf "\\nDownload directory information results.\\n\\n" >> setupTermuxArchDebug"$stime".log
	if [[ -d /sdcard/Download ]]; then echo "/sdcard/Download exists"; else echo "/sdcard/Download not found"; fi >> setupTermuxArchDebug"$stime".log 
	if [[ -d /storage/emulated/0/Download ]]; then echo "/storage/emulated/0/Download exists"; else echo "/storage/emulated/0/Download not found"; fi >> setupTermuxArchDebug"$stime".log
	if [[ -d ~/downloads ]]; then echo "~/downloads exists"; else echo "~/downloads not found"; fi >> setupTermuxArchDebug"$stime".log 
	if [[ -d ~/storage/downloads ]]; then echo "~/storage/downloads exists"; else echo "~/storage/downloads not found"; fi >> setupTermuxArchDebug"$stime".log 
	printf "\\ndf $installdir results:\\n\\n" >> setupTermuxArchDebug"$stime".log
	df "$installdir" >> setupTermuxArchDebug"$stime".log 2>/dev/null ||:
	printf "\\ndf results:\\n\\n" >> setupTermuxArchDebug"$stime".log
	df >> setupTermuxArchDebug"$stime".log 2>/dev/null ||:
	printf "\\ndu -hs $installdir results:\\n\\n" >> setupTermuxArchDebug"$stime".log
	du -hs "$installdir" >> setupTermuxArchDebug"$stime".log 2>/dev/null ||:
	printf "\\nls -al $installdir results:\\n\\n" >> setupTermuxArchDebug"$stime".log
	ls -al "$installdir" >> setupTermuxArchDebug"$stime".log 2>/dev/null ||:
	printf "\\nuname -a results:\\n\\n" >> setupTermuxArchDebug"$stime".log
	uname -a >> setupTermuxArchDebug"$stime".log
	printf "\\nEnd \`setupTermuxArchDebug$stime.log\` debug information.\\n\\nPost this information along with information regarding your issue at https://github.com/sdrausty/TermuxArch/issues.  Include information about input and output.  This debugging information is found in $PWD/$(ls setupTermuxArchDebug"$stime".log).  If you think screenshots will help in resolving this matter better, include them in your post as well.  \\n" >> setupTermuxArchDebug"$stime".log
	cat setupTermuxArchDebug"$stime".log
	printf "\\n\\e[0mSubmit this information if you plan to open up an issue at https://github.com/sdrausty/TermuxArch/issues to improve this installation script along with a screenshot of your topic.  Include information about input and output.  \\n"
}

refreshsys () {
	printf '\033]2; setupTermuxArch.sh refresh 📲 \007'
	nameinstalldir 
	namestartarch  
	setrootdir  
	if [[ ! -d "$installdir" ]] || [[ ! -f "$installdir"/bin/we ]];then
		printf "\\n\\e[0;33mThe root directory structure is incorrect; Cannot continue \\e[1;33msetupTermuxArch.sh refresh\\e[0;33m.\\e[0m\\n"
		exit $?
	fi
	cd "$installdir"
	addae
	addauser
	addauserps
	addauserpsc
	addbash_logout 
	addbash_profile 
	addbashrc 
	addcdtd
	addcdth
	addch 
	adddfa
	addexd
	addfibs
	addga
	addgcl
	addgcm
	addgp
	addgpl
	addkeys
	addmotd
	addmoto
	addpc
	addpci
	addprofile 
	addresolvconf 
	addt 
	addthstartarch
	addtour
	addtrim 
	addyt 
	addwe  
	addv 
	makefinishsetup
	makesetupbin 
	makestartbin 
	setlocalegen
	printf "\\n" 
	printwla 
	am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService > /dev/null
	printdone 
	printf '\033]2; setupTermuxArch.sh refresh 📲 \007'
	printf "\\n\\e[1;32m==> \\e[1;37m%s \\e[1;32m%s %s 📲 \\a\\n" "Running" "$(basename $0)" "$@" 
	"$installdir"/root/bin/setupbin.sh 
	rm -f root/bin/finishsetup.sh
	rm -f root/bin/setupbin.sh 
	printf "\\e[1;34m  The following files have been updated to the newest version.\\n\\n\\e[0;32m"
	ls "$installdir/$startbin" |cut -f7- -d /
	ls "$installdir"/bin/we |cut -f7- -d /
	ls "$installdir"/root/bin/* |cut -f7- -d /
	printf "\\n" 
	printwld 
	am startservice --user 0 -a com.termux.service_wake_unlock com.termux/com.termux.app.TermuxService > /dev/null
	printdone 
	printfooter 
	printf "\\a"
	"$installdir/$startbin" ||:
	printfooter2
# 	printf "\\n\\e[0;32msetupTermuxArch.sh refresh \\e[0m$versionid\\e[1;32m: \\e[0;32mDONE 🏁\\n\\n\\e[0m"'\033]2; setupTermuxArch.sh refresh 🏁 \007'
	exit $?
}
