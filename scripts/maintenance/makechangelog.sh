#!/bin/sh -e 
# Copyright 2017-2018 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
#############################################################################
gsn.sh >> CHANGE.log
du -hs .git >> CHANGE.log
du -hs >> CHANGE.log
#git push master --force 
