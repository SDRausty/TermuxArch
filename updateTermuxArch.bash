#!/usr/bin/env bash
# Copyright 2019-2020 (c) all rights reserved
# by S D Rausty https://termuxarch.github.io/TermuxArch/
# This script updates the main git repository and its' submodules.
#####################################################################
set -Eeuo pipefail

_SGSATRPERROR_() { # Run on script error.
	local RV="$?"
	printf "\\n%s\\n" "$RV"
	printf "\\e[?25h\\n\\e[1;48;5;138mBuildAPKs %s ERROR:  Generated script error %s near or at line number %s by \`%s\`!\\e[0m\\n" "gsa.bash" "${3:-VALUE}" "${1:-LINENO}" "${2:-BASH_COMMAND}"
	exit 179
}

_SGSATRPEXIT_() { # Run on exit.
	printf "\\e[?25h\\e[0m"
	set +Eeuo pipefail
	exit
}

_SGSATRPSIGNAL_() { # Run on signal.
	local RV="$?"
	printf "\\e[?25h\\e[1;7;38;5;0mBuildAPKs %s WARNING:  Signal %s received!\\e[0m\\n" "gsa.bash" "$RV"
 	exit 178
}

_SGSATRPQUIT_() { # Run on quit.
	local RV="$?"
	printf "\\e[?25h\\e[1;7;38;5;0mBuildAPKs %s WARNING:  Quit signal %s received!\\e[0m\\n" "gsa.bash" "$RV"
 	exit 177
}

trap '_SGSATRPERROR_ $LINENO $BASH_COMMAND $?' ERR
trap _SGSATRPEXIT_ EXIT
trap _SGSATRPSIGNAL_ HUP INT TERM
trap _SGSATRPQUIT_ QUIT

_GSA_() {
	[[ -f .cong/RONGSA ]] && ((git submodule update --init --recursive --remote "$1") || (git submodule update --init --recursive --remote "$1") || (printf "\\n\\n%s\\n" "Cannot add submodule $2 : Continuing...") || (git submodule add $3 https:/$SIAD$OUNA/$2 $1 && touch .conf/RONGSA)) || ((git submodule update --init --recursive --remote "$1" && touch .conf/RONGSA) || (printf "\\n\\n%s\\n" "Cannot add submodule $2 : Continuing..."))
	sleep 0."$(shuf -i 24-72 -n 1)"	# latency support
}
git pull
SIAD="/github.com"
OUNA="/shlibs"
_GSA_ "\.scripts/maintenance" maintenance ""
OUNA="/TermuxArch"
_GSA_ docs docsTermuxArch ""
_GSA_ gen genTermuxArch ""
_GSA_ scripts "scripts\.TermuxArch" ""
# updateTermuxArch.bash EOF
