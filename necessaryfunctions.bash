#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################

[ "$CPUABI" = i386 ] && CPUABI="x86"
CACHECPBI="${CPUABI/_/-}"
CACHEDIRPKG="/storage/emulated/0/Android/data/com.termux/files/cache/archlinux/$CACHECPBI/var/pacman/pkg/"
CACHEDIR="/storage/emulated/0/Android/data/com.termux/files/cache/archlinux/$CACHECPBI/"
PREFIXDATAFILES="/storage/emulated/0/Android/data/com.termux/"
CACHEDIRSUFIX="files/cache/archlinux/$CACHECPBI/var/pacman/pkg/"
BINFNSTP="finishsetup.bash"
LC_TYPE=("LANG" "LANGUAGE" "LC_ADDRESS" "LC_COLLATE" "LC_CTYPE" "LC_IDENTIFICATION" "LC_MEASUREMENT" "LC_MESSAGES" "LC_MONETARY" "LC_NAME" "LC_NUMERIC" "LC_PAPER" "LC_TELEPHONE" "LC_TIME")
TXPRQUON="Termux PRoot with QEMU"
TXPRQUON="Termux PRoot"

_ADDADDS_() {
_ADDREADME_
_ADDae_
_ADDauser_
printf '\e[0;32mGenerating dot files;  \e[1;32mBEGUN\n'
_ADDbash_logout_
_ADDbash_profile_
_ADDbashrc_
printf '\e[0;32mGenerating dot files;  \e[1;32mDONE\n'
_ADDbindexample_
_ADDcams_
_ADDcdtd_
_ADDcdth_
_ADDcdtmp_
_ADDch_
_ADDchperms.cache+gnupg_
_ADDcsystemctl_
_ADDes_
_ADDexd_
_ADDfbindprocpcidevices.prs_
_ADDfbindprocshmem.prs_
_ADDfbindprocuptime_
_ADDfbinds_
_ADDfibs_
_ADDga_
_ADDgcl_
_ADDgclone_
_ADDgcm_
_ADDgitconfig_
_ADDgp_
_ADDgpl_
_ADDinfo_
_ADDinputrc_
_ADDkeys_
_ADDmakeaurbauerbill_
_ADDmakeaurpacaur_
_ADDmakeaurpakku_
_ADDmakeaurparu_
_ADDmakeaurpbget_
_ADDmakeaurpikaur-git_
_ADDmakeaurpkgbuilder_
_ADDmakeaurpuyo_
_ADDmakeaurrepoctl_
_ADDmakeaurrepofish_
_ADDmakeauraclegit_
_ADDmakeaurfakeroottcp_
_ADDmakeaurhelpers_
_ADDmakeaurghcuphs_
_ADDmakeaurpikaur_
_ADDmakeaurpopularpackages_
_ADDmakeaurpackagequery_
_ADDmakeaurrustup_
_ADDmakeaurshellcheckbin_
_ADDmakeaurtllocalmgr_
_ADDmakeaurtrizen_
_ADDmakeauryaah_
_ADDmakeauryay_
_ADDmakeauryayim_
_ADDmakeaurutils_
_ADDmakeksh_
_ADDmemav_
_ADDmemfree_
_ADDmeminfo_
_ADDmemmem_
_ADDmemtot_
_ADDopen4root_
_ADDorcaconf_
_ADDpatchmakepkg_
_ADDpacmandblock_
_ADDpc_
_ADDpci_
_ADDpinghelp_
_ADDprofile_
if [[ -n "${VLORALCR:-}" ]]
then
_ADDprofileetc_
_ADDprofileusretc_
fi
_ADDresolvconf_
_PREPMOTS_
_ADDmota_
_ADDmotd_
_ADDmoto_
_ADDt_
_ADDtop_
_ADDthstartarch_
_ADDtimings_
# _ADDtools_
_ADDtour_
_ADDtrim_
_ADDv_
_ADDwe_
_ADDyt_
}

_CALLSYSTEM_() {
declare COUNTER=""
if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX8664" ]] || [[ "$CPUABI" = "${CPUABIX8664//_/-}" ]] || [[ "$CPUABI" = i386 ]]
then
_GETIMAGE_ ||:
else
if [[ "$CMIRROR" = "os.archlinuxarm.org" ]] || [[ "$CMIRROR" = "mirror.archlinuxarm.org" ]]
then
until _FTCHSTND_ ||:
do
_FTCHSTND_
sleep 2
printf "\\n"
COUNTER=$((COUNTER + 1))
if [[ "$COUNTER" = 9 ]]
then
_PRINTMAX_
break
fi
done
else
_FTCHIT_
fi
fi
}

_COPYSTARTBIN2PATH_() {
if [[ ":$PATH:" == *":$HOME/bin:"* ]] && [[ -d "$HOME"/bin ]]
then
BPATH="$HOME"/bin
else
BPATH="$PREFIX"/bin
fi
cp "$INSTALLDIR/$STARTBIN" "$BPATH"
printf "\\n\\e[0;34m%s\\e[1;34m%s\\e[1;32m%s\\e[1;34m%s\\e[1;37m%s\\e[1;34m.\\e[0m\\n\\n" " 🕛 > 🕦 " "File " "$STARTBIN " "copied to " "$BPATH"
}

_DETECTSYSTEM_() {
_PRINTDETECTEDSYSTEM_
if [[ "$CPUABI" = "$CPUABI5" ]]
then
_ARMV5L_
elif [[ "$CPUABI" = "$CPUABI7" ]]
then
_DETECTSYSTEM7_
elif [[ "$CPUABI" = "$CPUABI8" ]]
then
_DETECTSYSTEM64_
elif [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = i386 ]]
then
_I686_
elif [[ "$CPUABI" = "$CPUABIX8664" ]] || [[ "$CPUABI" = "${CPUABIX8664//_/-}" ]]
then
_X86-64_
else
_PRINTMISMATCH_
fi
}

_DETECTSYSTEM7_() {
if [[ "$(getprop ro.product.device)" == *_cheets ]]
then
_ARMV7CHROME_
else
_ARMV7ANDROID_
fi
}

_DETECTSYSTEM64_() {
if [[ "$(getprop ro.product.device)" == *_cheets ]]
then
_AARCH64CHROME_
else
_AARCH64ANDROID_
fi
}

_DOMIRROR_() { # partial implementaion: choose the corrrect mirror and test this mirror website
_DOCEMIRROR_() {
COUNTRYCODEISO="$(getprop gsm.operator.iso-country)"
USERCOUNTRYCODE="${COUNTRYCODEISO%%[\ \,]*}"
if [[ -z "${USERCOUNTRYCODE:-}" ]]
then
USERCOUNTRYCODE="$(getprop gsm.sim.operator.iso-country)"
fi
if [[ -z "${USERCOUNTRYCODE:-}" ]]
then
USERCOUNTRYCODE="us"
fi
printf "Copying file '%s' to file '%s';  " "$INSTALLDIR/etc/pacman.d/mirrorlist" "$INSTALLDIR/etc/pacman.d/mirrorlist.$STIME.termuxarchnew"
cp "$INSTALLDIR/etc/pacman.d/mirrorlist" "$INSTALLDIR/etc/pacman.d/mirrorlist.$STIME.termuxarchnew"
printf "DONE\\n"
if [[ $USERCOUNTRYCODE == us ]]
then
USERCOUNTRYCODE="edu\/"
fi
CHSENMIR="$(grep -w http "$INSTALLDIR/etc/pacman.d/mirrorlist" | grep ^#S | grep "$USERCOUNTRYCODE" | awk 'sub(/^.{1}/,"")' | head -n 1)"
printf "%s\\n" "$CHSENMIR" >> "$INSTALLDIR/etc/pacman.d/mirrorlist"
printf "Choosing mirror '%s' in file '%s';  Continuing...\\n" "$CHSENMIR" "${INSTALLDIR##*/}/etc/pacman.d/mirrorlist"
DOMIRLCR=0
}
if [[ -f "$INSTALLDIR/run/lock/${INSTALLDIR##*/}/domirror.lock" ]]
then
printf "Lockfile '%s' exists;  Continuing..." "$HOME/${INSTALLDIR##*/}/run/lock/${INSTALLDIR##*/}/domirror.lock"
else
if ! grep ^Server "$INSTALLDIR/etc/pacman.d/mirrorlist"
then
_DOCEMIRROR_
fi
fi
}

_DOPROXY_() {
[[ -f "$HOME"/.bash_profile ]] && grep -s "proxy" "$HOME"/.bash_profile | grep -s "export" >> root/bin/"$BINFNSTP" ||:
[[ -f "$HOME"/.bashrc ]] && grep -s "proxy" "$HOME"/.bashrc  | grep -s "export" >> root/bin/"$BINFNSTP" ||:
[[ -f "$HOME"/.profile ]] && grep -s "proxy" "$HOME"/.profile | grep -s "export" >> root/bin/"$BINFNSTP" ||:
}

_MAINBLOCK_() {
declare KID
declare -i KERNEL_VERSION
declare -i MAJOR_REVISION
declare -- MINOR_REVISION
declare -- TMPKERN
export KID=1
KERNEL_VERSION="$(awk -F'.' '{print $1}' <<< "$UNAMER")"
MAJOR_REVISION="$(awk -F'.' '{print $2}' <<< "$UNAMER")"
TMPKERN="$(awk -F'.' '{print $3}' <<< "$UNAMER")"
MINOR_REVISION="$(sed 's/[^0-9]*//g' <<< "${TMPKERN:0:3}")"
if [[ "$KERNEL_VERSION" -le 2 ]]
then
export KID=0
else
if [[ "$KERNEL_VERSION" -eq 3 ]]
then
if [[ "$MAJOR_REVISION" -lt 2 ]]
then
export KID=0
else
if [[ "$MAJOR_REVISION" -eq 2 ]] && [[ "$MINOR_REVISION" -eq 0 ]]
then
export KID=0
fi
fi
fi
fi
_NAMESTARTARCH_
_SPACEINFO_
_PREPINSTALLDIR_
_COPYSTARTBIN2PATH_
_DETECTSYSTEM_
_WAKEUNLOCK_
_PRINTFOOTER_
"$INSTALLDIR/$STARTBIN" || _PRINTPROOTERROR_
_PRINTFOOTER2_
_PRINTSTARTBIN_USAGE_
exit
}

_MAKEFINISHSETUP_() {
_DOKEYS_() {
if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = i386 ]]
then
DOKYSKEY="keys x86"
elif [[ "$CPUABI" = "$CPUABIX8664" ]] || [[ "$CPUABI" = "${CPUABIX8664//_/-}" ]]
then
DOKYSKEY="keys x86-64"
else
DOKYSKEY="keys"
fi
}
_DOKYLGEN_() {
DOKYSKEY=""
LOCGEN=":"
}
if [[ "${LCR:-}" -eq 5 ]] || [[ -z "${LCR:-}" ]]	# LCR equals 5 or is undefined
then
_DOKEYS_
LOCGEN="locale-gen || locale-gen"
elif [[ "${LCR:-}" -eq 1 ]] || [[ "${LCR:-}" -eq 2 ]] || [[ "${LCR:-}" -eq 3 ]] || [[ "${LCR:-}" -eq 4 ]] 	# LCR equals 1 or 2 or 3 or 4
then
_DOKYLGEN_
fi
_CFLHDR_ "root/bin/$BINFNSTP"
cat >> root/bin/"$BINFNSTP" <<- EOM
_PMFSESTRING_() {
printf "\\e[1;31m%s\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\n\\n" "Signal generated in " "'\$1'" "; Cannot complete task; " "Continuing..."
printf "\\e[1;34m%s\\e[0;34m%s\\e[1;34m%s\\e[0;34m%s\\e[1;34m%s\\n\\n" "  If you find better resolves for " "setupTermuxArch" " and " "\$0" ", please open an issue and accompanying pull request."
}
_PMGPSSTRING_() {
printf "\\n\\e[1;34m:: \\e[1;32m%s\\n" "Processing system for $NASVER $CPUABI, and removing redundant packages for Termux PRoot installation..."
}
EOM
_DOPROXY_
mkdir -p "$INSTALLDIR/run/lock/${INSTALLDIR##*/}"
if [[ ! -f "$INSTALLDIR/run/lock/${INSTALLDIR##*/}/pacmanRc.lock" ]]
then
if [[ "$CPUABI" = "$CPUABI5" ]]
then
printf "%s\\n" "{ _PMGPSSTRING_ && pacman -Rc linux-armv5 linux-firmware --noconfirm --color=always && :>"/run/lock/${INSTALLDIR##*/}/pacmanRc.lock" ; } || _PMFSESTRING_ \"pacman -Rc linux-armv5 linux-firmware $BINFNSTP \${0##/*}\"" >> root/bin/"$BINFNSTP"
elif [[ "$CPUABI" = "$CPUABI7" ]]
then
printf "%s\\n" "{ _PMGPSSTRING_ && pacman -Rc linux-armv7 linux-firmware --noconfirm --color=always && :>"/run/lock/${INSTALLDIR##*/}/pacmanRc.lock" ; } || _PMFSESTRING_ \"pacman -Rc linux-armv7 linux-firmware $BINFNSTP \${0##/*}\"" >> root/bin/"$BINFNSTP"
elif [[ "$CPUABI" = "$CPUABI8" ]]
then
printf "%s\\n" "{ _PMGPSSTRING_ && pacman -Rc linux-aarch64 linux-firmware --noconfirm --color=always && :>"/run/lock/${INSTALLDIR##*/}/pacmanRc.lock" ; } || _PMFSESTRING_ \"pacman -Rc linux-aarch64 linux-firmware $BINFNSTP \${0##/*}\"" >> root/bin/"$BINFNSTP"
fi
fi
cat >> root/bin/"$BINFNSTP" <<- EOM
$DOKYSKEY
EOM
if [[ "${LCR:-}" -eq 5 ]] || [[ -z "${LCR:-}" ]]
then
if [[ "$CPUABI" = "$CPUABIX8664" ]] || [[ "$CPUABI" = "${CPUABIX8664//_/-}" ]]
then
printf "%s\\n" "pacman -Su glibc grep gzip sed sudo --noconfirm --color=always || pacman -Su glibc grep gzip sed sudo  --noconfirm --color=always || _PMFSESTRING_ \"pacman -Su glibc grep gzip sed sudo $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
elif [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = i386 ]]
then
printf "%s\\n" "pacman -Su glibc sed sudo --noconfirm --color=always || pacman -Su glibc sed sudo --noconfirm --color=always || _PMFSESTRING_ \"pacman -Su glibc sed sudo $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
else
printf "%s\\n" "pacman -Su glibc --noconfirm --color=always || pacman -Su glibc --noconfirm --color=always || _PMFSESTRING_ \"pacman -Su glibc $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
fi
fi
cat >> root/bin/"$BINFNSTP" <<- EOM
printf "\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n" "To generate locales in a preferred language, you can use the native Android menu tap commands " "Settings > Language & Keyboard > Language " "in Android; Then run " "${0##*/} refresh" " for a full system refresh, which includes the locale generation function; For a quick refresh you can use " "${0##*/} r" ".  For a refresh with user directories " "${0##*/} re" " can be used."
$LOCGEN || _PMFSESTRING_ "LOCGEN $BINFNSTP ${0##/*}.  Please run '$LOCGEN' again in the installed system."
EOM
printf "%s\\n" "printf \"\\n\\e[1;32m==> \\e[1;37mRunning TermuxArch command \\e[1;32maddauser user\\e[1;37m...\\n\"" >> root/bin/"$BINFNSTP"
printf "%s\\n" "addauser user || _PMFSESTRING_ \"addauser user $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
chmod 700 root/bin/"$BINFNSTP"
}

_MAKESETUPBIN_() {
_CFLHDR_ root/bin/setupbin.bash
cat >> root/bin/setupbin.bash <<- EOM
set +Eeuox pipefail
EOM
printf "%s\\n" "$PROOTSTMNT /root/bin/$BINFNSTP ||:" >> root/bin/setupbin.bash
cat >> root/bin/setupbin.bash <<- EOM
set -Eeuo pipefail
EOM
chmod 700 root/bin/setupbin.bash
}

_MAKESTARTBIN_() {
_CFLHDR_ "$STARTBIN"
printf "%s\\n" "${FLHDRP[@]}" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
_CHCKUSER_() { [ -e "$INSTALLDIR/home/\$2/.profile" ] || _PRNTUSGE_ "\$@" ; }
_COMMANDGNE_() { printf "\\n\\e[1;48;5;138mScript %s\\e[0m\\n\\n" "\${0##*/} WARNING:  Please run '\${0##*/}' and 'bash \${0##*/}' from the BASH shell in native Termux:  EXITING..." && exit 202 ; }
if [ -w /root ]
then
_COMMANDGNE_
fi
_PRINTUSAGE_() {
printf "\\n\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN" "  starts Arch Linux in $TXPRQUON with PRoot root login.  This account is reserved for system administration.  Please use any system administrator account with care."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN c[ommand] command" "  runs Arch Linux commands from Termux as PRoot root login.  Quoting multiple commands can assit when passing multiple arguments: i.e.  " "$STARTBIN c 'whoami ; cat -n /etc/pacman.d/mirrorlist'" ".  Please pass commands through the system administrator account with caution."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN e[login|user] user" "  login as user.  Uses alternate elogin and euser option to login as user.  This option is preferred for working with programs that have already been installed, and for working with the 'git' command.  Please use " "$STARTBIN c 'addauser user'" " first to create this user and the user's home directory."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN l[ogin]|u[ser] user" "  login as user.  This option is preferred when installing software from a user account with the 'sudo' command, and when using commands such as 'makeaurhelpers', 'makepkg' and 'makeauryay'.  Please use 'addauser user' first to create this user and the user's home directory."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN r[aw]" "  construct the " "$STARTBIN " "proot statement from exec.../bin/.  For example " "$STARTBIN r su " "will exec 'su' in Arch Linux.  After installing the appropriate packages in Arch Linux, easy PRoot root shell access is possible with option raw:

~ $ startarch r bash
~ $ startarch r dash
~ $ startarch+x86 r csh
~ $ startarch+x86 r ksh
~ $ startarch+x86+64 r sh
~ $ startarch+x86+64 r zsh

Variable PROOTSTMNT has more information about PRoot init statement options 'grep -h PROOTSTMNT ~/TermuxArchBloom/* | grep \=' if you wish to modify the PRoot init statement extensively.  The PRoot init statement can also be modified on-the-fly simply by using the /var/binds/ directory once logged into the Arch Linux in Termux PRoot environment."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n\\e[0m" "$STARTBIN s[u] user command" "  executes commands as Arch Linux user from the Termux shell.  This option is preferred when installing software from a user account with the 'sudo' command, and when using commands such as 'makeaurhelpers', 'makepkg' and 'makeauryay'.  Quoting multiple commands can assit when passing multiple arguments:  " "$STARTBIN s user 'whoami ; cat -n /etc/pacman.d/mirrorlist'" ".  Please use " "$STARTBIN c 'addauser user'" " first to create a login and the login's home directory."
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN $@ 📲; DONE 🏁"
}
_PRNTUSGE_() { _PRINTUSAGE_ && printf "\\e[0;33m%s\\e[1;30m%s\\e[1;32m%s\\e[1;30m%s\\e[1;31m%s\\e[1;30m%s\\e[0m" "It appears that user '\$2' does not exist in the Arch Linux in Termux PRoot system!  " "You can create user '\$2' with the command " "\${0##*/} command 'addauser \$2'" " then rerun this comnand to login with user '\$2';" "  Exiting" "...  " ; exit 169 ; }
## [] Default Arch Linux in Termux PRoot root login.
if [[ -z "\${1:-}" ]]
then
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN 📲"
set +Eeuo pipefail
EOM
printf "%s\\n" "$PROOTSTMNT /bin/bash -l ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN 📲; DONE 🏁"
set -Eeuo pipefail
## [? | help] Displays usage information.
elif [[ "\${1//-}" = [?]* ]] || [[ "\${1//-}" = [Hh]* ]]
then
_PRINTUSAGE_
elif [[ -z "\${2:-}" ]]
then
_PRINTUSAGE_
printf "\\e[0;33m%s\\e[1;30m%s\\e[1;31m%s\\e[1;30m%s\\e[0m" "Please use one more argument to continue.  The command '\${0##*/} help' has more information" ";" "  Exiting" "...  "
## [command ARGS] Execute a command in BASH as root.
elif [[ "\${1//-}" = [Cc]* ]]
then
printf '\033]2; TermuxArch $STARTBIN command %s 📲\007' "\${@:2}"
:>"$INSTALLDIR/root/.chushlogin"
set +Eeuo pipefail
EOM
printf "%s\\n" "$PROOTSTMNT /bin/bash -lc \"\${@:2}\" ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\033]2; TermuxArch $STARTBIN command %s 📲;DONE 🏁 \007' "\${@:2}"
set -Eeuo pipefail
rm -f "$INSTALLDIR/root/.chushlogin"
## [e[login|user] user] Login as user.
elif [[ "\${1//-}" = e* ]]
then
_CHCKUSER_ "\$@"
printf '\033]2; TermuxArch $STARTBIN elogin %s 📲\007' "\$2"
set +Eeuo pipefail
:>"$INSTALLDIR/var/lock/${INSTALLDIR##*/}/\$\$elock"
if [ -f "$INSTALLDIR/var/lib/pacman/db.lck" ]
then
printf "%s" "File ~/${INSTALLDIR##*/}/var/lib/pacman/db.lck exists;  You can use the TermuxArch 'pacmandblock' command to alter the lock state.  Please use '$STARTBIN' and '$STARTBIN l[ogin] username' to install software in Arch Linux in Termux PRoot: "
else
printf "%s" "Creating file ~/${INSTALLDIR##*/}/var/lib/pacman/db.lck;  You can use the TermuxArch 'pacmandblock' command to alter the lock state.  Please use '$STARTBIN' and '$STARTBIN l[ogin] username' to install software in Arch Linux in Termux PRoot: "
:>"$INSTALLDIR/var/lib/pacman/db.lck"
printf "%s\\n" "DONE"
fi
printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "if [ -f \"$INSTALLDIR/var/lock/${INSTALLDIR##*/}/\$\$elock\" ]" "then" "if [ -f \"$INSTALLDIR/var/lib/pacman/db.lck\" ]" "then" "printf \"%s\" \"Deleting file '~/${INSTALLDIR##*/}/var/lib/pacman/db.lck';  You can use the TermuxArch 'pacmandblock' command to alter this lock state.  Please use 'startarch' and 'startarch l[ogin] username' to install software in Arch Linux in Termux PRoot: \"" "rm -f \"$INSTALLDIR/var/lib/pacman/db.lck\"" "printf \"%s\\\\n\" \"DONE\"" "fi" "rm -f \"$INSTALLDIR/var/lock/${INSTALLDIR##*}\$\$elock\"" "fi" "[ ! -f "$INSTALLDIR/home/\$2/.hushlogout" ] && [ ! -f "$INSTALLDIR/home/\$2/.chushlogout" ] && . /etc/moto" "h # write session history to file HOME/.historyfile" "## .bash_logout FE" > "$INSTALLDIR/home/\$2/.bash_logout"
EOM
printf "%s\\n" "$PROOTSTMNTEU /bin/su - \"\$2\" ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\033]2; TermuxArch $STARTBIN elogin %s 📲;DONE 🏁 \007' "\$2"
set -Eeuo pipefail
rm -f "$INSTALLDIR/home/\$2/.chushlogin"
## [l[ogin]|u[ser] user] Login as user.
elif [[ "\${1//-}" = [Ll]* ]] || [[ "\${1//-}" = [Uu]* ]]
then
_CHCKUSER_ "\$@"
printf '\033]2; TermuxArch $STARTBIN login %s 📲\007' "\$2"
set +Eeuo pipefail
EOM
printf "%s\\n" "$PROOTSTMNTU /bin/su - \"\$2\" ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\033]2; TermuxArch $STARTBIN login %s 📲;DONE 🏁 \007' "\$2"
set -Eeuo pipefail
## [raw ARGS] Construct the 'startarch' proot statement.
elif [[ "\${1//-}" = [Rr]* ]]
then
printf '\033]2; TermuxArch $STARTBIN raw %s 📲\007' "\$@"
set +Eeuo pipefail
EOM
printf "%s\\n" "$PROOTSTMNT /bin/\"\${@:2}\" ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\033]2; TermuxArch $STARTBIN raw %s 📲;DONE 🏁 \007' "\$@"
set -Eeuo pipefail
## [su user command] Login as user and execute command.
elif [[ "\${1//-}" = [Ss]* ]]
then
_CHCKUSER_ "\$@"
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN su \$2 \${@:3} 📲"
if [[ "\$2" = root ]]
then
printf "%s\\n" "Please use this command \"$STARTBIN c '\${@:3}'\" for the Arch Linux in Termux PRoot \$2 user account;  Exiting..."
exit
fi
:>"$INSTALLDIR/home/\$2/.chushlogin"
set +Eeuo pipefail
EOM
printf "%s\\n" "$PROOTSTMNTU /bin/su - \"\$2\" -c \"\${@:3}\" ||:" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN su \$2 \${@:3} 📲; DONE 🏁"
set -Eeuo pipefail
rm -f "$INSTALLDIR/home/\$2/.chushlogin"
else
_PRINTUSAGE_
fi
## $STARTBIN FE
EOM
chmod 700 "$STARTBIN"
}

_MAKESYSTEM_() {
_WAKELOCK_
if [ "$USECACHEDIR" = 0 ]
then
{ cd "$CACHEDIR" 2>/dev/null && printf '%s' "cd $CACHEDIR && " ; } || { cd "$PREFIXDATAFILES" && mkdir -p "$CACHEDIRSUFIX" && cd "$CACHEDIR" && printf '%s' "cd $PREFIXDATAFILES && mkdir -p $CACHEDIRSUFIX && cd $CACHEDIR && " ; } || exit 196
printf '%s\n' "cp -fr * $INSTALLDIR"
cp -fr * "$INSTALLDIR"
cd "$INSTALLDIR" && printf '%s\n\n' "cd $INSTALLDIR" || exit 196
fi
_CALLSYSTEM_
_MD5CHECK_
if [ "$KEEP" = 0 ]
then
_PRINTKEEP_
else
_PRINTCU_
rm -f "$INSTALLDIR"/*.tar.gz "$INSTALLDIR"/*.tar.gz.md5 ##  When KEEP=0 files *.tar.gz and *.tar.gz.md5 will remain on the system.
_PRINTDONE_
fi
_PRINTCONFIGUP_
_TOUCHUPSYS_
}

_MD5CHECK_() {
_PRINTMD5CHECK_
if md5sum -c "$IFILE".md5 1>/dev/null
then
_PRINTMD5SUCCESS_
printf "\\e[0;32m"
_TASPINNER_ clock & _PREPROOT_ ; kill $! || _PRINTERRORMSG_ "_PREPROOT_ _MD5CHECK_ ${0##*/} necessaryfunctions.bash"
else
if [ "$KEEP" = 0 ]
then
_PRINTKEEPEXIT_
else
rm -f "$INSTALLDIR"/*.tar.gz "$INSTALLDIR"/*.tar.gz.md5
_PRINTMD5ERROR_
fi
fi
}

_PREPROOTDIR_() {
# create local array of directories to be created for setupTermuxArch
local DRARRLST=("etc" "home" "root/bin" "usr/bin" "usr/local/bin" "var/backups/${INSTALLDIR##*/}/etc" "var/backups/${INSTALLDIR##*/}/root" "var/binds")
for ISDIR in ${DRARRLST[@]}
do
( [[ ! -d "$ISDIR" ]] && printf "\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[0m\\n" "Creating directory " "'/$ISDIR'" "." && mkdir -p "$ISDIR" ) || printf "\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[0m\\n" "Directory " "'/$ISDIR'" " exists; Continuing:"
done
}

_PREPINSTALLDIR_() {
cd "$INSTALLDIR" || exit 196
_PREPROOTDIR_
_SETLANGUAGE_
_ADDADDS_
_DOMODdotfiles_
_MAKEFINISHSETUP_
_MAKESETUPBIN_
_MAKESTARTBIN_
_FIXOWNER_
if [ "$ELCR" = 0 ]
then
exit	## Create ~/TermuxArchBloom directory and Arch Linux in Termux PRoot root directory skeleton.
fi
}

_PREPROOT_() {
if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = "$CPUABIX8664" ]] || [[ "$CPUABI" = "${CPUABIX8664//_/-}" ]] || [[ "$CPUABI" = i386 ]]
then
proot --link2symlink -0 bsdtar -p -xf "$IFILE" --strip-components 1 2>/dev/null ||:
else
proot --link2symlink -0 bsdtar -p -xf "$IFILE" 2>/dev/null ||:
fi
}

_RUNFINISHSETUP_() {
_SEDUNCOM_() {
sed -i "/\/mirror.archlinuxarm.org/ s/^# *//" "$INSTALLDIR/etc/pacman.d/mirrorlist" || _PSGI1ESTRING_ "sed -i _SEDUNCOM_ necessaryfunctions.bash ${0##*/}" # sed replace a character in a matched line in place
}
_ADDresolvconf_
ALMLLOCN="$INSTALLDIR/etc/pacman.d/mirrorlist"
cp "$ALMLLOCN" "$INSTALLDIR/var/backups/${INSTALLDIR##*/}/etc/mirrorlist.$SDATE.bkp" || _PSGI1ESTRING_ "cp _RUNFINISHSETUP_ necessaryfunctions.bash ${0##*/}"
if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = i386 ]]
then
AL32MRLT="https://git.archlinux32.org/packages/plain/core/pacman-mirrorlist/mirrorlist"
printf "\\e[0m\\n%s\\n" "Updating ${ALMLLOCN##*/} from $AL32MRLT."
curl --retry 4 "$AL32MRLT" -o "$ALMLLOCN"
_DOMIRROR_
elif [[ "$CPUABI" = "$CPUABIX8664" ]] || [[ "$CPUABI" = "${CPUABIX8664//_/-}" ]]
then
AL64MRLT="https://www.archlinux.org/mirrorlist/all/"
printf "\\e[0m\\n%s\\n" "Updating ${ALMLLOCN##*/} from $AL64MRLT."
curl -L --retry 4 "$AL64MRLT" -o "$ALMLLOCN"
_DOMIRROR_
fi
printf "\\e[0m"
if [[ "$FSTND" ]]
then
NMIR="$(awk -F'/' '{print $3}' <<< "$NLCMIRROR")"
sed -i '/http\:\/\/mir/ s/^#*/# /' "$INSTALLDIR/etc/pacman.d/mirrorlist"
# test if NMIR is in mirrorlist file
if grep "$NMIR" "$INSTALLDIR/etc/pacman.d/mirrorlist"
then
printf "%s\\n" "Found server $NMIR in /etc/pacman.d/mirrorlist; Uncommenting $NMIR."
sed -i "/$NMIR/ s/^# *//" "$INSTALLDIR/etc/pacman.d/mirrorlist"  || _SEDUNCOM_ || _PSGI1ESTRING_ "sed -i _RUNFINISHSETUP_ necessaryfunctions.bash ${0##*/}"
else
printf "%s\\n" "Did not find server $NMIR in /etc/pacman.d/mirrorlist; Adding $NMIR to file /etc/pacman.d/mirrorlist."
printf "%s\\n" "Server = $NLCMIRROR/\$arch/\$repo" >> "$INSTALLDIR/etc/pacman.d/mirrorlist"
fi
else
if [[ -z "${DOMIRLCR:-}" ]]
then
DOMIRLCR=0
if [[ -z "${USEREDIT:-}" ]] || [[ "$USEREDIT" = "" ]]
then
_EDITORS_
else
if [[ ! "$(sed 1q  "$INSTALLDIR"/etc/pacman.d/mirrorlist)" = "# # # # # # # # # # # # # # # # # # # # # # # # # # #" ]]
then
_EDITFILES_
fi
fi
"$USEREDIT" "$INSTALLDIR"/etc/pacman.d/mirrorlist
fi
fi
"$INSTALLDIR"/root/bin/setupbin.bash || _PRINTPROOTERROR_
}

_SETLANGUAGE_() { # This function uses device system settings to set locale.  To generate locales in a preferred language, you can use "Settings > Language & Keyboard > Language" in Android; Then run 'setupTermuxArch r' for a quick system refresh to regenerate locales in your preferred language.
ULANGUAGE="C"
LANGIN=([0]="$(getprop user.language)")
LANGIN+=([1]="$(getprop user.region)")
LANGIN+=([2]="$(getprop persist.sys.country)")
LANGIN+=([3]="$(getprop persist.sys.language)")
LANGIN+=([4]="$(getprop persist.sys.locale)")
LANGIN+=([5]="$(getprop ro.product.locale)")
LANGIN+=([6]="$(getprop ro.product.locale.language)")
LANGIN+=([7]="$(getprop ro.product.locale.region)")
:>"$INSTALLDIR"/etc/locale.gen
ULANGUAGE="${LANGIN[0]:-C}_${LANGIN[1]:-C}"
if ! grep -q "$ULANGUAGE" "$INSTALLDIR"/etc/locale.gen
then
ULANGUAGE="C"
fi
if [[ "$ULANGUAGE" != *_* ]]
then
ULANGUAGE="${LANGIN[3]:-C}_${LANGIN[2]:-C}"
if ! grep -q "$ULANGUAGE" "$INSTALLDIR"/etc/locale.gen
then
ULANGUAGE="C"
fi
fi
for i in "${!LANGIN[@]}"
do
if [[ "${LANGIN[i]}" = *-* ]]
then
ULANGUAGE="${LANGIN[i]//-/_}"
break
fi
done
if [[ "$ULANGUAGE" != *_* ]]
then
ULANGUAGE="${LANGIN[6]:-C}_${LANGIN[7]:-C}"
if ! grep -q "$ULANGUAGE" "$INSTALLDIR"/etc/locale.gen
then
ULANGUAGE="C"
fi
fi
if [[ "$ULANGUAGE" != *_* ]]
then
ULANGUAGE="en_US"
fi
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\n" "Setting locales to: " "Language " ">> $ULANGUAGE << " "Region" ": Please wait a moment."
}

_SETLOCALE_() { # This function uses device system settings to set locale.  To generate locales in a preferred language you can use "Settings > Language & Keyboard > Language" in Android;  Then run 'setupTermuxArch re' for a quick system refresh.
printf "%s\\n" "##  File locale.conf was generated by ${0##*/} at ${FTIME//-}." > etc/locale.conf
for LC_T in "${!LC_TYPE[@]}"
do
printf "%s\\n" "${LC_TYPE[LC_T]}=$ULANGUAGE.UTF-8" >> etc/locale.conf
done
sed -i "/\\#$ULANGUAGE.UTF-8 UTF-8/{s/#//g;s/@/-at-/g;}" etc/locale.gen
}

_TOUCHUPSYS_() {
_ADDmotd_
_PREPPACMANCONF_
_SETLOCALE_
_RUNFINISHSETUP_
rm -f root/bin/"$BINFNSTP"
rm -f root/bin/setupbin.bash
[ -f root/bin/"$BINFNSTP" ] && rm -f root/bin/"$BINFNSTP"
[ -f root/bin/setupbin.bash ] && rm -f root/bin/setupbin.bash
printf "\\n\\e[1;34m%s  \\e[0m\\n\\n" "🕛 > 🕤 Arch Linux in Termux is installed and configured 📲  "
printf "\\e]2;%s\\007" " 🕛 > 🕤 Arch Linux in Termux is installed and configured 📲"
}
# necessaryfunctions.bash FE
