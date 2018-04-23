#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

dd if=/dev/urandom bs=1K count=100 | hexdump -C >500KBfile.txt ; for i in {1..4}; do echo $i ; sleep 1 ; time nice -n 20 cat 500KBfile.txt ; sleep 2 ; done
