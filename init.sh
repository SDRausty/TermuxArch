#!/bin/env sh 
# Copyright 2019 by TermuxArch. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# https://termuxarch.github.io/TermuxArch/ has info about this project. 
# https://termuxarch.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
# Invocation : sh $HOME/init.sh 
################################################################################

STRING="Command \`au\` enables rollback; Available at https://github.com/sdrausty/au : Continuing..."
printf "%s\\n" "Beginning TermuxArch init.sh:"
for CMD in au pkg
do
       	[ ! -z "$(command -v "$CMD")" ] && ("$CMD" lftp busybox) || (printf "\\e[1;38;5;117m%s\\n" "$STRING") 
done
cd "$PREFIX/bin/applets/"
ln -s ../busybox awk
ln -s ../busybox md5sum
ln -s ../busybox rev
ln -s ../busybox sha512sum
ln -s ../busybox tar
ln -s ../busybox uname
bash "$HOME"/setupTermuxArch.sh # h for more information

#EOF
