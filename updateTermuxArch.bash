#!/usr/bin/env bash
# Copyright 2017-2020 (c) by TermuxArch, all rights reserved, see LICENSE 🌎 🌍 🌏 🌐 🗺
# https://termuxarch.github.io/TermuxArch courtesy host https://pages.github.com
# this script updates the main git repository and modules
################################################################################
set -Eeuo pipefail

_SGSATRPERROR_() { # run on script error signal
	local RV="$?"
	printf "\\n%s\\n" "$RV"
	printf "\\e[?25h\\n\\e[1;48;5;138mBuildAPKs %s ERROR:  Generated script error %s near or at line number %s by \`%s\`!\\e[0m\\n" "updateTermuxArch.bash" "${3:-VALUE}" "${1:-LINENO}" "${2:-BASH_COMMAND}"
	exit 179
}

_SGSATRPEXIT_() { # run on exit signal
	[[ ! -f .conf/RONGSA ]] && touch .conf/RONGSA
	printf "\\e[?25h\\e[0m"
	set +Eeuo pipefail
	exit
}

_SGSATRPSIGNAL_() { # run on signal signal
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

_GSA_() { # first add, then update modules if run once file exists
	[[ -f .conf/RONGSA ]] && ((git submodule update --depth 1 $3 --init --recursive --remote "$1") || (printf "\\n\\n%s\\n" "Cannot update module $2 : Continuing...")) || ((git submodule add --depth 1 $3 https:/$SIAD$OUNA/$2 $1) || (printf "\\n\\n%s\\n" "Cannot add module $2 : Continuing...")) ; sleep 0."$(shuf -i 24-72 -n 1)" # latency support
}
git pull || printf "\\n\\n%s\\n" "Cannot git pull : Continuing..."
SIAD="$(grep url .git/config | cut -d"=" -f 2 | head -n 1 | cut -d"/" -f 2-3)"
OUNA="/shlibs"
_GSA_ "\.scripts/maintenance" maintenance "" || printf "\\n\\n%s\\n" "Cannot add or update module .scripts/maintenance : Continuing..."
OUNA="/TermuxArch"
_GSA_ docs docsTermuxArch "" || printf "\\n\\n%s\\n" "Cannot add or update module docs : Continuing..."
_GSA_ gen genTermuxArch "" || printf "\\n\\n%s\\n" "Cannot add or update module gen : Continuing..."
_GSA_ scripts "scripts.TermuxArch" "" || printf "\\n\\n%s\\n" "Cannot add or update module scripts : Continuing..."
# updateTermuxArch.bash EOF
