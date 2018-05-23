#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about TermuxArch. 
################################################################################

addtestapp () {
cat > testapp.c <<- EOM
#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
int main() {
	int a = open("nonexistent-test-file-a", O_RDONLY);
	int ae = errno;
	int b = open("nonexistent-test-dir/nonexistent-test-file-b", O_RDONLY);
	int be = errno;
	int c = open("nonexistent-test-file-c", O_RDONLY);
	int ce = errno;
	printf("[%d %d %d %d %d %d]\n", a, ae, b, be, c, ce);
}
	EOM
	chmod 770 testapp.c 
}

clangif () {
	if [ ! -x $PREFIX/bin/clang ];then
		printf "\n\033[1;34mInstalling \033[0;32mclang\033[1;34m…\n\n\033[1;32m"
		pkg install clang --yes 
		printf "\n\033[1;34mInstalling \033[0;32mclang\033[1;34m: \033[1;32mDONE\n\n\033[0m"
	fi
	if [ ! -x $PREFIX/bin/clang ];then
		pe
	fi
}

pe () {
	printf "\n\033[1;31mPrerequisite exception;  Run the script again…\n\n\033[0m"'\033]2;  Thank you for using TermuxArch ktest.sh.  Run `bash ktest.sh` again…\007'
	exit
}

clangif 
addtestapp

printf "\n\033[1;32mPRoot test results:\n\n\033[0m"
clang testapp.c -o testapp
PROOT_NO_SECCOMP=1 proot ./testapp
rm test*
printf "\n\033[0m"'\033]2;  Thank you for using TermuxArch ktest.sh.\007'
