#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################

[ "$CPUABI" = i386 ] && CPUABI="x86"
CACHECPBI="${CPUABI/_/-}"
CACHEDIRPKG="/storage/emulated/0/Android/data/com.termux/files/cache/archlinux/$CACHECPBI/var/cache/pacman/pkg/"
CACHEDIR="/storage/emulated/0/Android/data/com.termux/files/cache/archlinux/$CACHECPBI/"
PREFIXDATAFILES="/storage/emulated/0/Android/data/com.termux/"
CACHEDIRSUFIX="files/cache/archlinux/$CACHECPBI/var/cache/pacman/pkg/"
BINFNSTP="finishsetup.bash"
LC_TYPE=("LANG" "LANGUAGE" "LC_ADDRESS" "LC_COLLATE" "LC_CTYPE" "LC_IDENTIFICATION" "LC_MEASUREMENT" "LC_MESSAGES" "LC_MONETARY" "LC_NAME" "LC_NUMERIC" "LC_PAPER" "LC_TELEPHONE" "LC_TIME")
TXPRQUON="Termux PRoot with QEMU"
TXPRQUON="Termux PRoot"

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

_MAKESYSTEM_() {
_WAKELOCK_
if [ "$USECACHEDIR" = 0 ]
then
printf '\e[0;32mPopulating from cache files;  \e[1;32mBEGUN\n'
{ cd "$CACHEDIR" 2>/dev/null && printf '%s' "cd $CACHEDIR && " ; } || { cd "$PREFIXDATAFILES" && mkdir -p "$CACHEDIRSUFIX" && cd "$CACHEDIR" && printf '%s' "cd $PREFIXDATAFILES && mkdir -p $CACHEDIRSUFIX && cd $CACHEDIR && " ; } || exit 196
printf '%s\n' "cp -fr * $INSTALLDIR"
cp -fr * "$INSTALLDIR"
cd "$INSTALLDIR" && printf '%s\n' "cd $INSTALLDIR" || exit 196
printf '\e[0;32mPopulating from cache files;  \e[1;32mDONE\n\n'
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
printf '\e[0;32mGenerating dot files;  \e[1;32mDONE\n'
_MAKEFINISHSETUP_
_MAKESETUPBIN_
_MAKESTARTBIN_
_FIXOWNER_
if [ "$ELCR" = 0 ]
then
tree 2>/dev/null || find . -type f -print | sed 's@.*/@@' | sort
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
curl --retry 4 "$AL32MRLT" -o "$ALMLLOCN" || curl --retry 4 "$AL32MRLT" -o "$ALMLLOCN"
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
LANGIN=([0]="$(getprop user.language)")
LANGIN+=([1]="$(getprop user.region)")
LANGIN+=([2]="$(getprop persist.sys.country)")
LANGIN+=([3]="$(getprop persist.sys.language)")
LANGIN+=([4]="$(getprop persist.sys.locale)")
LANGIN+=([5]="$(getprop ro.product.locale)")
LANGIN+=([6]="$(getprop ro.product.locale.language)")
LANGIN+=([7]="$(getprop ro.product.locale.region)")
ULANGUAGE="${LANGIN[0]:-C}_${LANGIN[1]:-C}"
for LANGSET in "${!LANGIN[@]}"
do
if [[ "${LANGIN[LANGSET]}" = *-* ]]
then
ULANGUAGE="${LANGIN[LANGSET]//-/_}"
break
fi
done
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
_PREPPACMANCONF_ || :
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
