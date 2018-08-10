#!/bin/env bash
# Copyright 2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about TermuxArch. 
################################################################################
sp="/-\|"
sc=0
spin() {
	printf "\\b${sp:sc++:1}"
	((sc==${#sp})) && sc=0
}

spinner() { 
	printf "\\e[0m"
	while $1 ;do
		spin 
	done
}

spinne() { 
	printf "\\e[0m"
	until $1; do
		spin
	done
}
