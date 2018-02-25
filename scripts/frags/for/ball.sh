#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################
#!/bin/bash
C=1
declare -A  BALL

while read color;do
	BALL[${color,,}]=$C
	C=$(( $C + 1 ))
done<"${0/sh/txt}"

echo "Ball $1 is worth ${BALL[${1,,}]}"
