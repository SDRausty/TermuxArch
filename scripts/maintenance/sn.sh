#!/data/data/com.termux/files/usr/bin/sh -e 
# Copyright 2017 (c) all rights reserved by
# SDRausty https://sdrausty.github.io 
# Used for creating the commit message in conjunction with `gr.sh`.
#####################################################################
date=`date +%Y%m%d`
time=`date +%H:%M:%S`
utime=`date +%s`
echo Commit on $date at $time and at $utime in Unix time.
