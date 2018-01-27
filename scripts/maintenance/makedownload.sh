#!/bin/sh 
# Copyright 2017-2018 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
#############################################################################

cdir=${PWD##*/}        
cp setupTermuxArch.sh ../../..
md5sum *sh > termuxarchchecksum.md5 
cd ../../..
bsdtar -czv -f setupTermuxArch.tar.gz --strip-components 3 scripts/files/$cdir/*
rm scripts/files/$cdir/termuxarchchecksum.md5
md5sum setupTermuxArch.tar.gz > setupTermuxArch.md5

