#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################
t1=Red
t2=Yellow
t3=Green
t4=Brown
t5=Blue
t6=Pink
t7=Black

case $1 in
 $t1) echo "The red ball is worth 1 point."         ;;
 $t2) echo "The yellow ball is worth 2 points."     ;;
 $t3) echo "The green ball is worth 3 points."      ;;
 $t4) echo "The brown ball is worth 4 points."      ;;
 $t5) echo "The blue ball is worth 5 points."       ;;
 $t6) echo "The pink ball is worth 6 points."       ;;
 $t7) echo "The black ball is worth 7 points."      ;;
 *)   echo "Any other option is a foul."            ;;
esac
