#!/data/data/com.termux/files/usr/bin/sh -e 
# Copyright 2017 (c) all rights reserved 
# by S D Rausty https://sdrausty.github.io
# Update repository and initialize and update submodules. 
#####################################################################
git pull 
git submodule init
git submodule update
