#!/bin/sh 
# Copyright 2017-2018 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
# `makedownload.sh` should be run in `TermuxArch/scripts/files/working`.
#############################################################################

cdir=${PWD##*/}        
#cdir=${pwd |sed 's!.*/!!'}
date=`date +%Y%m%d`
ntime=`date +%N`
time=`date +%H:%M:%S`
utime=`date +%s`
ymnth=`date +%Y%m`
msg="Running v0.9.2 rev$ntime from branch master hosted at https://sdrausty.github.io/TermuxArch"
echo "printf \"$msg\""
ms="		printf \"$msg\""

sed -i "/Using/c\\$ms" setupTermuxArch.sh 

cp setupTermuxArch.sh ../../..
ls -al setupTermuxArch.sh 
pwd
sha512sum *sh > termuxarchchecksum.sha512
cd ../../..
pwd
bsdtar -czv -f setupTermuxArch.tar.gz --strip-components 3 scripts/files/$cdir/*
rm scripts/files/$cdir/termuxarchchecksum.sha512
md5sum setupTermuxArch.tar.gz > setupTermuxArch.sha512
pwd
ls -al setupTermuxArch.sha512
ls -al setupTermuxArch.sh 
ls -al setupTermuxArch.tar.gz 

