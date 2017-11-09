#!/data/data/com.termux/files/usr/bin/sh -e 
# Copyright 2017 (c) all rights reserved 
# by S D Rausty https://sdrausty.github.io
#####################################################################
mv .git/config ~/saved_git_config
rm -rf .git
git init
git add .
git commit -m "$($HOME/TermuxArch/scripts/maintenance/sn.sh)"
cp ~/saved_git_config .git/config
git push master --force 
