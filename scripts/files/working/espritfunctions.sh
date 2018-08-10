#!/bin/env bash
# Copyright 2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about TermuxArch. 
################################################################################

spinner() { # Based on https://github.com/ringohub/sh-spinner
 	printf "\\e[?25l"
 	SPINNER="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
	task=$1
	msg=$2
	while :; do
		jobs %1 > /dev/null 2>&1
		[ $? = 0 ] || {
			printf "${CL}✓ ${task} Done       \n"
			break
		}
		for (( i=0; i<${#SPINNER}; i++ )); do
			sleep 0.05
			printf "${CL}${SPINNER:$i:1} ${task} ${msg}\r"
		done
	done
 	printf "\\e[?25h"
}
