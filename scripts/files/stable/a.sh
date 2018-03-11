#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

addmotd ()
{
cat > motd  <<- EOM
	printf "\033[1;34mWelcome to Arch Linux in Termux!  Enjoy!\nChat:    \033[0mhttps://gitter.im/termux/termux/\n\033[1;34mHelp:    \033[0;34minfo query \033[1;34mand \033[0;34mman query\n\033[1;34mPortal:  \033[0mhttps://wiki.termux.com/wiki/Community\n\n\033[1;34mInstall a package: \033[0;34mpacman -S package\n\033[1;34mMore  information: \033[0;34mpacman [-D|F|Q|R|S|T|U]h\n\033[1;34mSearch   packages: \033[0;34mpacman -Ss query\n\033[1;34mUpgrade  packages: \033[0;34mpacman -Syu\n\033[0m"
	EOM
}
addmotd 
. motd
