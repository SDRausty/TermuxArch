#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

sysinfo() {
	spaceinfo
	printf "\\n\\e[1;32m"
	printf "Begin setupTermuxArch debug information.\\n" > setupTermuxArchDebug"$stime".log
	systeminfo & spinner "System Info" "in Progress" ||:
}

systeminfo () {
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
	if [[ -d $HOME/downloads ]]; then echo "$HOME/downloads exists"; else echo "~/downloads not found"; fi >> setupTermuxArchDebug"$stime".log 
	if [[ -d $HOME/storage/downloads ]]; then echo "$HOME/storage/downloads exists"; else echo "$HOME/storage/downloads not found"; fi >> setupTermuxArchDebug"$stime".log 
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
	printf "\\n\\e[0mSubmit this information if you plan to open up an issue at https://github.com/sdrausty/TermuxArch/issues to improve this installation script along with a screenshot of your topic.  Include information about input and output.  \\n\\n"
}

copyimage() { 
	cfile="${1##/*/}" 
 	file="$cfile" 
	if [[ "$lc" = "" ]];then
		cp "$1".md5  "$installdir" & spinner "Copying ${cfile}.md5" "in Progress" ||:
		cp "$1" "$installdir" & spinner "Copying $cfile" "in Progress" ||:
	elif [[ "$lc" = "1" ]];then
		cp "$idir/$cfile".md5  "$installdir" & spinner "Copying ${cfile}.md5" "in Progress" ||:
		cp "$idir/$cfile" "$installdir" & spinner "Copying $cfile" "in Progress" ||:
	fi
}

loadimage() { 
	set +Ee
	namestartarch 
	prepinstalldir
 	spaceinfo
	wakelock
	prepinstalldir 
	copyimage "$@"
	printmd5check
	md5check
	printcu 
	rm -f "$installdir"/*.tar.gz "$installdir"/*.tar.gz.md5
	printdone 
	makestartbin 
	printconfigup 
	touchupsys 
	wakeunlock 
	printfooter
	"$installdir/$startbin" ||:
	"$startbin" help
	printfooter2
}

refreshsys() {
	# Refreshes
	printf '\033]2; setupTermuxArch.sh refresh 📲 \007'
	nameinstalldir 
	namestartarch  
	setrootdir  
	mkdir -p "$installdir"/root/bin
	if [[ ! -d "$installdir" ]] || [[ ! -f "$installdir"/bin/env ]];then
		printf "\\n\\e[0;33m%s\\e[1;33m%s\\e[0;33m.\\e[0m\\n" "The root directory structure is incorrect; Cannot continue " "setupTermuxArch.sh refresh"
		exit $?
	fi
	cd "$installdir"
	addREADME
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
	addfake_proc_stat
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
	setlocale
	printf "\\n" 
	printwla 
	am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService > /dev/null
	printdone 
	printf '\033]2; setupTermuxArch.sh refresh 📲 \007'
	printf "\\n\\e[1;32m==> \\e[1;37m%s \\e[1;32m%s %s 📲 \\a\\n" "Running" "$(basename "$0")" "$args" 
	"$installdir"/root/bin/setupbin.sh 
 	rm -f root/bin/finishsetup.sh
 	rm -f root/bin/setupbin.sh 
	printf "\\e[1;34mThe following files have been updated to the newest version.\\n\\n\\e[0;32m"
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
	"$startbin" help
	printfooter2
}

#EOF
