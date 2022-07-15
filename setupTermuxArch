#!/usr/bin/env bash
## Copyright 2017-2022 (c) by SDRausty, all rights reserved, see LICENSE
## hosting termuxarch.github.io/TermuxArch courtesy pages.github.com
## termuxarch.github.io/TermuxArch/CONTRIBUTORS thank you for your help!
################################################################################
set -Eeuo pipefail
shopt -s  extglob nullglob globstar
unset LD_PRELOAD
VERSIONID=2.0.548
_STRPEROR_() { # run on script error
local RV="$?"
printf "\\e[1;48;5;138m %s" "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} NOTICE:  Generated script signal received ${RV:-UNKNOWN} near or at line number ${1:-UNKNOWN} by '${2:-UNKNOWNCOMMAND}'!  "
[ $(ifconfig 2>/dev/null | grep inet | wc -l) = 1 ] && printf "\\e[1;48;5;133m %s" "Please ensure background data is not restricted.  Check the wireless connection.  "
exit "$RV"
}
_STRPEXIT_() { # run on exit
local RV="$?"
if [[ -n "${TAMATRIXENDLCR:-}" ]]
then
_TAMATRIXEND_
fi
if [[ "$RV" != 0 ]]
then
_PTSTRPXT_
fi
if [[ "$RV" = 0 ]]
then
printf "\\e[0;32mCommand \\e[1;32m'%s' \\e[0;32mversion %s\\e[1;34m: \\e[1;32m%s\\n" "${STRNRG:-}" "${VERSIONID:-}" "DONE 🏁 "
printf "\033]2;%s\\007" "${STRNRG:-}:  DONE 🏁 "
else
printf "\\e[0;32mCommand \\e[1;32m'%s' \\e[0;32mversion %s\\e[1;34m: \\e[1;32m%s\\n" "${STRNRG:-}" "${VERSIONID:-}" "[Exit Signal $RV] DONE 🏁 "
printf "\033]2;%s\\007" "${STRNRG:-} [Exit Signal $RV]:  DONE 🏁 "
fi
[ -z "${TAMPDIR:-}" ] || rm -rf "$TAMPDIR"
printf "\\e[?25h\\e[0m"
set +Eeuo pipefail
}
_STRPHNGP_() { # run on hang up
local RV="$?"
printf "\\e[1;48;5;138m %s" "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} HANG UP:  Generated signal received ${RV:-UNKNOWN} near or at line number ${1:-UNKNOWN} by '${2:-UNKNOWNCOMMAND}'!  "
exit "$RV"
}
_STRPNTRT_() { # run on signal
local RV="$?"
printf "\\e[1;48;5;138m%s" "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} SIGNAL:  Generated signal received ${RV:-UNKNOWN} near or at line number ${1:-UNKNOWN} by '${2:-UNKNOWNCOMMAND}'!  "
exit "$RV"
}
_STRPQUIT_() { # run on quit
local RV="$?"
printf "\\e[1;48;5;138m %s" "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} QUIT:  Quit signal received ${RV:-UNKNOWN} near or at line number ${1:-UNKNOWN} by '${2:-UNKNOWNCOMMAND}'!  "
exit "$RV"
}
_STRPTERM_() { # run on terminate
local RV="$?"
printf "\\e[1;48;5;138m %s" "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} TERMINATE:  Generated signal received ${RV:-UNKNOWN} near or at line number ${1:-UNKNOWN} by '${2:-UNKNOWNCOMMAND}'!  "
exit "$RV"
}
trap '_STRPEROR_ $LINENO $BASH_COMMAND $?' ERR
trap '_STRPEXIT_ $LINENO $BASH_COMMAND $?' EXIT
trap '_STRPHNGP_ $LINENO $BASH_COMMAND $?' HUP
trap '_STRPNTRT_ $LINENO $BASH_COMMAND $?' INT
trap '_STRPQUIT_ $LINENO $BASH_COMMAND $?' QUIT
trap '_STRPTERM_ $LINENO $BASH_COMMAND $?' TERM
ARGS="${@%/}"
PGNM="${0##*/}"
{ [ -z "${ARGS:-}" ] && STRNRG="${0##*/}" ; } || STRNRG="${0##*/} ${ARGS:-}"
if [ "$EUID" = 0 ] || [ "$UID" = 0 ]
then
printf "\\e[1;48;5;168m%s\\e[0m  " "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} SIGNAL:  Please do not use the root login for PRoot:  EXITING..." && exit
fi
if [ -w /root ]
then
printf "\\e[1;48;5;138m%s\\e[0m  " "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} SIGNAL:  Please run '${0##*/}' and 'bash ${0##*/}' from the BASH shell in native Termux:  EXITING..." && exit
fi
_ARG2DIR_() {  # argument as ROOTDIR
ARG2="${@:2:1}"
if [[ -z "${ARG2:-}" ]]
then
ROOTDIR=/arch
else
ROOTDIR=/"$ARG2"
fi
_PREPTERMUXARCH_
}
_CHK_() {
if sha512sum -c --quiet termuxarchchecksum.sha512
then
if [[ -z "${INSTALLDIR:-}" ]]	# is unset
then	# exit here or the program will run on
printf "\\e[0;34m%s \\e[1;34m%s \\e[1;32m%s\\n" " 🕛 = 🕛" "TermuxArch version $VERSIONID integrity:" "OK"
exit 123
else
printf "\\n\\e[0;34m%s \\e[1;34m%s \\e[1;32m%s\\n" " 🕛 > 🕜" "TermuxArch version $VERSIONID integrity:" "OK"
_CHKSELF_
_COREFILESLOAD_
fi
else
printf "\\n"
_PRINTSHA512SYSCHKER_
fi
}
_CHKDWN_() {
sha512sum -c --quiet setupTermuxArch.sha512 && printf "\\e[0;34m%s\\e[1;34m%s\\e[1;32m%s\\n" " 🕛 > 🕐 " "TermuxArch download: " "OK" || _PRINTSHA512SYSCHKER_
TMPCMD="bsdtar -x -p -f setupTermuxArch.tar.gz" && $TMPCMD || printf "\\e[1;48;5;138m%s\\e[0m  " "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} SIGNAL $TMPCMD:  CONTINUING..."
}
_CHKSELF_() {	# compare setupTermuxArch and file being used
cd "$WFDIR"	# change directory to working file directory
if [[ "$(<"$TAMPDIR"/setupTermuxArch)" != "$(<"${0##*/}")" ]] # differ
then	# update the working file to newest version
## update working file
cd "$WDIR"
cp "$TAMPDIR/setupTermuxArch" "$0"
[[ -z "${ARGS:-}" ]] && printf "\\n\\e[1;32mFile \\e[0;32m'%s'\\e[1;32m was UPDATED\\e[1;34m:\\e[0;32m  Please run 'bash %s' again if this automatic update was unsuccessful.\\n\\n\\e[1;32mRESTARTED \\e[0;32m'%s'\\e[1;34m:\\e[1;32m CONTINUING...\\n\\n" "${0##*/}" "${0##*/}" "${0##*/}" || printf "\\n\\e[1;32mFile \\e[0;32m'%s'\\e[1;32m was UPDATED\\e[1;34m:\\e[0;32m run 'bash %s' again if this automatic update was unsuccessful;  You should be able to use the '!!' command to run '%s' again.\\n\\e[1;32mRESTARTED \\e[0;32m'%s'\\e[1;34m:\\e[1;32m CONTINUING...\\n\\n" "${0##*/}" "$STRNRG" "$STRNRG" "$STRNRG"
## restart with updated version
. $0 $ARGS
fi
cd "$TAMPDIR"
}
_CHOOSEABI_(){
if [[ -z "$CPUABILIST64" ]]
then
ARCHITEC="i386"
CPUABI="i386"
else
ARCHITEC="x86_64"
CPUABI="x86_64"
fi
}
_CHOOSEABIx86_(){
CPUABILIST64="$(getprop ro.product.cpu.abilist64)"
if [[ $CPUABI == *86* ]]
then
_OPT1_ "$@"
_INTRO_ "$@"
else
_CHOOSEABI_
_OPT1_ "$@"
_QEMU_
_INTRO_ "$@"
fi
}
_COREFILES_() {
[[ -f archlinuxconfig.bash ]] && [[ -f espritfunctions.bash ]] && [[ -f fbindsfunctions.bash ]] && [[ -f getimagefunctions.bash ]] && [[ -f initkeyfunctions.bash ]] && [[ -f knownconfigurations.bash ]] && [[ -f maintenanceroutines.bash ]] && [[ -f necessaryfunctions.bash ]] && [[ -f printoutstatements.bash ]] && [[ -f setupTermuxArch ]]
}
_COREFILESDO_() {
cd "$WFDIR" || exit 169	# change directory to working file directory
if _COREFILES_
then
LOADLCRFILES=0 && _COREFILESLOAD_
else
cd "$TAMPDIR"
_DWNL_
_CHKDWN_
_CHK_ "$@"
fi
}
_COREFILESLOAD_() {
if [[ "$OPT" = BLOOM ]]
then
rm -f termuxarchchecksum.sha512
fi
if [[ "$OPT" = MANUAL ]]
then
_MANUAL_
fi
. necessaryfunctions.bash
_LOADCONF_
. fbindsfunctions.bash
. initkeyfunctions.bash
. maintenanceroutines.bash
. archlinuxconfig.bash
. espritfunctions.bash
. getimagefunctions.bash
. printoutstatements.bash
}
_DEPENDDM_() { # check and set download manager
for PKG in "${!ADM[@]}"
do
if [[ -x $(command -v "${ADM[$PKG]}") ]]
then
DM="$PKG"
printf "\\nFound download tool '%s': Continuing...\\n" "$PKG"
break
fi
done
}
_DEPENDIFDM_() { # check if download tool is available and set for install
for PKG in "${!ADM[@]}" # check from available toolset and set one for install
do #	check for both set DM and if tool exists on device
if [[ "$DM" = "$PKG" ]] && [[ ! -x $(command -v "${ADM[$PKG]}") ]]
then	#	sets both download tool for install and exception check.
PKGS+=($PKG)
printf "\\nSetting download tool '%s' for install: Continuing...\\n" "$PKG"
fi
done
}
_DEPENDS_() {	# check for missing commands
_INPKGS_() {	# install missing packages
STRNGB="\\e[1;38;5;146m%s"
STRNGC="\\e[1;38;5;124m%s"
if [[ "$COMMANDIF" = au ]] # can enable rollback https://wae.github.io/au/
then	# use 'au' to install missing packages
au "${PKGS[@]}" && printf "$STRNGB%s" "$STRING1F" || printf "$STRNGC%s" "$STRING2"
elif [[ "$COMMANDIF" = pkg ]]
then	# use 'pkg' to install missing packages
pkg install "${PKGS[@]}" printf '%s' "$STRNGC $STRING1" || printf '%s' "$STRNGC $STRING2"
elif [[ "$COMMANDIF" = apt ]]
then	# use 'apt' to install missing packages
apt install "${PKGS[@]}" --yes && printf "$STRNGB%s" "$STRING1" || printf "$STRNGC%s" "$STRING2"
fi
}
if [[ -z "${VLORALCR:-}" ]]
then
PKGS=(bsdtar proot)
else
PKGS=(pulseaudio bsdtar proot)
fi
printf "\\e[1;34mChecking prerequisites...\\n\\e[1;32m"
ADM=([aria2]=aria2c [axel]=axel [curl]=curl [lftp]=lftpget [wget]=wget)
if [[ "$DM" != "" ]]
then
_DEPENDIFDM_
fi
if [[ "$DM" = "" ]]
then
_DEPENDDM_
fi
## set and install lftp if nothing else was found
if [[ "$DM" = "" ]]
then
DM=lftp
PKGS+=(lftp)
printf "Setting download tool 'lftp' for install: Continuing...\\n"
fi
for PKG in "${PKGS[@]}"
do	# check for missing commands
COMMANDP="$(command -v "$PKG")" || printf "\\e[1;38;5;242mCommand %s not found: Continuing...\\e[0m\\n" "$PKG" # test if command exists
COMMANDPF="${COMMANDP##*/}"
if [[ "$COMMANDPF" != "$PKG" ]]
then
_INPKGS_
fi
done
printf "\\n\\e[1;38;5;242mUsing %s to manage downloads.\\e[0m\\n" "${DM:-lftp}"
printf "\\n\\e[0;34m 🕛 > 🕧 \\e[1;34mPrerequisites: \\e[1;32mOK  \\e[1;34mDownloading TermuxArch...\\n\\n\\e[0;32m"
}
_DEPENDSBLOCK_() {
_DEPENDS_ || _PSGI1ESTRING_ "_DEPENDS_ _DEPENDSBLOCK_ ${0##*/}"
_COREFILESDO_ "$@"
}
_DWNL_() { # download TermuxArch from Github
FILE[sha]="https://raw.githubusercontent.com/TermuxArch/TermuxArch/master/setupTermuxArch.sha512"
FILE[tar]="https://raw.githubusercontent.com/TermuxArch/TermuxArch/master/setupTermuxArch.tar.gz"
if [[ "$DM" = aria2 ]]
then	# use https://github.com/aria2/aria2
"${ADM[aria2]}" -Z "${FILE[sha]}" "${FILE[tar]}"
elif [[ "$DM" = axel ]]
then	# use https://github.com/mopp/Axel
"${ADM[axel]}" -a "${FILE[sha]}"
"${ADM[axel]}" -a "${FILE[tar]}"
elif [[ "$DM" = curl ]]
then	# use https://github.com/curl/curl
"${ADM[curl]}" "$DMVERBOSE" -O {"${FILE[sha]},${FILE[tar]}"}
elif [[ "$DM" = wget ]]
then	# use https://github.com/mirror/wget
_DOADMWGET_() {
"${ADM[wget]}" "$DMVERBOSE" -N --show-progress "${FILE[sha]}" "${FILE[tar]}"
}
_DOADMWGET_  || (au wget && "$PREFIX/bin/wget" "$DMVERBOSE" -N --show-progress "${FILE[sha]}" "${FILE[tar]}") || _PSGI1ESTRING_ "_DOADMWGET_ _DWNL_ ${0##*/}"
else	# use https://github.com/lavv17/lftp
"${ADM[lftp]}" "${FILE[sha]}" "${FILE[tar]}"
fi
}
_EDITORCHOOSER_() {	# add 'export EDITOR=editor_name' to HOME/.bash_profile in order to use your favorite editor during runtime
if [[ -z "${EDITOR:-}" ]]
then
if command -v editor 1>/dev/null
then
USEREDIT="editor"
fi
elif [[ -n "${EDITOR:-}" ]]
then
USEREDIT="$EDITOR"
fi
if [[ -z "${EDITOR:-}" ]]
then
USEREDIT="nano"
fi
}
_INTRO_() {
printf "\033]2;%s\007" "bash $STRNRG 📲"
_SETROOT_EXCEPTION_
_INSTLLDIRCHK_
_PRINTINTRO_ "will attempt to install Linux in " "~/${INSTALLDIR##*/}" ".  Arch Linux in TermuxArch PRoot QEMU will be available upon successful completion"
_DEPENDSBLOCK_ "$@"
if [[ "$LCC" = "1" ]]
then
_LOADIMAGE_ "$@"
else
_MAINBLOCK_
fi
}
_INTROBLOOM_() { # BLOOM = setupTermuxArch manual verbose
OPT=BLOOM
printf "\033]2;%s\007" "bash ${0##*/} bloom 📲"
_PRINTINTRO_ "bloom option" "" ""
_PREPTERMUXARCH_
_DEPENDSBLOCK_ "$@"
_BLOOM_
}
_INTROSYSINFO_() {
printf "\033]2;%s\007" "bash ${0##*/} sysinfo 📲"
_SETROOT_EXCEPTION_
_PRINTINTRO_ "will create a system information file" "" ""
_DEPENDSBLOCK_ "$@"
_SYSINFO_ "$@"
}
_DODIRCHK_() {
_SETROOT_EXCEPTION_
if [ ! -d "$INSTALLDIR" ] || [ ! -d "$INSTALLDIR/root/bin" ] || [ ! -d "$INSTALLDIR/var/binds" ] || [ ! -f "$INSTALLDIR/bin/we" ] || [ ! -f "$INSTALLDIR/usr/bin/env" ]
then
printf "\\n\\e[0;33m%s\\e[1;33m%s\\e[0;33m.\\n\\n" "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} NOTICE!  " "The root directory structure is of ~/${INSTALLDIR##*/} seems to be incorrect; Cannot continue '$STRNRG'!  This command '${0##*/} help' has more information"
if [ -d "$INSTALLDIR"/tmp ]
then	# check for superfluous tmp directory
DIRCHECK=0
DIRNAME=(dev etc home opt proc root sys usr var)
for IDIRNAME in ${DIRNAME[@]}
do
if [ ! -d "$INSTALLDIR/$IDIRNAME" ]
then
DIRCHECK=1
else
DIRCHECK=0
fi
done
fi
if [ -z "${DIRCHECK:-}" ]
then
printf "Variable DIRCHECK is unbound.\\n"
elif [ "$DIRCHECK" -eq 1 ]
then	# delete superfluous tmp dir
rm -rf "$INSTALLDIR"/tmp
rmdir "$INSTALLDIR" ||  _PSGI1ESTRING_ "rmdir INSTALLDIR _DODIRCHK_ ${0##*/}"
fi
exit 204
fi
}
_INTROREFRESH_() {
printf '\033]2;  bash setupTermuxArch refresh 📲 \007'
if [ "${OPT:-}" = FORCE ]
then
_DODIRCHK_
else
_SETROOT_EXCEPTION_
fi
_PRINTINTRO_ "will refresh your TermuxArch files in " "~/${INSTALLDIR##*/}" ".  Arch Linux in TermuxArch PRoot QEMU will be available upon successful completion"
_DODIRCHK_
_DEPENDSBLOCK_ "$@"
_REFRESHSYS_ "$@"
}
_INSTLLDIRCHK_() {
if [[ -f "$INSTALLDIR"/bin/we ]] && [[ -d "$INSTALLDIR"/usr/local/termuxarch/bin ]] && [[ -d "$INSTALLDIR"/root/bin ]] && [[ -d "$INSTALLDIR"/var/binds ]]
then
printf "\\n\\e[0;33m%s\\e[1;33m%s\\e[0;33m.\\n\\n" "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} NOTICE!  " "The root directory structure of ~/${INSTALLDIR##*/} appears correct;  Cannot continue '$STRNRG' to install Arch Linux in TermuxArch PRoot QEMU!  Commands '${0##*/} h[e[lp]]' have more information"
exit 205
fi
}
_LOADCONF_() {
if [[ -f "${WDIR}setupTermuxArchConfigs.bash" ]]
then
. "${WDIR}setupTermuxArchConfigs.bash"
_PRINTCONFLOADED_
else
. knownconfigurations.bash
fi
}
_MANUAL_() {
printf '\033]2; bash setupTermuxArch manual 📲 \007'
if [[ -f "${WDIR}setupTermuxArchConfigs.bash" ]]
then
$USEREDIT "${WDIR}setupTermuxArchConfigs.bash"
else
cp knownconfigurations.bash "${WDIR}setupTermuxArchConfigs.bash"
sed -i "7s/.*/\# The architecture of this device is $CPUABI; Adjust configurations in the appropriate section.  Change mirror (https:\/\/wiki.archlinux.org\/index.php\/Mirrors and https:\/\/archlinuxarm.org\/about\/mirrors) to desired geographic location to resolve 404 and checksum issues.  /" "${WDIR}setupTermuxArchConfigs.bash"
$USEREDIT "${WDIR}setupTermuxArchConfigs.bash"
fi
}
_NAMEINSTALLDIR_() {
if [[ "$ROOTDIR" = "" ]]
then
ROOTDIR=arch
fi
INSTALLDIR="$(printf "%s\\n" "$HOME/${ROOTDIR%/}" | sed 's#//*#/#g')"
}
_NAMESTARTARCH_() {
DARCH="$(printf "%s\\n" "${ROOTDIR%/}"|sed 's#//*#/#g')" # ${@%/} removes trailing slash
if [[ "$DARCH" = "/arch" ]]
then
AARCH=""
STARTBI2=arch
else
AARCH="$(printf "%s\\n" "$DARCH" | sed 's/\//\+/g')"
STARTBI2=arch
fi
STARTBIN=start"$STARTBI2$AARCH"
}
_OPT1_() {
if [[ -z "${2:-}" ]]
then
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
elif [[ "${2//-}" = [Bb]* ]]
then
shift
printf "%s\\n" "Setting mode to bloom."
_INTROBLOOM_ "$@"
elif [[ "${2//-}" = [Dd]* ]] || [[ "${2//-}" = [Ss]* ]]
then
shift
printf "%s\\n" "Setting mode to sysinfo."
_ARG2DIR_ "$@"
_INTROSYSINFO_ "$@"
elif [[ "${2//-}" = [Ii]* ]]
then
shift
printf "%s\\n" "Setting mode to install."
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
elif [[ "${2//-}" = [Mm][Ii]* ]]
then
shift
printf "%s\\n" "Setting mode to manual install."
OPT=MANUAL
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
elif [[ "${2//-}" = [Mm]* ]]
then
shift
printf "%s\\n" "Setting mode to manual."
OPT=MANUAL
_OPT2_ "$@"
elif [[ "${2//-}" = [Rr][Ee][Ff][Rr][Ee]* ]]
then
shift
printf "\\nSetting mode to full refresh.\\n"
_PRPREFRESH_ "5"
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
_INTROREFRESH_ "$@"
elif [[ "${2//-}" = [Rr][Ee][Ff][Rr]* ]]
then
shift
printf "\\nSetting mode to 4 refresh.\\n"
_PRPREFRESH_ "4"
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
_INTROREFRESH_ "$@"
elif [[ "${2//-}" = [Rr][Ee][Ff]* ]]
then
shift
printf "\\nSetting mode to 3 refresh.\\n"
_PRPREFRESH_ "3"
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
_INTROREFRESH_ "$@"
elif [[ "${2//-}" = [Rr][Ee]* ]]
then
shift
printf "\\nSetting mode to 2 refresh.\\n"
_PRPREFRESH_ "2"
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
_INTROREFRESH_ "$@"
elif [[ "${2//-}" = [Rr]* ]]
then
shift
printf "%s\\n" "Setting mode to 1 refresh."
_PRPREFRESH_ "1"
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
_INTROREFRESH_ "$@"
else
_OPT2_ "$@"
fi
}
_OPT2_() {
if [[ -z "${3:-}" ]]
then
shift
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
elif [[ "${3//-}" = [Ii]* ]]
then
shift 2
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
_INTRO_ "$@"
elif [[ "${3//-}" = [Mm][Ii]* ]]
then
shift 2
printf "%s\\n" "Setting mode to manual install."
OPT=MANUAL
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
elif [[ "${3//-}" = [Mm]* ]]
then
shift 2
printf "%s\\n" "Setting mode to manual."
OPT=MANUAL
_OPT2_ "$@"
elif [[ "${3//-}" = [Rr][Ee][Ff][Rr][Ee]* ]]
then
shift 2
printf "\\nSetting mode to full refresh.\\n"
_PRPREFRESH_ "5"
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
_INTROREFRESH_ "$@"
elif [[ "${3//-}" = [Rr][Ee][Ff][Rr]* ]]
then
shift 2
printf "\\nSetting mode to 4 refresh.\\n"
_PRPREFRESH_ "4"
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
_INTROREFRESH_ "$@"
elif [[ "${3//-}" = [Rr][Ee][Ff]* ]]
then
shift 2
printf "\\nSetting mode to 3 refresh.\\n"
_PRPREFRESH_ "3"
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
_INTROREFRESH_ "$@"
elif [[ "${3//-}" = [Rr][Ee]* ]]
then
shift 2
printf "\\nSetting mode to 2 refresh.\\n"
_PRPREFRESH_ "2"
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
_INTROREFRESH_ "$@"
elif [[ "${3//-}" = [Rr]* ]]
then
shift 2
printf "\\nSetting mode to 1 refresh.\\n"
_PRPREFRESH_ "1"
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
_INTROREFRESH_ "$@"
else
shift
_ARG2DIR_ "$@"
_PREPTERMUXARCH_
fi
}
_PREPTMPDIR_() {
[ -d "$INSTALLDIR/tmp" ] || { mkdir -p "$INSTALLDIR/tmp" && chmod 777 "$INSTALLDIR/tmp" && chmod +t "$INSTALLDIR/tmp" ; }
TAMPDIR="$INSTALLDIR/tmp/${0##*/}$STIME$PPID"
[ -d "$TAMPDIR" ]|| mkdir -p "$TAMPDIR"
}
_PREPTERMUXARCH_() {
_NAMEINSTALLDIR_
_NAMESTARTARCH_
_PREPTMPDIR_ || _PSGI1ESTRING_ "_PREPTMPDIR_ _PREPTERMUXARCH_ ${0##*/}"
_EDITORCHOOSER_
}
_PRINTERRORMSG_() {
printf "\\e[1;31m%s\\e[1;37m%s\\n\\n" "Signal generated in '$1'; Cannot complete task; " "Continuing..."
printf "\\e[1;34mIf you find improvements for \\e[0;34m'%s' \\e[1;34mplease open an issue and an accompanying pull request.  A pull request can assist in shedding more light on an issue.\\n\\n" "${0##*/}"
}
_PRPREFRESH_() {
printf "\\n%s\\n" "Refresh mode is set to refresh mode $1;  Initializing system refresh..."
LCR="$1"
}
_PRINTCONFLOADED_() {
printf "\\n\\e[0;34m%s \\e[1;34m%s \\e[0;32m%s\\e[1;32m%s \\e[1;34m%s \\e[1;32m%s\\n" " 🕛 > 🕑" "TermuxArch configuration" "$WDIR" "setupTermuxArchConfigs.bash" "loaded:" "OK"
}
_PRINTSHA512SYSCHKER_() {
printf "\\n\\e[07;1m\\e[31;1m\\n%s \\e[34;1m\\e[30;1m%s \\n\\e[0;0m\\n" " 🔆 ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} NOTICE sha512sum mismatch!  Setup initialization mismatch!  Is your wireless on?" "  Try again, initialization was not successful this time.  Wait a little while.  Then run the command 'bash $STRNRG' again..."
printf '\033]2; Run %s again...\007' "bash $STRNRG"
exit 124
}
_PRINTSTARTBIN_USAGE_() {
_NAMESTARTARCH_
if [[ -x "$(command -v "$STARTBIN")" ]]
then
printf "\\e[1;38;5;155m\\n%s\\n" "$STARTBIN help"
"$STARTBIN" help
printf "\\n"
else
printf "\\n"
fi
}
_PRINTUSAGE_() {
printf "\\n\\e[1;32m  %s     \\e[0;32mcommands \\e[1;32m%s \\e[0;32m%s\\n" "HELP" "'${0##*/} he[lp]'" "shows this help screen."
printf "\\n\\e[1;32m  %s    \\e[0;32mcommand \\e[1;32m%s \\e[0;32m%s\\n" "TERSE" "'${0##*/} he[lp]'" "shows the terse help screen."
printf "\\n\\e[1;32m  %s  \\e[0;32mcommand \\e[1;32m%s \\e[0;32m%s\\n" "VERBOSE" "'${0##*/} h[elp]'" "shows the verbose help screen."
printf "\\n\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n" "Usage information for" " ${0##*/}" " version $VERSIONID.  Some arguments can be abbreviated to one, two and three letters each;  Two and three letter arguments are acceptable.  For example" " 'bash ${0##*/} cs'" " will use 'curl' to download TermuxArch and produce a file like" " setupTermuxArchSysInfo$STIME.log" " populated with system information.  If you have a new smartphone that you are not familiar with, once created, this file" " setupTermuxArchSysInfo$STIME.log" " might make for an interesting read in order to find out more about the device you might be holding in the palm of your hand right at this moment.  User configurable variables are in file" " setupTermuxArchConfigs.bash." "  To create this file from file" " knownconfigurations.bash" " in the working directory, execute" " 'bash ${0##*/} manual'" " to create and edit file" " setupTermuxArchConfigs.bash" "."
printf "\\n\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n" "  INSTALL" "  You can run" " ${0##*/}" " without arguments in a bash shell to install Arch Linux in a PRoot QEMU container in a smartphone, smartTV, table, wearable and more...  Command" " 'bash ${0##*/} curl'"  " will envoke 'curl' as the download manager.  You can copy" " knownconfigurations.bash" " to" " setupTermuxArchConfigs.bash" " with the command" " 'bash ${0##*/} manual'" " to edit your preferred mirror site, refine the init statement and to access more options.  Change mirror to desired geographic location to resolve download, 404 and checksum issues should these occur."
printf "\\n\\e[0;32m  %s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n" "After editing file" " setupTermuxArchConfigs.bash" ", you can run" " 'bash ${0##*/}'" " and" " setupTermuxArchConfigs.bash" " loads automatically from the working directory.  User configurable variables are present in this file for your convenience. This link" " https://github.com/SDRausty/TermuxArch/issues/212" " at GitHub has the most current information about setting Arch Linux in PRoot QEMU as the default login shell in Termux in your smartphone, tablet, smartTV, wearable and more.  If you choose to, or are simply curious about setting Arch Linux in PRoot QEMU as the default login shell, please be well acquainted with safe mode;  Long tapping on NEW SESSION will open a new session in safe mode.  This mode can be used to reset the default shell."
printf "\\n\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n" "  PURGE    " "command " "'${0##*/} purge' " "uninstalls Arch Linux in PRoot from Termux."
printf "\\n\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "  SYSINFO  " "command" " '${0##*/} sysinfo'" " creates a system information file;  A file like" " 'setupTermuxArchSysInfo$STIME.log'" " will be populated with device and system information in the working directory.  Please post information from this file along with details at" " https://github.com/TermuxArch/TermuxArch/issues"  " if questions or comments are related to a particular device;  Should screenshots help in resolving an issue, include these with information from this system information log file as well.  If you are sharing an issue please consider creating a pull request at"  " https://github.com/TermuxArch/TermuxArch/pulls"  " also.  A pull request can give a much better perspective of how an issue can be easily resolved."
if [[ "$LCC" = 1 ]]
then
printf "\\e[1;38;5;150m%s\\n\\n" "$(sed -n '600,1240p;1240p' "$0" | grep "^##" | sed 's/## /\n  /g')"
printf "\\e[0;32m  Command \\e[1;32m%s\\e[0;32m has \\e[1;32m%s\\e[0;32m usage information:\\n" "'$STARTBIN help'" "'$STARTBIN'"
_PRINTSTARTBIN_USAGE_
else
printf "\\e[0;32m  Command \\e[1;32m%s\\e[0;32m has \\e[1;32m%s\\e[0;32m usage information.\\n\\n" "'$STARTBIN help'" "'$STARTBIN'"
fi
}
_PRINTINTRO_() {
printf "\\n\\e[0;34m 🕛 > 🕛 \\e[1;34mＴｅｒｍｕｘＡｒｃｈ %s $1\\e[1;32m$2\\e[1;34m$3.  You can use '!!' to run this BASH script again with options.  Please check the wireless connection if you do not see one o'clock 🕐 below and ensure background data is not restricted.  The command \\e[1;32mbash %s help \\e[1;34mhas additional information about \\e[1;32m%s\\e[1;34m.  \\e[0;34m" "version $VERSIONID" "${0##*/}" "${0##*/}"
}
_PSGI1ESTRING_() {	# print signal generated in arg 1 format
printf "\\e[1;33m%s\\e[1;34m; \\e[1;32mCONTINUING...  \\e[0;34mExecuting \\e[0;32m%s\\e[0;34m in the native shell once the installation and configuration process completes will attempt to finish the autoconfiguration and installation if the installation and configuration processes were not completely successful.  Should better solutions for \\e[0;32m%s\\e[0;34m be found, please open an issue and accompanying pull request if possible.\\nThe entire script can be reviewed by creating a \\e[0;32m%s\\e[0;34m directory with the command \\e[0;32m%s\\e[0;34m which can be used to access the entire installation script.  This option does NOT configure and install the root file system.  This command transfers the entire script into the home directory for hacking, modification and review.  The command \\e[0;32m%s\\e[0;34m has more information about how to use use \\e[0;32m%s\\e[0;34m.\\n" "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} SIGNAL GENERATED in '$1'" "'bash ${0##*/} refresh'" "'${0##*/}'" "'~/TermuxArchBloom/'" "'${0##*/} b'" "'${0##*/} help'" "'${0##*/}'"
}
_PTSTRPXT_() { # print run on exit messages
printf "\\e[0;32mPlease run 'bash %s' again, or use 'bash %s refresh' once Arch Linux is installed in TermuxArch PRoot QEMU.  " "${STRNRG:-}" "${0##*/}"
printf "\\e[0;32mRunning command '%s refresh' assists in completing the installation and configuration.  This command also updates the system to the newest version and runs the command 'keys'.  If command '%s refresh' does not assist in completing the tasks of installing and configuring the Arch Linux system completely, these alternate commands '%s re' then using '%s r' helps in the order given.  Command 'keys' assists in installing default Arch Linux system keyrings.  " "${0##*/}" "${0##*/}" "${0##*/}" "${0##*/}"
printf "\\e[0;32mCommand '%s refresh' can be used to refresh the Arch Linux system in TermuxArch PRoot QEMU system to the newest version published;  Command '%s sysinfo' has more information and can help with diagnostics.  " "${0##*/}" "${0##*/}"
printf "\\e[1;32mIs the system that you are using [up to date with packages](https://github.com/WAE/au), [Termux app](https://github.com/termux/termux-app/releases) and device software?  "
printf "\\e[0;32mCommand '%s help' has more information.  " "${0##*/}"
}
_QEMU_() {
_QEMUCHCK_() {
if [[ "$CPUABI" == "$1" ]]
then
printf "\\e[1;33m %s\\e[0;33m  %s\\e[1;31m  %s  " "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^}" "QEMU NOTICE!  Machine architecture is $CPUABI.  Please choose a different computer architecture." "Exiting..."
exit 189
fi
}
_INSTLLDIRCHK_
_INST_() { # check for neccessary commands
COMMS="$1"
[ "$COMMS" = "qemu-user-x86_64"  ] && COMMS="qemu-x86_64"
COMMANDR="$(command -v au)" || printf "%s\\n\\n" "$STRING1"
COMMANDIF="${COMMANDR##*/}"
PKG="$2"
[ "$PKG" = "qemu-user-x86_64"  ] && PKG="qemu-user-x86_64"
_INPKGS_() {
printf "%s\\n" "Beginning qemu '$ARCHITEC' setup:"
if [ "$COMMANDIF" = au ]
then
au "$PKG" || printf "%s\\n" "$STRING2"
else
curl -JOL https://wae.github.io/au/au "$PKG" || printf "%s\\n" "$STRING2"
fi
}
if ! command -v "$COMMS"
then
_INPKGS_
fi
}
_INSTLLDIRCHK_
printf "%s'\\n" "Command '$STRNRG':  Please set the architecture to install with PRoot QEMU emulation.  This computer architecture for this device is '$CPUABI'. 32 bit arm7 supports i386 emulated architecture.  64 bit arm64 supports arm7, i386 and x86_64 emulated architectures with PRoot QEMU.  Please select the architecture to install by number (2-5) from this list:"
select ARCHITECTURE in exit armv7 arm64-v8a i386 x86_64 ;
do
[[ "$ARCHITECTURE" == [Ee]* ]] && exit
if [[ "$ARCHITECTURE" == armv7 ]]
then
_QEMUCHCK_ "armeabi-v7a"
ARCHITEC="arm"
CPUABI="armeabi-v7a"
elif [[ "$ARCHITECTURE" == arm64-v8a ]]
then
_QEMUCHCK_ "arm64-v8a"
ARCHITEC="aarch64"
CPUABI="$ARCHITECTURE"
elif [[ "$ARCHITECTURE" == i386 ]]
then
_QEMUCHCK_ "i386"
ARCHITEC="i386"
CPUABI="$ARCHITECTURE"
elif [[ "$ARCHITECTURE" == x86_64 ]]
then
_QEMUCHCK_ "x86_64"
ARCHITEC="x86_64"
CPUABI="$ARCHITECTURE"
fi
[[ $CPUABI == *arm* ]] || [[ $CPUABI == *86* ]] && printf "%s\\n" "Option ($REPLY) with architecture $CPUABI (${ARCHITEC:-}) was picked from this list;  The chosen Arch Linux architecture for installation with emulation is $CPUABI (${ARCHITEC:-}):  " && INCOMM="qemu-user-${ARCHITEC:-}" && QEMUCR=0 && break || printf "%s\\n" "Answer ($REPLY) was chosen;  Please select the architecture by number from this list: (1) armeabi, (2) armeabi-v7a, (3) arm64-v8a, (4) i386, (5) x86_64 or choose option (6) exit to exit command '${0##*/}':"
done
INCOMM="qemu-user-$ARCHITEC" && QEMUCR=0
if ! command -v "${INCOMM//-user}"
then
_INST_ "$INCOMM" "$INCOMM" "${0##*/}" || _PSGI1ESTRING_ "_INST_ _QEMU_ setupTermuxArch ${0##*/}"
fi
printf "Detected architecture is %s;  Install architecture is set to %s.\\n" "$CPUABI" "$ARCHITEC"
}
_RMARCHQ_() {
printf "\\n\\e[0;33m %s \\e[1;33m%s \\e[0;33m%s\\n\\n\\e[1;30m%s\\n" "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^}" "DIRECTORY NOTICE!  ~/${INSTALLDIR##*/}/" "directory detected." "Purge '$INSTALLDIR' as requested?"
if [[ -z "${PURGELCR:-}" ]]
then
PURGEMETHOD="quick "
else
PURGEMETHOD=""
fi
printf "\\e[1;30m"
while true; do
read -n 1 -p "Uninstall '~/${INSTALLDIR##*/}/' with ${PURGEMETHOD}purge? [Y|n] " RUANSWER
if [[ "$RUANSWER" = [Ee]* ]] || [[ "$RUANSWER" = [Nn]* ]] || [[ "$RUANSWER" = [Qq]* ]]
then
printf "\\n%s\\n" "No was answered: uninstalling '~/${INSTALLDIR##*/}/': nothing to do for '~/${INSTALLDIR##*/}/'."
break
elif [[ "$RUANSWER" = [Yy]* ]] || [[ "$RUANSWER" = "" ]]
then
printf "\\e[30m%s\\n" "Uninstalling '~/${INSTALLDIR##*/}/'..."
if grep -q ^pacmd "$PREFIX/etc/profile" && grep -q ^pulseaudio "$PREFIX/etc/profile"
then
awk '!/^pulseaudio/' "$PREFIX/etc/profile" > "$TAMPDIR/profile$FTIME"
awk '!/^pacmd/' "$TAMPDIR/profile$FTIME" > "$PREFIX/etc/profile"
fi
if [[ -d "$INSTALLDIR" ]]
then
_RMARCHRM_
else
printf "%s\\n" "Uninstalling '~/${INSTALLDIR##*/}/': nothing to do for '~/${INSTALLDIR##*/}/'."
fi
if [[ -e "$PREFIX/bin/$STARTBIN" ]]
then
rm -f "$PREFIX/bin/$STARTBIN"
else
printf "%s\\n" "Uninstalling '$PREFIX/bin/$STARTBIN': nothing to do for '$PREFIX/bin/$STARTBIN'."
fi
if [[ -e "$HOME/bin/$STARTBIN" ]]
then
rm -f "$HOME/bin/$STARTBIN"
else
printf "%s\\n" "Uninstalling '$HOME/bin/$STARTBIN': nothing to do for '$HOME/bin/$STARTBIN'."
fi
printf "%s \\e[1;32mDONE\\e[30m\\n\\n" "Uninstalling '~/${INSTALLDIR##*/}/':"
break
else
printf "\\nYou answered \\e[33;1m%s\\e[30m.\\n\\nAnswer \\e[32mYes\\e[30m or \\e[1;31mNo\\e[30m. [\\e[32my\\e[30m|\\e[1;31mn\\e[30m]\\n" "$RUANSWER"
fi
done
}
_RMARCHRM_() {
_RMARCHCRRM_() {	# remove installation
chmod -R 777 "$INSTALLDIR" || { printf "\\e[1;31m%s\\e[1;35m%s\\e[1;31m%s" "Exit signal recieved:" "  Attempting to 'rmdir ${EXONSTGEM##*/}' exception.  Please either remove directory '$EXONSTGEM' manually or use command 'chmod -R 777 ~/${INSTALLDIR##*/}' followed by 'rm -rf ~/${INSTALLDIR##*/}' in order to remove directory '~/${INSTALLDIR##*/}'.  " "Exiting...  " && exit 206 ; }
find "$INSTALLDIR" -type l -delete  || _PSGI1ESTRING_ "find INSTALLDIR _RMARCHRM_ ${0##*/}"
rm -rf "$INSTALLDIR" || _PSGI1ESTRING_ "rm -rf INSTALLDIR _RMARCHRM_ ${0##*/}"
}
_DOEXONSTGE_() {	# remove empty storage directories
printf "\\e[0;35m"
for EXONSTGEM in ${EXONSTGE[@]:-}
do
{ find "$EXONSTGEM" -type l -delete && rmdir "$EXONSTGEM" ; } || { printf "\\e[1;31m%s\\e[1;35m%s\\e[1;31m%s" "Exit signal recieved:" "  Attempting to 'rmdir ${EXONSTGEM##*/}' exception.  Please either remove directory '$EXONSTGEM' manually or use command 'chmod -R 777 ~/${INSTALLDIR##*/}' followed by 'rm -rf ~/${INSTALLDIR##*/}' in order to remove directory '~/${INSTALLDIR##*/}'.  " "Exiting...  " && exit 206 ; }
done
printf "\\e[1;30m"
}
_SETROOT_EXCEPTION_
declare -a EXONSTGE
EXONSTGE=("$(find "$INSTALLDIR" -name storage -type d || printf "")")
if [[ -n "${EXONSTGE:-}" ]]
then
_DOEXONSTGE_
fi
_RMARCHCRRM_
}
_SETROOT_EXCEPTION_() {
if [[ "$INSTALLDIR" = "$HOME" ]] || [[ "$INSTALLDIR" = "$HOME"/ ]] || [[ "$INSTALLDIR" = "$HOME"/.. ]] || [[ "$INSTALLDIR" = "$HOME"/../ ]] || [[ "$INSTALLDIR" = "$HOME"/../.. ]] || [[ "$INSTALLDIR" = "$HOME"/../../ ]]
then
printf  '\033]2;%s\007' "Rootdir exception.  Please run bash ${0##*/} again with different options..."
printf "\\n\\e[1;31m%s\\n\\n" "Rootdir exception.  Please run the script ${0##*/} again with different options..."
exit 125
fi
}
_TAMATRIXEXIT_() { # run when Matrix presentation ends
if [[ -n "${TAMATRIXENDLCR:-}" ]]
then
_TAMATRIXEND_
fi
}
## USER INFORMATION:  Configurable variables such as mirrors and download manager options are in 'setupTermuxArchConfigs.bash'.  Working with 'knownconfigurations.bash' in the working directory is simple.  The command 'bash setupTermuxArch manual' will create 'setupTermuxArchConfigs.bash' in the working directory for editing;  This command 'setupTermuxArch h' has more information.
declare -A ADM		# declare associative array for download tools
declare -A ALLRCTFVR	# declare associative array for all known architectures
ALLRCTFVR=([i386]="i386" [i686]="i686" [x86]="x86" [x86_64]="x86_64" [armeabi]="armeabi" [armv7]="armv7" [armeabi-v7a]="armeabi-v7a" [arm64-v8a]="arm64-v8a")	# populate associative array for all known architectures
declare -A FILE		# declare associative array for download file
declare -a ECLAVARR	# declare indexed array for arrays and variables
declare -a LC_TYPE	# declare indexed array for locale types
declare -a QEMUUSER	# declare indexed array for qemu user tools
declare PRFXTOLS	# declare variable for device tools
declare -A EMPARIAS	# declare associative array for empty variables
EMPARIAS=([COMMANDIF]="" [COMMANDG]="" [DFL]="# used for development" [DM]="" [FILE]="" [FSTND]="" [INSTALLDIR]="" [LCC]="" [LCP]="" [OPT]="" [QEMUCR]="" [ROOTDIR]="" [WDIR]="" [SDATE]="" [STI]="# generates pseudo random number" [STIME]="# generates pseudo random number" [USEREDIT]="")
for PKG in ${!EMPARIAS[@]} ; do declare "$PKG"="" ; done
ECLAVARR=(ARGS BINFNSTP COMMANDIF COMMANDR COMMANDG CPUABI CPUABI5 CPUABI7 CPUABI8 CPUABIX86 CPUABIX8664 DFL DMVERBOSE DM EDO01LCR ELCR USEREDIT FSTND INSTALLDIR LCC LCP LCR OPT PKGS ROOTDIR RWDIR SDATE STI STIME STRING1 STRING2 TMXRCHBND)
for ECLAVARS in ${ECLAVARR[@]} ; do declare $ECLAVARS ; done
ARGS="${@%/}"
## TERMUXARCH FEATURES INCLUDE:
## 1)  Create aliases and commands that aid in using the command line, and assist in accessing the more advanced features like the commands 'pikaur' and 'yay' easily;  The files '.bashrc', '.bash_profile' and 'usr/local/termuxarch/bin/README.md' have more information about this feature,
## 2)  Set timezone and locales from device,
## 3)  Test for correct OS,
## 4)  Get device information via the 'getprop' command,
CPUABI="$(getprop ro.product.cpu.abi)"
CPUABI5="armeabi"	# used for development; 'getprop ro.product.cpu.abi' ascertains architecture
CPUABI7="armeabi-v7a"	# used for development
CPUABI8="arm64-v8a"	# used for development
CPUABIX86="i386"	# used for development
CPUABIX8664="x86_64"	# used for development
DMVERBOSE="-q"	# -v for verbose download manager output from curl and wget;  for verbose output throughout runtime also change in 'setupTermuxArchConfigs.bash' when using 'setupTermuxArch m[anual]'
ELCR=1
ROOTDIR="/arch"
STRING1="COMMAND 'au' enables rollback, available at https://wae.github.io/au/ IS NOT FOUND: Continuing... "
STRING1F="COMMAND 'au' enables auto upgrade and rollback.  Available at https://wae.github.io/au/ is found: Continuing... "
STRING2="Cannot update '${0##*/}' prerequisites: Continuing..."
_COMMANDGNE_() { printf "\\n\\e[1;48;5;138m%s\\n\\n" "ＴｅｒｍｕｘＡｒｃｈ ${PGNM^^} NOTICE:  Run '${0##*/}' and 'bash ${0##*/}' from the native BASH shell in Termux:  EXITING..." && exit 126 ; }
COMMANDG="$(command -v getprop)" || _COMMANDGNE_
_IFBINEXT_() {
if [ -d "$HOME/bin" ] && grep "$HOME/bin" <<< "$PATH"
then
{ curl -L "https://raw.githubusercontent.com/WAE/au/master/$SCMD" -o "$HOME/bin/$SCMD" && chmod 700 "$HOME/bin/$SCMD" ; } || _PSGI1ESTRING_ "curl SCMD to HOME/bin setupTermuxArch ${0##*/}"
else
{ curl -L "https://raw.githubusercontent.com/WAE/au/master/$SCMD" -o "$PREFIX/bin/$SCMD" && chmod 700 "$PREFIX/bin/$SCMD" ; } || _PSGI1ESTRING_ "curl SCMD to PREFIX/bin setupTermuxArch ${0##*/}"
fi
}
SCMD="au"
if ! command -v "$SCMD"  > /dev/null
then
printf "\\e[1;38;5;142mCommand \\e[1;38;5;138m%s\\e[1;38;5;142m not found: \\e[1;38;5;150mContinuing...\\n" "'$SCMD'" && _IFBINEXT_
fi
COMMANDR="$(command -v au)" || COMMANDR="$(command -v pkg)" || COMMANDR="$(command -v apt)"
COMMANDIF="${COMMANDR##*/}"
## 5)  Generate pseudo random numbers to create uniq strings,
SDATE="$(date +%s)" || SDATE="$(shuf -i 0-99999999 -n 1)" || _PSGI1ESTRING_ "SDATE setupTermuxArch ${0##*/}"
if [[ -r /proc/sys/kernel/random/uuid ]]
then
STIME="$(cat /proc/sys/kernel/random/uuid)" && STIME="${STIME//-}" && STIME="${STIME//[[:alpha:]]}" && STIME="${STIME:0:3}"
else
STIME="$SDATE" && STIME="$(rev <<< "${STIME:7:4}")"
fi
ONESA="${SDATE: -1}"
FTIME="$(date +%F%H%M%S)"
STIME="$ONESA$STIME"
## 6)  Determine its own name and location of invocation,
WDIR="$PWD/" && WFDIR="$(realpath "$0")"
WFDIR="${WFDIR%/*}"
## 7)  Create a default Arch Linux in TermuxArch PRoot QEMU user account with the TermuxArch command 'addauser' that also configure user accounts to use the Arch Linux 'sudo' command,
## 8)  Install emulated computer architectures with QEMU in your smartphone with two taps, or in one tap with 'setupTermuxArch visualorca [options]',
## 9)  Help make some of aur installers including the installer the Arch Linux package installers 'pacaur', 'pikaur' and 'yay' with TermuxArch commands 'makeaur*' and more!  Please read /usr/local/termuxarch/bin/README.md for details,
## 10)  And all options are are optional for installing Arch Linux in Android!
## >>>>>>>>>>>>>>>>>>
## >> HELP OPTIONS >>
## >>>>>>>>>>>>>>>>>>
## Open an issue and an accompanying pull request at GitHub if you would like to have any these options amended and/or new options added.  Please see the new feature at Github, the discussion option.  Brackets mean optional.  They are not meant to be typed.
## []  Run default Arch Linux install.
if [[ -z "${1:-}" ]]
then
_OPT1_ "$@"
_INTRO_ "$@"
## [./path/systemimage.tar.gz [customdir]]  Network install can be substituted by copying systemimage.tar.gz and systemimage.tar.gz.md5 files with 'setupTermuxArch ./[path/]systemimage.tar.gz' and 'setupTermuxArch /absolutepath/systemimage.tar.gz'.  Both '*.tar.gz' and '*.tar.gz.md5' files are required for this process to complete successfully.  The install directory argument is optional.  Installation for many versions of Linux that publish a root file sysytem is supported with this TermuxArch festure.  Download and configuration is not presently implemented, and hopefully will be in the future.  Create an issue and pull request at GitHub to implement these features.
elif [[ "${ARGS:0:1}" = . ]]
then
printf "\\n%s\\n" "Setting mode to copy system image."
GFILE="$1"
LCC="1"
LCP="1"
_OPT1_ "$@"
_PREPTERMUXARCH_
_INTRO_ "$@"
## [systemimage.tar.gz [customdir]]  Install directory argument is optional.  Network install can be substituted by copying systemimage.tar.gz and systemimage.tar.gz.md5 files with 'setupTermuxArch systemimage.tar.gz'.  Both '*.tar.gz' and '*.tar.gz.md5' files are required for this process to complete successfully.  Installation for many versions of Linux that publish a root file sysytem is supported with this TermuxArch festure.  Download and configuration is not presently implemented, and hopefully will be in the future.  Create an issue and pull request at GitHub to implement these features.
elif [[ "$ARGS" = *.tar.gz* ]]
then
printf "\\n%s\\n" "Setting mode to copy system image."
GFILE="$1"
LCC="1"
LCP="0"
_OPT1_ "$@"
_PREPTERMUXARCH_
_INTRO_ "$@"
## [axd|axs]  Get device system information with 'axel'.
elif [[ "${1//-}" = [Aa][Xx][Dd]* ]] || [[ "${1//-}" = [Aa][Xx][Ss]* ]]
then
printf "\\nGetting device system information with 'axel'.\\n"
DM=axel
shift
_ARG2DIR_ "$@"
_INTROSYSINFO_ "$@"
## [ax[el] [customdir]|axi [customdir]]  Install Arch Linux with 'axel'.
elif [[ "${1//-}" = [Aa][Xx]* ]] || [[ "${1//-}" = [Aa][Xx][Ii]* ]]
then
printf "\\nSetting 'axel' as download manager.\\n"
DM=axel
_OPT1_ "$@"
_INTRO_ "$@"
## [ad|as]  Get device system information with 'aria2c'.
elif [[ "${1//-}" = [Aa][Dd]* ]] || [[ "${1//-}" = [Aa][Ss]* ]]
then
printf "\\nGetting device system information with 'aria2c'.\\n"
DM=aria2
shift
_ARG2DIR_ "$@"
_INTROSYSINFO_ "$@"
## [a[ria2c] [customdir]|ai [customdir]]  Install Arch Linux with 'aria2c'.
elif [[ "${1//-}" = [Aa]* ]]
then
printf "\\nSetting 'aria2c' as download manager.\\n"
DM=aria2
_OPT1_ "$@"
_INTRO_ "$@"
## [bl[oom]]  Create ~/TermuxArchBloom directory and Arch Linux in TermuxArch PRoot QEMU root tree skeleton and skeleton files.  This option does NOT install the complete root file system.  Useful for running a customized setupTermuxArch locally and for developing and hacking TermuxArch.
elif [[ "${1//-}" = [Bb][Ll]* ]]
then
printf "\\nSetting mode to bloom. \\n"
ELCR=0
_ARG2DIR_ "$@"
_INTROBLOOM_ "$@"
## [b[loom]]  Create a local copy of TermuxArch in TermuxArchBloom.  Useful for running a customized setupTermuxArch locally and for developing and hacking TermuxArch.
elif [[ "${1//-}" = [Bb]* ]]
then
printf "\\nSetting mode to bloom. \\n"
_INTROBLOOM_ "$@"
## [cd|cs]  Get device system information with 'curl'.
elif [[ "${1//-}" = [Cc][Dd]* ]] || [[ "${1//-}" = [Cc][Ss]* ]]
then
printf "\\nGetting device system information with 'curl'.\\n"
DM=curl
shift
_ARG2DIR_ "$@"
_INTROSYSINFO_ "$@"
## [cmi] [customdir]  Install Arch Linux with manual install using 'curl'.
elif [[ "${1//-}" = [Cc][Mm][Ii]* ]]
then
printf "\\nSetting 'curl' as download manager.\\n"
printf "\\nSetting mode to manual install.\\n"
DM=curl
OPT=MANUAL
_OPT1_ "$@"
_ARG2DIR_ "$@"
_INTRO_ "$@"
## [c[url] [customdir]|ci [customdir]]  Install Arch Linux with 'curl'.
elif [[ "${1//-}" = [Cc][Ii]* ]] || [[ "${1//-}" = [Cc]* ]]
then
printf "\\nSetting 'curl' as download manager.\\n"
DM=curl
_OPT1_ "$@"
_ARG2DIR_ "$@"
_INTRO_ "$@"
## [de[bug]|s[ysinfo]]  Generate system information.
elif [[ "${1//-}" = [Dd][Ee]* ]] || [[ "${1//-}" = [Ss]* ]]
then
printf "\\nSetting mode to sysinfo.\\n"
shift
_ARG2DIR_ "$@"
_INTROSYSINFO_ "$@"
## [do [[flavor] [variaty]] [installdir]]  please see [systemimage.tar.gz [customdir]], https://github.com/TermuxArch/TermuxArch/issues/25, https://github.com/TermuxArch/TermuxArch/issues/34 and https://github.com/TermuxArch/TermuxArch/issues/68 for information.
elif [[ "${1//-}" = [Dd][Oo]* ]]
then
printf "\\nSetting mode to do/what.\\n"
shift
_OPT1_ "$@"
_INTRO_ "$@"
## [he[lp] [customdir]]  Display terse builtin help.
elif [[ "${1//-}" = [Hh][Ee]* ]]
then
_ARG2DIR_ "$@"
_PRINTUSAGE_ "$@"
## [h [customdir]]  Display verbose builtin help.
elif [[ "${1//-}" = [?]* ]] || [[ "${1//-}" = [Hh]* ]]
then
LCC="1"
_ARG2DIR_ "$@"
_PRINTUSAGE_ "$@"
## [i[nstall] [customdir]]  Install Arch Linux in a custom directory.  Instructions: Install in userspace.  The HOME directory is appended to the installation directory.  To install Arch Linux in HOME/customdir use 'bash setupTermuxArch install customdir'.  In the BASH shell you can use './setupTermuxArch install customdir'.  All options can be abbreviated to one, two and three letters.  Hence './setupTermuxArch install customdir' can be run as './setupTermuxArch i customdir' in BASH.
elif [[ "${1//-}" = [Ii]* ]]
then
printf "\\nSetting mode to install.\\n"
_ARG2DIR_ "$@"
_INTRO_ "$@"
## [ld|ls]  Get device system information with 'lftp'.
elif [[ "${1//-}" = [Ll][Dd]* ]] || [[ "${1//-}" = [Ll][Ss]* ]]
then
printf "\\nGetting device system information with 'lftp'.\\n"
DM=lftp
shift
_ARG2DIR_ "$@"
_INTROSYSINFO_ "$@"
## [l[ftp] [customdir]]  Install Arch Linux with 'lftp'.
elif [[ "${1//-}" = [Ll]* ]]
then
printf "\\nSetting 'lftp' as download manager.\\n"
DM=lftp
_OPT1_ "$@"
_INTRO_ "$@"
## [matr[ix]]  Print TermuxArch source code as Matrix loop
elif [[ "${1//-}" = [Mm][Aa][Tt][Rr]* ]]
then
printf "Setting mode to matrix loop.\\n"
MATRIXLCR=0
_PREPTERMUXARCH_
_DEPENDSBLOCK_ "$@"
_TAMATRIX_
## [mat[ix]]  Print TermuxArch source code as Matrix
elif [[ "${1//-}" = [Mm][Aa][Tt]* ]]
then
printf "\\nSetting mode to matrix.\\n"
MATRIXLCR=1
_PREPTERMUXARCH_
_DEPENDSBLOCK_ "$@"
_TAMATRIX_
## [m[anual]]  Manual Arch Linux install, can be useful for resolving download and proot init statement issues.
elif [[ "${1//-}" = [Mm][Ii]* ]]
then
printf "\\nSetting mode to manual install.\\n"
OPT=MANUAL
_OPT1_ "$@"
_ARG2DIR_ "$@"
_INTRO_ "$@"
elif [[ "${1//-}" = [Mm]* ]]
then
printf "\\nSetting mode to manual install.\\n"
OPT=MANUAL
_OPT1_ "$@"
_INTRO_ "$@"
## [o[ption]]  Option under development.
elif [[ "${1//-}" = [Oo]* ]]
then
printf "\\nSetting mode to option.\\n"
EDO01LCR=0
printf "\\n\\e[0;32mSetting mode\\e[1;34m; \\e[1;32mupdate Termux tools with minimal refresh with refresh user directories\\e[1;34m;\\e[0;32m For a full system refresh you can use the%s \\e[1;32m'%s' \\e[0;32m%s\\e[1;34m...\\n" "" "${0##*/} ref[resh]" "command"
_PRPREFRESH_ "2"
_ARG2DIR_ "$@"
_INTROREFRESH_ "$@"
## [purge [customdir]]  Purge/uninstall Arch Linux from device.
elif [[ "${1//-}" = [Pp][Uu]* ]]
then
printf "\\nSetting mode to purge.\\n"
PURGELCR=0
_ARG2DIR_ "$@"
_RMARCHQ_
## [p[urge] [customdir]] Quick purge/uninstall Arch Linux from device.
elif [[ "${1//-}" = [Pp]* ]]
then
printf "\\nSetting mode to quick purge.\\n"
_ARG2DIR_ "$@"
_RMARCHQ_
## [q[emu] [m[anual]] [i[nstall]|r[e[f[resh]]]] [customdir]]  Install alternate architecture on smartphone with https://github.com/qemu/QEMU emulation.  Issue [Implementing QEMU #25](https://github.com/TermuxArch/TermuxArch/issues/25) has more information.
elif [[ "${1//-}" = [Qq][Ii]* ]]
then
printf "\\nSetting mode to qemu install.\\n"
_ARG2DIR_ "$@"
_QEMU_
_INTRO_ "$@"
elif [[ "${1//-}" = [Qq][Mm][Ii]* ]]
then
printf "\\nSetting mode to qemu manual install.\\n"
OPT=MANUAL
_QEMU_
_ARG2DIR_ "$@"
_INTRO_ "$@"
elif [[ "${1//-}" = [Qq]* ]]
then
printf "\\nSetting mode to qemu.\\n"
_OPT1_ "$@"
_QEMU_
_INTRO_ "$@"
elif [[ "${1//-}" = [Rr][Ee][Ff][Rr][Ee]*[Ff][Oo][Rr][Cc][Ee] ]]
then
printf "\\nSetting mode to full refresh force.\\n"
OPT=FORCE
echo Developing feature\; Please see https://github.com/TermuxArch/TermuxArch/discussions/92 for more information.
_PRPREFRESH_ "5"
_ARG2DIR_ "$@"
_INTROREFRESH_ "$@"
## [refre[sh] [customdir]]  Refresh the Arch Linux in TermuxArch PRoot QEMU scripts created by TermuxArch and the Arch Linux installation itself.  This option is useful for refreshing the installation, the root user's home directory, the user home directories and the TermuxArch generated scripts to their newest version;  Directory '/var/backups/' backs up the refreshed files.  This refresh mode also runs keys, generates locales and updates the Arch Linux in PRoot QEMU system.
elif [[ "${1//-}" = [Rr][Ee][Ff][Rr][Ee]* ]]
then
printf "\\nSetting mode to full refresh.\\n"
_PRPREFRESH_ "5"
_ARG2DIR_ "$@"
_INTROREFRESH_ "$@"
elif [[ "${1//-}" = [Rr][Ee][Ff][Rr]* ]]
then
printf "\\nSetting mode to 4 refresh.\\n"
_PRPREFRESH_ "4"
_ARG2DIR_ "$@"
_INTROREFRESH_ "$@"
## [ref [customdir]]  Refresh the Arch Linux in TermuxArch PRoot QEMU scripts created by TermuxArch and populate the installation from the cache directory.  Useful for refreshing the root user's home directory, the user home directories and the TermuxArch generated scripts to their newest version;  Directory '/var/backups/' backs up files.
elif [[ "${1//-}" = [Rr][Ee][Ff]* ]]
then
printf "\\nSetting mode to 3 refresh.\\n"
_PRPREFRESH_ "3"
_ARG2DIR_ "$@"
_INTROREFRESH_ "$@"
## [re [customdir]]  Refresh the Arch Linux in TermuxArch PRoot QEMU scripts created by TermuxArch.  Useful for refreshing the root user's home directory and the user home directories and the TermuxArch generated scripts to their newest version;  Directory '/var/backups/' backs up files.
elif [[ "${1//-}" = [Rr][Ee]* ]]
then
printf "\\n\\e[0;32mSetting mode\\e[1;34m: \\e[1;32mminimal refresh with refresh user directories.  Directory '/var/backups/' backs up files \\e[1;34m:\\e[0;32m For a full system refresh the \\e[1;32m'%s' \\e[0;32mcommand can used\\e[1;34m...\\n" "${0##*/} refresh"
_PRPREFRESH_ "2"
_ARG2DIR_ "$@"
_INTROREFRESH_ "$@"
## [r [customdir]]  Refresh the Arch Linux in TermuxArch PRoot QEMU scripts created by TermuxArch.  Useful for only refreshing the root user's home directory and the TermuxArch generated scripts to their newest version;  Directory '/var/backups/' backs up the refreshed files.
elif [[ "${1//-}" = [Rr]* ]]
then
printf "\\n\\e[0;32mSetting mode\\e[1;34m: \\e[1;32mminimal refresh; Directory '/var/backups/' backs up files\\e[1;34m:\\e[0;32m  For a full system refresh the \\e[1;32m'%s' \\e[0;32mcommand can used\\e[1;34m...\\n" "${0##*/} refresh"
_PRPREFRESH_ "1"
_ARG2DIR_ "$@"
_INTROREFRESH_ "$@"
## [u[pdateTermuxTools] [refresh] [customdir]]  Developing implementation; Update installation with Termux tools.
elif [[ "${1//-}" = [Uu]* ]]
then
EDO01LCR=0
printf "\\n\\e[0;32mSetting mode\\e[1;34m; \\e[1;32mupdate Termux tools with minimal refresh including user directories\\e[1;34m;\\e[0;32m  For a full system refresh the%s \\e[1;32m'%s' \\e[0;32mcommand can used\\e[1;34m...\\n" "" "${0##*/} refresh"
_PRPREFRESH_ "2"
_ARG2DIR_ "$@"
_INTROREFRESH_ "$@"
## [vis[ualorca] [manual] [install|refresh] [customdir]]  Install Arch Linux on smartphone.  Please use the TermuxArch command 'orcaconf' once Arch Linux in installed to complete the configuration.  Issue [Expanding setupTermuxArch so visually impaired users can install Orca screen reader (assistive technology) and have VNC support added easily. #34](https://github.com/TermuxArch/TermuxArch/issues/34) has more information about this option.
elif [[ "${1//-}" = [Vv][Ii][Ss]* ]]
then
VLORALCR=0
printf "\\nSetting mode to vis[ualorca] [manual] [install|refresh] [customdir].\\n"
_OPT1_ "$@"
_PREPTERMUXARCH_
_INTRO_ "$@"
## [vi[sualorca] [manual] [install|refresh] [customdir]]  Install alternate architecture on smartphone with https://github.com/qemu/QEMU emulation.  Please use the TermuxArch command 'orcaconf' once Arch Linux is installed to complete the configuration.
elif [[ "${1//-}" = [Vv][Ii]* ]]
then
VLORALCR=0
printf "\\nSetting mode to vi[sualorca] [manual] [install|refresh] [customdir].\\n"
_CHOOSEABIx86_ "$@"
## [v[isualorca] [manual] [install|refresh] [customdir]]  Install alternate architecture on smartphone with https://github.com/qemu/QEMU emulation.  Please use the TermuxArch command 'orcaconf' once Arch Linux is installed to complete the configuration.
elif [[ "${1//-}" = [Vv]* ]]
then
VLORALCR=0
printf "\\nSetting mode to v[isualorca] [manual] [install|refresh] [customdir].\\n"
_CHOOSEABIx86_ "$@"
## [wd|ws]  Get device system information with 'wget'.
elif [[ "${1//-}" = [Ww][Dd]* ]] || [[ "${1//-}" = [Ww][Ss]* ]]
then
printf "\\nGetting device system information with 'wget'.\\n"
DM=wget
shift
_ARG2DIR_ "$@"
_INTROSYSINFO_ "$@"
## [w[get] [customdir]]  Install Arch Linux with 'wget'.
elif [[ "${1//-}" = [Ww]* ]]
then
printf "\\nSetting 'wget' as download manager.\\n"
DM=wget
_OPT1_ "$@"
_INTRO_ "$@"
else
LCC="1"
_ARG2DIR_ "$@"
_PRINTUSAGE_
fi
## >>>>>>>>>>>>>>>>>>
## >>  HELP FACTS  >>
## >>>>>>>>>>>>>>>>>>
## THESE OPTIONS ARE AVAILABLE FOR YOUR CONVENIENCE:
## GRAMMAR[a]: setupTermuxArch [HOW/WHAT] [DO] [WHERE]
## OPTIONS[a]: setupTermuxArch [HOW/WHAT] [DO] [WHERE]
## GRAMMAR[b]: setupTermuxArch [WHAT] [WHERE]
## OPTIONS[b]: setupTermuxArch [~/|./|/absolute/path/]image.tar.gz [WHERE]
## DEFAULTS ARE IMPLIED AND CAN BE OMITTED
## SYNTAX[1]: [HOW (aria2|axel|curl|lftp|wget (default1: present on system (default2: lftp)))]
## SYNTAX[2]: [DO (do|help|install|manual|purge|refresh|sysinfo (default: install))]
## SYNTAX[3]: [WHERE (default: arch)]  Install in userspace, not external storage.
## EXAMPLE USAGE:
## USAGE[1]: 'setupTermuxArch curl sysinfo' will use curl as the download manager and produce a system information file in the working directory.  This can be abbreviated to 'setupTermuxArch cs' and 'setupTermuxArch c s'.
## USAGE[2]: 'setupTermuxArch curl manual customdir' will install the installation in customdir with curl and use manual mode during installation.
## USAGE[3]: 'setupTermuxArch curl refresh customdir' will refresh the installation using curl as the download manager.
## Should any of these options fail to work as expected, please open an issue at GitHub with the command line used and output.  This product is being designed for both the sighted, and also the visually impaired;  Comments are welcome at discussions and issues webportals.
## After installing TermuxArch on device, file 'INSTALLDIR/usr/local/termuxarch/bin/README.md' has more information.  The TermuxArch files in directory 'INSTALLDIR/usr/local/termuxarch/bin' have more information.
## Very many hardy thank yous to contributors who are helping and have worked very hard for many long years, some for more, and to those who took mere minutes from their valuable effort with time in order to make this open source resource much better for all of us!  Please enjoy using TermuxArch in PRoot QEMU in Android, Chromebook, Amazon Fire OS and Windows on smartphone, tablet, wearable and similar:  setupTermuxArch FE
