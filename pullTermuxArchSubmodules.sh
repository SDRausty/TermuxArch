#!/bin/env sh
# Copyright 2019 (c) all rights reserved 
# by S D Rausty https://sdrausty.github.io
# Update repository and update submodules.
#####################################################################
set  -e 

git pull 
git submodule update --init 
git submodule update --init --recursive --remote

# pullTermuxArchSubmodules.sh EOF
