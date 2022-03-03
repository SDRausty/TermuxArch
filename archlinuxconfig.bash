#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
_PRNT_ () { printf "%s\\n" "$1" ; }	# print message with one trialing newline
_PRT_ () { printf "%s" "$1" ; }	# print message with no trialing newline
if [ "${LOADLCRFILES:-}" = 0 ] || [ "${MATRIXLCR:-}" = 0 ] || [ "${MATRIXLCR:-}" = 1 ]
then
:
else
set +e
PVAR="$(ping -n 1 1.1.1.1 2>&1 ||:)"
set -e
if [ -z "${PVAR##*unreachable*}" ]
then
_PRNT_ "Script '${0##*/} $ARGS' SIGNAL:  Please check your wireless connection and run '${0##*/} $ARGS' again.  EXITING...  " && exit 6
fi
fi

[ "$CPUABI" = i386 ] && CPUABI="x86"
CACHECPBI="${CPUABI/_/-}"
CACHEDIR="/storage/emulated/0/Android/data/com.termux/files/cache/archlinux/$CACHECPBI/"
PREFIXDATAFILES="/storage/emulated/0/Android/data/com.termux/"
CACHEDIRSUFIX="files/cache/archlinux/$CACHECPBI/var/cache/pacman/pkg/"
BINFNSTP="finishsetup.bash"
LC_TYPE=("LANG" "LANGUAGE" "LC_ADDRESS" "LC_COLLATE" "LC_CTYPE" "LC_IDENTIFICATION" "LC_MEASUREMENT" "LC_MESSAGES" "LC_MONETARY" "LC_NAME" "LC_NUMERIC" "LC_PAPER" "LC_TELEPHONE" "LC_TIME")
TXPRQUON="Termux PRoot with QEMU"
TXPRQUON="Termux PRoot"

_PREPFILEFCTN_() { printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf '\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\n' \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit 0" "_PRNTWAIT_() { printf '\\e[0;32m%s\n' \"Please wait a moment;  Command '\${0##*/}' is attempting to make the command '$1';  Continuing...\" ; }" "{ [ -x /usr/bin/\"$1\" ] && printf '\\e[0;31m%s\n' \"The command '$1' is installed;  Exiting...\" ; }" "[ -x /usr/bin/fakeroot ] || { pc base base-devel || pci base base-devel ; }" "{ cd && [ -x \"$2\" ] || gcl https://aur.archlinux.org/\"$2\" ; } && cd \"$2\" && _PRNTWAIT_ && makepkg -firs --noconfirm ; \"$1\" --help" "## ~/${INSTALLDIR##*/}/usr/local/bin/makeaur\"$3\" FE" >> "$3" ; }

_ADDREADME_() {
_CFLHDR_ usr/local/bin/README.md
cat > usr/local/bin/README.md <<- EOM
The /usr/local/bin directory contains TermuxArch shortcut commands that automate and make using the command line easier.  Some of these commands are listed here:

* Command 'csystemctl' replaces systemctl with https://github.com/TermuxArch/docker-systemctl-replacement,
* Command 'keys' installs Arch Linux keys,
* Command 'makeauryay' creates the 'yay' command, and also patches the 'makepkg' command,
* Command 'patchmakepkg' patches the 'makepkg' command,
* Command 'pc' pacman shortcut command; cat \$(command -v pc),
* Command 'pci' pacman shortcut command; cat \$(command -v pci),
* Command 'tour' runs a short tour of the Arch Linux system directories,
* Command 'trim' removes downloaded packages from the Arch Linux system directories and frees up space on device,
* Command 'yt' youtube shortcut command that installs and runs the command 'youtube-dl',
* Command 'v' is a vim editor shortcut command that  installs and runs the vim editor.

This command; 'ls /usr/local/bin && cat ~/.bashrc' will show the installed TermuxArch commands.

This file can be expanded so the beginning user can get to know the Linux experience easier.  Would you like to create an issue along with a pull request to add information to this file so that the beginning user can get to know the Arch Linux in Termux PRoot experience easier?  If you do want to expand this file to enhance this experience, visit these links:

* Comments are welcome at https://github.com/TermuxArch/TermuxArch/issues ✍
* Pull requests are welcome at https://github.com/TermuxArch/TermuxArch/pulls ✍
<!-- ~/${INSTALLDIR##*/}/usr/local/bin/README.md FE -->
EOM
}

_ADDae_() {
_CFLHDR_ usr/local/bin/ae "# Developed at [pacman-key --populate archlinux hangs](https://github.com/SDRausty/TermuxArch/issues/33) Contributor cb125"
cat >> usr/local/bin/ae <<- EOM
watch cat /proc/sys/kernel/random/entropy_avail
## ~/${INSTALLDIR##*/}/usr/local/bin/ae FE
EOM
chmod 755 usr/local/bin/ae
}

_ADDbash_logout_() {
cat > root/.bash_logout <<- EOM
[ ! -f "\$HOME"/.hushlogout ] && [ ! -f "\$HOME"/.chushlogout ] && . /etc/moto
h
## .bash_logout FE
EOM
}

_ADDbash_profile_() {
[ -e root/.bash_profile ] && _DOTHRF_ "root/.bash_profile"
printf "%s\\n%s\\n%s\\n%s\\n" "PPATH=\"\$PATH\"" "# [ -d /system/xbin ] && PATH=\"/system/xbin\"" "# [ -d /system/sbin ] && PATH=\"/system/sbin:\$PATH\"" "# [ -d /system/bin ] && PATH=\"/system/bin:\$PATH\"" > root/.bash_profile
if [ -d "$INSTALLDIR"/usr/local/texlive ]
then
TEXLIVEPATH="$(find "$INSTALLDIR"/usr/local/texlive/*/bin/ -maxdepth 1 | tail -n 1)"
TEXLIVEPATH="${TEXLIVEPATH#*"${INSTALLDIR##*/}"}"
TEXDIR="${TEXLIVEPATH%/*}"
TEXDIR="${TEXDIR%/*}"
printf "%s\\n" "PATH=\"\$HOME/bin:$TEXLIVEPATH:\$PPATH\"" >> root/.bash_profile
else
printf "%s\\n" "PATH=\"\$HOME/bin:\$PPATH\"" >> root/.bash_profile
fi
printf "%s\\n" "[[ -f \"\$HOME\"/.bashrc ]] && . \"\$HOME\"/.bashrc" >> root/.bash_profile
printf "%s\\n" "[[ -f \"\$HOME\"/.profile ]] && . \"\$HOME\"/.profile" >> root/.bash_profile
printf "%s\\n" "if [ ! -e \"\$HOME\"/.hushlogin ] && [ ! -e \"\$HOME\"/.chushlogin ]
then
[ -e /etc/mota ] && . /etc/mota
fi
if [ -e \"\$HOME\"/.chushlogin ]
then
rm -f \"\$HOME\"/.chushlogin
fi
PS1=\"\\[\\e[38;5;148m\\]\\u\\[\\e[1;0m\\]\\A\\[\\e[1;38;5;112m\\]\\W\\[\\e[0m\\]$ \"" >> root/.bash_profile
[[ -f "$HOME"/.bash_profile ]] && grep proxy "$HOME"/.bash_profile | grep -s "export" >> root/.bash_profile ||:
SHELVARS=" ANDROID_ART_ROOT ANDROID_DATA ANDROID_I18N_ROOT ANDROID_ROOT ANDROID_RUNTIME_ROOT ANDROID_TZDATA_ROOT BOOTCLASSPATH DEX2OATBOOTCLASSPATH"
for SHELVAR in ${SHELVARS[@]}
do
ISHELVAR="$(export | grep "$SHELVAR" || printf '%s\n' 1)"
if [[ "$ISHELVAR" != 1 ]]
then
printf "export %s\\n" "${ISHELVAR/declare -x }" >> root/.bash_profile
fi
done
printf "%s\\n" "export GPG_TTY=\"\$(tty)\"" >> root/.bash_profile
printf "%s\\n" "export MOZ_FAKE_NO_SANDBOX=1" >> root/.bash_profile
printf "%s\\n" "export PULSE_SERVER=127.0.0.1" >> root/.bash_profile
if [ -d "$INSTALLDIR"/usr/local/texlive ]
then
printf "%s\\n" "[ -d \"$TEXDIR\" ] && export TEXDIR=\"$TEXDIR\"" >> root/.bash_profile
printf "%s\\n" "[ -d \"\$HOME\"/.texlive2021/texmf-config ] && export TEXMFCONFIG=\"\$HOME/.texlive2021/texmf-config\"" >> root/.bash_profile
printf "%s\\n" "[ -d \"\$HOME\"/texmf ] && export TEXMFHOME=\"\$HOME/texmf\"" >> root/.bash_profile
printf "%s\\n" "[ -d /usr/local/texlive/texmf-local ] && export TEXMFLOCAL=\"/usr/local/texlive/texmf-local\"" >> root/.bash_profile
printf "%s\\n" "[ -d $TEXDIR/texmf-config ] && export TEXMFSYSCONFIG=\"$TEXDIR/texmf-config\"" >> root/.bash_profile
printf "%s\\n" "[ -d $TEXDIR/texmf-var ] && export TEXMFSYSVAR=\"$TEXDIR/texmf-var\"" >> root/.bash_profile
printf "%s\\n" "[ -d \"\$HOME\"/.texlive2021/texmf-var ] && export TEXMFVAR=\"\$HOME/.texlive2021/texmf-var\"" >> root/.bash_profile
fi
printf "%s\\n%s\\n" "export TZ=\"$(getprop persist.sys.timezone)\"" "## .bash_profile FE" >> root/.bash_profile
}

_ADDbashrc_() {
[ -e root/.bashrc ] && _DOTHRF_ "root/.bashrc"
cat > root/.bashrc <<- EOM
function _PWD_() {
printf '%s\n' "\$PWD"
}
function git-branch() {
if [ -d .git ]
then
printf "%s" "(\$(git branch 2> /dev/null | awk '/\*/{print \$2}'))";
fi
}
function em() {
[ -x /usr/bin/make ] || { pc base base-devel || pci base base-devel ; }
[ -x \$HOME/bin/uemacs ] && \$HOME/bin/uemacs "\$@" || { { cd && [ -e uemacs ] || gcl https://github.com/torvalds/uemacs ; } && { cd uemacs || exit 169 ; } && printf '%s\\n' "making uemacs" && make && mv em \$HOME/bin/uemacs && \$HOME/bin/uemacs emacs.hlp ; }
}
alias ..='cd ../.. && _PWD_'
alias ...='cd ../../.. && _PWD_'
alias ....='cd ../../../.. && _PWD_'
alias .....='cd ../../../../.. && _PWD_'
alias aiabrowser='am start -a android.intent.action.VIEW -d "content://com.android.externalstorage.documents/root/primary"'	## Reference [Android 11 (with Termux storage permission denied) question; What's the source for the shortcut to the file manager of the settings app?](https://www.reddit.com/r/termux/comments/msq7lm/android_11_with_termux_storage_permission_denied/) Contributors u/DutchOfBurdock u/xeffyr
alias aiachrome='am start --user 0 -n com.android.chrome/com.google.android.apps.chrome.Main'	## Reference [Can I start an app from Termux's command line? How?](https://www.reddit.com/r/termux/comments/62zi71/can_i_start_an_app_from_termuxs_command_line_how/) Contributors u/u/fornwall u/Kramshet
alias aiadial='am start -a android.intent.action.DIAL'
alias aiafilemanager='am start -a android.intent.action.VIEW -d "content://com.android.externalstorage.documents/root/primary"'
alias aiasearch='am start -a android.intent.action.SEARCH'
alias aiaview='am start -a android.intent.action.VIEW'
alias aiaviewd='am start -a android.intent.action.VIEW -d '
alias aiawebsearch='am start -a android.intent.action.WEB_SEARCH'
alias C='cd .. && _PWD_'
alias c='cd .. && _PWD_'
alias CN='cat -n \$(command -v' # use a ) to complete this alias
alias Cn='cat -n \$(command -v' # use a ) to complete this alias
alias cn='cat -n \$(command -v' # use a ) to complete this alias
alias CW='cat \$(command -v' # use a ) to complete this alias
alias Cw='cat \$(command -v' # use a ) to complete this alias
alias cw='cat \$(command -v' # use a ) to complete this alias
alias CR='cp -r'
alias Cr='cp -r'
alias cr='cp -r'
alias CUO='curl -C - --fail --retry 4 -O'
alias Cuo='curl -C - --fail --retry 4 -O'
alias cuo='curl -C - --fail --retry 4 -O'
alias CUOL='curl -C - --fail --retry 4 -OL'
alias Cuol='curl -C - --fail --retry 4 -OL'
alias cuol='curl -C - --fail --retry 4 -OL'
alias D='nice -n 20 du -hs'
alias d='nice -n 20 du -hs'
alias DFA='df | grep storage\/emulated'
alias Dfa='df | grep storage\/emulated'
alias dfa='df | grep storage\/emulated'
alias DFT='df | grep storage\/'
alias Dft='df | grep storage\/'
alias dft='df | grep storage\/'
alias EE='am startservice --user 0 -a com.termux.service_wake_unlock com.termux/com.termux.app.TermuxService > /dev/null ; exit'
alias Ee='am startservice --user 0 -a com.termux.service_wake_unlock com.termux/com.termux.app.TermuxService > /dev/null ; exit'
alias ee='am startservice --user 0 -a com.termux.service_wake_unlock com.termux/com.termux.app.TermuxService > /dev/null ; exit'
alias E='exit'
alias e='exit'
alias F='nice -n 20 grep -n --color=always'
alias f='nice -n 20 grep -n --color=always'
alias Fr='nice -n 20 grep -nr --color=always'
alias fr='nice -n 20 grep -nr --color=always'
alias G='ga ; gcm ; gp'
alias g='ga ; gcm ; gp'
alias GITS='git show'
alias Gits='git show'
alias gits='git show'
alias GCA='git commit -a -S'
alias Gca='git commit -a -S'
alias gca='git commit -a -S'
alias GCAM='git commit -a -S -m'
alias Gcam='git commit -a -S -m'
alias gcam='git commit -a -S -m'
alias H='history >> \$HOME/.historyfile'
alias h='history >> \$HOME/.historyfile'
alias HW='head \$(command -v' # use a ) to complete this alias
alias Hw='head \$(command -v' # use a ) to complete this alias
alias hw='head \$(command -v' # use a ) to complete this alias
alias J='jobs'
alias j='jobs'
alias I='whoami'
alias i='whoami'
alias L='ls -al --color=always'
alias l='ls -al --color=always'
alias LA='ls -alR --color=always'
alias La='ls -alR --color=always'
alias la='ls -alR --color=always'
alias LS='ls --color=always'
alias ls='ls --color=always'
alias LR='ls -alR --color=always'
alias lr='ls -alR --color=always'
alias MEMAV='grep -i available /proc/meminfo'
alias Memav='grep -i available /proc/meminfo'
alias MEMFREE='grep -i free /proc/meminfo'
alias Memfree='grep -i free /proc/meminfo'
alias MEMINFO='cat /proc/meminfo'
alias Meminfo='cat /proc/meminfo'
alias MEMTOT='grep -i total /proc/meminfo'
alias Memtot='grep -i total /proc/meminfo'
alias MKDIP='mkdir -p'
alias Mkdip='mkdir -p'
alias mkdip='mkdir -p'
alias N2='nice -n -20'
alias n2='nice -n -20'
alias P='_PWD_'
alias p='_PWD_'
alias PACMAN='pacman --color=always'
alias Pacman='pacman --color=always'
alias pacman='pacman --color=always'
alias PCS='pacman -S --color=always'
alias Pcs='pacman -S --color=always'
alias pcs='pacman -S --color=always'
alias PCSS='pacman -Ss --color=always'
alias Pcss='pacman -Ss --color=always'
alias pcss='pacman -Ss --color=always'
alias PF='printf "%s\n"'
alias Pf='printf "%s\n"'
alias pf='printf "%s\n"'
alias PX='ps aux'
alias Px='ps aux'
alias px='ps aux'
alias Q='exit'
alias q='exit'
alias RMD='rmdir -p'
alias Rmd='rmdir -p'
alias rmd='rmdir -p'
alias TO='termux-open'
alias To='termux-open'
alias to='termux-open'
alias TW='tail \$(command -v' # use a ) to complete this alias
alias Tw='tail \$(command -v' # use a ) to complete this alias
alias tw='tail \$(command -v' # use a ) to complete this alias
alias V='v'
alias v='v'
alias UM='uname -m'
alias Um='uname -m'
alias um='uname -m'
EOM
[ -f "$HOME"/.bashrc ] && grep -s proxy "$HOME"/.bashrc | grep -s "export" >>  root/.bashrc ||:
cat >> root/.bashrc <<- EOM
## .bashrc FE
EOM
}

_ADDcams_() {
_CFLHDR_ usr/local/bin/cams "### Example usage: 'cams 0 255 16 2048 r 90 2'
### Loop example: 'while true ; do cams ; done'
### Semantics: [camid [totalframes+1 [framespersecond [threshold [r[otate] [degrees [exitwait]]]]]]]
### Please run 'au ffmpeg imagemagick termux-api' before running this script.  Also ensure that Termux-api is installed, which is available at this https://github.com/termux/termux-api/actions/workflows/debug_build.yml webpage.
### VLC media player APK can be downloaded from these https://www.videolan.org/vlc/download-android.html and https://get.videolan.org/vlc-android/3.3.4/ webpages.
### More options in addition to image checking and rotation can be added by editing this file at the magick rotation command;  The command line options for magick are listed at this https://imagemagick.org/script/command-line-options.php webpage.
### Seven arguments are listed below, including their default values;  If run with no arguments, the default values will be used:"
cat >> usr/local/bin/cams <<- EOM
[[ -n "\${1:-}" ]] && { [[ "\${1//-}" = [\/]* ]] || [[ "\${1//-}" = [?]* ]] || [[ "\${1//-}" = [Hh]* ]] ; } && { printf '\e[1;32m%s\n' "Help for '\${0##*/}':" && TSFILE="(\$(grep '##\ ' "\$0"))" && printf '\e[0;32m%s\e[1;32m\n%s\n' "\$(for HL in "\${TSFILE[@]}" ; do cut -d\) -f1 <<< "\${HL//###/	}" | cut -f 2 ; done )" "Help for '\${0##*/}': DONE" ; exit ; }
[[ -n "\${1:-}" ]] && { [[ "\${1//-}" = [Pp]* ]] && POCKET=0 && CAMID=2 && printf '%s\\n' pocket || CAMID=\${1:-2} ; }
[[ -z "\${1:-}" ]] && CAMID=2 ### [1] default 2:  One camera 0 1 2 3 4 5 6 7 id,
FRAMECTOT=\${2:-11} ### [2] default 11:  Total frame count + 1,
FRAMERATE=\${3:-1} ### [3] default 1:  Video 0.5 1 2 4 8 16 32 frames per second rendered in the mpg file,
THRESHOLDSET=\${4:-256} ### [4] default 256:  Byte difference 64 128 256 512 1024 2048 4096 8192 16384 32768 65536 between last two picture frames taken;  Can be used for motion detection.  The greater the number, the lesser the sensitivity.  Camera resolution also affects this argument,
_CAMS_ () {
while [ "\$FRAMECOUNT" -le "\$FRAMECTOT" ]
do
LTSENSOR="\$(termux-sensor -n 1 -s "LIGHT" | grep -w 0 || printf 1)"
if [ "\$LTSENSOR" -eq 1 ]
then
{ [[ "\${POCKET:-}" == 0 ]] && _CAMSSENSORS_ "\$@" ; } || _CAMSCORE_ "\$@"
else
printf '\e[0;36m%s\e[0m\n' "IM light sensor wait; sleeping."
sleep 4
fi
done
}
_CAMSSENSORS_ () {
ITSENSOR="\$(termux-sensor -n 1 -s "IN_POCKET" | grep 1|| printf 0)"
PYSENSOR="\$(termux-sensor -n 1 -s "PROXIMITY" | grep 1|| printf 0)"
if [ "\${ITSENSOR//,}" -eq 1 ] || [ "\$PYSENSOR" -eq 1 ]
then
_CAMSCORE_ "\$@"
else
printf '\e[0;36m%s\e[0m\n' "IM sensors wait; sleeping."
sleep 4
fi
}
_CAMSCORE_ () {
FRAMENAME="camid\$(printf '%s.%04d.jpg' "\$CAMID" "\$FRAMECOUNT")"
printf '\e[0;32m%s\e[1;32m%s\e[0;32m%s\e[1;32m%s\e[0;32m%s\n\e[0;32m%s' "IT " "\$((FRAMECOUNT + 1))/\$((FRAMECTOT + 1))" " frame count: " "\${THRESHOLDSET:-} threshold" " set" "IP camid \$CAMID taking picture \$FRAMENAME: "
:>"\$PWD/\$FRAMENAME"
sleep 0.42 # Adjust for device being used; This sleep may be unnecessary.
"\${PREFIX:-/data/data/com.termux/files/usr}"/libexec/termux-api CameraPhoto --es camera "\$CAMID" --es file "\$PWD/\$FRAMENAME"
printf '\e[0;32m%s\n' "DONE"
_ISZERO_ "\$@"
}
_CHECKMOTIONDIFF_() {
if [ "\$FRAMECOUNT" -ne 0 ]
then
THRESHOLD="\$((LASTZERO - ISZERO))"
THRESHOLD="\${THRESHOLD//-}"
if [ "\$THRESHOLD" -le "\$THRESHOLDSET" ]
then
printf '\e[0;2m%s\n' "ID \$THRESHOLD/\$THRESHOLDSET threshold: deleting file \$FRAMENAME"
rm -f "\$FRAMENAME"
OLDISZERO="\$ISZERO"
fi
fi
}
_ISZERO_ () {
if [ -n "\${ISZERO:-}" ]
then
LASTZERO="\$ISZERO"
fi
ISZERO="\$(find . -type f -name "\$FRAMENAME" -printf "%s")"
printf '\e[0;36m%s\e[1;36m%s\n' "IS framename \$FRAMENAME size: " "\$ISZERO"
if [ "\$ISZERO" -eq 0 ]
then
ISZERO="\${OLDISZERO:-}"
printf '\e[0;33m%s' "E0 deleting zero size file \$FRAMENAME: "
rm -f "\$FRAMENAME"
printf '\e[0;32m%s\n' "DONE"
E0VAR=1
fi
if [[ \${E0VAR:-} == 0 ]]
then
_CHECKMOTIONDIFF_
_MAGICKCK_ "\$@"
else
E0VAR=0
fi
}
_MAKEDIRS_ () {
CAMD="camid\$CAMID"
[ -e "output/\$CAMD/\$CAMD\$TIMESTAMP" ] || { printf '\e[0;36m%s' "IM mkdir -p output/\$CAMD/\$CAMD\$TIMESTAMP: " && mkdir -p output/"\$CAMD/\$CAMD\$TIMESTAMP" && printf '\e[0;32m%s\n' "DONE"; }
[ -e output/gifs/"\$CAMD" ] || { printf '\e[0;36m%s' "IM mkdir -p output/gifs/\$CAMD: " && mkdir -p output/gifs/"\$CAMD" && printf '\e[0;32m%s\n' "DONE"; }
[ -e output/webms/"\$CAMD" ] || { printf '\e[0;36m%s' "IM mkdir -p output/webms/\$CAMD: " && mkdir -p output/webms/"\$CAMD" && printf '\e[0;32m%s\n' "DONE"; }
printf '\e[0;36m%s' "IM cd output/\$CAMD/\$CAMD\$TIMESTAMP: " && cd output/"\$CAMD/\$CAMD\$TIMESTAMP" && printf '\e[0;32m%s\n' "DONE"
}
_MAGICKCK_ () {
if [ -e "\$FRAMENAME" ]
then
printf '\e[0;36m%s' "IC checking file \$FRAMENAME for errors: "
MAGICKCK="\$(nice -n 20 magick identify "\$FRAMENAME" 2>&1 ||:)"
if grep -i error <<< "\$MAGICKCK"
then
printf '\e[0;31m%s\e[0m\n' "ERROR"
rm -f "\$FRAMENAME"
printf '\e[0;31m%s\n\e[0;36m%s\n' "ED deleted file \$FRAMENAME: ERROR" "IR redoing file \$FRAMENAME..."
else
printf '\e[0;32m%s\n' "DONE"
FRAMECOUNT="\$((FRAMECOUNT + 1))"
printf '\e[0;32m%s\e[1;32m%s\e[0;32m%s\n' "IF " "file \$FRAMENAME added" " to que."
if [ -n "\${5:-}" ]
then
if [[ "\${5//-}" = [Rr]* ]] ### [5] default no rotation:  R|r[otate]: useful for portrait orientation.  You can use R or r to activate rotation which is preset to 90° rotation.  The sixth argument can be used to enter a rotation angle to change the preset 90° rotation,
then
printf '\e[0;36m%s' "IR rotating file \$FRAMENAME by \${6:-90}°: " ### [6] default 90°:  Enter desired picture rotation angle in digits if you want to use 180° and 270° degree rotation.  Other rotation angles can also be used,
nice -n 20 magick "\$FRAMENAME" -rotate "\${6:-90}" "\$FRAMENAME".jpg
mv "\$FRAMENAME".jpg "\$FRAMENAME"
printf '\e[0;32m%s\n' "DONE"
fi
fi
fi
fi
}
_MECONVERT_ () {
printf '\e[0;36m%s\e[0m\n' "IM making camid\$CAMID.\$TIMESTAMP.gif: This job will complete in the background..." && nice -n 20 convert -delay "\$((FRAMERATE * 100))" -loop 0 "\$CAMD."*.jpg "\$CAMD.\$TIMESTAMP".gif && { ls -al "\$CAMD.\$TIMESTAMP".gif && printf '\e[0;32m%s\e[0m\n' "IM making camid\$CAMID.\$TIMESTAMP.gif: DONE" ; } || printf '\e[1;31m%s\e[0m\n' "EM creating camid\$CAMID.\$TIMESTAMP.gif: ERROR"
printf '\e[0;36m%s' "IM mv camid\$CAMID.\$TIMESTAMP.gif ../../gifs/\$CAMD: " && mv "\$CAMD.\$TIMESTAMP".gif ../../gifs/\$CAMD && printf '\e[0;32m%s\e[0m\n' "DONE"
}
_MEFFMPEG_ () {
# To start at frame 20 and finish at frame 420: ffmpeg -start_number 20 -i filename%04d.jpg -vframes 400 video.webm
printf '\e[0;36m%s\e[0m\n' "IM making camid\$CAMID.\$TIMESTAMP.webm: This job will complete in the background..." && nice -n 20 ffmpeg -framerate "\$FRAMERATE" -i "\$CAMD."%04d.jpg -movflags +faststart -c:v libvpx-vp9 -g 1 "\$CAMD.\$TIMESTAMP".webm && { ls -al "\$CAMD.\$TIMESTAMP".webm && printf '\e[0;32m%s\e[0m\n' "IM making camid\$CAMID.\$TIMESTAMP.webm: DONE" ; } || printf '\e[1;31m%s\e[0m\n' "EM creating camid\$CAMID.\$TIMESTAMP.webm: ERROR"
printf '\e[0;36m%s' "IM mv camid\$CAMID.\$TIMESTAMP.webm ../../webm/\$CAMD; " && mv "\$CAMD.\$TIMESTAMP".webm ../../webms/\$CAMD && printf '\e[0;32m%s\e[0m\n' "DONE"
}
printf '\e[0;34m%s\e[1;36m%s\e[0;34m%s' "Starting command " "termux-wake-lock" ": "
am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService 1>/dev/null && printf '\e[0;32m%s\n\e[0;34m%s\e[1;36m%s\e[0;34m%s\n' "DONE" "Command " "termux-wake-unlock" " stops the wake lock." || printf '\e[0;33m%s\e[0m\n' "UTP am startservice: Continuing..."
E0VAR=0 # used to process zero size files
FRAMECOUNT=0 # initial frame count
TIMESTAMP="\$(date +%Y%m%d%H%M%S)"
_MAKEDIRS_ "\${1:-2}"
_CAMS_ "\$@"
_MECONVERT_ &
_MEFFMPEG_ &
PSAUX="(\$(ps aux))"
PSAUX="\$(grep -e convert -e ffmpeg <<< "\${PSAUX[@]}" | cut -d":" -f 2-9999 | cut -d " " -f 2-9999 ||:)"
printf '\e[0;34m%s\e[1;36m%s\n\e[1;32m%s\n' "IM " "running these background jobs:" "\${PSAUX[@]}"
printf '\e[0;34m%s\e[1;36m%s\e[0;34m%s\n' "IM " "ps aux" " shows processes running."
printf '\e[0;34m%s\e[1;36m%s\e[0;34m%s\e[0m\n' "The command " "termux-wake-unlock" " stops the wake lock."
sleep "\${7:-4}" ### [7] default of four seconds:  Time before exit;  Programs 'convert' and 'ffmpeg' will continue to run in the background until their jobs of producing animated gif and webm files end.
## ~/${INSTALLDIR##*/}/usr/local/bin/cams FE
EOM
chmod 755 usr/local/bin/cams
}

_ADDcdtd_() {
_CFLHD_ usr/local/bin/cdtd "# Usage: \`. cdtd\` the dot sources \`cdtd\` which makes this shortcut script work."
cat > usr/local/bin/cdtd <<- EOM
#!/usr/bin/env bash
cd "$HOME/storage/downloads" && pwd
## ~/${INSTALLDIR##*/}/usr/local/bin/cdtd FE
EOM
chmod 755 usr/local/bin/cdtd
}

_ADDcdth_() {
_CFLHD_ usr/local/bin/cdth "# Usage: \`. cdth\` the dot sources \`cdth\` which makes this shortcut script work."
cat > usr/local/bin/cdth <<- EOM
#!/usr/bin/env bash
cd "$HOME" && pwd
## ~/${INSTALLDIR##*/}/usr/local/bin/cdth FE
EOM
chmod 755 usr/local/bin/cdth
}

_ADDcdtmp_() {
_CFLHD_ usr/local/bin/cdtmp "# Usage: \`. cdtmp\` the dot sources \`cdtmp\` which makes this shortcut script work."
cat > usr/local/bin/cdtmp <<- EOM
#!/usr/bin/env bash
cd "$TMPDIR" && pwd || exit 169
## ~/${INSTALLDIR##*/}/usr/local/bin/cdtmp FE
EOM
chmod 755 usr/local/bin/cdtmp
}

_ADDch_() {
_CFLHDR_ usr/local/bin/ch "# This script creates and deletes the .hushlogin and .hushlogout files."
cat >> usr/local/bin/ch <<- EOM
declare -a ARGS

_TRPET_() {
printf "\\\\e[?25h\\\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\${ARGS[@]}"
}

_PRINTTAIL_() {
printf "\\\\e[0m%s \\\\e[1;32m%s \\\\e[0;32m%s\\\\e[1;34m: \\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\e[0m" "TermuxArch command" "\${0##*/} \$ARGS"  "version \$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s:DONE 📱 \007' "\${0##*/} \$ARGS"
}

## ch begin ####################################################################

if [[ -z "\${1:-}" ]]
then
ARGS=""
else
ARGS="\$@"
fi

if [[ -f "\$HOME"/.hushlogin ]] && [[ -f "\$HOME"/.hushlogout ]]
then
rm -f "\$HOME"/.hushlogin "\$HOME"/.hushlogout
printf "%s\\\\n" "Hushed login and logout: OFF"
elif [[ -f "\$HOME"/.hushlogin ]] || [[ -f "\$HOME"/.hushlogout ]]
then
touch "\$HOME"/.hushlogin "\$HOME"/.hushlogout
printf "%s\\\\n" "Hushed login and logout: ON"
else
touch "\$HOME"/.hushlogin "\$HOME"/.hushlogout
printf "%s\\\\n" "Hushed login and logout: ON"
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/ch FE
EOM
chmod 755 usr/local/bin/ch
}

_ADDchperms.cache+gnupg_() {
_CFLHDR_ usr/local/bin/chperms.cache+gnupg
cat >> usr/local/bin/chperms.cache+gnupg <<- EOM
[[ -d "\$HOME/.cache" ]] && find "\$HOME/.cache" -type d -exec chmod 777 {} \; && find "\$HOME/.cache" -type f -exec chmod 666 {} \;
[[ -d "\$HOME/.gnupg" ]] && find "\$HOME/.gnupg" -type d -exec chmod 777 {} \; && find "\$HOME/.gnupg" -type f -exec chmod 666 {} \;
## ~/${INSTALLDIR##*/}/usr/local/bin/chperms.cache+gnupg FE
EOM
chmod 755 usr/local/bin/chperms.cache+gnupg
}

_ADDcsystemctl_() {
_CFLHDR_ usr/local/bin/csystemctl "# Contributor https://github.com/petkar"
cat >> usr/local/bin/csystemctl <<- EOM
INSTALLDIR="$INSTALLDIR"
printf "\\\\e[38;5;148m%s\\\\e[0m\\\\n" "Installing /usr/bin/systemctl replacement: "
[ -f "/run/lock/${INSTALLDIR##*/}/csystemctl.lock" ] && printf "%s\\\\n" "Already installed /usr/local/bin/systemctl replacement: DONE 🏁" && exit
declare COMMANDP
COMMANDP="\$(command -v python3)" || printf "%s\\\\n" "Command python3 can not be found: continuing..."
[[ "\${COMMANDP:-}" == *python3* ]] || { pc python3 || pci python3 ; }
SDATE="\$(date +%s)"
# path is /usr/local/bin because updates overwrite /usr/bin/systemctl and may make systemctl-replacement obsolete
# backup original binary
mv -f /usr/bin/systemctl $INSTALLDIR/var/backups/${INSTALLDIR##*/}/systemctl.\$SDATE.bkp
printf "\\\\e[38;5;148m%s\\\\n\\\\e[0m" "Moved /usr/bin/systemctl to $INSTALLDIR/var/backups/${INSTALLDIR##*/}/systemctl.\$SDATE.bkp"
printf "%s\\\\n" "Getting replacement systemctl from https://raw.githubusercontent.com/TermuxArch/docker-systemctl-replacement/master/files/docker/systemctl3.py"
# Arch Linux package 'systemctl' updates will mot halt functioning as /usr/local/bin precedes /usr/bin in the PATH
# download and copy to both directories /usr/local/bin and /usr/bin
curl --fail --retry 2 https://raw.githubusercontent.com/TermuxArch/docker-systemctl-replacement/master/files/docker/systemctl3.py | tee /usr/bin/systemctl /usr/local/bin/systemctl >/dev/null
chmod 755 /usr/bin/systemctl /usr/local/bin/systemctl
:>"/run/lock/${INSTALLDIR##*/}/csystemctl.lock"
printf "\\\\e[38;5;148m%s\\\\e[1;32m%s\\\\e[0m\\\\n" "Installing systemctl replacement in /usr/local/bin and /usr/bin: " "DONE 🏁"
## ~/${INSTALLDIR##*/}/usr/local/bin/csystemctl FE
EOM
chmod 755 usr/local/bin/csystemctl
}

_ADDes_() {
_CFLHDR_ usr/local/bin/es
cat >> usr/local/bin/es <<- EOM
if [[ -z "\${1:-}" ]]
then
ARGS=(".")
else
ARGS=("\$@")
fi
EOM
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in $INSTALLDIR; the command '$STARTBIN command addauser username' can create user accounts in $INSTALLDIR from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "[ ! -x \"\$(command -v emacs)\" ] && { pc emacs || pci emacs ; } && emacs \"\${ARGS[@]}\" || emacs \"\${ARGS[@]}\"" "## ~/${INSTALLDIR##*/}/usr/local/bin/es FE" >> usr/local/bin/es
chmod 755 usr/local/bin/es
}

_ADDexd_() {
_CFLHDR_ usr/local/bin/exd "# Usage: \`. exd\` the dot sources \`exd\` which makes this shortcut script work."
cat >> usr/local/bin/exd <<- EOM
export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4712
## ~/${INSTALLDIR##*/}/usr/local/bin/exd FE
EOM
chmod 755 usr/local/bin/exd
}

_ADDfibs_() {
_CFLHDR_ usr/local/bin/fibs
cat >> usr/local/bin/fibs <<- EOM
find /proc/ -name maps 2>/dev/null | xargs awk '{print \$6}' 2>/dev/null | grep '\.so' | sort | uniq && exit
## ~/${INSTALLDIR##*/}/usr/local/bin/fibs FE
EOM
chmod 755 usr/local/bin/fibs
}

_ADDga_() {
_CFLHDR_ usr/local/bin/ga
cat >> usr/local/bin/ga <<- EOM
if [[ ! -x "\$(command -v git)" ]]
then
{ pc git || pci git ; }
git add .
else
git add .
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/ga FE
EOM
chmod 755 usr/local/bin/ga
}

_ADDgcl_() {
_CFLHDR_ usr/local/bin/gcl "# Contributor https://reddit.com/u/ElectricalUnion"
cat >> usr/local/bin/gcl <<- EOM
{ [ "\$UID" = 0 ] && printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..." && exit 101 ; }
{ [ "\$#" = 0 ] && printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "Example usage: " "'\${0##*/} https://github.com/TermuxArch/TermuxArch' " "Exiting..." ; } && exit 101
_GITCLONE_() {
WDIR_="\$PWD"
{ [ -d "$TMPDIR/\$\$" ] || mkdir -p "$TMPDIR/\$\$" ; } && cd "$TMPDIR/\$\$" && git init
printf "%s\\n" "Checking HEAD branch in \$@..."
RBRANCH="\$(git remote show "\$@" | grep 'HEAD branch' | cut -d' ' -f5)"
rm -rf "$TMPDIR/\$\$"
RBRANCH="\${RBRANCH# }" # strip leading space
printf "%s\\n" "Getting branch \$RBRANCH from git repository \$@..."
{ cd "\$WDIR_" && git clone --depth 1 "\$@" --branch \$RBRANCH --single-branch
}
}
[ -d "\${@##*/}" ] && printf "Directory %s exits;  Exiting...\\n" "\${@##*/}" && exit
if [[ ! -x "\$(command -v git)" ]]
then
{ pc git || pci git ; }
git clone --depth 1 "\$@" --branch master --single-branch || _GITCLONE_ "\$@"
else
git clone --depth 1 "\$@" --branch master --single-branch || _GITCLONE_ "\$@"
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/gcl FE
EOM
chmod 755 usr/local/bin/gcl
}

_ADDgclone_() {
_CFLHDR_ usr/local/bin/gclone "# Usefull for cloning over very slow and sketchy Internet connections."
cat >> usr/local/bin/gclone <<- EOM
if [ "\$UID" = 0 ]
then
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..."
else
{ [ "\$#" = 0 ] && printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "Example usage: " "'\${0##*/} https://github.com/TermuxArch/TermuxArch' " "Exiting..." ; } && exit 101
_GCLONEMAIN_() {
BASENAME="\${*%/}" # strip trailing slash
BASENAME="\${BASENAME#*//}" # strip before double slash
REPONAME="\${BASENAME##*/}" # strip before last slash
[ -e "\$REPONAME-master" ] && { cd "\$REPONAME-master" || exit 169 : } || { ( [ -e "\$REPONAME-main" ] || ( wget -c -O "\$REPONAME.zip" "\$*"/archive/main.zip && unzip "\$REPONAME.zip" ) && { cd "\$REPONAME-main" || exit 169 : } ; } || { [ -e "\$REPONAME-master" ] || ( wget -c -O "\$REPONAME.zip" "\$*"/archive/master.zip && unzip "\$REPONAME.zip" ) && cd "\$REPONAME-master" ; }
git init
git remote add origin "\$@" ||:
git checkout -b main || git checkout main
git add .
git pull --no-rebase --depth 1 "\$@" master || git pull --no-rebase --depth 1 "\$@" main
git add .
}
if [[ ! -x "\$(command -v wget)" ]] && [[ ! -x "\$(command -v unzip)" ]]
then
{ pc wget unzip || pci wget unzip || au wget unzip ; }
_GCLONEMAIN_ "\$@"
else
_GCLONEMAIN_ "\$@"
fi
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/gclone FE
EOM
chmod 755 usr/local/bin/gclone
}

_ADDgcm_() {
_CFLHDR_ usr/local/bin/gcm
cat >> usr/local/bin/gcm <<- EOM
if [[ ! -x "\$(command -v git)" ]]
then
{ pc git || pci git ; }
git commit
else
git commit
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/gcm FE
EOM
chmod 755 usr/local/bin/gcm
}

_ADDgitconfig_() {
if [[ -f "$HOME/.gitconfig" ]]
then
if [[ -f "$INSTALLDIR/root/.gitconfig" ]]
then
_DOTHRF_ "root/.gitconfig"
cp "$HOME/.gitconfig" "$INSTALLDIR/root/.gitconfig"
else
cp "$HOME/.gitconfig" "$INSTALLDIR/root/.gitconfig"
fi
else
:>"$INSTALLDIR/root/.gitconfig"
fi
}

_ADDgpl_() {
_CFLHDR_ usr/local/bin/gpl
cat >> usr/local/bin/gpl <<- EOM
if [[ ! -x "\$(command -v git)" ]]
then
{ pc git || pci git ; }
git pull
else
git pull
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/gpl FE
EOM
chmod 755 usr/local/bin/gpl
}

_ADDgp_() {
_CFLHDR_ usr/local/bin/gp "# git push https://username:password@github.com/username/repository.git"
cat >> usr/local/bin/gp <<- EOM
if [[ ! -x "\$(command -v git)" ]]
then
{ pc git || pci git ; }
git push
else
git push
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/gp FE
EOM
chmod 755 usr/local/bin/gp
}

_ADDinfo_ () {
_CFLHDR_ usr/local/bin/info
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in $INSTALLDIR; the command '$STARTBIN command addauser username' can create user accounts in $INSTALLDIR from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "[ ! -x \"/usr/bin/info\" ] && { pc texinfo || pci texinfo ; } && /usr/bin/info \"\$@\" || /usr/bin/info \"\$@\"" "## ~/${INSTALLDIR##*/}/usr/local/bin/info FE" >> usr/local/bin/info
chmod 755 usr/local/bin/info
}

_ADDmakeauraclegit_() {
_CFLHDR_ usr/local/bin/makeauraclegit
printf "%s\\n%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "_PRNTWAIT_() { printf \"\\e[0;32m%s\\n\" \"Please wait a moment;  Command '\${0##*/}' continuing...\" ; }" "{ [ -x /usr/bin/auracle ] && printf \"\\e[0;31m%s\\n\" \"The comman 'aur' is installed;  Exiting...\" ; } || { { cd && gcl https://aur.archlinux.org/auracle-git ||: ; } && cd auracle-git && _PRNTWAIT_ && makepkg -firs --noconfirm ; auracle --help ; }" "## ~/${INSTALLDIR##*/}/usr/local/bin/makeaurracle FE" >> usr/local/bin/makeauraclegit
chmod 755 usr/local/bin/makeauraclegit
}

_ADDmakeaurhelpers_() {
_CFLHDR_ usr/local/bin/makeaurhelpers "# add Arch Linux AUR helpers https://wiki.archlinux.org/index.php/AUR_helpers"
cat >> usr/local/bin/makeaurhelpers <<- EOM
printf "%s\\n" "Command ${0##*/} is depreciated;  Exiting..."
exit 0
_CLONEAURHELPER_() {
cd "\$HOME/aurhelpers" || exit 196
if [[ ! -d "\$AURHELPER" ]]
then
printf "%s\\\\n\\\\n" "Cloning repository '\$AURHELPER' from https://aur.archlinux.org." && cd && gcl https://aur.archlinux.org/\${AURHELPER}.git && printf "%s\\\\n\\\\n" "Finished cloning repository '\$AURHELPER' from https://aur.archlinux.org." && _MAKEAURHELPER_ || _PRTERROR_
else
{ printf "%s\\\\n" "Repository '\$AURHELPER' is already cloned." && _MAKEAURHELPER_ ; } || _PRTERROR_
fi
}

_DONEAURHELPER_(){
#command "\$1" || _DOAURHELPERS_
if ! command "\$1"
then
printf '%s\n' "Found command \$1"
if printf '%s\n' "\${AURHELPERS[@]}" | grep -q -P "^\$1$"
then
printf '%s\n' "\$1"
fi
fi
}

_DOAURHELPERS_(){
for AURHELPER in \${AURHELPERS[@]}
do
if [ "\$AURHELPER" = stack-static ]
then
gpg --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442
fi
if [ "\$AURHELPER" = pacaur ]
then
{ pc expac  || pci expac ; }
AURHELPER=auracle-git
_CLONEAURHELPER_
fi
if [ "\$AURHELPER" = bauerbill ]
then
{ pc python-pyxdg || pci python-pyxdg ; }
BAUERBILLDEPS=(pbget pm2ml powerpill python3-aur python3-colorsysplus python3-memoizedb python3-xcgf python3-xcpf)
for AURHELPER in \${BAUERBILLDEPS[@]}
do
_CLONEAURHELPER_
done
fi
_CLONEAURHELPER_
done
}

_MAKEAURHELPER_() {
cd "\$HOME/aurhelpers/\$AURHELPER" || exit 196
printf "%s\\\\n" "Running command 'nice -n 20 makepkg -firs --noconfirm';  Building and attempting to install '\$AURHELPER' with '\${0##*/}' version $VERSIONID.  Please be patient..."
nice -n 20 makepkg -firs --noconfirm || nice -n 20 makepkg -firs --noconfirm || _PRTERROR_
}

_PRTERROR_() {
printf "\\\\n\\\\e[1;31merror: \\\\e[1;37m%s\\\\e[0m\\\\n\\\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s) and run '\${0##*/} \$ARGS' again."
}

[ ! -d "\$HOME/aurhelpers" ] && mkdir -p "\$HOME/aurhelpers"
UNAMEM="\$(uname -m)"
if [ "\$UNAMEM" = x86-64 ]
then
AURHELPERS=(stack-static aura-git auracle-git aurutils bauerbill pacaur pakku paru pbget pikaur-git pkgbuilder puyo repoctl repofish rua trizen yaah yayim)
elif [ "\$UNAMEM" = i386 ]
then
AURHELPERS=(auracle-git aurutils bauerbill pacaur pakku paru pbget pikaur-git pkgbuilder puyo repoctl repofish rua trizen yaah yayim)
else
AURHELPERS=(aurutils bauerbill pacaur pakku paru pbget pikaur-git pkgbuilder puyo repoctl repofish trizen yaah yayim)
fi
# command yay || makeauryay
# _DONEAURHELPER_ pikaur
# _DOAURHELPERS_
## ~/${INSTALLDIR##*/}/usr/local/bin/makeaurhelpers FE
EOM
chmod 755 usr/local/bin/makeaurhelpers
}

_ADDmakeaurfakeroottcp_() {
_CFLHDR_ usr/local/bin/makeaurfakeroottcp "# build and install fakeroot-tcp"
cat >> usr/local/bin/makeaurfakeroottcp <<- EOM
_DOMAKEFAKEROOTTCP_() {
_PRTERROR_() {
printf "\\n\\e[1;31merror: \\e[1;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s), and run '\${0##*/} \$ARGS' again." && exit 104
}
if [ "\$UID" = 0 ]
then
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..."
else
[ ! -f "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" ] && patchmakepkg || printf "\\\\e[0;33m%s\\\\e[0m\\\\n" "Lock file "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" found;  Continuing..."
printf "%s\\\\n" "Preparing to build and install fakeroot-tcp with \${0##*/} version $VERSIONID: "
if ([[ ! "\$(command -v automake)" ]] || [[ ! "\$(command -v git)" ]] || [[ ! "\$(command -v gcc -v)" ]] || [[ ! "\$(command -v libtool)" ]] || [[ ! "\$(command -v po4a)" ]]) 2>/dev/null
then
pci automake base base-devel fakeroot git gcc libtool po4a || printf "\\n\\e[1;31mＴｅｒｍｕｘＡｒｃｈ SIGNAL: \\e[7;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s) by running command 'pci automake base base-devel fakeroot git gcc go libtool po4a' as root user in a new Termux session.  You can do this without closing this session by running command \"$STARTBIN command 'pci automake base base-devel fakeroot git gcc go libtool po4a'\"in a new Termux session. Then return to this session and run '\${0##*/} \$ARGS' again."
fi
cd
[ ! -d fakeroot-tcp ] && gcl https://aur.archlinux.org/fakeroot-tcp.git
_FUNDOPKGBUILD_() {
cp PKGBUILD PKGBUILD.$$.bkp
sed -ir '/prepare()/,+4d' PKGBUILD
sed -i 's/silence-dlerror.patch//g' PKGBUILD
sed -i 's/pkgver=1.24/pkgver=1.25.3/g' PKGBUILD
sed -i 's/ftp.debian.org\/debian/http.kali.org\/kali/g' PKGBUILD
sed -i '/^md5sums=/{n;d}' PKGBUILD
sed -ir "s/^md5sums=.*/md5sums=('f6104ef6960c962377ef062bf222a1d2')/g" PKGBUILD
:>"/run/lock/${INSTALLDIR##*/}/makeaurfakeroottcp_FUNDOPKGBUILD_.lock"
}
cd fakeroot-tcp || exit 196
[ ! -f "/run/lock/${INSTALLDIR##*/}/makeaurfakeroottcp_FUNDOPKGBUILD_.lock" ] && _FUNDOPKGBUILD_
printf "%s\\\\n" "Running command 'nice -n 20 makepkg -firs --noconfirm';  Building and attempting to install 'fakeroot-tcp' with '\${0##*/}' version $VERSIONID.  Please be patient..."
nice -n 20 makepkg -firs --noconfirm || _PRTERROR_
libtool --finish /usr/lib/libfakeroot || _PRTERROR_
:>"/run/lock/${INSTALLDIR##*/}/makeaurfakeroottcp.lock"
fi
printf "%s\\\\n" "Building and installing fakeroot-tcp: DONE 🏁"
}
[ ! -f "/run/lock/${INSTALLDIR##*/}/makeaurfakeroottcp.lock" ] && _DOMAKEFAKEROOTTCP_ || printf "%s\\\\n" "Please remove file "/run/lock/${INSTALLDIR##*/}/makeaurfakeroottcp.lock" in order to rebuild fakeroot-tcp with \${0##*/} version $VERSIONID."
## ~/${INSTALLDIR##*/}/usr/local/bin/makeaurfakeroottcp FE
EOM
chmod 755 usr/local/bin/makeaurfakeroottcp
}

_ADDmakeaurghcuphs_() {
_CFLHDR_ usr/local/bin/makeaurghcuphs "# install Haskell language ghcup-hs installer with the Arch Linux aur installer yay"
cat >> usr/local/bin/makeaurghcuphs <<- EOM
if [ "\$UID" = 0 ]
then
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..."
else
[ -x /usr/bin/ghcup ] && printf "\\\\e[0;32m%s\\\\e[0m\\\\n" "The command 'ghcup' is already installed!  Please use the command 'ghcup':  Exiting..." && exit 169
[ -f /usr/lib/libnuma.so ] || { pc numactl || pci numactl ; } || { printf "\\n\\e[1;31mＴｅｒｍｕｘＡｒｃｈ SIGNAL: \\e[7;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s) by running command 'pci numactl' as proot root user.  You might be able to bring this about without closing this session.  Please try running command: $STARTBIN command 'pci numactl' in a new Termux PRoot session.  This should install the neccessary packages to make 'ksh'.  Then return to this session, and run '\${0##*/}' again." && exit 120 ; }
yay ghcup-hs --noconfirm 2>/dev/null || { [ -f /usr/bin/yay ] || set +x && makeauryay && yay ghcup-hs --noconfirm && set -x ; }
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/makeaurghcuphs FE
EOM
chmod 755 usr/local/bin/makeaurghcuphs
}

_ADDmakeaurutils_() {
_CFLHDR_ usr/local/bin/makeaurutils "# install Arch Linux aurutils aur installer"
printf "%s\\n%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "_PRNTWAIT_() { printf \"\\e[0;32m%s\\n\" \"Please wait a moment;  Command '\${0##*/}' is continuing...\" ; }" "{ [ -x /usr/bin/aur ] && printf \"\\e[0;31m%s\\n\" \"The comman 'aur' is installed;  Exiting...\" ; } || { { cd && gcl https://github.com/AladW/aurutils ||: ; } && cd aurutils/makepkg && _PRNTWAIT_ && makepkg -firs --noconfirm ; aur --help ; }" "## ~/${INSTALLDIR##*/}/usr/local/bin/makeaurutils FE" >> usr/local/bin/makeaurutils
chmod 755 usr/local/bin/makeaurutils
}

_ADDmakeaurpikaur_() {
_CFLHDR_ usr/local/bin/makeaurpikaur "# install Arch Linux pikaur aur installer"
printf "%s\\n%s\\n%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "{ [ -x /usr/bin/pikaur ] && printf \"\\e[0;31m%s\\n\" \"The command 'pikaur' is installed;  Exiting...\" && exit ; } || _PRNTWAIT_() { printf \"\\e[0;32m%s\\n\" \"Please wait a moment;  Command '\${0##*/}' continuing...\" ; }" "[ -x /usr/bin/fakeroot ] || pci base base-devel" "{ cd && [ -x pikaur ] || gcl https://github.com/actionless/pikaur ; } && cd pikaur && _PRNTWAIT_ && makepkg -fisr --noconfirm ; pikaur --help" "## ~/${INSTALLDIR##*/}/usr/local/bin/makeaurpikaur FE" >> usr/local/bin/makeaurpikaur
chmod 755 usr/local/bin/makeaurpikaur
}

_ADDmakeaurrustup_() {
_CFLHDR_ usr/local/bin/makeaurrustup
cat >> usr/local/bin/makeaurrustup <<- EOM
if [ "\$UID" = 0 ]
then
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..."
else
[ -x /usr/bin/rustup ] && printf "\\\\e[0;32m%s\\\\e[0m\\\\n" "The command 'rustup' is already installed!  Please use the command 'rustup':  Exiting..." && exit 169
{ pc rustup --noconfirm || pci rustup --noconfirm ; } || yay rustup --noconfirm
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/rustup FE
EOM
chmod 755 usr/local/bin/makeaurrustup
}

_ADDmakeaurshellcheckbin_() {
_CFLHDR_ usr/local/bin/makeaurshellcheckbin
cat >> usr/local/bin/makeaurshellcheckbin <<- EOM
if [ "\$UID" = 0 ]
then
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..."
else
[ -x /usr/bin/shellcheck ] && printf "\\\\e[0;32m%s\\\\e[0m\\\\n" "The command 'shellcheck' is already installed!  Please use the command 'shellcheck':  Exiting..." && exit 169
yay shellcheck-bin --noconfirm 2>/dev/null || { [ ! "\$(command -v yay)" ] && makeauryay && yay shellcheck-bin --noconfirm ; }
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/makeaurshellcheckbin FE
EOM
chmod 755 usr/local/bin/makeaurshellcheckbin
}

_ADDmakeaurtllocalmgr_() {
_CFLHDR_ usr/local/bin/makeaurtllocalmgr
cat >> usr/local/bin/makeaurtllocalmgr <<- EOM
if [ "\$UID" = 0 ]
then
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..."
else
[ -x /usr/bin/tllocalmgr ] && printf "\\\\e[0;32m%s\\\\e[0m\\\\n" "The command 'tllocalmgr' is already installed!  Please use the command 'tllocalmgr':  Exiting..." && exit 169
yay tllocalmgr --noconfirm 2>/dev/null || { [ ! -x /usr/bin/yay ] && makeauryay && yay tllocalmgr --noconfirm ; }
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/makeaurtllocalmgr FE
EOM
chmod 755 usr/local/bin/makeaurtllocalmgr
}

_ADDmakeaurtrizen_() {
_CFLHDR_ usr/local/bin/makeaurtrizen
printf "%s\\n%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "_PRNTWAIT_() { printf \"\\e[0;32m%s\\n\" \"Please wait a moment;  Command '\${0##*/}' is continuing...\" ; }" "{ [ -x /usr/bin/trizen ] && printf \"\\e[0;31m%s\\n\" \"The comman 'trizen' is installed;  Exiting...\" ; } || { { cd && gcl https://github.com/trizen/trizen ||: ; } && cd trizen/archlinux/ && _PRNTWAIT_ && makepkg -firs --noconfirm; trizen --help ; }" "## ~/${INSTALLDIR##*/}/usr/local/bin/makeaurtrizen FE" >> usr/local/bin/makeaurtrizen
chmod 755 usr/local/bin/makeaurtrizen
}

_ADDmakeauryay_() {
_CFLHDR_ usr/local/bin/makeauryay "# build and install command yay; Contributors https://github.com/cb125 and https://github.com/SampsonCrowley"
cat >> usr/local/bin/makeauryay <<- EOM
_PRTERROR_() {
printf "\\n\\e[1;31mＴｅｒｍｕｘＡｒｃｈ SIGNAL: \\e[1;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct thiserror the error(s) and/or warning(s), and run '\${0##*/}' again."
exit 100
}
if [ "\$UID" = 0 ]
then
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..."
else
[ -x /usr/bin/yay ] && printf "\\\\e[0;32m%s\\\\e[0m\\\\n" "The command 'yay' is already installed!  Please use the command 'yay':  Exiting..." && exit 169
_PRMAKE_() {
printf "\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mnice -n 20 makepkg -firs --noconfirm\\\\e[1;37m...\\\\n"
}
printf "\\\\e[0;32m%s\\\\e[0m\\\\n" "Attempting to build and install 'yay':"
if [[ -n "\${PREFIX:-}" ]]
then
: # pull requests are requested to automate install missing Termux packages
else
[ ! -f "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" ] && patchmakepkg
if { [[ ! "\$(command -v fakeroot)" ]] || [[ ! "\$(command -v git)" ]] || [[ ! "\$(command -v go)" ]] ; } 2>/dev/null
then
pci base base-devel fakeroot gcc git go || pci base base-devel fakeroot gcc git go || ( printf "\\n\\e[1;31mＴｅｒｍｕｘＡｒｃｈ SIGNAL: \\e[7;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s);  The command 'pci base base-devel fakeroot gcc git go' can be run as proot root user in a new Termux session and might resolve this issue.  You might be able to do this without closing this session.  Please try running command: $STARTBIN command 'pci base base-devel fakeroot gcc git go' in a new Termux PRoot session.  Then return to this session, and run '\${0##*/}' again." && exit 120 )
fi
fi
cd
[ ! -d yay ] && gcl https://aur.archlinux.org/yay.git
{ cd yay && _PRMAKE_ && nice -n 20 makepkg -firs --noconfirm ; } || { printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL: " "The command 'nice -n 20 makepkg -firs --noconfirm' did not run as expected; " "EXITING..." && exit 124 ; }
printf "\\\\e[0;32m%s\\\\n%s\\\\n%s\\\\e[1;32m%s\\\\e[0m\\\\n" "Paths that can be followed after building 'yay' are 'yay cmatrix --noconfirm' which builds a matrix screensaver.  The commands 'yay pikaur|pikaur-git|tpac' build more aur installers which can also be used to download aur repositories and build packages like with 'yay' in your Android smartphone, tablet, wearable and more.  Did you know that 'android-studio' is available with the command 'yay android'?" "If you have trouble importing keys, this command 'gpg --keyserver keyserver.ubuntu.com --recv-keys 71A1D0EFCFEB6281FD0437C71A1D0EFCFEB6281F' might help.  Change the number to the number of the key being imported." "Building and installing yay: " "DONE 🏁"
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/makeauryay FE
EOM
chmod 755 usr/local/bin/makeauryay
}

_PREPFILEFTN0_() { _CFLHDR_ usr/local/bin/makeaur"$3" && _PREPFILEFCTN_ "$1" "$2"  usr/local/bin/makeaur"$3" && chmod 755 usr/local/bin/makeaur"$3" ; }

_ADDmakeaurpopularpackages_() { _PREPFILEFTN0_ popular-packages popular-packages popularpackages ; }

_ADDmakeaurpackagequery_() { _PREPFILEFTN0_ package-query package-query packagequery ; }

_ADDmakeauryaah_() { _PREPFILEFTN0_ yaah yaah yaah ; }

_ADDmakeauryayim_() { _PREPFILEFTN0_ yayim yayim yayim ; }

_ADDmakeaurbauerbill_() { _PREPFILEFTN0_ bauerbill bauerbill bauerbill ; }

_ADDmakeaurpacaur_() { _PREPFILEFTN0_ pacaur pacaur pacaur ; }

_ADDmakeaurpakku_() { _PREPFILEFTN0_ pakku pakku pakku ; }

_ADDmakeaurparu_() { _PREPFILEFTN0_ paru paru paru ; }

_ADDmakeaurpbget_() { _PREPFILEFTN0_ pbget pbget pbget ; }

_ADDmakeaurpikaur-git_() { _PREPFILEFTN0_ pikaur pikaur-git pikaur-git ; }

_ADDmakeaurpkgbuilder_() { _PREPFILEFTN0_ pkgbuilder pkgbuilder pkgbuilder ; }

_ADDmakeaurpuyo_() { _PREPFILEFTN0_ puyo puyo puyo ; }

_ADDmakeaurrepoctl_() { _PREPFILEFTN0_ repoctl repoctl repoctl ; }

_ADDmakeaurrepofish_() { _PREPFILEFTN0_ repofish repofish repofish ; }

_ADDmakeksh_() {
_CFLHDR_ usr/local/bin/makeksh "# build and install the ksh shell; Inspired by https://github.com/termux/termux-api/issues/436"
cat >> usr/local/bin/makeksh <<- EOM
_PRTERROR_() {
printf "\\n\\e[1;31merror: \\e[1;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s), and run '\${0##*/} \$ARGS' again."
exit 100
}
if [ "\$UID" = 0 ]
then
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..."
else
printf "\\\\e[0;32m%s\\\\e[0m\\\\n" "Attempting to build and install 'ksh':"
if [[ -n "\${PREFIX:-}" ]]
then
: # pull requests are requested to automate install missing Termux packages
else
if [[ ! -f /usr/bin/make ]] || [[ ! -f /usr/bin/git ]] || [[ ! -f /usr/bin/bison ]]
then
pc bison base base-devel gcc git || pci bison base base-devel gcc git || ( printf "\\n\\e[1;31mＴｅｒｍｕｘＡｒｃｈ SIGNAL: \\e[7;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s) by running command 'pci bison base base-devel gcc git' as proot root user.  You might be able to bring this about without closing this session.  Please try running command: $STARTBIN command 'pci base base-devel gcc git' in a new Termux PRoot session.  This should install the neccessary packages to make 'ksh'.  Then return to this session, and run '\${0##*/}' again." && exit 120 )
fi
fi
cd
[ ! -d ksh ] && gcl https://github.com/ksh-community/ksh
( cd ksh && nice -n 20 ./bin/package make ) || ( printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL: " "The commands 'cd ksh && nice -n 20 ./bin/package make' did not run as expected; " "EXITING..." && exit 124 )
find "\$HOME"/ksh/arch/*/bin -type f -executable ||: # printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\n" "ＴｅｒｍｕｘＡｒｃｈ SIGNAL: " "The command 'find arch/*/bin -type f -executable' did not run as expected; CONTINUING..." && _PRTERROR_
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/makeksh FE
EOM
chmod 755 usr/local/bin/makeksh
}

_ADDmemav_() {
_CFLHDR_ usr/local/bin/memav
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "grep -i available /proc/meminfo" "## ~/${INSTALLDIR##*/}/usr/local/bin/memav FE" >> usr/local/bin/memav
chmod 755 usr/local/bin/memav
}

_ADDmemfree_() {
_CFLHDR_ usr/local/bin/memfree
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "grep -i free /proc/meminfo" "## ~/${INSTALLDIR##*/}/usr/local/bin/memfree FE" >> usr/local/bin/memfree
chmod 755 usr/local/bin/memfree
}

_ADDmeminfo_() {
_CFLHDR_ usr/local/bin/meminfo
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "cat /proc/meminfo" "## ~/${INSTALLDIR##*/}/usr/local/bin/meminfo FE" >> usr/local/bin/meminfo
chmod 755 usr/local/bin/meminfo
}

_ADDmemmem_() {
_CFLHDR_ usr/local/bin/memmem
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "grep -i mem /proc/meminfo" "## ~/${INSTALLDIR##*/}/usr/local/bin/memmem FE" >> usr/local/bin/memmem
chmod 755 usr/local/bin/memmem
}

_ADDmemtot_() {
_CFLHDR_ usr/local/bin/memtot
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "grep -i total /proc/meminfo" "## ~/${INSTALLDIR##*/}/usr/local/bin/memtot FE" >> usr/local/bin/memtot
chmod 755 usr/local/bin/memtot
}

_ADDmota_() {
cat > etc/mota <<- EOM
printf "\\\\n\\\\e[1;34m%s\\\\n%s\\\\e[0;34m%s\\\\n\\\\e[1;34m%s\\\\e[0;34m%s\\\\n\\\\e[1;34m%s\\\\e[0;34m%s\\\\n\\\\e[1;34m%s\\\\e[0;34m%s\\\\n\\\\n\\\\e[1;34m%s\\\\e[0m%s\\\\n\\\\e[1;34m%s\\\\e[0m%s\\\\n\\\\e[1;34m%s\\\\e[0m%s\\\\n\\\\e[1;34m%s\\\\e[0;34m%s\\\\e[1;34m%s\\\\e[0;34m%s\\\\n\\\\e[1;34m%s\\\\e[0m%s\\\\n\\\\e[1;34m%s\\\\e[0m%s\\\\n\\\\n" "Welcome to Arch Linux in Termux PRoot!" "Install a package: " "pacman -S package" "More  information: " "pacman -[D|F|Q|R|S|T|U]h" "Search   packages: " "pacman -Ss query" "Upgrade  packages: " "pacman -Syu" "Chat:	" "wiki.termux.com/wiki/Community" "Discus:	" "github.com/login/repo/discussions" "GitHub:	" "$MOTTECGIT" "Help:	" "help man " "and " "info man" "IRC:	" "$MOTTECIRC" "Rev:	" "github.com/login/repo/releases"
EOM
}

_ADDmotd_() {
cat > etc/motd <<- EOM
Welcome to Arch Linux in Termux PRoot!
Install a package: pacman -S package
More  information: pacman -[D|F|Q|R|S|T|U]h
Search   packages: pacman -Ss query
Upgrade  packages: pacman -Syu

$MOTTECBBS
Chat:	wiki.termux.com/wiki/Community
Discus:	github.com/login/repo/discussions
Help:	info query and man query
GitHub:	$MOTTECGIT
IRC:	$MOTTECIRC
Rev:	github.com/login/repo/releases
EOM
}

_ADDmoto_() {
cat > etc/moto <<- EOM
printf "\\\\n\\\\e[1;34mPlease share your Arch Linux in Termux PRoot experience!\\\\n\\\\n\\\\e[1;34mChat:	\\\\e[0mwiki.termux.com/wiki/Community\\\\n\\\\e[1;34mDiscus:	\\\\e[0mgithub.com/login/repo/discussions\\\\n\\\\e[1;34mGitHub:	\\\\e[0m%s\\\\n\\\\e[1;34mHelp:	\\\\e[0;34mhelp man \\\\e[1;34mand \\\\e[0;34minfo man\\\\n\\\\e[1;34mIRC:	\\\\e[0m%s\\\\n\\\\e[1;34mRev:	\\\\e[0mgithub.com/login/repo/releases\\\\n\\\\n\\\\e[0m" "$MOTTECGIT" "$MOTTECIRC"
EOM
}

_ADDopen4root_() {
_CFLHDR_ usr/local/bin/open4root "# open programs in /usr/local/bin/ for root user"
cat >> usr/local/bin/open4root <<- EOM
sed -i 's/UID\" = 0/UID\" = -1/g' /usr/local/bin/*
sed -i 's/EUID == 0/EUID == -1/g' /usr/local/bin/*
## ~/${INSTALLDIR##*/}/usr/local/bin/open4root FE
EOM
chmod 755 usr/local/bin/open4root
}

_ADDorcaconf_() {
_CFLHDR_ usr/local/bin/orcaconf "# Contributor https://github.com/JanuszChmiel" "# Reference https://github.com/SDRausty/termux-archlinux/issues/66 Let us expand setupTermuxArch so users can install Orca screen reader (assistive technology) and also have VNC support added easily."
cat >> usr/local/bin/orcaconf <<- EOM
[[ -f "/run/lock/${INSTALLDIR##*/}/orcaconf.lock" ]] && printf "%s\\\\n" "Already configured orca: DONE 🏁" && exit
_INSTALLORCACONF_() {
[[ ! -f "/run/lock/${INSTALLDIR##*/}/orcaconfinstall.lock" ]] && (nice -n 18 pci espeak-ng mate mate-extra orca pulseaudio-alsa tigervnc || nice -n 18 pci espeak-ng mate mate-extra orca pulseaudio-alsa tigervnc) && :>"/run/lock/${INSTALLDIR##*/}/orcaconfinstall.lock" || printf "%s\\n" "_INSTALLORCACONF_ \${0##*/} did not completed as expected; Continuing..."
}
_INSTALLORCACONF_ || _INSTALLORCACONF_ || (printf "%s\\n" "_INSTALLORCACONF_ \${0##*/} did not completed as expected.  Please check for errors and run \${0##*/} again." && exit)
csystemctl || printf "\\e[1;31m%s\\e[0m\\n" "command 'csystemctl' did not completed as expected"
[[ ! -f "/run/lock/${INSTALLDIR##*/}/orcaconf.lock" ]] && :>"/run/lock/${INSTALLDIR##*/}/orcaconf.lock"
orcarun || printf "\\e[1;31m%s\\e[0m\\n" "command 'orcarun' did not completed as expected"
## ~/${INSTALLDIR##*/}/usr/local/bin/orcaconf FE
EOM
chmod 755 usr/local/bin/orcaconf
_ADDorcarun_() {
_CFLHDR_ usr/local/bin/orcarun "# Contributor https://github.com/JanuszChmiel " "# Reference https://github.com/SDRausty/termux-archlinux/issues/66 Let's expand setupTermuxArch so users can install Orca screen reader (assistive technology) and also have VNC support added easily."
cat >> usr/local/bin/orcarun <<- EOM
if ! command Xvnc
then
orcaconf
else
Xvnc -localhost -geometry 1024x768 -depth 24 -SecurityTypes=None
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/orcarun FE
EOM
chmod 755 usr/local/bin/orcarun
}
_ADDorcarun_
}

_ADDpatchmakepkg_() {
_CFLHDR_ usr/local/bin/patchmakepkg "# patch makepkg;  Contributor https://github.com/petkar"
cat >> usr/local/bin/patchmakepkg <<- EOM
[ -f "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" ] && printf "%s\\\\n" "Found /run/lock/${INSTALLDIR##*/}/patchmakepkg.lock file;  Already patched makepkg:  DONE 🏁" && exit
printf "Patching makepkg: \\\\n"
SDATE="\$(date +%s)"
BKPDIR="$INSTALLDIR/var/backups/${INSTALLDIR##*/}/"
[ ! -d "\$BKPDIR" ] && mkdir -p "\$BKPDIR"
cp /bin/makepkg "\$BKPDIR/makepkg.\$SDATE.bkp"
if [ "\$(awk 'FNR==232{print \$0}' /bin/makepkg)" != "#" ]
then
sed -ie 's/fakeroot -- bash/bash/g' /bin/makepkg
sed -ir 's/\$(fakeroot -v)/fakeroot -v/g' /bin/makepkg
# sed append to beginning of lines
sed -ie 240,241's/.*/# &/' /bin/makepkg
sed -ie 1195,1199's/.*/# &/' /bin/makepkg
fi
# copy makepkg to /usr/local/bin to update proof it (fail safe measure)
cp /bin/makepkg /usr/local/bin/makepkg
# create lock file to update proof patchmakepkg
:>"/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock"
printf "Patching makepkg: DONE 🏁\\\\n"
## ~/${INSTALLDIR##*/}/usr/local/bin/patchmakepkg FE
EOM
chmod 755 usr/local/bin/patchmakepkg
}

_ADDpacmandblock_() {
_CFLHDR_ usr/local/bin/pacmandblock "# When using the alternate elogin or euser option to login with $STARTBIN as user 'pacman' does not behave as expected;  Hence 'pacman' is blocked when the alternate login feature is used."
cat >> usr/local/bin/pacmandblock <<- EOM
LOCKFILE="/var/lib/pacman/db.lck"
if [ ! -f "\$LOCKFILE" ]
then
printf "%s" "Creating file \$LOCKFILE: "
:>"\$LOCKFILE"
printf "%s\\\\n" "DONE"
elif [ -f "\$LOCKFILE" ]
then
printf "%s" "Deleting file \$LOCKFILE: "
rm -f "\$LOCKFILE"
printf "%s\\\\n" "DONE"
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/pacmandblock FE
EOM
chmod 755 usr/local/bin/pacmandblock
}

_ADDpc_() {
_CFLHDR_ usr/local/bin/pc "# pacman install packages wrapper without system update"
cat >> usr/local/bin/pc <<- EOM
declare -g ARGS="\$@"
umask 0022
_TRPET_() {
printf "\\\\e[?25h\\\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\$ARGS"
}

_PRINTTAIL_() {
printf "\\\\e[0;32m%s %s %s\\\\e[1;34m: \\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\e[0m" "TermuxArch \${0##*/}" "\$ARGS" "version \$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s:DONE 📱 \007' "\${0##*/} \$ARGS"
}

trap _TRPET_ EXIT
## pc begin ####################################################################
printf '\033]2;  🔑 TermuxArch %s 📲 \007' "\${0##*/} \$ARGS"
printf "\\\\e[1;32m==> \\\\e[1;37mRunning TermuxArch command \\\\e[1;32m%s \\\\e[0;32m%s\\\\e[1;37m...\\\\n" "\${0##*/} \$ARGS" "version \$VERSIONID"
[ "\$UID" -eq 0 ] && SUDOCONF="" || SUDOCONF="sudo"
if [[ -z "\${1:-}" ]]
then
printf "\\\\e[1;31m%s \\\\e[0m\\\\n" "Run command '\${0##*/}' with at least one argument;  Exiting..."
elif [[ "\$1" = "a" ]]
then
nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -S base base-devel "\${@:2}"
elif [[ "\$1" = "ae" ]]
then
nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -S base base-devel emacs "\${@:2}"
elif [[ "\$1" = "a8" ]]
then
nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -S base base-devel emacs jdk8-openjdk "\${@:2}"
else
nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -S "\$@"
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/pc FE
EOM
chmod 755 usr/local/bin/pc
}

_ADDpci_() {
_CFLHDR_ usr/local/bin/pci "# pacman install packages wrapper with system update"
cat >> usr/local/bin/pci <<- EOM
declare ARGS="\$@"
umask 0022
_TRPET_() {
printf "\\\\e[?25h\\\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\$ARGS"
}

_PRINTTAIL_() {
printf "\\\\e[0;32m%s %s %s\\\\e[1;34m: \\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\e[0m" "TermuxArch \${0##*/}" "\$ARGS" "version \$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s:DONE 📱 \007' "\${0##*/} \$ARGS"
}

trap _TRPET_ EXIT
## pci begin ###################################################################
[ "\$UID" -eq 0 ] && SUDOCONF="" || SUDOCONF="sudo"
printf "\\\\e[1;32m==> \\\\e[1;37mRunning TermuxArch command \\\\e[1;32m%s \\\\e[0;32m%s\\\\e[1;37m...\\\\n" "\${0##*/} \$ARGS" "version \$VERSIONID"
if [[ -z "\${1:-}" ]]
then
nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Syu || nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Syu
elif [[ "\$1" = "e" ]]
then
nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Syu "\${@:2}" || base base-devel emacs "\${@:2}" || nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Su base base-devel emacs "\${@:2}"
elif [[ "\$1" = "e8" ]]
then
nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Syu base base-devel emacs jdk8-openjdk "\${@:2}" || nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Su base base-devel emacs jdk8-openjdk "\${@:2}"
elif [[ "\$1" = "e11" ]]
then
nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Syu base base-devel emacs jdk11-openjdk "\${@:2}" || nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Su base base-devel emacs jdk11-openjdk "\${@:2}"
else
nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Syu "\$@" || nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Su "\$@"
fi
## ~/${INSTALLDIR##*/}/usr/local/bin/pci FE
EOM
chmod 755 usr/local/bin/pci
}

_ADDprofileusretc_() {
if ! grep -q pulseaudio "$PREFIX/etc/profile" 2>/dev/null
then
printf "%s\\n%s\\n" "pulseaudio --start --exit-idle-time=-1" "pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" >> "$PREFIX/etc/profile"
fi
}

_ADDprofileetc_() {
if [ -f "$INSTALLDIR/etc/profile" ]
then
if ! grep -q 'export PULSE_SERVER=127.0.0.1' "$INSTALLDIR/etc/profile"
then
printf "%s\\n" "##  The next lines were generated by ${0##*/} at ${FTIME//-}.
export DISPLAY=:0
export PULSE_SERVER=127.0.0.1
unset DBUS_SESSION_BUS_ADDRESS
unset SESSION_MANAGER" >> "$INSTALLDIR/etc/profile"
fi
fi
}

_ADDpinghelp_() {
_CFLHDR_ usr/local/bin/pinghelp
printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "_PRTSYG_() { printf '%s\\n' \"Signal received:  Continuing...\" ; }" "ARGONE=\"\${1-www.github.com}\"" "ISCOMCAR=\"\$(command -v ping)\"" "printf '%s\\n' \"\$ISCOMCAR\"" "{ SHUFREST=\"\$(shuf -n 1 -i 2-8)\" && printf '\\n%s\\n' \"Running command '/system/bin/ping -c 2 -i \$SHUFREST \$ARGONE':\" && /system/bin/ping -c 2 -i \"\$SHUFREST\" \"\$ARGONE\" ; } || _PRTSYG_" "{ SHUFREST=\"\$(shuf -n 1 -i 2-8)\" && printf '\\n%s\\n' \"Running command '$PREFIX/bin/ping -c 2 -i \$SHUFREST \$ARGONE':\" && $PREFIX/bin/ping -c 2 -i \"\$SHUFREST\" \"\$ARGONE\" ; } || _PRTSYG_" "{ SHUFREST=\"\$(shuf -n 1 -i 2-8)\" && printf '\\n%s\\n' \"Running command '/bin/ping -c 2 -i \$SHUFREST \$ARGONE':\" && /bin/ping -c 2 -i \"\$SHUFREST\" \"\$ARGONE\" ; } || _PRTSYG_" "{ SHUFREST=\"\$(shuf -n 1 -i 2-8)\" && printf '\\n%s\\n' \"Running command '/usr/bin/ping -c 2 -i \$SHUFREST \$ARGONE':\" && /usr/bin/ping -c 2 -i \"\$SHUFREST\" \"\$ARGONE\" ; } || _PRTSYG_" "{ printf '\\n%s\\n' \"Running command 'curl -I \$ARGONE 80':\" && curl -I \"\$ARGONE\" ; } || _PRTSYG_" "{ printf '\\n%s\\n' \"Running command 'dig \$ARGONE':\" && { dig \"\$ARGONE\" || { pc dnsutils && dig \"\$ARGONE\" ; } ; } ; } || _PRTSYG_" "{ printf '\\n%s\\n' \"Running command 'telnet \$ARGONE 79':\" && telnet \"\$ARGONE\" 80 ; } || _PRTSYG_" >> usr/local/bin/pinghelp
printf "%s\\n%s\\n" "printf '\\n%s\\n' \"The Termux packages 'dnsutils', 'lynx' and 'strace' can be helpful in diagnosing network issues.  The 'telnet' command can assist as well.\"" "## ~/${INSTALLDIR##*/}/usr/local/bin/pinghelp FE" >> usr/local/bin/pinghelp
chmod 755 usr/local/bin/pinghelp
}

_ADDresolvconf_() {
[ ! -d run/systemd/resolve ] && mkdir -p run/systemd/resolve
cat > run/systemd/resolve/resolv.conf <<- EOM
nameserver 1.1.1.1
nameserver 1.0.0.1
EOM
_ADDTORESOLVE_() {
cat >> etc/resolv.conf <<- EOM
nameserver 1.1.1.1
nameserver 1.0.0.1
EOM
}
_CHECKRESOLVE_() {
[ ! -d etc ] && mkdir -p etc
if [ -f etc/resolv.conf ]
then
if ! grep -q 'nameserver 1.1.1.1' etc/resolv.conf
then
_ADDTORESOLVE_
fi
fi
}
_CHECKRESOLVE_
}

_ADDstriphtmlcodefromfile_() { _CFLHDR_ usr/local/bin/striphtmlcodefromfile "#strip html code from file" ; printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in $INSTALLDIR; the command '$STARTBIN command addauser username' can create user accounts in $INSTALLDIR from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "[ ! -x \"\$(command -v tree)\" ] && pci sed && sed || sed -n '/^$/!{s/<[^>]*>//g;p;}' \"\$@\"" "## ~/${INSTALLDIR##*/}/usr/local/bin/striphtmlcodefromfile FE" >> usr/local/bin/striphtmlcodefromfile ; chmod 755 usr/local/bin/striphtmlcodefromfile ; }

_ADDt_() {
_CFLHDR_ usr/local/bin/t
printf "%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" >> usr/local/bin/t
printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "if [ -x /usr/bin/tree ] || [ -x \"\${PREFIX:-}\"/bin/tree ]" "then" "tree \"\$@\"" "else" "{ pc tree || pci tree ; } && tree \"\$@\"" "fi" "## ~/${INSTALLDIR##*/}/usr/local/bin/t FE" >> usr/local/bin/t
chmod 755 usr/local/bin/t
}

_ADDtlmgrinstaller_() {
_CFLHDR_ usr/local/bin/tlmgrinstaller "# install TexLive installer"
printf "%s\\n" "[ -d /usr/local/texlive ] || mkdir -p /usr/local/texlive" >> usr/local/bin/tlmgrinstaller
printf "%s\\n" "_GETINSTALLER_() { { [ -d /usr/local/texlive/install-tl ] || mkdir -p /usr/local/texlive/install-tl ; } && { { [ -f /usr/local/texlive/install-tl/install-tl.zip ] && [ -f /usr/local/texlive/install-tl/install-tl.zip.sha512 ] || wget -c -P /usr/local/texlive/install-tl https://mirror.math.princeton.edu/pub/CTAN/systems/texlive/tlnet/install-tl.zip.sha512 https://mirror.math.princeton.edu/pub/CTAN/systems/texlive/tlnet/install-tl.zip ; } && cd /usr/local/texlive/install-tl && { sha512sum -c install-tl.zip.sha512 || { rm -f install-tl.zip* && printf '%s\\n' \"Files were corrupt and were deleted;  Please try again.  Exiting...  \" && exit 189 ; } ; } && unzip -n install-tl.zip ; } && { CDDIR=\"\$(find . -maxdepth 1 | tail -n 1)\" && { cd \"\$CDDIR\" || exit 169 ; } && printf '%s\\n' \"\$PWD\" && ls && printf '%s\\n' \"Please wait;  Command '\${0##*/}' continuing...\" && perl install-tl && printf '%s\\n' \"\$PWD\" | tee dir.pth > dir.tmp ; } ; }" >> usr/local/bin/tlmgrinstaller
printf "%s\\n" "_PRINTHELP_() { printf '\\n%s\\n' \"The command '${0##*/} re' adds TEX environment variables automatically to BASH init files in the Arch Linux in Termux PRoot environment.  Please exit this shell and login again.  If logging in again does not add TEX environment variables, then please run command '${0##*/} re' in order to add TEX environment variables to the BASH init files in Termux PRoot.  Command '${0##*/} h' has more information.  \" ; }" >> usr/local/bin/tlmgrinstaller
printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "printf '%s\\n' \"Command '\${0##*/}';  Begun...  \"" "{ command -v tlmgr && printf '%s\\n' \"The command 'tlmgr' is installed;  Continuing...  \" ; } || if [ -x /usr/bin/perl ] && [ -x /usr/bin/wget ] && [ -x /usr/bin/unzip ]" "then" "_GETINSTALLER_" "else" "{ { pc perl wget unzip || pci perl wget unzip ; } || { pkg i perl wget unzip || { pkg up && pkg i perl wget unzip ; } ; } ; } && _GETINSTALLER_" "fi" "_PRINTHELP_" >> usr/local/bin/tlmgrinstaller
printf "%s\\n" "INSDIR=\"\$(find /usr/local/texlive/install-tl/ -maxdepth 1 -type d | tail -n 1)\"" >> usr/local/bin/tlmgrinstaller
printf "%s\\n" "[ -d /usr/local/texlive/install-tl ] && { [ -f \"\$INSDIR\"/dir.pth ] && [ -f \"\$INSDIR\"/dir.tmp ] && rm -f \"\$INSDIR\"/dir.tmp || printf '\\n%s\\n' \"Running command '\$INSDIR/install-tl';  Continuing...  \" && \"\$INSDIR\"/install-tl && exit 0 ; }" >> usr/local/bin/tlmgrinstaller
printf "%s\\n" "## ~/${INSTALLDIR##*/}/usr/local/bin/tlmgrinstaller FE" >> usr/local/bin/tlmgrinstaller
chmod 755 usr/local/bin/tlmgrinstaller
}

_ADDtop_() {
_CFLHDR_ usr/local/bin/top
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" "{ [ -f /system/bin/top ] && /system/bin/top && exit ; } || { printf \"%s\\n\" \"The command '\${0##*/}' is currently disabled in Termux PRoot.   Please open an issue and PR should a better resolution for '\${0##*/}' in Termux PRoot be found.  Running command 'ps aux':\" && ps aux && printf \"%s\\n\" \"Running command 'nproc':\" && nproc && printf \"%s\\n\" \"Running command 'nproc --all':\" && nproc --all && ps aux | cut -d:  -f2- | grep -v TIME | grep -v '\-bash' | grep -v cut | grep -v ps\ aux | grep -v sort | cut -c 4- | sort && exit ; }" "## ~/${INSTALLDIR##*/}/usr/local/bin/top FE" >> usr/local/bin/top
chmod 755 usr/local/bin/top
}

_ADDtimings_() {
_CFLHDR_ usr/local/bin/timings "# Developed at [Terminal output speed issues](https://github.com/termux/termux-app/issues/603) Contributor evg-zhabotinsky"
cat >> usr/local/bin/timings <<- EOM
dd if=/dev/urandom bs=1K count=100 | hexdump -C >500KBfile.txt
for TIMING in 0 1 2 3; do
printf '%s\n' \$TIMING
sleep 1
time nice -n 20 cat 500KBfile.txt
sleep 2
done
rm -f 500KBfile.txt
## ~/${INSTALLDIR##*/}/usr/local/bin/timings FE
EOM
chmod 755 usr/local/bin/timings
}

_ADDthstartarch_() {
_CFLHDR_ usr/local/bin/th"$STARTBIN"
cat >> usr/local/bin/th"$STARTBIN" <<- EOM
_PRTERROR_() {
printf "\\e[1;31mERROR;\\e[1;37m%s\\e[0m\\n" " Please run '\${0##*/}' again."
}
printf "%s\\n" "$STARTBIN help"
$STARTBIN help
sleep 1
printf '%s command "pwd && whoami"\\n' "$STARTBIN"
$STARTBIN command "pwd && whoami" || _PRTERROR_
sleep 1
printf "%s\\n" "STARTBIN login user"
$STARTBIN login user || _PRTERROR_
printf '%s raw su user -c "pwd && whoami"\\n' "$STARTBIN"
$STARTBIN raw su user -c "pwd && whoami" || _PRTERROR_
sleep 1
printf '%s su user "pwd && whoami"\\n' "$STARTBIN"
$STARTBIN su user "pwd && whoami" || _PRTERROR_
printf "%s\\n" "th$STARTBIN done"
## ~/${INSTALLDIR##*/}/usr/local/bin/th$STARTBIN FE
EOM
chmod 755 usr/local/bin/th"$STARTBIN"
}

_ADDtools_() {	# developing implementaion; working system tools that work can be added to array PRFXTOLS
if [[ -z "${EDO01LCR:-}" ]]
then
if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = i386 ]]
then	# set customized commands for Arch Linux 32 architecture
PRFXTOLS="awk top"
else
PRFXTOLS="top"
fi
elif [[ $EDO01LCR = 0 ]]
then
PRFXTOLS="am awk dpkg getprop grep gzip ping ps sed top which $(compgen -c|grep termux- || find "$PREFIX/bin" -type f -executable -name termux-)"
fi
_CPSTOOL_() {	# copy Termux tool to PRoot installation
cp "$WHICHSTOOL" "$INSTALLDIR/usr/local/bin/$STOOL" && printf "%s\\n" "cp $WHICHSTOOL $INSTALLDIR/usr/local/bin/$STOOL: continuing..."
}
for STOOL in ${PRFXTOLS[@]}
do
WHICHSTOOL="$(command -v "$STOOL" || printf "1")"
if [ ! -f "$INSTALLDIR/usr/local/bin/$STOOL" ]
then
_CPSTOOL_
else
if [ "$WHICHSTOOL" != 1 ]
then
if ! diff "$WHICHSTOOL" "$INSTALLDIR/usr/local/bin/$STOOL"
then
_CPSTOOL_
fi
else
printf "System tool \\e[1m'%s'\\e[0m cannot be found: continuing...\\e[1\\n" "$STOOL"
fi
fi
done
if [ ! -e root/storage ] && [ -e "$HOME/storage" ]
then
ln -s "$HOME/storage" root/storage
fi
if [ ! -e root/txhome ]
then
ln -s "$HOME" root/txhome
fi
}

_ADDtour_() {
_CFLHDR_ usr/local/bin/tour "# A short tour that shows a few of the new featires of this system."
cat >> usr/local/bin/tour <<- EOM
printf "\\\\e[1;32m==> \\\\e[1;37mPlease hide the virtual keyboard.  Beginning a short tour that shows a few of the new featires of this system.  Running \\\\e[1;32mexport\\\\e[1;37m...\\\\n\\\\n"
sleep 1
export
sleep 2
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mls -alRr --color=always %s\\\\e[1;37m...\\\\n\\\\n" "\$HOME"
sleep 1
ls -alRr --color=always "\$HOME"
sleep 4
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mcat %s/.bash_profile\\\\e[1;37m...\\\\n\\\\n" "\$HOME"
sleep 1
cat "\$HOME"/.bash_profile
sleep 4
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mcat %s/.bashrc\\\\e[1;37m...\\\\n\\\\n" "\$HOME"
sleep 1
cat "\$HOME"/.bashrc
sleep 4
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mcat /usr/local/bin/pci\\\\e[1;37m...\\\\n\\\\n"
sleep 1
cat /usr/local/bin/pci
sleep 4
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mcat /usr/local/bin/README.md\\\\e[1;37m...\\\\n\\\\n"
sleep 1
cat /usr/local/bin/README.md
printf "\\\\e[1;32m\\\\n%s \\\\e[38;5;121m%s \\\\n\\\\n\\\\e[4;38;5;129m%s\\\\e[0m\\\\n\\\\n\\\\e[1;34m%s \\\\e[38;5;135m%s\\\\e[0m\\\\n\\\\n" "==>" "Short tour is complete; Scroll up if you wish to study the output.  Run this script again at a later time, and it might be surprising at how this environment changes over time. " "If you are new to *nix, http://tldp.org has documentation." "IRC: " "https://$MOTTECIRC"
## ~/${INSTALLDIR##*/}/usr/local/bin/timings FE
EOM
chmod 755 usr/local/bin/tour
}

_ADDtrim_() {
_CFLHDR_ usr/local/bin/trim
cat >> usr/local/bin/trim <<- EOM
printf "\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32m%s\\\\e[1;37m...\\\\n" "\${0##*/}"
_PMFSESTRING_() {
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\n\\\\n" "Signal generated in '\$1'; Cannot complete task; " "Continuing..."
printf "\\\\e[1;34m%s\\\\e[0;34m%s\\\\e[1;34m%s\\\\e[0;34m%s\\\\e[1;34m%s\\\\e[0m\\\\n\\\\n" "  If you find improvements for " "${0##*/}" " and " "\$0" " please open an issue and accompanying pull request."
}
[ "\$UID" -eq 0 ] && SUTRIM="" || SUTRIM="sudo"
printf "%s\\\\n" "[1/4] rm -rf /usr/lib/firmware"
rm -rf /usr/lib/firmware
printf "%s\\\\n" "[2/4] rm -rf /usr/lib/modules"
rm -rf /usr/lib/modules
if [ -z "\$SUTRIM" ]
then
printf "%s\\\\n" "[3/4] pacman -Scc --noconfirm --color=always"
pacman -Scc --noconfirm --color=always || _PMFSESTRING_ "\${0##*/} \$SUTRIM pacman -Scc"
else
printf "%s\\\\n" "[3/4] \$SUTRIM pacman -Scc --noconfirm --color=always"
"\$SUTRIM" pacman -Scc --noconfirm --color=always || _PMFSESTRING_ "\${0##*/} \$SUTRIM pacman -Scc"
fi
printf "%s\\\\n" "[4/4] rm -f /var/cache/pacman/pkg/*pkg*"
rm -f /var/cache/pacman/pkg/*pkg* || _PMFSESTRING_ "rm -f \${0##*/}"
## ~/${INSTALLDIR##*/}/usr/local/bin/trim FE
EOM
chmod 755 usr/local/bin/trim
}

_ADDv_() {
_CFLHDR_ usr/local/bin/v
cat >> usr/local/bin/v <<- EOM
if [[ -z "\${1:-}" ]]
then
ARGS=(".")
else
ARGS=("\$@")
fi
EOM
printf "%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" \"Exiting...\" && exit" >> usr/local/bin/v
printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "if [ -x /usr/bin/vim ] || [ -x \"\${PREFIX:-}\"/bin/vim ]" "then" "vim \"\${ARGS[@]}\"" "else" "{ pc vim || pci vim ; } && vim \"\${ARGS[@]}\"" "fi" "## ~/${INSTALLDIR##*/}/usr/local/bin/v FE" >> usr/local/bin/v
chmod 755 usr/local/bin/v
}

_ADDwe_() {
_CFLHDR_ usr/bin/we "# Watch available entropy on device." "# cat /proc/sys/kernel/random/entropy_avail Contributor https://github.com/cb125"
cat >> usr/bin/we <<- EOM
declare -a ARGS

_TRPWE_() {
printf "\\\\e[?25h\\\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\${ARGS[@]}"
}

_PRINTTAIL_() {
printf "\\\\n\\\\e[0m%s \\\\e[0;32m%s %s %s\\\\e[1;34m: \\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\e[0m" "TermuxArch" "\${0##*/}" "\$ARGS"  "version \$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s:DONE 📱 \007' "\${0##*/}"
}

trap _TRPET_ EXIT
## we begin ####################################################################

if [[ -z "\${1:-}" ]]
then
ARGS=""
else
ARGS="\$@"
fi

i=1
multi=16
entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null)

printintro() {
printf '\033]2; TermuxArch Watch Entropy '%s' 📲  \007' "\${0##*/} \$@"
printf "\\\\n\\\\e[1;32mTermuxArch Watch Entropy '%s':\\\\n" "\${0##*/} \$@"
}

_PRINTTAIL_() {
printf "\\\\n\\\\n\\\\e[1;32mTermuxArch Watch Entropy 🏁 \\\\n\\\\n"'\033]2; TermuxArch Watch Entropy 🏁 \007'
}

_PRINTUSAGE_() {
printf "\\\\n\\\\e[0;32mUsage:  \\\\e[1;32mwe \\\\e[0;32m Watch Entropy sequential.\\\\n\\\\n	\\\\e[1;32mwe sequential\\\\e[0;32m Watch Entropy sequential.\\\\n\\\\n	\\\\e[1;32mwe simple\\\\e[0;32m Watch Entropy simple.\\\\n\\\\n	\\\\e[1;32mwe verbose\\\\e[0;32m Watch Entropy verbose.\\\\n\\\\n"'\033]2; TermuxArch Watch Entropy 📲  \007'
}

infif() {
if [[ \$entropy0 = "inf" ]] || [[ \$entropy0 = "" ]] || [[ \$entropy0 = 0 ]]
then
entropy0=1000
printf "\\\\e[1;32m∞^∞infifinfif2minfifinfifinfifinfif∞=1\\\\e[0;32minfifinfifinfifinfif\\\\e[0;32m∞==0infifinfifinfifinfif\\\\e[0;32minfifinfifinfif∞"
fi
}

en0=\$((\${entropy0}*\$multi))

esleep() {
int=\$(printf "%s\\\\n" "\$i/\$entropy0" | bc -l)
for i in {1..5}; do
if (( \$(printf "%s\\\\n" "\$int > 0.1"|bc -l) ))
then
tmp=\$(printf "%s\\\\n" "\${int}/100" | bc -l)
int=\$tmp
fi
if (( \$(printf "%s\\\\n" "\$int > 0.1"|bc -l) ))
then
break
fi
done
}

1sleep() {
sleep 0.1
}

bcif() {
commandif=\$(command -v getprop) ||:
if [[ \$commandif = "" ]]
then
abcif=\$(command -v bc) ||:
if [[ \$abcif = "" ]]
then
printf "\\\\e[1;34mInstalling \\\\e[0;32mbc\\\\e[1;34m...\\\\n\\\\n\\\\e[1;32m"
{ pc bc || pci bc ; }
printf "\\\\n\\\\e[1;34mInstalling \\\\e[0;32mbc\\\\e[1;34m: \\\\e[1;32mDONE 🏁\\\\n\\\\e[0m"
fi
else
tbcif=\$(command -v bc) ||:
if [[ \$tbcif = "" ]]
then
printf "\\\\e[1;34mInstalling \\\\e[0;32mbc\\\\e[1;34m...\\\\n\\\\n\\\\e[1;32m"
apt install bc --yes
printf "\\\\n\\\\e[1;34mInstalling \\\\e[0;32mbc\\\\e[1;34m: \\\\e[1;32mDONE 🏁\\\\n\\\\e[0m"
fi
fi
}

entropysequential() {
printf '\033]2; TermuxArch Watch Entropy Sequential '%s' 📲  \007' "\${0##*/} \$@"
printf "\\\\n\\\\e[1;32mTermuxArch Watch Entropy Sequential '%s':\\\\n" "\${0##*/} \$@"
for i in \$(seq 1 \$en0); do
entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null)
infif
printf "\\\\e[1;30m \$en0 \\\\e[0;32m\$i \\\\e[1;32m\${entropy0}\\\\n"
1sleep
done
}

entropysimple() {
printf '\033]2; TermuxArch Watch Entropy Simple '%s' 📲  \007' "\${0##*/} \$@"
printf "\\\\n\\\\e[1;32mTermuxArch Watch Entropy Simple '%s':\\\\n" "\${0##*/} \$@"
for i in \$(seq 1 \$en0); do
entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null)
infif
printf "\\\\e[1;32m\${entropy0} "
1sleep
done
}

entropyverbose() {
printf '\033]2; TermuxArch Watch Entropy Verbose '%s' 📲  \007' "\${0##*/} \$@"
printf "\\\\n\\\\e[1;32mTermuxArch Watch Entropy Verbose '%s':\\\\n" "\${0##*/} \$@"
for i in \$(seq 1 \$en0); do
entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null)
infif
printf "\\\\e[1;30m \$en0 \\\\e[0;32m\$i \\\\e[1;32m\${entropy0} \\\\e[0;32m#E&&√♪"
esleep
sleep \$int
entropy1=\$(cat /proc/sys/kernel/random/uuid 2>/dev/null)
infif
printf "\$entropy1"
esleep
sleep \$int
printf "&&π™♪&##|♪FLT"
esleep
sleep \$int
printf "\$int♪||e"
esleep
sleep \$int
done
}

# [we sequential] Run sequential watch entropy.
if [[ -z "\${1:-}" ]]
then
printintro
entropysequential
elif [[ \$1 = [Ss][Ee]* ]] || [[ \$1 = -[Ss][Ee]* ]] || [[ \$1 = --[Ss][Ee]* ]]
then
printintro
entropysequential
# [we simple] Run simple watch entropy.
elif [[ \$1 = [Ss]* ]] || [[ \$1 = -[Ss]* ]] || [[ \$1 = --[Ss]* ]]
then
printintro
entropysimple
# [we verbose] Run verbose watch entropy.
elif [[ \$1 = [Vv]* ]] || [[ \$1 = -[Vv]* ]] || [[ \$1 = --[Vv]* ]]
then
printintro
bcif
entropyverbose
# [] Run default watch entropy.
elif [[ \$1 = "" ]]
then
printintro
entropysequential
else
_PRINTUSAGE_
fi
_PRINTTAIL_
## ~/${INSTALLDIR##*/}/usr/local/bin/we FE
EOM
chmod 755 usr/bin/we
}

_ADDyt_() {
_CFLHDR_ usr/local/bin/yt
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user :\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/} : the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux : a default user account is created during setup : the default username 'user' can be used to access the PRoot system employing a user account : command '$STARTBIN help' has more information :  \" \"Exiting...\" && exit" "youtube-dl \"\${ARGS[@]}\" 2>/dev/null || { { pc youtube || pci youtube-dl ; } && youtube-dl \"\${ARGS[@]}\" ; }" "## ~/${INSTALLDIR##*/}/usr/local/bin/yt FE" >> usr/local/bin/yt
chmod 755 usr/local/bin/yt
}

_DOMODdotfiles_() {
# Are you familiar with metacarpals syndrome?  Metacarpals can flare from vibrations.  To disable the silent bell feature replace the contents of this function with a colon (:) as in this example:
# 	_DOMODexample_() {
# 		:
# 	}
_MODdotfile_() {
_MODdotfNF_() {
printf "\\e[0;33mline %s can not be found in %s file \\e[0;34m: adding line %s to %s file \\e[0m\\n" "'$MODFILEADD'" "/${INSTALLDIR##*/}/root/$MODFILENAME" "'$MODFILEADD'" "/${INSTALLDIR##*/}/root/$MODFILENAME"
printf "%s\\n" "$MODFILEADD" >> "$INSTALLDIR/root/$MODFILENAME"
}
# add MODFILEADD to file /root/MODFILENAME
{ [[ -f "$INSTALLDIR/root/$MODFILENAME" ]] && { _DOTHRF_ "root/$MODFILENAME" && ! grep -q "$MODFILEADD" "$INSTALLDIR/root/$MODFILENAME" && _MODdotfNF_ || printf "\\e[0;34mline %s found in %s file\\e[0m\\n" "'$MODFILEADD'" "/${INSTALLDIR##*/}/root/$MODFILENAME" ; } ; } || _MODdotfNF_
}
# add (setq visible-bell 1) to file /root/.emacs
MODFILENAME=".emacs"
MODFILEADD='(setq visible-bell 1)'
_MODdotfile_
# add set belloff=all to file /root/.vimrc
MODFILENAME=".vimrc"
MODFILEADD='set belloff=all'
_MODdotfile_
}

_PREPMOTS_() {
if [[ "$CPUABI" = "$CPUABIX8664" ]]
then
MOTTECBBS="BBS: bbs.archlinux.org"
MOTTECGIT="github.com/archlinux"
MOTTECIRC="wiki.archlinux.org/index.php/IRC_channel"
elif [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = i386 ]]
then
MOTTECBBS="BBS:	bbs.archlinux32.org"
MOTTECGIT="github.com/archlinux32"
MOTTECIRC="wiki.archlinux32.org"
else
MOTTECBBS=""
MOTTECGIT="github.com/archlinuxarm"
MOTTECIRC="archlinuxarm.org/about/contact"
fi
}

_PREPPACMANCONF_() {
{ [ -f "$INSTALLDIR"/etc/pacman.conf ] && { sed -i 's/^CheckSpace/\#CheckSpace/g' "$INSTALLDIR/etc/pacman.conf" && sed -i 's/^#Color/Color/g' "$INSTALLDIR/etc/pacman.conf" ; } ; } || _PSGI1ESTRING_ "Cannot find file $INSTALLDIR/etc/pacman.conf; _PREPPACMANCONF_ archlinuxconfig.bash ${0##*/}"
[ -f /usr/share/libalpm/scripts/systemd-hook ] && { sed -i 's/\-\-chroot/\-c/g' /usr/share/libalpm/scripts/systemd-hook ; }
}
# archlinuxconfig.bash FE
