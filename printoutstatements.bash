#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
## printout statement subroutines for 'setupTermuxArch'
################################################################################
FLHDR0[0]="#!/usr/bin/env bash"
FLHDR0[1]="# Copyright 2017-2022 by SDRausty. All rights reserved, see LICENSE 🌎 🌍 🌏"
FLHDR0[2]="# Hosting sdrausty.github.io/TermuxArch courtesy https://pages.github.com."
FLHDR0[3]="# https://sdrausty.github.io/TermuxArch/README has info about this project."
FLHDR0[4]="# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help."
FLHDR1[0]="##############################################################################"
FLHDR1[1]=""
FLHDR1[2]="set -Eeuo pipefail"
FLHDR1[3]="shopt -s extglob nullglob globstar"
FLHDR1[4]="unset LD_PRELOAD"
FLHDR1[5]="VERSIONID=2.0.548"
FLHDR1[6]="SRPTNM=\"\${0##*/}\""
FLHDRP[0]="## BEGIN #####################################################################"
FLHDRP[1]=""
TRPERROR[0]="_TRPERR_() {  # run on script error"
TRPERROR[1]="	local RV=\"\$?\""
TRPERROR[2]="	printf \"\\\\e[?25h\\\\n\\\\e[1;48;5;138m %s\\\\e[0m\\\\n\\\\n\" \"ＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} NOTICE:  Generated script signal \${RV:-UNKNOWN} near or at line number \${1:-UNKNOWN} by '\${2:-UNKNOWNCOMMAND}'!\""
TRPERROR[3]="	exit \"\$RV\""
TRPERROR[4]="}"
TRPERROR[5]=""
TRPEXIT[0]="_TRPET_() {  # run on exit"
TRPEXIT[1]="	local RV=\"\$?\""
TRPEXIT[2]="	printf \"\""
TRPEXIT[3]="	if [[ \"\$RV\" = 0 ]]"
TRPEXIT[4]="	then"
TRPEXIT[5]="		printf \"\\\\e[0;32mTermuxArch command \\\\e[1;32m'%s'\\\\e[0;32m version %s\\\\e[1;34m: \\\\e[1;32mDONE 🏁\\\\e[0m\\\\n\" \"\$STRNRG\" \"\$VERSIONID\""
TRPEXIT[6]="		printf \"\\\\e]2;%s\007\" \"\$STRNRG:  DONE 🏁 \""
TRPEXIT[7]="	else"
TRPEXIT[8]="		printf \"\\\\e[0;32mTermuxArch command \\\\e[1;32m'%s'\\\\e[0;32m version %s\\\\e[0m [Exit Signal %s]\\\\e[1;34m: \\\\e[1;32mDONE  🏁\\\\e[0m\\\\n\" \"\$STRNRG\" \"\$VERSIONID\" \"\$RV\""
TRPEXIT[9]="		printf \"\033]2;%s\007\" \"\$STRNRG [Exit Signal \$RV]:  DONE 🏁 \""
TRPEXIT[10]="	fi"
TRPEXIT[11]="	printf \"\\e[?25h\\e[0m\""
TRPEXIT[12]="	set +Eeuo pipefail"
TRPEXIT[13]="	exit"
TRPEXIT[14]="}"
TRPEXIT[15]=""
TRPSIGNAL[0]="_TRPSIG_() {  # run on signal"
TRPSIGNAL[1]="	local RV=\"\$?\""
TRPSIGNAL[2]="	printf \"\\\\e[?25h\\\\e[1;7;38;5;0mＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} NOTICE:  Signal %s received!\\\\e[0m\\\\n\" \"\$?\""
TRPSIGNAL[3]="	exit \"\$RV\""
TRPSIGNAL[4]="}"
TRPQUIT[0]="_TRPQ_() {  # run on quit"
TRPQUIT[1]="	local RV=\"\$?\""
TRPQUIT[2]="	printf \"\\\\e[?25h\\\\e[1;7;38;5;0mＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} NOTICE:  Quit signal %s received!\\\\e[0m\\\\n\" \"\$?\""
TRPQUIT[3]="	exit \"\$RV\""
TRPQUIT[4]="}"
TRAPS[0]="trap '_TRPERR_ \$LINENO \$BASH_COMMAND \$?' ERR"
TRAPS[1]="trap _TRPET_ EXIT"
TRAPS[2]="trap _TRPSIG_ HUP INT TERM"
TRAPS[3]="trap _TRPQ_ QUIT"
TRAPS[4]="ARGS=\"\${@%/}\""
TRAPS[5]="{ [ -z \"\${ARGS:-}\" ] && STRNRG=\"\${0##*/}\" ; } || STRNRG=\"\${0##*/} \${ARGS:-}\""
# TRAPS[6]="printf \"\\\\e[1;32m==> \\\\e[0mRunning TermuxArch command \\\\e[1;32m%s\\\\e[0;32m %s\\\\e[1;37m...\\\\n\" \"\$STRNRG\" \"version \$VERSIONID\""

_CFLHD_() { #	creates file header and inserts comments
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

_CFLHDR_() { #	creates BASH script boilerplate, file header and inserts comments
if [[ -z "${2:-}" ]]
then
printf "%s\\n" "${FLHDR0[@]}" > "$1"
printf "%s\\n" "${FLHDR1[@]}" >> "$1"
else
printf "%s\\n" "${FLHDR0[@]}" > "$1"
for LINENUMR in ${#@}
do
printf "%s\\n" "${@:LINENUMR}" >> "$1"
done
printf "%s\\n" "${FLHDR1[@]}" >> "$1"
fi
printf "%s\\n" "${TRPERROR[@]}" >> "$1"
printf "%s\\n" "${TRPEXIT[@]}" >> "$1"
printf "%s\\n" "${TRPSIGNAL[@]}" >> "$1"
printf "%s\\n" "${TRPQUIT[@]}" >> "$1"
printf "%s\\n" "${TRAPS[@]}" >> "$1"
}

_CFLHDRS_() { #	creates file header and inserts comments
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

_PRINTCONTACTING_() {
printf "\033]2;  🕛 > 🕞 Contacting https://%s...\007" "$CMIRROR"
printf "\\e[0;34m 🕛 > 🕞 \\e[1;34mContacting worldwide mirror \\e[0;32m%s\\e[1;34m: " "http://$CMIRROR"
}

_PRINTCU_() {
printf '\033]2; 🕛 > 🕙 Cleaning up installation files: \007'
printf "\\n\\e[0;34m 🕛 > 🕙 \\e[1;34mCleaning up installation files: "
}

_PRINTDETECTEDSYSTEM_() {
if [[ "$(getprop ro.product.device)" == *_cheets ]]
then
printf "\\e[1;34m%s\\n\\n\\e[0m" " 🕛 > 🕝 Detected $NASVER Chromebook operating system;  Install architecture is set to $CPUABI."
else
printf "\\e[1;34m%s\\n\\n\\e[0m" " 🕛 > 🕝 Detected $NASVER operating system;  Install architecture is set to $CPUABI."
fi
}

_PRINTDONE_() {
printf "\\e[1;32mDONE  \\e[0m\\n\\n"
}

_PRINTWLA_() {
printf '\033]2; 🕛 > 🕒 Activating termux-wake-lock: OK\007'
printf "\\n\\e[0;34m 🕛 > 🕒 \\e[1;34mActivating termux-wake-lock: "
}

_PRINTWLD_() {
printf '\033]2; 🕛 > 🕙 Releasing termux-wake-lock: OK\007'
printf "\\e[0;34m 🕛 > 🕙 \\e[1;34mReleasing termux-wake-lock: "
}

_PRINTDOWNLOADINGX86_() {
printf '\033]2; 🕛 > 🕞 Downloading the Arch Linux system image checksum...  \007'
printf "\\n\\e[0;34m 🕛 > 🕞 \\e[0;34mDownloading checksum from \\e[0;32mhttp://%s\\e[0;34m...\\n\\n\\e[0;32m" "$CMIRROR"
}

_PRINTDOWNLOADINGX86TWO_() {
printf '\033]2; 🕛 > 🕓 Downloading the Arch Linux system image file...  \007'
printf "\\n\\e[0;34m 🕛 > 🕓 \\e[0;34mDownloading \\e[0;32m%s \\e[0;34mfrom \\e[0;32mhttp://%s\\e[0;34m...  \\e[1;37mThis may take a long time pending connection.\\n\\n\\e[0;32m" "$IFILE" "$CMIRROR"
}

_PRINTDOWNLOADINGFTCH_() {
printf "\033]2;%s\007" " 🕛 > 🕓 Downloading the checksum and Arch Linux system image files...  "
printf "\\e[0;34m 🕛 > 🕓 \\e[1;34mDownloading the checksum file and \\e[1;34m%s \\e[1;34mfrom the geographically local mirror \\e[1;32m%s\\e[1;34m.  If contact with the local mirror is not successful, run \\e[1;32mbash \\e[0;32m%s\\e[1;34m again.  Should the worldwide mirror not provide another geographically nearby server after a couple of attempts, use \\e[1;32mbash \\e[0;32m%s manual \\e[1;34mafter locating a local mirror from the Internet; The command \\e[1;32mbash \\e[0;32m%s help \\e[1;34mhas information about additional options.  \\e[1;37mDownload of %s pending Internet connection...\\n\\n\\e[0;32m" "$IFILE" "${NLCMIRROR:-MIRROR NOT FOUND}" "${0##*/}" "${0##*/}" "${0##*/}" "$IFILE"
}

_PRINT_DOWNLOADING_FTCHIT_() {
printf "\033]2;%s\007" " 🕛 > 🕓 Downloading the checksum and $IFILE files...  "
printf "\\e[0;34m 🕛 > 🕓 \\e[0;34mDownloading the checksum file and \\e[0;32m%s \\e[0;34m from \\e[0;32mhttp://%s\\e[0;34m...  \\e[1;37mThis may take a long time pending connection.\\n\\n\\e[0;32m" "$IFILE" "$CMIRROR"
}

_PRINTCONFIGUP_() {
printf "\033]2;%s\007" " 🕛 > 🕤 Arch Linux is installed!  Configuring and updating Arch Linux 📲"
printf "\\n\\e[0;34m 🕛 > 🕤 \\e[1;34mArch Linux in Termux PRoot QEMU is installed.  Configuring and updating Arch Linux 📲  "
}

_PRINTMAX_() {
printf "\033]2;%s\007" "Please run 'bash ${0##*/}' again."
printf "\\n\\e[07;1m\\e[31;1m 🔆 ＴｅｒｍｕｘＡｒｃｈ NOTICE: Maximum amount of attempts exceeded.\\e[34;1m\\e[30;1m\\n\\nPlease run 'bash %s' again.  See 'bash %s help' to resolve download errors.  If this keeps repeating, copy 'knownconfigurations.bash' to 'setupTermuxArchConfigs.bash' with preferred mirror.  After editing 'setupTermuxArchConfigs.bash', run 'bash %s' and 'setupTermuxArchConfigs.bash' loads automaticaly from the same directory.  Change mirror to desired geographic location to resolve md5sum errors.\\n\\nUser configurable variables are in 'setupTermuxArchConfigs.bash'.  To create this file from 'knownconfigurations.bash' in the working directory the command 'bash %s manual' can be used to create and edit 'setupTermuxArchConfigs.bash'.\\n\\nPlease run 'bash %s' again.\\n\\e[0;0m\\n" "${0##*/}" "${0##*/}" "${0##*/}" "${0##*/}" "${0##*/}"
}

_PRINTKEEPEXIT_() {
printf "\\n\\e[0;34m 🕛 > 🕕 \\e[1;34mNot removing files after FAILED check of download integrity files with md5sum.  \\e[37;1m%s  \\e[1;33m" "Please run '${0##*/}' again to continue a partial download.  Otherwise remove '$INSTALLDIR' and restart the installation from scratch if the download is complete and FAILED checking download integrity checksum error continues.  You can set KEEP=1 in file 'setupTermuxArchConfigs.bash' by running '${0##*/} manual' to disable the keep download image file feature that is disabled by default as after downloading the root image file as it might no longer be needed by the end user execept for reinstalling the Arch Linux system and similar.  The command 'bash ${0##*/} help' and the source code for TermuxArch have more information."
}

_PRINTKEEP_() {
printf "\\n\\e[0;34m 🕛 > 🕗 \\e[1;34mNot removing files after checking download integrity with md5sum.  \\n"
}

_PRINTMD5CHECK_() {
printf "\\n\\e[0;34m 🕛 > 🕠 \\e[1;34mChecking download integrity with md5sum.  \\e[37;1mThis may take a little while  \\e[1;33m"
}

_PRINTMD5ERROR_() {
printf "\033]2;%s\007" "Run 'bash ${0##*/}' again..."
printf "\\n\\e[07;1m\\e[31;1m 🔆 ＴｅｒｍｕｘＡｒｃｈ SIGNAL md5sum mismatch! The download failed and was removed!\\e[30;1m  Run 'bash %s' again.  The command 'bash %s help' has more information.  This kind of error can go away, just like magic.  Waiting before executing %s again is recommended.  There are numerous reasons for checksum errors.  Proxies are one explaination.  Mirroring and mirrors are another explaination for md5sum errors.  An interrupted download is one more reason for an md5sum mismatch error.\\n	If this keeps repeating, file 'knownconfigurations.bash' can be copied to file 'setupTermuxArchConfigs.bash' with command 'bash %s manual' in order to choose a preferred mirror.  After editing 'setupTermuxArchConfigs.bash', command 'bash %s' loads file 'setupTermuxArchConfigs.bash' automaticaly from the same directory.  Change mirror to desired geographic location to resolve md5sum errors.\\n	User configurable variables are in 'setupTermuxArchConfigs.bash'.  In order to create this file from 'knownconfigurations.bash' in the working directory, the command 'bash %s manual' can be used to create and edit 'setupTermuxArchConfigs.bash'.\\n\\n	Please run command 'bash %s' again, or command 'bash %s manual' can be run which creates file '%sConfigs.bash' for editing.\\n\\e[0;0m\n" "${0##*/}" "${0##*/}" "${0##*/}" "${0##*/}" "${0##*/}" "${0##*/}" "${0##*/}" "${0##*/}" "${0##*/}"
}

_PRINTMD5SUCCESS_() {
printf "\\e]2;%s\\007" " 🕛 > 🕡 Unpacking $IFILE..."
printf "\\n\\n\\e[0;34m 🕛 > 🕔 \\e[1;34mSystem image file download integrity check: \\e[1;32mDONE\\n\\n\\e[0;34m 🕛 > 🕡 \\e[1;34mUnpacking %s into %s.  The option to create Arch Linux system users is available through \\e[1;32maddauser\\e[1;34m.  Arch Linux user login from Termux with \\e[1;32m%s \\e[1;34mis now implemented.  Please see \\e[0;36mAbility for Scripts to Launch Commands for Arch Linux in Termux PRoot on Device\\e[1;34m https://github.com/sdrausty/TermuxArch/issues/54 for information how to use this option.  \\n\\nWhile waiting, any of these commands can be used \\e[0;36mdf\\e[1;34m, \\e[0;36mdu -hs\\e[1;34m, \\e[0;36mps\\e[1;34m, \\e[0;36mtop\\e[1;34m and \\e[0;36mwatch\\e[1;34m in a new Termux session to watch the unpacking while this session completes.  Use \\e[0;36mhelp man \\e[1;34mand \\e[0;36minfo man \\e[1;34mto learn more about your Linux system in the palm of your hand.  See The Linux Documentation Project http://tldp.org to learn more about Linux and CLI (command line interface) commands.\\n\\nIf simply scrolling the screen up by scrolling up does produce the desired effect, this method can be employed.  Long tap until the popup menu shows.  Then scroll up without loosing touch with the screen and without touching the popup menu.  \\e[1;37mUnpacking \\e[1;32m%s\\e[1;37m will take a long time;  Please be patient   \\e[0m" "$IFILE" "$INSTALLDIR" "$STARTBIN" "$IFILE"
}

_PRINTMISMATCH_() {
printf "\033]2;%s\007" "Run 'bash ${0##*/}' again..."
printf "\\n\\e[07;1m\\e[31;1m 🔆 ＴｅｒｍｕｘＡｒｃｈ NOTICE: Unknown configuration!  Did not find an architecture and operating system match in 'knownconfigurations.bash'!  \\e[36;1m\\nDetected %s architecture.  There still is hope.  Other images may be available at http://mirror.archlinuxarm.org/os/ and https://www.archlinux.org/mirrors/ to see if any match might the device.  If there is a match found, then please \\e[37;1msubmit a pull request\\e[36;1m at https://github.com/TermuxArch/TermuxArch/pulls with script modifications.  Alternatively, \\e[37;1ma modification can be submitted\\e[36;1m at https://github.com/TermuxArch/TermuxArch/issues if a new configuration match is found.  Please include output from \\e[37;1m'uname -mo'\\e[36;1m on the device in order to expand autodetection for \\e[37;1m'%s'\\e[36;1m.  The webpage at https://termuxarch.github.io/docsTermuxArch/Known_Configurations has more information.\\n\\n	\\e[36;1mRun '%s purge' to remove the installation;  Then please try '%s' again with new options...\\e[0m\\n" "$NASVER $CPUABI" "${0##*/}" "${0##*/}" "${0##*/}"
exit
}

_PRINTFOOTER_() {
printf "\033]2;%s\007" "Thank you for using '${0##*/}' to install Arch Linux in Termux PRoot QEMU 📲 "
printf "\\e[0;34m 🕛 > 🕚 \\e[1;34mYou can use \\e[1;32m%s \\e[1;34mto launch Arch Linux in Termux PRoot QEMU.  Alternatively, command \\e[1;32m~%s \\e[1;34mcan be run in a BASH shell to start Arch Linux in Termux PRoot QEMU in future sessions.  See \\e[1;32m%s help \\e[1;34mfor usage information.\\e[0m\\n\\n" "$STARTBIN" "$PRINTROOTDIR/$STARTBIN" "$STARTBIN"
printf "\\e[0;32m 🕛 = 🕛 \\e[1;34mThe command \\e[1;32mtour \\e[1;34mcan be used to run a very short tour in order to get to know the new Arch Linux in Termux PRoot QEMU environment a little bit better.  If there was more than one error during the update procedure and you would like to refresh the installation, use \\e[1;32m%s refresh\\e[1;34m.  This will update and recreate the configuration provided.  The TermuxArch command \\e[1;32mkeys \\e[1;34mhelps install and generate Arch Linux keyring keys.\\n\\n" "${0##*/}"
_PRINTFOOTER2_
}

_PRINTFOOTER2_() {
_PRTARM_() {
printf "\\e[1;34m%s\\e[0;32m%s\\e[1;34m%s\\e[0m\\n\\n" "The webpage " "https://archlinuxarm.org/forum" " has discussion forums available for the Arch Linux arm project regarding the Arch Linux $CPUABI computer architecture."
}
_PRTX86_() {
printf "\\e[1;34m%s\\e[0;32m%s\\e[1;34m%s\\e[0;32m%s\\e[1;34m%s\\e[0m\\n\\n" "The website " "https://bbs.archlinux32.org/" " has Arch Linux 32 discussion forums.  The website " "https://wiki.archlinux32.org/" " has information about the Arch Linux 32 project regarding the Arch Linux $CPUABI computer architecture."
}
_PRTX8664_() {
printf "\\e[1;34m%s\\e[0;32m%s\\e[1;34m%s\\e[0;32m%s\\e[1;34m%s\\e[0m\\n\\n" "The website " "https://bbs.archlinux.org/" " has Arch Linux discussion forums for the Arch Linux project.  The webpage " "https://wiki.archlinux.org/index.php/IRC_channel" " lists available Arch Linux IRC channels regarding the Arch Linux $CPUABI computer architecture."
}
printf "\\e[1;34m%s\\n\\n%s\\e[1;32m%s\\e[1;34m%s\\e[1;32m%s\\e[1;34m%s" "Arch Linux in Termux PRoot QEMU is installed in $INSTALLDIR.  This project is in active development.  Contributions to this project are welcome; See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS for information.  The documentation repository for TermuxArch https://sdrausty.github.io/TermuxArch/docs is a TermuxArch module that is located at https://github.com/sdrausty/docsTermuxArch.  Pull requests and contributions through the issues pages are open to improve the ux (user experience) and this Termux PRoot QEMU installation script. " "The commands " "~$PRINTROOTDIR/$STARTBIN " "and " "$STARTBIN " "can be used in a BASH shell to launch Arch Linux in Termux PRoot QEMU for future sessions.  For those new to *nix, http://tldp.org has *nix documentation.  "
if [[ "$CPUABI" = "$CPUABIX86" ]]
then
_PRTX86_
elif [[ "$CPUABI" = "$CPUABIX8664" ]]
then
_PRTX8664_
else
_PRTARM_
fi
}

_PRINTPROOTERROR_() {
printf "\\e[0;34m%s\\n\\n" "1) IF ERROR 'env ... not found' IS FOUND, ensure that all the software is up to date.  After updating, please reference these weblinks in order to find a resolution if updating Termux app and Termux packages and device software was unsuccessful:
i) https://github.com/termux/proot/issues?q=\"env\"+\"not+found\"
ii) https://github.com/termux/termux-packages/issues?q=\"not+found\"+\"proot\""
printf "%s\\n\\n" "2) IF ERROR 'proot info: vpid 1: terminated with signal 4' IS FOUND, please create a 'qbind.prs' file by using 'bindexample.prs' as an example file located in directory '$INSTALLDIR/var/binds/'.  In order to complete this PRoot QEMU configuration add a QEMU bind statement to variable PROOTSTMNT.  Then run the '$STRNRG' command again after creating and editing the 'qbind.prs' file; i.e:
\`\`\`
cd $INSTALLDIR/var/binds/
cp bindexample.prs bindq.prs
\`\`\`
Edit file bindq.prs and run command '$STRNRG' again."
printf "%s\\n\\n\\e[0m" "3) IF ERROR 'proot info: vpid 1: terminated with signal 11' IS FOUND, please ensure that all software is up to date.  After updating all the software, including device software was unsuccessful in resolving this signal, then please reference these weblinks in order to find a resolution if updating Termux app and Termux packages and device software was unsuccessful in resolving this signal:
i)  https://github.com/termux/proot/issues?q=\"proot info: vpid 1: terminated with signal 11\"
ii) https://github.com/termux/termux-packages/issues?q=\"proot info: vpid 1: terminated with signal 11\""
}

_PRINTROOTDIRFUNCTION_() {
declare -g PRINTROOTDIR
PRINTROOTDIR="$(printf "%s" "${ROOTDIR%/}"|sed 's#//*#/#g')"
}
_PRINTROOTDIRFUNCTION_
# printoutstatements.bash FE
