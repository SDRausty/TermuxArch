#!/bin/env sh
# Copyright 2019 (c) all rights reserved by S D Rausty; see LICENSE  
# https://sdrausty.github.io hosted courtesy https://pages.github.com
#####################################################################
set -eu
IVIDV=$(cat .conf/VERSIONID)
PVIDV=${IVIDV%.*} # http://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Shell-Parameter-Expansion 
SVIDV=${IVIDV##*.} 
NSVIDV=$((SVIDV + 1))
echo $PVIDV.$NSVIDV > .conf/VERSIONID 
cat .conf/VERSIONID 
# vgen.sh EOF
