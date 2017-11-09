#!/data/data/com.termux/files/usr/bin/sh -e 
# Copyright 2017 (c) all rights reserved by
# SDRausty https://sdrausty.github.io 
#####################################################################
find . -type f -exec chmod 600 {} \;
find . -type f -name "*sh" -exec chmod 700 {} \;
find . -type d -exec chmod 700 {} \;
