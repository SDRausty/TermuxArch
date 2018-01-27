#!/bin/sh -e 
# Copyright 2017 (c) all rights reserved 
# by S D Rausty https://sdrausty.github.io
#####################################################################
mv .git/config ~/saved_git_config
rm -rf .git
git init
git add .
git commit -m "$($HOME/bin/sn.sh)"
cp ~/saved_git_config .git/config
# git push https://github.com/path/repository --force
