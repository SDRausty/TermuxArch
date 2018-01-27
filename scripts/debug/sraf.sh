#!/data/data/com.termux/files/usr/bin/bash -e
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You! 
# Copyright 2017 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Run the following before using `raf.sh` to debug `setupTermuxArch.sh`:
# apt-get -qq update && apt-get -qq upgrade --yes
# apt-get -qq install findutils --yes 
# See README.md for instructions and warning! 
#####################################################################
if [ -d $HOME/arch ] ;then
cd $HOME/arch
rm -rf * 2>/dev/null||:
find -type d -exec chmod 700 {} \; 2>/dev/null||:
cd ..
rm -rf arch
printf "sraf.sh done\n"
else 
printf "sraf.sh exiting\nnothing to do\n"
fi

