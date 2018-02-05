#!/bin/sh 
# Copyright 2017-2018 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
#############################################################################

cdir=${PWD##*/}        
#cdir=${pwd |sed 's!.*/!!'}
date=`date +%Y%m%d`
ntime=`date +%N`
time=`date +%H:%M:%S`
utime=`date +%s`
ymnth=`date +%Y%m`
msg="Running v0.5.$ntime from branch master hosted at https://sdrausty.github.io/TermuxArch"
echo "printf \"$msg\""
ms="		printf \"$msg\""

sed -i "/Using/c\\$ms" setupTermuxArch.sh 

cp setupTermuxArch.sh ../../..
ls -al setupTermuxArch.sh 
pwd
md5sum *sh > termuxarchchecksum.md5 
cd ../../..
pwd
bsdtar -czv -f setupTermuxArch.tar.gz --strip-components 3 scripts/files/$cdir/*
rm scripts/files/$cdir/termuxarchchecksum.md5
md5sum setupTermuxArch.tar.gz > setupTermuxArch.md5
pwd
ls -al setupTermuxArch.md5
ls -al setupTermuxArch.sh 
ls -al setupTermuxArch.tar.gz 

