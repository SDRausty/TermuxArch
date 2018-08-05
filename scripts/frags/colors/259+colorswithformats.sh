#!/bin/bash -e
# Copyright 2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/wae courtesy https://pages.github.com
# https://sdrausty.github.io/wae/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/wae/README has information about wae. 
################################################################################

for attr2 in 38 48 ; do # Foreground / Background
	for attr0 in {0..258} ; do # Colors
		for attr3 in {0..4} {7..9} ; do 
#			Display the color
			printf "\\e[%s;%s;5;%sm  %s %-3s  \\e[0m" "$attr3" "$attr2" "$attr0" "$attr3" "$attr0" 
#		Display 10 colors per lines
			if [ $(((attr0 + 1) % 10)) == 10 ] ; then
				printf "\\e[0m\\n\\n" # New line
			fi
		done
		echo # New line
	done
done
 
exit 0
