#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

editors ()
{
	ceds=""
	if [ -e $PREFIX/bin/applets/vi ];then
		ceds+="vi "
	fi
	if [ -e $PREFIX/bin/emacs ];then
		ceds+="emacs "
	fi
	if [ -e $PREFIX/bin/joe ];then
		ceds+="joe "
	fi
	if [ -e $PREFIX/bin/jupp ];then
		ceds+="jupp "
	fi
	if [ -e $PREFIX/bin/micro ];then
		ceds+="micro "
	fi
	if [ -e $PREFIX/bin/nano ];then
		ceds+="nano "
	fi
	if [ -e $PREFIX/bin/ne ];then
		ceds+="ne "
	fi
	if [ -e $PREFIX/bin/nvim ];then
		ceds+="nvim "
	fi
	if [ -e $PREFIX/bin/vim ];then
		ceds+="vim "
	fi
	if [ -e $PREFIX/bin/zile ];then
		ceds+="zile "
	fi

# In a 'for' loop (really, a type of disguised assignment):
echo -n "Values of \"a\" in the loop are: "
for a in {0..8}
do
  echo -n "$a "
done

echo
echo

	echo $ceds
declare -i edcnt="$( echo $ceds | wc -w )"
	echo $edcnt
declare -i edcnt             # Declaring it an integer doesn't help.
	echo $edcnt
	printf '%s\n' "${ceds[@]}"
	for t in "${ceds[@]}"
do
echo $t[@]
done
	for i in {0..$edcnt}; do
#	for i in {0..5}; do
		ceds[i]="ceds $i"  # dynamically create element with index $i
#		ceds[i]="$ceds[$i]"  # dynamically create element with index $i
	done
	printf '%s\n' "${ceds[@]}"
}

editors
