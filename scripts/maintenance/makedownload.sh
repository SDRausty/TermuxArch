#!/bin/sh 
# Copyright 2017 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
#############################################################################

cp setupTermuxArch.sh ../../..
ls -al setupTermuxArch.sh 
pwd
md5sum *sh > termuxarchchecksum.md5 
cd ../../..
pwd
bsdtar -czv -f setupTermuxArch.tar.gz --strip-components 3 scripts/files/stable/*
rm scripts/files/stable/termuxarchchecksum.md5
md5sum setupTermuxArch.tar.gz > setupTermuxArch.md5
pwd
ls -al setupTermuxArch.md5
ls -al setupTermuxArch.sh 
ls -al setupTermuxArch.tar.gz 
