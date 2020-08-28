#!/usr/bin/env bash
# Copyright 2017-2020 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project.
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
# To regenerate the start script use 'setupTermuxArch [r[e[fresh]]]'.  The command 'setupTermuxArch refresh' will refresh the installation globally, including excecuting keys and locales and backup user configuration files that were refreshed.  The command 'setupTermuxArch re' will refresh the installation and update user configuration files and backup user configuration files that were refreshed.  While the command 'setupTermuxArch r' will only refresh the installation and update the root user configuration files and backup root user configuration files that were refreshed.
# Appending to the PRoot statement can be accomplished on the fly by creating a .prs file in the var/binds directory.  The format is straightforward, 'PROOTSTMNT+="option command "'.  The space is required before the last double quote.  Commands 'info proot' and 'man proot' have more information about what can be configured in a proot init statement.  If more suitable configurations are found, share them at https://github.com/TermuxArch/TermuxArch/issues to improve TermuxArch.  PRoot bind usage: PROOTSTMNT+="-b host_path:guest_path "  The space before the last double quote is necessary.

_PR00TSTRING_() { # construct the PRoot init statement
	PROOTSTMNT="exec proot "
       	if [[ -z "${KID:-}" ]]
	then
		PROOTSTMNT+="--kernel-release=$(uname -r)-generic "
       	elif [[ "$KID" = 0 ]]
	then
	       	PROOTSTMNT+="--kernel-release=4.14.15-generic "
	else
	       	PROOTSTMNT+=""
       	fi
       	if [[ "$KOE" = 0 ]]
	then
	       	PROOTSTMNT+="--kill-on-exit "
       	fi
       	PROOTSTMNT+="--link2symlink -0 -r $INSTALLDIR "
	# file var/binds/fbindexample.prs has a few more examples
       	if [[ -n "$(ls -A "$INSTALLDIR"/var/binds/*.prs)" ]]
	then
	       	for PRSFILES in "$INSTALLDIR"/var/binds/*.prs
		do
		       	. "$PRSFILES"
	       	done
	fi
	[[ "$SYSVER" -ge 10 ]] && PROOTSTMNT+="-b /apex:/apex "
	# Function _PR00TSTRING_ which creates the PRoot init statement PROOTSTMNT uses associative arrays.  Page https://www.gnu.org/software/bash/manual/html_node/Arrays.html has information about BASH arrays and is also available at https://www.gnu.org/software/bash/manual/ this link.  
	declare -A PRSTARR # associative array
	# populate writable binds
	PRSTARR=([/dev/ashmem]=/dev/ashmem [/dev/shm]=/dev/shm)
	for PRBIND in ${!PRSTARR[@]}
	do
	       	if [[ -w "$PRBIND" ]]	# is writable
		then	# add proot bind
		       	PROOTSTMNT+="-b $PRBIND:$PRBIND "
		fi
	done
	# populate readable binds
 	PRSTARR=([/dev/]=/dev/ [/dev/urandom]=/dev/random ["$EXTERNAL_STORAGE"]="$EXTERNAL_STORAGE" ["$HOME"]="$HOME" ["$PREFIX"]="$PREFIX" [/proc/]=/proc/ [/proc/self/fd]=/dev/fd [/proc/self/fd/0]=/dev/stdin [/proc/self/fd/1]=/dev/stdout [/proc/self/fd/2]=/dev/stderr [/proc/stat]=/proc/stat [/property_contexts]=/property_contexts [/storage/]=/storage/ [/sys/]=/sys/ [/system/]=/system/ [/vendor/]=/vendor/)
	for PRBIND in ${!PRSTARR[@]}
	do
	       	if [[ -r "$PRBIND" ]]	# is readable
		then	# add proot bind
		       	PROOTSTMNT+="-b $PRBIND:${PRSTARR[$PRBIND]} "
		fi
	done
	# populate NOT readable binds
	PRSTARR=([/dev/]=/dev/ [/dev/ashmem]="$INSTALLDIR/tmp" [/dev/shm]="$INSTALLDIR/tmp" [/proc/stat]="$INSTALLDIR/var/binds/fbindprocstat" [/sys/]=/sys/ [/proc/uptime]="$INSTALLDIR/var/binds/fbindprocuptime")
	for PRBIND in ${!PRSTARR[@]}
	do
	       	if [[ ! -r "$PRBIND" ]]	# is not readable
		then	# add proot bind
		       	PROOTSTMNT+="-b ${PRSTARR[$PRBIND]}:$PRBIND "
		fi
	done
	PROOTSTMNT+="-w \"\$PWD\" /usr/bin/env -i HOME=/root TERM=\"\$TERM\" TMPDIR=/tmp ANDROID_DATA=/data " # create PRoot user string
}
_PR00TSTRING_
# uncomment the next line to test function _PR00TSTRING_
# printf "%s\\n" "$PROOTSTMNT" && exit
# knownconfigurations.bash EOF
