#!/usr/bin/env bash
# copyright 2020 (c) by SDRausty, all rights reserved, see LICENSE
################################################################################
set -eu
declare X86REALEASE
_INST_() { # checks for neccessary commands
COMMS="$1"
STRING1="COMMAND 'au' enables rollback, available at https://wae.github.io/au/ IS NOT FOUND: Continuing... "
STRING2="Cannot update ~/${0##*/} prerequisite: Continuing..."
COMMANDR="$(command -v au)" || (printf "%s\\n\\n" "$STRING1")
COMMANDIF="${COMMANDR##*/}"
PKG="$2"
_INPKGS_() {
printf "%s\\n" "Beginning qemu 'qemu-system-i386' setup:"
if [ "$COMMANDIF" = au ]
then
au "$PKG" || printf "%s\\n" "$STRING2"
else
apt install "$PKG" || printf "%s\\n" "$STRING2"
fi
}
if ! command -v "$COMMS"
then
_INPKGS_
fi
}
_BOOTISO_() {
qemu-system-i386 -m 512M -nographic -cdrom "$1"
}
_PSGI1ESTRING_() {	# print signal generated in arg 1 format
printf "\\e[1;33mSIGNAL GENERATED in %s\\e[1;34m : \\e[1;32mCONTINUING...  \\e[0;34mExecuting \\e[0;32m%s\\e[0;34m in the native shell once the installation and configuration process completes will attempt to finish the autoconfiguration and installation if the installation and configuration processes were not completely successful.  Should better solutions for \\e[0;32m%s\\e[0;34m be found, please open an issue and accompanying pull request if possible.\\nThe entire script can be reviewed by creating a \\e[0;32m%s\\e[0;34m directory with the command \\e[0;32m%s\\e[0;34m which can be used to access the entire installation script.  This option does NOT configure and install the root file system.  This command transfers the entire script into the home directory for hacking, modification and review.  The command \\e[0;32m%s\\e[0;34m has more information about how to use use \\e[0;32m%s\\e[0;34m in an effective way.\\e[0;32m%s\\e[0m\\n" "'$1'" "'bash ${0##*/} refresh'" "'${0##*/}'" "'~/TermuxArchBloom/'" "'setupTermuxArch b'" "'setupTermuxArch help'" "'${0##*/}'"
}
if ! command -v qemu-system-i386
then
_INST_ qemu-system-i386 qemu-system-i386-headless "${0##*/}" || _PSGI1ESTRING_ "_INST_ qemu-system-i386 ${0##*/}"
fi
[ -f alpinev3.12releasesx86 ] && printf "%s\\n\\n" "Found alpinev3.12releasesx86 file." || (printf "%s\\n\\n" "Downloading index into alpinev3.12releasesx86 file from https://dl-cdn.alpinelinux.org." && curl -0 https://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86/ -o alpinev3.12releasesx86)
X86REALEASESHA="$(sed -n '/^$/!{s/<[^>]*>//g;p;}' alpinev3.12releasesx86 | awk '/virt/' | awk '/sha512/' | awk 'END{print}'|  awk '{print$1}')"
[ -f "$X86REALEASESHA" ] && printf "%s\\n\\n" "Found $X86REALEASESHA file." || (printf "%s\\n\\n" "Downloading $X86REALEASESHA file from https://dl-cdn.alpinelinux.org." && curl -0 "https://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86/$X86REALEASESHA" -o "$X86REALEASESHA")
X86REALEASE="$(awk '{print$2}' "$X86REALEASESHA")"
[ -f "$X86REALEASE" ] && printf "%s\\n\\n" "Found $X86REALEASE file." || (printf "%s\\n\\n" "Downloading $X86REALEASE file from https://dl-cdn.alpinelinux.org." && curl -C - --fail --retry 4 -0 "https://dl-cdn.alpinelinux.org/alpine/v3.12/releases/x86/$X86REALEASE" -o "$X86REALEASE")
if [ ! -f "checked${X86REALEASE##* }" ]
then
printf "%s\\n\\n" "Checking file '${X86REALEASE##* }' with sha512sum."
if sha512sum "$X86REALEASESHA"
then
touch "checked${X86REALEASE##* }"
_BOOTISO_ "${X86REALEASE##* }"
else
printf "%s\\n\\n" "Checking file '${X86REALEASE##* }' with sha512sum failed;  Removing files '${X86REALEASE##* }' and sha512sums."
# rm -f "${X86REALEASE##* }" sha512sums
fi
else
_BOOTISO_ "${X86REALEASE##* }"
fi
## qemualpinex86.bash EOF
