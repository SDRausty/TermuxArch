#!/bin/sh -e 
# Copyright 2017-2018 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
#############################################################################
cat CHANGE.log
gsn.sh >> CHANGE.log
cat CHANGE.log
du -hs .git >> CHANGE.log
du -hs >> CHANGE.log
cat CHANGE.log
