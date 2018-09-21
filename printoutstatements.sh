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
FLHDR1[5]="VERSIONID=v1.6.id4659"
FLHDR1[6]=" "
FLHDRP[0]="## BEGIN #######################################################################"
FLHDRP[1]=""
TRPERROR[0]="_TRPERR_() {  #	Run on script error."
TRPERROR[1]="	local RV=\"\$?\""
TRPERROR[2]="	printf \"\\e[?25h\\n\\e[1;48;5;138m %s\\e[0m\\n\\n\" \"TermuxArch WARNING:  Generated script signal \${RV:-unknown} near or at line number \${1:-unknown} by \`\${2:-command}\`!\""
TRPERROR[3]="	exit 201"
TRPERROR[4]="}"
TRPERROR[5]=" "
TRPEXIT[0]="_TRPET_() {  #	Run on exit."
TRPEXIT[1]="	local RV=\"\$?\" "
TRPEXIT[2]="  	printf \"\\a\\a\\a\\a\" "
TRPEXIT[3]="	sleep 0.4 "
TRPEXIT[4]="	if [[ \"\$RV\" = 0 ]] ; then"
TRPEXIT[5]="		printf \"\\a\\e[0;32m%s\\e[1;34m: \\a\\e[1;32m%s\\e[0m\\n\\n\\a\\e[0m\" \"\${0##*/} \$@ $VERSIONID\" \"DONE 🏁 \""
TRPEXIT[6]="		printf \"\\e]2; %s: %s \007\" \"\${0##*/} \$@\" \"DONE 🏁 \""
TRPEXIT[7]="	else "
TRPEXIT[8]="		printf \"\\a\\e[0;32m%s \\a\\e[0m%s\\e[1;34m: \\a\\e[1;32m%s\\e[0m\\n\\n\\a\\e[0m\" \"\${0##*/} \$@ $VERSIONID\" \"[Exit Signal \$RV]\" \"DONE  🏁 \""
TRPEXIT[9]="		printf \"\033]2; %s: %s %s \007\" \"\${0##*/} \$@\" \"[Exit Signal \$RV]\" \"DONE 🏁 \""
TRPEXIT[10]="	fi"
TRPEXIT[11]="	printf \"\\e[?25h\\e[0m\""
TRPEXIT[12]="	set +Eeuo pipefail"
TRPEXIT[13]="	exit"
TRPEXIT[14]="}"
TRPEXIT[15]=" "
TRPSIGNAL[0]="_TRPSIG_() {  #	Run on signal."
TRPSIGNAL[1]="	printf \"\\e[?25h\\e[1;7;38;5;0mTermuxArch WARNING:  Signal \$? received!\\e[0m\\n\""
TRPSIGNAL[2]=" 	exit 211"
TRPSIGNAL[3]="}"
TRPSIGNAL[4]=" "
TRPQUIT[0]="_TRPQ_() {  #	Run on quit."
TRPQUIT[1]="	printf \"\\e[?25h\\e[1;7;38;5;0mTermuxArch WARNING:  Quit signal \$? received!\\e[0m\\n\""
TRPQUIT[2]=" 	exit 221"
TRPQUIT[3]="}"
TRPQUIT[4]=" "
TRAPS[0]="trap \"_TRPERR_ \$LINENO \$BASH_COMMAND \$?\" ERR"
TRAPS[1]="trap _TRPET_ EXIT"
TRAPS[2]="trap _TRPSIG_ HUP INT TERM"
TRAPS[3]="trap _TRPQ_ QUIT"
TRAPS[4]=" "

_CFLHD_() { #	Creates file header and interests comments.  
  	if [[ -z "${2:-}" ]] ; then
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
  	if [[ -z "${2:-}" ]] ; then
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
  	if [[ -z "${2:-}" ]] ; then
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

_PRINTCONTACTING_() {
 	printf "\033]2;  🕛 > 🕞 Contacting https://%s…\007" "$CMIRROR"
	printf "\033[0;34m 🕛 > 🕞 \033[1;34mContacting worldwide mirror \033[0;32m%s\033[1;34m: " "https://$CMIRROR"
}

_PRINTCU_() {
	printf "\n\033[0;34m 🕛 > 🕘 \033[1;34mCleaning up installation files: "'\033]2; 🕛 > 🕙 Cleaning up installation files: \007'
}

_PRINTDETECTEDSYSTEM_() {
	printf "\n\033[0;34m 🕛 > 🕝 \033[1;34mDetected $(uname -m) " 
	if [[ "$(getprop ro.product.device)" == *_cheets ]];then
		printf "Chromebook.\n\n\033[0m"
	else
		printf "$(uname -o) operating system.\n\n\033[0m"
	fi
}

_PRINTDONE_() {
	printf "\033[1;32mDONE  \033[0m\n\n"
}

_PRINTWLA_() {
	printf "\033[0;34m 🕛 > 🕒 \033[1;34mActivating termux-wake-lock: "'\033]2; 🕛 > 🕒 Activating termux-wake-lock: OK\007'
}

_PRINTWLD_() {
	printf "\n\033[0;34m 🕛 > 🕙 \033[1;34mReleasing termux-wake-lock: "'\033]2; 🕛 > 🕙 Releasing termux-wake-lock: OK\007'
}

_PRINTDOWNLOADINGX86_() {
	printf "\n\033[0;34m 🕛 > 🕞 \033[0;34mDownloading checksum from \033[0;32mhttp://$CMIRROR\033[0;34m…\n\n\033[0;32m"'\033]2; 🕛 > 🕞 Downloading the Arch Linux system image checksum…  \007'
}

_PRINTDOWNLOADINGX86TWO_() {
	printf "\033[0;34m 🕛 > 🕓 \033[0;34mDownloading \033[0;32m$file \033[0;34mfrom \033[0;32mhttp://$CMIRROR\033[0;34m…  \033[1;37mThis may take a long time pending connection.\n\n\033[0;32m"'\033]2; 🕛 > 🕓 Downloading the Arch Linux system image file…  \007'
}

_PRINTDOWNLOADINGFTCH_() {
	printf "\033[0;34m 🕛 > 🕓 \033[1;34mDownloading the checksum file and \033[1;34m$file \033[1;34mfrom the geographically local mirror \033[1;32m$NLCMIRROR\033[1;34m.  If contact with the local mirror is not successful, run \033[1;32mbash \033[0;32msetupTermuxArch.sh\033[1;34m again.  Should the worldwide mirror not provide another geographically nearby server after a couple of attempts, use \033[1;32mbash \033[0;32msetupTermuxArch.sh manual \033[1;34mafter locating a local mirror from the Internet; See \033[1;32mbash \033[0;32msetupTermuxArch.sh help \033[1;34mfor additional options.  \033[1;37mDownload of $file pending Internet connection:\n\n\033[0;32m"'\033]2; 🕛 > 🕓 Downloading the checksum and Arch Linux system image file…  \007'
}

_PRINT_DOWNLOADING_FTCHIT_() {
	printf "\033[0;34m 🕛 > 🕓 \033[0;34mDownloading the checksum file and \033[0;32m$file \033[0;34m from \033[0;32mhttp://$CMIRROR\033[0;34m…  \033[1;37mThis may take a long time pending connection.\n\n\033[0;32m"'\033]2; 🕛 > 🕓 Downloading the checksum and Arch Linux system image file…  \007'
	printf "\033]2;%s\007" " 🕛 > 🕓 Downloading $file…"
}

_PRINTCONFIGUP_() {
	printf "\033[0;34m 🕛 > 🕤 \033[1;34mArch Linux in Termux PRoot is installed.  Configuring and updating Arch Linux 📲"'\033]2; 🕛 > 🕤 Arch Linux is installed!  Configuring and updating Arch Linux 📲 \007'
}

_PRINTMAX_() {
	printf "\\n\\e[07;1m\\e[31;1m 🔆 WARNING: Maximum amount of attempts exceeded!\\e[34;1m\\e[30;1m  Run \`bash setupTermuxArch.sh\` again.  See \`bash setupTermuxArch.sh help\` to resolve download errors.  If this keeps repeating, copy \`knownconfigurations.sh\` to \`setupTermuxArchConfigs.sh\` with preferred mirror.  After editing \`setupTermuxArchConfigs.sh\`, run \`bash setupTermuxArch.sh\` and \`setupTermuxArchConfigs.sh\` loads automaticaly from the same directory.  Change mirror to desired geographic location to resolve md5sum errors.\\n\\nUser configurable variables are in \`setupTermuxArchConfigs.sh\`.  Create this file from \`kownconfigurations.sh\` in the working directory.  Use \`bash setupTermuxArch.sh manual\` to create and edit \`setupTermuxArchConfigs.sh\`.\\n\\n	Run \`bash setupTermuxArch.sh\` again…\\n\\e[0;0m\\n"'\033]2;  Thank you for using setupTermuxArch.sh.  Run `bash setupTermuxArch.sh` again…\007'
}

_PRINTMD5CHECK_() {
	printf "\n\033[0;34m 🕛 > 🕠 \033[1;34mChecking download integrity with Termux busybox md5sum.  \033[37;1mThis may take a little while:\n\n\033[1;33m"
}

_PRINTMD5ERROR_() {
	printf "\n\033[07;1m\033[31;1m 🔆 WARNING md5sum mismatch! The download failed and was removed!\033[34;1m\033[30;1m  Run \`bash setupTermuxArch.sh\` again.  See \`bash setupTermuxArch.sh help\` to resolve md5sum errors.  This kind of error can go away, like magic.  Waiting before executing again is recommended.  There are numerous reasons for checksum errors.  Proxies are one explaination.  Mirroring and mirrors are another explaination for md5sum errors.  Interrupted download is one more reason.  If this keeps repeating, copy \`knownconfigurations.sh\` to \`setupTermuxArchConfigs.sh\` with preferred mirror.  After editing \`setupTermuxArchConfigs.sh\`, run \`bash setupTermuxArch.sh\` and \`setupTermuxArchConfigs.sh\` loads automaticaly from the same directory.  Change mirror to desired geographic location to resolve md5sum errors.\n\nUser configurable variables are in \`setupTermuxArchConfigs.sh\`.  Create this file from \`kownconfigurations.sh\` in the working directory.  Use \`bash setupTermuxArch.sh manual\` to create and edit \`setupTermuxArchConfigs.sh\`.\n\n	Run \`bash setupTermuxArch.sh\` again…\n\033[0;0m\n"'\033]2;  Thank you for using setupTermuxArch.sh.  Run `bash setupTermuxArch.sh` again…\007'
	exit 
}

_PRINTMD5SUCCESS_() {
 	printf "\\e]2;%s\\007" " 🕛 > 🕡 Unpacking $file…"
	printf "\033[0;34m 🕛 > 🕕 \033[1;34mSystem image file download integrity: \033[1;32mOK\n\n\033[0;34m 🕛 > 🕡 \033[1;34mUnpacking $file into $INSTALLDIR.  The option to create Arch Linux system users is available through \033[1;32maddauser.  Arch Linux user login from Termux with \033[1;32m$STARTBIN \033[1;34mis now implemented.  See \033[0;36mAbility for Scripts to Launch Commands for Arch Linux in Termux PRoot on Device\033[1;34m https://github.com/sdrausty/TermuxArch/issues/54 for more information about these brand new options.  Additional features of TermuxArch are also listed at https://github.com/sdrausty/TermuxArch/releases.\n\nWhile waiting, you can use \033[0;36mdf\033[1;34m, \033[0;36mdu -hs\033[1;34m, \033[0;36mhtop\033[1;34m, \033[0;36mps\033[1;34m, \033[0;36mtop\033[1;34m and \033[0;36mwatch\033[1;34m in a new Termux session to watch the unpacking while the session completes.  Use \033[0;36minfo query \033[1;34mand \033[0;36mman query \033[1;34mto learn more about your Linux system in the palm of your hand.  See The Linux Documentation Project http://tldp.org to learn more about Linux and CLI commands.  \033[1;37mUnpacking \033[37m$file\033[1;37m will take a long time; Be patient…\n\n\033[0m"
}

_PRINTMISMATCH_() {
	printf "\n\033[07;1m\033[31;1m 🔆 WARNING: Unknown configuration!  Did not find an architecture and operating system match in\033[37;1m knownconfigurations.sh\033[31;1m!  \033[36;1mDetected $(uname -mo).  There still is hope.  Other images are available at http://mirror.archlinuxarm.org/os/ and https://www.archlinux.org/mirrors/ to see if any match might the device.  If you find a match, then please \033[37;1msubmit a pull request\033[36;1m at https://github.com/sdrausty/TermuxArch/pulls with script modifications.  Alternatively, \033[37;1msubmit a modification request\033[36;1m at https://github.com/sdrausty/TermuxArch/issues if you find a configuration match.  Include output from \033[37;1muname -mo\033[36;1m on the device in order to expand autodetection for \033[37;1msetupTermuxArch.sh\033[36;1m.  See https://sdrausty.github.io/docs/TermuxArch/Known_Configurations for more information.\n\n	\033[36;1mRun setupTermuxArch.sh again…\n\033[0m"'\033]2;  Thank you for using setupTermuxArch.sh.  Run `bash setupTermuxArch.sh` again…\007'
	exit 
}

_PRINTFOOTER_() {
	printf "\033[0;34m 🕛 > 🕥 \033[1;34mUse \033[1;32m$STARTBIN \033[1;34mto launch Arch Linux in Termux PRoot.  Alternatively, run \033[1;32m~$PRINTROOTDIR/$STARTBIN \033[1;34min a BASH shell to start Arch Linux in Termux PRoot for future sessions.  See \033[1;32m$STARTBIN help \033[1;34mfor usage information.\033[0m\n\n"'\033]2;  Thank you for using `setupTermuxArch.sh` to install Arch Linux in Termux 📲  \007'
	_COPYSTARTBIN2PATH_
	printf "\033[0;32m 🕛 = 🕛 \033[1;34mInformation about \033[0;36m\"Starting Arch Linux from Termux?\"\033[1;34m at \033[1;34mhttps://github.com/sdrausty/TermuxArch/issues/25\033[1;34m.  Use \033[1;32mtour\033[1;34m to run a very short tour to get to know the new Arch Linux in Termux PRoot environment you just set up a little bit better.  If there was more than one error during the update procedure and you would like to refresh the installation, use \033[1;32msetupTermuxArch.sh refresh\033[1;34m.  This will update and recreate the configuration provided.  The TermuxArch command \033[1;32mkeys \033[1;34mhelps install and generate Arch Linux keyring keys.\n\n"
	_PRINTFOOTER2_
	_PRINTSTARTBIN_USAGE_
# 	printf "\n"
}

_PRINTFOOTER2_() {
	printf "\033[1;34mArch Linux in Termux PRoot is installed in $INSTALLDIR.  This project is in active development.  Contributions to this project are welcome; See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS for information.  The documentation repository for TermuxArch https://sdrausty.github.io/TermuxArch/docs/ is a Termux Arch submodule that is located at https://github.com/sdrausty/docsTermuxArch.  Pull requests and contributions through the issues pages are open to improve the ux (user experience) and this Termux PRoot installation script.\n\nUse \033[1;32m~$PRINTROOTDIR/$STARTBIN \033[1;34mand \033[1;32m$STARTBIN \033[1;34min a BASH shell to launch Arch Linux in Termux PRoot for future sessions.  If you are new to *nix, http://tldp.org has *nix documentation.  See https://wiki.archlinux.org/index.php/IRC_channel for available Arch Linux IRC channels.\n\n\033[0m"
}

_PRINTROOTDIRFUNCTION_() {
	declare -g PRINTROOTDIR
	PRINTROOTDIR="$(echo "${ROOTDIR%/}" |sed 's#//*#/#g')"
}
_PRINTROOTDIRFUNCTION_ 

## EOF
