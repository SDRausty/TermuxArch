#!/bin/bash -e
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You! 
# Copyright 2017 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# If you are encountering issues regarding systemimage.tar.gz download or md5checksum, edit this script and change $mirror to your desired geographic location in knownconfigurations.sh.
################################################################################

printf '\033]2;  Thank you for using `setupTermuxArch.sh` 📲 \007'"\n\033[0m 🕛 \033[34;1m<\033[0m 🕛This setup script will attempt to set Arch Linux up in your Termux environment.  When successfully completed, you will be enjoying the bash prompt in Arch Linux in Termux on your smartphone or tablet.  \033[32;1mUpdating Termux and installing the required components for Arch Linux in Termux installation. This will take some time.  \033[0mIf you do not see 🕐 one o'clock below after updating Termux and installing the required components for Arch Linux in Termux installation is completed, run this script again. You might want to check your Internet connection too.  \n\n"

apt-get -qq update && apt-get -qq upgrade --yes
apt-get -qq install bsdtar proot termux-exec wget --yes 

depend ()
{
wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/archsystemconfigs.sh
wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/knownconfigurations.sh
wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/necessaryfunctions.sh
wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/printoutstatements.sh
wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/setupTermuxArch.sh
wget -q -N --show-progress https://raw.githubusercontent.com/sdrausty/TermuxArch/master/termuxarchchecksum.md5
. ./archsystemconfigs.sh
. ./knownconfigurations.sh
. ./necessaryfunctions.sh
. ./printoutstatements.sh
}

# Main Block
termux-wake-lock
depend 
callsystem 
$HOME/arch/$bin ||:
printtail
termux-wake-unlock
exit 

