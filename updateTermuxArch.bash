#!/usr/bin/env bash
# Copyright 2019-2020 (c) all rights reserved
# by S D Rausty https://termuxarch.github.io/TermuxArch/
# this script updates the main git repository and its' modules
#####################################################################
set -Eeuo pipefail

_SGSATRPERROR_() { # Run on script error.
	local RV="$?"
	printf "\\n%s\\n" "$RV"
	printf "\\e[?25h\\n\\e[1;48;5;138mBuildAPKs %s ERROR:  Generated script error %s near or at line number %s by \`%s\`!\\e[0m\\n" "updateTermuxArch.bash" "${3:-VALUE}" "${1:-LINENO}" "${2:-BASH_COMMAND}"
	exit 179
}

_SGSATRPEXIT_() { # Run on exit.
	printf "\\e[?25h\\e[0m"
	set +Eeuo pipefail
	exit
}

_SGSATRPSIGNAL_() { # Run on signal.
	local RV="$?"
	printf "\\e[?25h\\e[1;7;38;5;0mBuildAPKs %s WARNING:  Signal %s received!\\e[0m\\n" "updateTermuxArch.bash" "$RV"
 	exit 178
}

_SGSATRPQUIT_() { # Run on quit.
	local RV="$?"
	printf "\\e[?25h\\e[1;7;38;5;0mBuildAPKs %s WARNING:  Quit signal %s received!\\e[0m\\n" "updateTermuxArch.bash" "$RV"
 	exit 177
}

trap '_SGSATRPERROR_ $LINENO $BASH_COMMAND $?' ERR
trap _SGSATRPEXIT_ EXIT
trap _SGSATRPSIGNAL_ HUP INT TERM
trap _SGSATRPQUIT_ QUIT

_GSA_() { # add or update module 
	[[ -f .cong/RONGSA ]] && ((git submodule update --init --recursive --remote "$1") || (printf "\\n\\n%s\\n" "Cannot update module $2 : Continuing...")) || ((git submodule add $3 https:/$SIAD$OUNA/$2 $1 && touch .conf/RONGSA) || (printf "\\n\\n%s\\n" "Cannot add module $2 : Continuing..."))
	 sleep 0."$(shuf -i 24-72 -n 1)"	# latency support
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
