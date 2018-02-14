#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

sysinfo ()
{
	ntime=`date +%N`
	spaceinfo
	printf "\n\033[1;32m"
	printf "Begin setupTermuxArch debug information.\n" > setupTermuxArchdebug$ntime.log
	printf "\nDisk report $usrspace on /data `date`\n\n" >> setupTermuxArchdebug$ntime.log 
	for n in 0 1 2 3 4 5 
	do 
		echo "BASH_VERSINFO[$n] = ${BASH_VERSINFO[$n]}"  >> setupTermuxArchdebug$ntime.log
	done
	printf "\ncat /proc/cpuinfo results:\n\n" >> setupTermuxArchdebug$ntime.log
	cat /proc/cpuinfo >> setupTermuxArchdebug$ntime.log
	printf "\ndpkg --print-architecture result:\n\n" >> setupTermuxArchdebug$ntime.log
	dpkg --print-architecture >> setupTermuxArchdebug$ntime.log
	printf "\ngetprop ro.product.cpu.abi result:\n\n" >> setupTermuxArchdebug$ntime.log
	getprop ro.product.cpu.abi >> setupTermuxArchdebug$ntime.log
	printf "\ngetprop ro.product.device result:\n\n" >> setupTermuxArchdebug$ntime.log
	getprop ro.product.device >> setupTermuxArchdebug$ntime.log
	printf "\nDownload directory information results.\n\n" >> setupTermuxArchdebug$ntime.log
	ls -al ~/storage/downloads  2>>setupTermuxArchdebug$ntime.log >> setupTermuxArchdebug$ntime.log 2>/dev/null ||:
	ls -al ~/downloads 2>>setupTermuxArchdebug$ntime.log  >> setupTermuxArchdebug$ntime.log 2>/dev/null ||:
	if [ -d /sdcard/Download ]; then echo "/sdcard/Download exists"; else echo "/sdcard/Download not found"; fi >> setupTermuxArchdebug$ntime.log 
	if [ -d /storage/emulated/0/Download ]; then echo "/storage/emulated/0/Download exists"; else echo "/storage/emulated/0/Download not found"; fi >> setupTermuxArchdebug$ntime.log
	printf "\nuname -mo results:\n\n" >> setupTermuxArchdebug$ntime.log
	uname -mo >> setupTermuxArchdebug$ntime.log
	printf "\nEnd \`setupTermuxArch.sh\` debug information.\n\nPost this information along with information regarding your issue at https://github.com/sdrausty/TermuxArch/issues.  Include information about input and output.  This debugging information is found in $(pwd)/$(ls setupTermuxArchdebug$ntime.log).  If you think screenshots will help in resolving this matter better, include them in your post please.  \n" >> setupTermuxArchdebug$ntime.log
	cat setupTermuxArchdebug$ntime.log
	printf "\n\033[0mSubmit this information if you plan to open up an issue at https://github.com/sdrausty/TermuxArch/issues to improve this installation script along with a screenshot of your topic.  Include information about input and output.  \n"
}

