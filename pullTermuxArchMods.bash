#!/usr/bin/env bash
## Copyright 2017-2022 (c) by TermuxArch, all rights reserved, see LICENSE 🌎 🌍 🌏 🌐 🗺
## https://termuxarch.github.io/TermuxArch courtesy host https://pages.github.com
## update git repository, then update modules
################################################################################
set -Eeuo pipefail

_SGSATRPERROR_() { # run on script error signal
local RV="$?"
printf "\\n%s\\n" "$RV"
printf "\\e[?25h\\n\\e[1;48;5;138mBuildAPKs %s ＴｅｒｍｕｘＡｒｃｈ SIGNAL:  Generated script error %s near or at line number %s by \`%s\`!\\e[0m\\n" "updateTermuxArch.bash" "${3:-VALUE}" "${1:-LINENO}" "${2:-BASH_COMMAND}"
exit 179
}

_SGSATRPEXIT_() { # run on exit signal
printf "\\e[?25h\\e[0m"
set +Eeuo pipefail
exit
}

_SGSATRPSIGNAL_() { # run on signal
local RV="$?"
printf "\\e[?25h\\e[1;7;38;5;0mＴｅｒｍｕｘＡｒｃｈ %s NOTICE:  Signal %s received!\\e[0m\\n" "${0##*/}" "$RV"
exit 178
}

_SGSATRPQUIT_() { # run on quit signal
local RV="$?"
printf "\\e[?25h\\e[1;7;38;5;0mＴｅｒｍｕｘＡｒｃｈ %s NOTICE:  Quit signal %s received!\\e[0m\\n" "${0##*/}" "$RV"
exit 177
}

trap '_SGSATRPERROR_ $LINENO $BASH_COMMAND $?' ERR
trap _SGSATRPEXIT_ EXIT
trap _SGSATRPSIGNAL_ HUP INT TERM
trap _SGSATRPQUIT_ QUIT

RDR="$PWD"
_GSA_() { # git repository update modules
WRDR="$1"
{ git submodule update --depth 1 --init --recursive --remote "$1" && _PRCS_ ; } || { git submodule add --depth 1 https://github.com/"$3"/"$2" "$1" && _PRCS_ ; } || _PESTRG_ "$1" update # the command ` git submodule help ` and the book https://git-scm.com/book/en/v2/Git-Tools-Submodules have more information about git submodules
}

_PESTRG_() {
printf "\\n\\n%s\\n" "Cannot $2 module $1; Continuing..."
}

_PRCS_ () {	# print checksums message and run sha512sum
cd "$WRDR"
if [[ -f sha512.sum ]]
then
_PRT_ "Checking checksums in directory $PWD with sha512sum: "
sha512sum -c --quiet sha512.sum || printf "%s\\n" "sha512sum -c sha512.sum FAILED!"
_PRNT_  "DONE"
else
printf "%s\\n" "No 'sha512.sum' file found in directory $PWD."
fi
cd "$RDR"
sleep 0."$(shuf -i 24-72 -n 1)" # latency support
}

_PRT_ () {	# print message with no trialing newline
printf "%s" "$1"
}

_PRNT_ () {	# print message with one trialing newline
printf "%s\\n" "$1"
}

git pull || printf "\\n\\n%s\\n" "Cannot git pull; Continuing..."
if grep '\.\/\.git\/' sha512.sum 1>/dev/null || grep '\.\/\.scripts\/maintenance\/' sha512.sum 1>/dev/null || grep '\.\/docs\/' sha512.sum 1>/dev/null || grep '\.\/gen\/' sha512.sum 1>/dev/null
then
sed -i '/\.\/\.git\//d' sha512.sum
sed -i '/\.\/\.scripts\/maintenance\//d' sha512.sum
sed -i '/\.\/docs\//d' sha512.sum
sed -i '/\.\/gen\//d' sha512.sum
fi
sha512sum -c --quiet sha512.sum || _PRNT_ "ＴｅｒｍｕｘＡｒｃｈ NOTICE:  Checking checksums in directory $PWD with sha512sum FAILED! "
_GSA_ ".scripts/maintenance" maintenance shlibs || printf "\\n\\n%s\\n" "Cannot add or update module .scripts/maintenance; Continuing..."
_GSA_ docs docsTermuxArch TermuxArch || printf "\\n\\n%s\\n" "Cannot add or update module docs; Continuing..."
_GSA_ gen genTermuxArch TermuxArch || printf "\\n\\n%s\\n" "Cannot add or update module gen; Continuing..."
_GSA_ scripts "scripts.TermuxArch" TermuxArch || printf "\\n\\n%s\\n" "Cannot add or update module scripts; Continuing..."
# pullTermuxArchSubmodules.bash FE
