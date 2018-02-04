#!/bin/sh -e 
# Copyright 2017-2018 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
#############################################################################
mv .git/config ~/saved_git_config
rm -rf .git
git init
git add .
git commit -m "$($HOME/bin/sn.sh)"
cp ~/saved_git_config .git/config
printf "\n\n\`git push https://github.com/path/repository --force"
# git push https://github.com/path/repository --force
# git push master --force
