#!/usr/bin/env bash
# copyright 2020 (c) by SDRausty, all rights reserved, see LICENSE
################################################################################
set -eu
declare LATESTI686
_BOOTISO_() {
qemu-system-i386 -m 512M -nographic -cdrom "$1"
}
[ -f sha512sums ] && printf "%s\\n\\n" "Found sha512sums file." || curl -OL https://mirror.math.princeton.edu/pub/archlinux32/archisos/sha512sums
LATESTI686="$(grep i686 sha512sums |tail -n 1)"
printf "%s\\n\\n" "Found filename '${LATESTI686##* }' with sha512sum ${LATESTI686%% *}."
[ -f "${LATESTI686##* }" ] && printf "%s\\n\\n" "Found filename '${LATESTI686##* }'." || curl -OL "https://mirror.math.princeton.edu/pub/archlinux32/archisos/${LATESTI686##* }"
printf "%s\\n\\n" "Checking file '${LATESTI686##* }' with sha512sum."
LATESTI686ISO="$(sha512sum "${LATESTI686##* }")"
if [[ "$LATESTI686ISO" == "$LATESTI686" ]]
then
_BOOTISO_ "${LATESTI686##* }"
else
printf "%s\\n\\n" "Checking file '${LATESTI686##* }' with sha512sum failed;  Removing files '${LATESTI686##* }' and sha512sums."
rm -f "${LATESTI686##* }" sha512sums
fi
## qemugeti686.bash EOF
