#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

bloom ()
{
	mkdir TermuxArchBloom
	cd TermuxArchBloom
	tar xfv setupTermuxArch.tar.gz
}

printusage ()
{
	printf "\n\n\033[1;34mUsage information for \033[1;32msetupTermuxArch.sh \033[1;34m"
		printf "v0.8 id558937627"
	printf ".  Arguments can abbreviated to one letter; Two letter arguments are acceptable.  For example, \033[1;32mbash setupTermuxArch.sh cs\033[1;34m will use \033[1;32mcurl\033[1;34m to download TermuxArch and produce the \033[1;32msetupTermuxArchdebug.log\033[1;34m file.\n\n\033[1;33mDEBUG\033[1;34m    Use \033[1;32msetupTermuxArch.sh --sysinfo \033[1;34mto create \033[1;32msetupTermuxArchdebug.log\033[1;34m and populate it with debug information.  Post this information along with detailed information about the issue at https://github.com/sdrausty/TermuxArch/issues.  If screenshots will help in resolving the issue better, include them in a post along with information from the debug log file.\n\n\033[1;33mHELP\033[1;34m     Use \033[1;32msetupTermuxArch.sh --help \033[1;34mto output this help screen.\n\n\033[1;33mINSTALL\033[1;34m  Run \033[1;32m./setupTermuxArch.sh\033[1;34m without arguments in a bash shell to install Arch Linux in Termux.  Use \033[1;32mbash setupTermuxArch.sh --curl \033[1;34mto envoke \033[1;32mcurl\033[1;34m as the download manager.  Copy \033[1;32mknownconfigurations.sh\033[1;34m to \033[1;32msetupTermuxArchConfigs.sh\033[1;34m with preferred mirror.  After editing \033[1;32msetupTermuxArchConfigs.sh\033[1;34m, run \033[1;32mbash setupTermuxArch.sh\033[1;34m and \033[1;32msetupTermuxArchConfigs.sh\033[1;34m loads automatically from the same directory.  Change mirror to desired geographic location to resolve download errors.\n\n\033[1;33mPURGE\033[1;34m    Use \033[1;32msetupTermuxArch.sh --uninstall\033[1;34m \033[1;34mto uninstall Arch Linux from Termux.\n"
}


if [[ $1 = [Cc][Pp]* ]] || [[ $1 = -[Cc][Pp]* ]] || [[ $1 = --[Cc][Pp]* ]] || [[ $1 = [Cc][Uu]* ]] || [[ $1 = -[Cc][Uu]* ]] || [[ $1 = --[Cc][Uu]* ]];then
	dm=curl
	intro 
	rmarch
elif [[ $1 = [Cc][Dd]* ]] || [[ $1 = -[Cc][Dd]* ]] || [[ $1 = --[Cc][Dd]* ]] || [[ $1 = [Cc][Ss]* ]] || [[ $1 = -[Cc][Ss]* ]] || [[ $1 = --[Cc][Ss]* ]];then
	dm=curl
	intro 
	sysinfo 
elif [[ $1 = [Cc]* ]] || [[ $1 = -[Cc]* ]] || [[ $1 = --[Cc]* ]] || [[ $1 = [Cc][Ii]* ]] || [[ $1 = -[Cc][Ii]* ]] || [[ $1 = --[Cc][Ii]* ]];then
	dm=curl
	intro 
	mainblock
elif [[ $1 = [Ww][Pp]* ]] || [[ $1 = -[Ww][Pp]* ]] || [[ $1 = --[Ww][Pp]* ]] || [[ $1 = [Ww][Uu]* ]] || [[ $1 = -[Ww][Uu]* ]] || [[ $1 = --[Ww][Uu]* ]];then
	dm=wget
	intro 
	rmarch
elif [[ $1 = [Ww][Dd]* ]] || [[ $1 = -[Ww][Dd]* ]] || [[ $1 = --[Ww][Dd]* ]] || [[ $1 = [Ww][Ss]* ]] || [[ $1 = -[Ww][Ss]* ]] || [[ $1 = --[Ww][Ss]* ]];then
	dm=wget
	intro 
	sysinfo 
elif [[ $1 = [Ww]* ]] || [[ $1 = -[Ww]* ]] || [[ $1 = --[Ww]* ]] || [[ $1 = [Ww][Ii]* ]] || [[ $1 = -[Ww][Ii]* ]] || [[ $1 = --[Ww][Ii]* ]];then
	dm=wget
	intro 
	mainblock
elif [[ $1 = [Dd]* ]] || [[ $1 = -[Dd]* ]] || [[ $1 = --[Dd]* ]] || [[ $1 = [Ss]* ]] || [[ $1 = -[Ss]* ]] || [[ $1 = --[Ss]* ]];then
	intro 
	sysinfo 
elif [[ $1 = [Hh]* ]] || [[ $1 = -[Hh]* ]] || [[ $1 = --[Hh]* ]]  || [[ $1 = [?]* ]] || [[ $1 = -[?]* ]] || [[ $1 = --[?]* ]];then
	printusage
elif [[ $1 = [Pp]* ]] || [[ $1 = -[Pp]* ]] || [[ $1 = --[Pp]* ]] || [[ $1 = [Uu]* ]] || [[ $1 = -[Uu]* ]] || [[ $1 = --[Uu]* ]];then
	intro 
	rmarch
elif [[ $1 = "" ]] || [[ $1 = [Ii]* ]] || [[ $1 = -[Ii]* ]] || [[ $1 = --[Ii]* ]];then
	intro 
	mainblock
else
	printusage
fi
printtail 
