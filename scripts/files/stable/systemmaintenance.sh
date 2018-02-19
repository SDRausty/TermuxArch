#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

sysinfo ()
{
	spaceinfo
	printf "\n\033[1;32m"
	printf "Begin setupTermuxArch debug information.\n" > setupTermuxArchDebug$stime.log
	printf "\nDisk report $usrspace on /data `date`\n\n" >> setupTermuxArchDebug$stime.log 
	for n in 0 1 2 3 4 5 
	do 
		echo "BASH_VERSINFO[$n] = ${BASH_VERSINFO[$n]}"  >> setupTermuxArchDebug$stime.log
	done
	printf "\ncat /proc/cpuinfo results:\n\n" >> setupTermuxArchDebug$stime.log
	cat /proc/cpuinfo >> setupTermuxArchDebug$stime.log
	printf "\ndpkg --print-architecture result:\n\n" >> setupTermuxArchDebug$stime.log
	dpkg --print-architecture >> setupTermuxArchDebug$stime.log
	printf "\ngetprop ro.product.cpu.abi result:\n\n" >> setupTermuxArchDebug$stime.log
	getprop ro.product.cpu.abi >> setupTermuxArchDebug$stime.log
	printf "\ngetprop ro.product.device result:\n\n" >> setupTermuxArchDebug$stime.log
	getprop ro.product.device >> setupTermuxArchDebug$stime.log
	printf "\nDownload directory information results.\n\n" >> setupTermuxArchDebug$stime.log
	ls -al ~/storage/downloads  2>>setupTermuxArchDebug$stime.log >> setupTermuxArchDebug$stime.log 2>/dev/null ||:
	ls -al ~/downloads 2>>setupTermuxArchDebug$stime.log  >> setupTermuxArchDebug$stime.log 2>/dev/null ||:
	if [ -d /sdcard/Download ]; then echo "/sdcard/Download exists"; else echo "/sdcard/Download not found"; fi >> setupTermuxArchDebug$stime.log 
	if [ -d /storage/emulated/0/Download ]; then echo "/storage/emulated/0/Download exists"; else echo "/storage/emulated/0/Download not found"; fi >> setupTermuxArchDebug$stime.log
	printf "\ndu -hs $HOME$rootdir results:\n\n" >> setupTermuxArchDebug$stime.log
	du -hs $HOME$rootdir >> setupTermuxArchDebug$stime.log 2>/dev/null ||:
	printf "\nls -al $HOME$rootdir results:\n\n" >> setupTermuxArchDebug$stime.log
	ls -al $HOME$rootdir >> setupTermuxArchDebug$stime.log 2>/dev/null ||:
	printf "\nuname -a results:\n\n" >> setupTermuxArchDebug$stime.log
	uname -a >> setupTermuxArchDebug$stime.log
	printf "\nEnd \`setupTermuxArchDebug$stime.log\` debug information.\n\nPost this information along with information regarding your issue at https://github.com/sdrausty/TermuxArch/issues.  Include information about input and output.  This debugging information is found in $(pwd)/$(ls setupTermuxArchDebug$stime.log).  If you think screenshots will help in resolving this matter better, include them in your post as well.  \n" >> setupTermuxArchDebug$stime.log
	cat setupTermuxArchDebug$stime.log
	printf "\n\033[0mSubmit this information if you plan to open up an issue at https://github.com/sdrausty/TermuxArch/issues to improve this installation script along with a screenshot of your topic.  Include information about input and output.  \n"
}

