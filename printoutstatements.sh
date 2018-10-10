#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project. 
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# _STANDARD_="function name" && STANDARD="variable name" are under construction.
# Printout statement subroutines for `setupTermuxArch.sh`.
################################################################################
FLHDR0[0]="#!/bin/env bash"
FLHDR0[1]="# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺 "
FLHDR0[2]="# Hosting sdrausty.github.io/TermuxArch courtesy https://pages.github.com." 
FLHDR0[3]="# https://sdrausty.github.io/TermuxArch/README has info about this project."
FLHDR0[4]="# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help." 
FLHDR1[0]="################################################################################"
FLHDR1[1]="# IFS=$'\\n\\t'"
FLHDR1[2]="set -Eeuo pipefail"
FLHDR1[3]="# shopt -s nullglob globstar"
FLHDR1[4]="unset LD_PRELOAD"
FLHDR1[5]="VERSIONID=v1.6.6.id8974"
FLHDR1[6]=" "
FLHDRP[0]="## BEGIN #######################################################################"
FLHDRP[1]=""
TRPERROR[0]="_TRPERR_() {  #	Run on script error."
TRPERROR[1]="	local RV=\"\$?\""
TRPERROR[2]="	printf \"\\e[?25h\\n\\e[1;48;5;138m %s\\e[0m\\n\\n\" \"\${0##*/} WARNING:  Generated script signal \${RV:-unknown} near or at line number \${1:-unknown} by \`\${2:-command}\`!\""
TRPERROR[3]="	exit 201"
TRPERROR[4]="}"
TRPERROR[5]=" "
TRPEXIT[0]="_TRPET_() {  #	Run on exit."
TRPEXIT[1]="	local RV=\"\$?\" "
TRPEXIT[2]="  	printf \"\\a\\a\\a\\a\" "
TRPEXIT[3]="	sleep 0.4 "
TRPEXIT[4]="	if [[ \"\$RV\" = 0 ]]
	then"
TRPEXIT[5]="		printf \"\\a\\e[0;32m%s\\e[1;34m: \\a\\e[1;32m%s\\e[0m\\n\\n\\a\\e[0m\" \"\${0##*/} \$@ $VERSIONID\" \"DONE 🏁 \""
TRPEXIT[6]="		printf \"\\e]2; %s: %s \\007\" \"\${0##*/} \$@\" \"DONE 🏁 \""
TRPEXIT[7]="	else "
TRPEXIT[8]="		printf \"\\a\\e[0;32m%s \\a\\e[0m%s\\e[1;34m: \\a\\e[1;32m%s\\e[0m\\n\\n\\a\\e[0m\" \"\${0##*/} \$@ $VERSIONID\" \"[Exit Signal \$RV]\" \"DONE  🏁 \""
TRPEXIT[9]="		printf \"\\e]2; %s: %s %s \\007\" \"\${0##*/} \$@\" \"[Exit Signal \$RV]\" \"DONE 🏁 \""
TRPEXIT[10]="	fi"
TRPEXIT[11]="	printf \"\\e[?25h\\e[0m\""
TRPEXIT[12]="	set +Eeuo pipefail"
TRPEXIT[13]="	exit"
TRPEXIT[14]="}"
TRPEXIT[15]=" "
TRPSIGNAL[0]="_TRPSIG_() {  #	Run on signal."
TRPSIGNAL[1]="	printf \"\\e[?25h\\e[1;7;38;5;0m\${0##*/} WARNING:  Signal \$? received!\\e[0m\\n\""
TRPSIGNAL[2]=" 	exit 211"
TRPSIGNAL[3]="}"
TRPSIGNAL[4]=" "
TRPQUIT[0]="_TRPQ_() {  #	Run on quit."
TRPQUIT[1]="	printf \"\\e[?25h\\e[1;7;38;5;0m\${0##*/} WARNING:  Quit signal \$? received!\\e[0m\\n\""
TRPQUIT[2]=" 	exit 221"
TRPQUIT[3]="}"
TRPQUIT[4]=" "
TRAPS[0]="trap '_TRPERR_ \$LINENO \$BASH_COMMAND \$?' ERR"
TRAPS[1]="trap _TRPET_ EXIT"
TRAPS[2]="trap _TRPSIG_ HUP INT TERM"
TRAPS[3]="trap _TRPQ_ QUIT"
TRAPS[4]=" "

_CFLHD_() { #	Creates file header and interests comments.  
  	if [[ -z "${2:-}" ]]
	then
		printf "%s\\n" "${FLHDR0[1]}" > "$1"
		printf "%s\\n" "${FLHDR0[2]}" >> "$1"
		printf "%s\\n" "${FLHDR0[3]}" >> "$1"
		printf "%s\\n" "${FLHDR0[4]}" >> "$1"
		printf "%s\\n" "${FLHDR1[0]}" >> "$1"
  	else
		printf "%s\\n" "${FLHDR0[1]}" > "$1"
		printf "%s\\n" "${FLHDR0[2]}" >> "$1"
		printf "%s\\n" "${FLHDR0[3]}" >> "$1"
		printf "%s\\n" "${FLHDR0[4]}" >> "$1"
   		printf "%s\\n"  "${@:2}" >> "$1"
		printf "%s\\n" "${FLHDR1[0]}" >> "$1"
  	fi
}

_CFLHDR_() { #	Creates BASH script boilerplate, file header and interests comments.  
  	if [[ -z "${2:-}" ]]
	then
		printf "%s\\n" "${FLHDR0[@]}" > "$1"
		printf "%s\\n" "${FLHDR1[@]}" >> "$1"
  	else
		printf "%s\\n" "${FLHDR0[@]}" > "$1"
   		printf "%s\\n"  "${@:2}" >> "$1"
		printf "%s\\n" "${FLHDR1[@]}" >> "$1"
  	fi
	printf "%s\\n" "${TRPERROR[@]}" >> "$1"
 	printf "%s\\n" "${TRPEXIT[@]}" >> "$1"
	printf "%s\\n" "${TRPSIGNAL[@]}" >> "$1"
	printf "%s\\n" "${TRPQUIT[@]}" >> "$1"
 	printf "%s\\n" "${TRAPS[@]}" >> "$1"
}

_CFLHDRS_() { #	Creates file header and interests comments.  
  	if [[ -z "${2:-}" ]]
	then
		printf "%s\\n" "${FLHDR0[1]}" > "$1"
		printf "%s\\n" "${FLHDR0[2]}" >> "$1"
		printf "%s\\n" "${FLHDR0[3]}" >> "$1"
		printf "%s\\n" "${FLHDR0[4]}" >> "$1"
		printf "%s\\n" "${FLHDR1[0]}" >> "$1"
  	else
		printf "%s\\n" "${FLHDR0[1]}" > "$1"
		printf "%s\\n" "${FLHDR0[2]}" >> "$1"
		printf "%s\\n" "${FLHDR0[3]}" >> "$1"
		printf "%s\\n" "${FLHDR0[4]}" >> "$1"
   		printf "%s\\n"  "${@:2}" >> "$1"
		printf "%s\\n" "${FLHDR1[0]}" >> "$1"
  	fi
}

_PRINT_CONFIGUP_() {
	printf "\\e[0;34m 🕛 > 🕤 \\e[1;34mArch Linux in Termux PRoot is installed.  Configuring and updating Arch Linux 📲"'\\e]2; 🕛 > 🕤 Arch Linux is installed!  Configuring and updating Arch Linux 📲 \\007'
}

_PRINT_CONFLOADED_() {
	printf "\\n\\e[0;34m%s \\e[1;34m%s \\e[0;32m%s\\e[1;32m%s \\e[1;34m%s \\e[1;32m%s\\n" " 🕛 > 🕑" "TermuxArch configuration" "$WDIR" "setupTermuxArchConfigs.sh" "loaded:" "OK"
}

_PRINT_CONTACTING_() {
 	printf "\\e]2;  🕛 > 🕞 Contacting https://%s…\\007" "$CMIRROR"
	printf "\\e[0;34m 🕛 > 🕞 \\e[1;34mContacting worldwide mirror \\e[0;32m%s\\e[1;34m: " "https://$CMIRROR"
}

_PRINT_CU_() {
	printf "\n\\e[0;34m 🕛 > 🕘 \\e[1;34mCleaning up installation files: "'\\e]2; 🕛 > 🕙 Cleaning up installation files: \\007'
}

_PRINT_DETECTED_SYSTEM_() {
	printf "\n\\e[0;34m 🕛 > 🕝 \\e[1;34mDetected $CPUABI " 
	if [[ "$(getprop ro.product.device)" == *_cheets ]]
	then
		printf "Chromebook.\n\n\\e[0m"
	else
		printf "$(uname -o) operating system.\n\n\\e[0m"
	fi
}

_PRINT_DONE_() {
	printf "\\e[1;32mDONE  \\e[0m\n\n"
}

_PRINT_DOWNLOADING_X86_() {
	printf "\n\\e[0;34m 🕛 > 🕞 \\e[0;34mDownloading checksum from \\e[0;32mhttp://$CMIRROR\\e[0;34m…\n\n\\e[0;32m"'\\e]2; 🕛 > 🕞 Downloading the Arch Linux system image checksum…  \\007'
}

_PRINT_DOWNLOADING_X86TWO_() {
	printf "\n\\e[0;34m 🕛 > 🕓 \\e[0;34mDownloading \\e[0;32m$file \\e[0;34mfrom \\e[0;32mhttp://$CMIRROR\\e[0;34m…  \\e[1;37mThis may take a long time pending connection.\n\n\\e[0;32m"'\\e]2; 🕛 > 🕓 Downloading the Arch Linux system image file…  \\007'
}

_PRINT_DOWNLOADING_FTCH_() {
	printf "\\e[0;34m 🕛 > 🕓 \\e[1;34mDownloading the checksum file and \\e[1;34m$file \\e[1;34mfrom the geographically local mirror \\e[1;32m$NLCMIRROR\\e[1;34m.  If contact with the local mirror is not successful, run \\e[0;32msetupTermuxArch.sh\\e[1;34m again.  Should the worldwide mirror not provide another geographically nearby server after a couple of attempts, use \\e[0;32msetupTermuxArch.sh manual \\e[1;34mafter locating a local mirror from the Internet; See \\e[0;32msetupTermuxArch.sh help \\e[1;34mfor additional options.  \\e[1;37mDownload of $file pending Internet connection:\n\n\\e[0;32m"'\\e]2; 🕛 > 🕓 Downloading the checksum and Arch Linux system image file…  \\007'
}

_PRINT_DOWNLOADING_FTCHIT_() {
	printf "\\e[0;34m 🕛 > 🕓 \\e[0;34mDownloading the checksum file and \\e[0;32m$file \\e[0;34m from \\e[0;32mhttp://$CMIRROR\\e[0;34m…  \\e[1;37mThis may take a long time pending connection.\n\n\\e[0;32m"'\\e]2; 🕛 > 🕓 Downloading the checksum and Arch Linux system image file…  \\007'
	printf "\\e]2;%s\\007" " 🕛 > 🕓 Downloading $file…"
}

_PRINT_FOOTER_() {
	printf "\\e[0;34m 🕛 > 🕥 \\e[1;34mUse \\e[1;32m$STARTBIN \\e[1;34mto launch Arch Linux in Termux PRoot.  Alternatively, run \\e[1;32m~$PRINTROOTDIR/$STARTBIN \\e[1;34min a BASH shell to start Arch Linux in Termux PRoot for future sessions.  See \\e[1;32m$STARTBIN help \\e[1;34mfor usage information.\\e[0m\n\n"
	printf "\\e]2;  Thank you for using \`setupTermuxArch.sh\` to install Arch Linux in Termux 📲  \\007"
	_COPYSTARTBIN2PATH_
	printf "\\e[0;32m 🕛 = 🕛 \\e[1;34mInformation about \\e[0;36m\"Starting Arch Linux from Termux?\"\\e[1;34m at \\e[1;34mhttps://github.com/sdrausty/TermuxArch/issues/25\\e[1;34m.  Use \\e[1;32mtour\\e[1;34m to run a very short tour to get to know the new Arch Linux in Termux PRoot environment you just set up a little bit better.  If there was more than one error during the update procedure and you would like to refresh the installation, use \\e[1;32msetupTermuxArch.sh refresh\\e[1;34m.  This will update and recreate the configuration provided.  The TermuxArch command \\e[1;32mkeys \\e[1;34mhelps install and generate Arch Linux keyring keys.\n\n"
	_PRINT_FOOTER2_
	_PRINT_STARTBIN_USAGE_
}

_PRINT_FOOTER2_() {
	printf "\\e[1;34mArch Linux in Termux PRoot is installed in $INSTALLDIR.  This project is in active development.  Contributions to this project are welcome; See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS for information.  The documentation repository for TermuxArch https://sdrausty.github.io/TermuxArch/docs/ is a Termux Arch submodule that is located at https://github.com/sdrausty/docsTermuxArch.  Pull requests and contributions through the issues pages are open to improve the ux (user experience) and this Termux PRoot installation script.\n\nUse \\e[1;32m~$PRINTROOTDIR/$STARTBIN \\e[1;34mand \\e[1;32m$STARTBIN \\e[1;34min a BASH shell to launch Arch Linux in Termux PRoot for future sessions.  If you are new to *nix, http://tldp.org has *nix documentation.  See https://wiki.archlinux.org/index.php/IRC_channel for available Arch Linux IRC channels.  See ~/bin directory for available shortcuts.  For example, \`ch\` turns hush login on and off, and \`tour\` shall run a short $TA introduction.  Consider starring ⭐️ $TA and ✨ the submodules at Github 🌠 \n\\e[0m"
}

_PRINT_MAX_() {
	printf "\\n\\e[07;1m\\e[31;1m 🔆 WARNING: Maximum amount of attempts exceeded!\\e[34;1m\\e[30;1m  Run \`setupTermuxArch.sh\` again.  See \`setupTermuxArch.sh help\` to resolve download errors.  If this keeps repeating, copy \`knownconfigurations.sh\` to \`setupTermuxArchConfigs.sh\` with preferred mirror.  After editing \`setupTermuxArchConfigs.sh\`, run \`setupTermuxArch.sh\` and \`setupTermuxArchConfigs.sh\` loads automaticaly from the same directory.  Change mirror to desired geographic location to resolve md5sum errors.\\n\\nUser configurable variables are in \`setupTermuxArchConfigs.sh\`.  Create this file from \`kownconfigurations.sh\` in the working directory.  Use \`setupTermuxArch.sh manual\` to create and edit \`setupTermuxArchConfigs.sh\`.\\n\\n	Run \`setupTermuxArch.sh\` again…\\n\\e[0;0m\\n"'\\e]2;  Thank you for using setupTermuxArch.sh.  Run `setupTermuxArch.sh` again…\\007'
}

_PRINT_MD5CHECK_() {
	printf "\n\\e[0;34m 🕛 > 🕠 \\e[1;34mChecking download integrity with Termux busybox md5sum.  \\e[37;1mThis may take a little while:\n\n\\e[1;33m"
}

_PRINT_MD5ERROR_() {
	printf "\n\\e[07;1m\\e[31;1m 🔆 WARNING md5sum mismatch! The download failed and was removed!\\e[34;1m\\e[30;1m  Run \`setupTermuxArch.sh\` again.  See \`setupTermuxArch.sh help\` to resolve md5sum errors.  This kind of error can go away, like magic.  Waiting before executing again is recommended.  There are numerous reasons for checksum errors.  Proxies are one explaination.  Mirroring and mirrors are another explaination for md5sum errors.  Interrupted download is one more reason.  If this keeps repeating, copy \`knownconfigurations.sh\` to \`setupTermuxArchConfigs.sh\` with preferred mirror.  After editing \`setupTermuxArchConfigs.sh\`, run \`setupTermuxArch.sh\` and \`setupTermuxArchConfigs.sh\` loads automaticaly from the same directory.  Change mirror to desired geographic location to resolve md5sum errors.\n\nUser configurable variables are in \`setupTermuxArchConfigs.sh\`.  Create this file from \`kownconfigurations.sh\` in the working directory.  Use \`setupTermuxArch.sh manual\` to create and edit \`setupTermuxArchConfigs.sh\`.\n\n	Run \`setupTermuxArch.sh\` again…\n\\e[0;0m\n"'\\e]2;  Thank you for using setupTermuxArch.sh.  Run `setupTermuxArch.sh` again…\\007'
	exit 
}

_PRINT_MD5SUCCESS_() {
 	printf "\\e]2;%s\\007" " 🕛 > 🕡 Unpacking $file…"
	printf "\\e[0;34m 🕛 > 🕕 \\e[1;34mSystem image file download integrity: \\e[1;32mOK\n\n\\e[0;34m 🕛 > 🕡 \\e[1;34mUnpacking $file into $INSTALLDIR.  The option to create Arch Linux system users is available through \\e[1;32maddauser\\e[1;34m.  Arch Linux user login from Termux with \\e[1;32m$STARTBIN \\e[1;34mis now implemented.  See \\e[0;34mAbility for Scripts to Launch Commands for Arch Linux in Termux PRoot on Device\\e[1;34m https://github.com/sdrausty/TermuxArch/issues/54 for more information about these brand new options.  \n\nWhile waiting, you can use \\e[0;36mdf\\e[1;34m, \\e[0;36mdu -hs\\e[1;34m, \\e[0;36mhtop\\e[1;34m, \\e[0;36mps\\e[1;34m, \\e[0;36mtop\\e[1;34m and \\e[0;36mwatch\\e[1;34m in a new Termux session to watch the unpacking while the session completes.  Use \\e[0;36minfo query \\e[1;34mand \\e[0;36mman query \\e[1;34mto learn more about your Linux system in the palm of your hand.  See The Linux Documentation Project http://tldp.org to learn more about Linux and CLI commands.  \\e[1;37mUnpacking \\e[37m$file\\e[1;37m will take a long time; Be patient…\n\n\\e[0m"
}

_PRINT_MISMATCH_() {
	printf "\n\\e[07;1m\\e[31;1m 🔆 WARNING: Unknown configuration!  Did not find an architecture and operating system match in\\e[37;1m knownconfigurations.sh\\e[31;1m!  \\e[36;1mDetected $(uname -mo).  There still is hope.  Other images are available at http://mirror.archlinuxarm.org/os/ and https://www.archlinux.org/mirrors/ to see if any match might the device.  If you find a match, then please \\e[37;1msubmit a pull request\\e[36;1m at https://github.com/sdrausty/TermuxArch/pulls with script modifications.  Alternatively, \\e[37;1msubmit a modification request\\e[36;1m at https://github.com/sdrausty/TermuxArch/issues if you find a configuration match.  Include output from \\e[37;1muname -mo\\e[36;1m on the device in order to expand autodetection for \\e[37;1msetupTermuxArch.sh\\e[36;1m.  See https://sdrausty.github.io/docs/TermuxArch/Known_Configurations for more information.\n\n	\\e[36;1mRun setupTermuxArch.sh again…\n\\e[0m"'\\e]2;  Thank you for using setupTermuxArch.sh.  Run `setupTermuxArch.sh` again…\\007'
	exit 
}

_PRINT_ROOTDIRFUNCTION_() {
	declare -g PRINTROOTDIR
	PRINTROOTDIR="$(echo "${ROOTDIR%/}" |sed 's#//*#/#g')"
}
_PRINT_ROOTDIRFUNCTION_ 

_PRINT_STARTBIN_USAGE_() {
	printf "\\n\\e[1;38;5;155m" 
	if [[ -x "$(command -v "$STARTBIN")" ]]
	then
		echo "$STARTBIN" help 
		"$STARTBIN" help 
	fi
}

_PRINT_USAGE_() {
	_NAME_STARTARCH_ 
	printf "\\n\\e[1;33m %s     \\e[0;32m%s \\e[1;34m%s\\n" "HELP" "${0##*/} help" "shall output the help screen." 
	printf "\\n\\e[1;33m %s    \\e[0;32m%s \\e[1;34m%s\\n" "TERSE" "${0##*/} he[lp]" "shall output the terse help screen." 
	printf "\\n\\e[1;33m %s  \\e[0;32m%s \\e[1;34m%s\\n" "VERBOSE" "${0##*/} h" "shall output the verbose help screen." 
	printf "\\n\\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\n\\n%s \\e[0;32m%s\\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s\\e[1;34m%s\\n" "Usage information for" "${0##*/}" "$VERSIONID.  Arguments can abbreviated to one, two and three letters each; Two and three letter arguments are acceptable.  For example," "bash ${0##*/} cs" "shall use" "curl" "to download $TA and produce a" "setupTermuxArchSysInfo$STIME.log" "system information file." "User configurable variables are in" "setupTermuxArchConfigs.sh" ".  To create this file from" "kownconfigurations.sh" "in the working directory, run" "bash ${0##*/} manual" "to create and edit" "setupTermuxArchConfigs.sh" "." 
	printf "\\n\\e[1;33m %s\\e[1;34m  %s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s\\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s\\n" "INSTALL" "Run" "./${0##*/}" "without arguments in a bash shell to install Arch Linux in Termux.  " "bash ${0##*/} curl" "shall envoke" "curl" "as the download manager.  Copy" "knownconfigurations.sh" "to" "setupTermuxArchConfigs.sh" "with" "bash ${0##*/} manual" "to edit preferred CMIRROR site and to access more options.  After editing" "setupTermuxArchConfigs.sh" ", run" "bash ${0##*/}" "and" "setupTermuxArchConfigs.sh" "loads automatically from the working directory.  Change CMIRROR to desired geographic location to resolve download errors." 
 	printf "\\n\\e[1;33m %s    \\e[0;32m%s \\e[1;34m%s\\n" "PURGE" "${0##*/} purge" "shall uninstall Arch Linux from Termux." 
	printf "\\n\\e[1;33m %s  \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s \\e[1;34m%s \\e[0;32m%s\\e[1;34m%s \\n\\n" "SYSINFO" "${0##*/} sysinfo" "shall create" "setupTermuxArchSysInfo$STIME.log" "and populate it with system information.  Post this file along with detailed information at" "https://github.com/sdrausty/TermuxArch/issues" ".  If screenshots will help in resolving an issue better, include these along with information from the system information log file in a post as well." 
	if [[ "$lcc" = 1 ]]
	then
		printf "\\n\\e[1;38;5;149m" 
		if [[ "$LCW" = 0 ]]
	then
			awk 'NR>=241 && NR<=491'  espritfunctions.sh | awk '$1 == "##"' | awk '{ $1 = ""; print }' | awk '1;{print ""}'
			else
			awk 'NR>=241 && NR<=491'  "$TAMPDIR"/espritfunctions.sh | awk '$1 == "##"' | awk '{ $1 = ""; print }' | awk '1;{print ""}'
		fi
	fi
	_PRINT_STARTBIN_USAGE_
}

_PRINT_WLA_() {
	printf "\\e]2;%s\\007" "🕛 > 🕒 Activating wake-lock: OK"
	printf "\\e[0;34m%s\\e[1;34m%s" " 🕛 > 🕒 " "Activating wake-lock: "
}

_PRINT_WLD_() {
	printf "\\e]2;%s\\007" "🕛 > 🕙 Releasing wake-lock: OK"
	printf "\\e[0;34m%s\\e[1;34m%s" " 🕛 > 🕙 " "Releasing wake-lock: "
}

# EOF
