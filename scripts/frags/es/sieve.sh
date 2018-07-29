#!/usr/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
# sieve.sh 
# Ref Example 27-13. The Sieve of Eratosthenes
# tldp.org/LDP/abs/html/arrays.html
# Must invoke with command-line argument (limit of primes).
# -------------------------------------------------------- #
# https://www.bing.com/search?q="Sieve of Eratosthenes"
################################################################################

if test "$BASH" = "" || "$BASH" -uc "a=();true \"\${a[@]}\"" 2>/dev/null;then
#	Bash 4.4, Zsh
	set -euo pipefail
else
#	Bash 4.3 and older chokes on empty arrays with set -u.
	set -eo pipefail
fi
shopt -s nullglob globstar

UPPER_LIMIT="$1"                  # From command-line.
(( SPLIT=UPPER_LIMIT/2 ))         # Halfway to max number.

declare -a Primes
mapfile -t Primes < <(seq "$UPPER_LIMIT")

i=1
until (( ( i += 1 ) > SPLIT ))  # Need check only halfway.
do
       	if [[ -n "${Primes[i]}" ]]
       	then
	       	t="$i"
	       	until (( ( t += i ) > UPPER_LIMIT ))
	       	do
		       	Primes[t]=
	       	done
       	fi  
done  
echo "${Primes[*]}"

exit $?
