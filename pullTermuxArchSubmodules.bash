#!/usr/bin/env bash
# Copyright 2017-2020 (c) by TermuxArch, all rights reserved, see LICENSE 🌎 🌍 🌏 🌐 🗺
# https://termuxarch.github.io/TermuxArch courtesy host https://pages.github.com
# update git repository, then update modules
################################################################################
set -Eeuo pipefail

_SGSATRPERROR_() { # run on script error signal
	local RV="$?"
	printf "\\n%s\\n" "$RV"
	printf "\\e[?25h\\n\\e[1;48;5;138mBuildAPKs %s ERROR:  Generated script error %s near or at line number %s by \`%s\`!\\e[0m\\n" "updateTermuxArch.bash" "${3:-VALUE}" "${1:-LINENO}" "${2:-BASH_COMMAND}"
	exit 179
}

_SGSATRPEXIT_() { # run on exit signal
	printf "\\e[?25h\\e[0m"
	set +Eeuo pipefail
	exit
}

_SGSATRPSIGNAL_() { # run on signal
	local RV="$?"
	printf "\\e[?25h\\e[1;7;38;5;0mBuildAPKs %s WARNING:  Signal %s received!\\e[0m\\n" "updateTermuxArch.bash" "$RV"
 	exit 178
}

_SGSATRPQUIT_() { # run on quit signal
	local RV="$?"
	printf "\\e[?25h\\e[1;7;38;5;0mBuildAPKs %s WARNING:  Quit signal %s received!\\e[0m\\n" "updateTermuxArch.bash" "$RV"
 	exit 177
}

trap '_SGSATRPERROR_ $LINENO $BASH_COMMAND $?' ERR
trap _SGSATRPEXIT_ EXIT
trap _SGSATRPSIGNAL_ HUP INT TERM
trap _SGSATRPQUIT_ QUIT

_PESTRG_() {
	printf "\\n\\n%s\\n" "Cannot $2 module $1 : Continuing..."
}

_GSA_() { # git repository update modules
	(git submodule update $3 --depth 1 --init --recursive --remote "$1") || _PESTRG_ "$1" update # the command ` git submodule help ` and the book https://git-scm.com/book/en/v2/Git-Tools-Submodules have more information about git submodules
	sleep 0."$(shuf -i 24-72 -n 1)" # latency support
}
git pull || printf "\\n\\n%s\\n" "Cannot git pull : Continuing..."
SIAD="$(grep url .git/config|cut -d"=" -f 2|head -n 1|cut -d"/" -f 2-3)"
OUNA="/shlibs"
_GSA_ "\.scripts/maintenance" maintenance "" || printf "\\n\\n%s\\n" "Cannot add or update module .scripts/maintenance : Continuing..."
OUNA="/TermuxArch"
_GSA_ docs docsTermuxArch "" || printf "\\n\\n%s\\n" "Cannot add or update module docs : Continuing..."
_GSA_ gen genTermuxArch "" || printf "\\n\\n%s\\n" "Cannot add or update module gen : Continuing..."
_GSA_ scripts "scripts.TermuxArch" "" || printf "\\n\\n%s\\n" "Cannot add or update module scripts : Continuing..."
# pullTermuxArchSubmodules.bash EOF
