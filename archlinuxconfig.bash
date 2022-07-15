#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
_DPTCHHLP_() { printf "%s\\n%s\\n" "[ -e $INSTALLDIR$TMXRCHBNDR/am ] || cp -f $PREFIX/bin/am $INSTALLDIR$TMXRCHBNDR/am" "[ -e $INSTALLDIR$TMXRCHBNDR/patch ] || cp -f $PREFIX/bin/patch $INSTALLDIR$TMXRCHBNDR/patch" >> "$1" ;  }
_PRTPATCHHELP_() { printf "%s\\n" "[ -e $TMXRCHBNDR/patch ] || printf \"\\e[1;30m%s\\e[0;40m%s\\e[1;30m%s\\e[0;40m%s\\e[1;30m%s\\e[0;40m%s\\e[1;30m%s\\e[0;40m%s\\e[1;30m%s\\e[0m\\n\" \"This command \" \"'ln -s $PREFIX/bin/patch $INSTALLDIR$TMXRCHBNDR/patch'\" \" should resolve a \" \"'patch: setting attribute security.selinux for security.selinux: Permission denied'\" \" error.  This workaround seems to work equally well in Termux PRoot with QEMU architecture emulation as well.  Issues \" \"“Building xrdp from AUR fails mentioning selinux #293”\" \" at https://github.com/SDRausty/TermuxArch/issues/293 and \" \"“patch: setting attribute security.selinux for security.selinux: Permission denied #182”\" \" at https://github.com/termux/proot/issues/182 have more information about this error.\"" >> "$1" ; }
_PRTRTHLP_() {
printf "%s\\n" "if [ \"\$EUID\" = 0 ] || [ \"\$UID\" = 0 ]
then
printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...  \\e[0m\" \"ＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} SIGNAL:\" \"  Command '\$SRPTNM' should not be used by the root user account.  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot QEMU and configures these user accounts for the Arch Linux 'sudo' command.  The 'addauser' command can be run by the Arch Linux in Termux PRoot root and user accounts.  This command can be run '$STARTBIN command 'addauser user'' directly from Termux to create this account in Arch Linux Termux PRoot QEMU.  The command '$STARTBIN help' has more information about how to use '$STARTBIN'.  \"
exit 101
fi" >> "$1"
}

_ADDREADME_() {
_CFLHDR_ "$TMXRCHBNDS"/README.md
printf "%s\\n" "The $TMXRCHBNDR directory contains TermuxArch shortcut commands that automate and make using the command line easier.  Some of these commands are listed here:

* Command 'addauser' creates Arch Linux user accounts in Termux PRoot QEMU and configures them for use with the Arch Linux 'sudo' command,
* Command 'cams' records from device cameras,
* Command 'csystemctl' replaces systemctl with https://github.com/TermuxArch/docker-systemctl-replacement,
* Command 'em' is a 'uemacs' editor shortcut command that builds and installs and then runs the uemacs editor.
* Command 'keys' installs Arch Linux keys,
* Command 'gcl https://github.com/indigo-dc/udocker'  will clone 'udocker', a basic user tool to execute simple docker containers in user space without requiring root privileges,
* Command 'makeaurhelpers' attempts to build and install AUR helper package installer commands,
* Command 'patchmakepkg' patches the Arch Linux 'makepkg' command for use in Termux PRoot QEMU,
* Command 'pc' is a pacman shortcut command; 'cw pc' in order to learn more,
* Command 'pci' is a pacman shortcut command; 'cw pci' in order to learn more,
* Command 'tour' runs a short tour of the TermuxArch Linux system,
* Command 'trim' moves the downloaded packages from the Arch Linux system directories into a cache directory,
* Command 'yt' is a youtube shortcut command that installs and runs the command 'youtube-dl',
* Command 'v' is a 'vim' editor shortcut command that installs and runs the vim editor.

This command 'ls $TMXRCHBNDR && cat ~/.bashrc' issued in a Termux PRoot QEMU environment will show installed TermuxArch commands.  This README.md file can be expanded so a beginning user can get to know the *nix experience easier.  Would you like to create an issue along with a pull request to add information to this file so that a beginning user can get to know the Arch Linux in Termux PRoot experience much easier?  If you would like to expand this README.md file to encapsulate and enhance the newbie *nix experience, then please visit these links:

* Comments are welcome at https://github.com/TermuxArch/TermuxArch/issues ✍
* Pull requests are welcome at https://github.com/TermuxArch/TermuxArch/pulls ✍
<!-- $INSTALLDIR$TMXRCHBNDR/README.md FE -->" > "$TMXRCHBNDS"/README.md
}

_ADDae_() {
_CFLHDR_ "$TMXRCHBNDS"/ae "# Developed at [pacman-key --populate archlinux hangs](https://github.com/SDRausty/TermuxArch/issues/33) Contributor cb125"
printf "%s\\n" "watch cat /proc/sys/kernel/random/entropy_avail
## $INSTALLDIR$TMXRCHBNDR/ae FE" >> "$TMXRCHBNDS"/ae
chmod 755 "$TMXRCHBNDS"/ae
}

_ADDbash_logout_() {
printf "%s\\n" "[ ! -f \"\$HOME\"/.hushlogout ] && [ ! -f \"\$HOME\"/.chushlogout ] && . /etc/moto
h
## .bash_logout FE" > root/.bash_logout
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
printf "%s\\n" "PATH=\"\$HOME/bin:$TMXRCHBNDR:$TEXLIVEPATH:\$PPATH\"" >> root/.bash_profile
else
printf "%s\\n" "PATH=\"\$HOME/bin:$TMXRCHBNDR:\$PPATH\"" >> root/.bash_profile
fi
printf "%s\\n" "[ -f \"\$HOME\"/.bashrc ] && . \"\$HOME\"/.bashrc" >> root/.bash_profile
printf "%s\\n" "[ -f \"\$HOME\"/.profile ] && . \"\$HOME\"/.profile" >> root/.bash_profile
printf "%s\\n" "if [ ! -e \"\$HOME\"/.hushlogin ] && [ ! -e \"\$HOME\"/.chushlogin ]
then
[ -e /etc/mota ] && . /etc/mota
fi
if [ -e \"\$HOME\"/.chushlogin ]
then
rm -f \"\$HOME\"/.chushlogin
fi
PS1=\"\\[\\e[38;5;148m\\]\\u\\[\\e[1;0m\\]\\A\\[\\e[1;38;5;112m\\]\\W\\[\\e[0m\\]$ \"" >> root/.bash_profile
[[ ! -f "$HOME"/.bash_profile ]] || grep proxy "$HOME"/.bash_profile | grep -s "export" >> root/.bash_profile ||:
[[ ! -f "$HOME"/.bash_profile ]] || grep EDITOR "$HOME"/.bash_profile | grep -s "export" >> root/.bash_profile ||:
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
printf "%s\\n" "export TZ=\"$(getprop persist.sys.timezone)\"
## .bash_profile FE" >> root/.bash_profile
}

_ADDbashrc_() {
[ -e root/.bashrc ] && _DOTHRF_ "root/.bashrc"
cat > root/.bashrc <<- EOM
function _AM_() {
command -v am 1>/dev/null || cp "$PREFIX"/bin/am "$TMXRCHBNDR"
}
function _PWD_() {
printf '%s\n' "\$PWD"
}
function git-branch() {
if [ -d .git ]
then
printf "%s" "(\$(git branch | awk '/\*/{print \$2}'))";
fi
}
function em() {
[ -x /usr/bin/make ] || { pc base base-devel || pci base base-devel ; }
{ [ -x $TMXRCHBNDR/uemacs ] && $TMXRCHBNDR/uemacs "\$@" ; } || { { { cd || exit 69 ; } && [ -d uemacs ] || gcl https://github.com/torvalds/uemacs ; } && { [ -d uemacs ] && { cd uemacs || exit 69 ; } ; } && printf '%s\\n' "making uemacs" && make && cp -f em $TMXRCHBNDR/uemacs && make clean && $TMXRCHBNDR/uemacs emacs.hlp ; }
}
alias ..='cd ../.. && _PWD_'
alias ...='cd ../../.. && _PWD_'
alias ....='cd ../../../.. && _PWD_'
alias .....='cd ../../../../.. && _PWD_'
alias aiabrowser='_AM_ && am start -a android.intent.action.VIEW -d "content://com.android.externalstorage.documents/root/primary"'	## Reference [Android 11 (with Termux storage permission denied) question; What's the source for the shortcut to the file manager of the settings app?](https://www.reddit.com/r/termux/comments/msq7lm/android_11_with_termux_storage_permission_denied/) Contributors u/DutchOfBurdock u/xeffyr
alias aiachrome='_AM_ && am start --user 0 -n com.android.chrome/com.google.android.apps.chrome.Main'	## Reference [Can I start an app from Termux's command line? How?](https://www.reddit.com/r/termux/comments/62zi71/can_i_start_an_app_from_termuxs_command_line_how/) Contributors u/u/fornwall u/Kramshet
alias aiadial='_AM_ && am start -a android.intent.action.DIAL'
alias aiafilemanager='_AM_ && am start -a android.intent.action.VIEW -d "content://com.android.externalstorage.documents/root/primary"'
alias aiasearch='_AM_ && am start -a android.intent.action.SEARCH'
alias aiaview='_AM_ && am start -a android.intent.action.VIEW'
alias aiaviewd='_AM_ && am start -a android.intent.action.VIEW -d '
alias aiawebsearch='_AM_ && am start -a android.intent.action.WEB_SEARCH'
alias C='cd .. && _PWD_'
alias c='cd .. && _PWD_'
alias CN='cat -n \$(command -v' # use a close parenthesis ) to complete this alias
alias Cn='cat -n \$(command -v' # use a close parenthesis ) to complete this alias
alias cn='cat -n \$(command -v' # use a close parenthesis ) to complete this alias
alias CW='cat \$(command -v' # use a close parenthesis ) to complete this alias
alias Cw='cat \$(command -v' # use a close parenthesis ) to complete this alias
alias cw='cat \$(command -v' # use a close parenthesis ) to complete this alias
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
alias E='exit'
alias e='exit'
alias F='nice -n 20 grep -n --color=always'
alias f='nice -n 20 grep -n --color=always'
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
alias HW='head \$(command -v' # use a close parenthesis ) to complete this alias
alias Hw='head \$(command -v' # use a close parenthesis ) to complete this alias
alias hw='head \$(command -v' # use a close parenthesis ) to complete this alias
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
alias Ls='ls --color=always'
alias ls='ls --color=always'
alias LR='ls -alR --color=always'
alias Lr='ls -alR --color=always'
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
alias PCS='pacman -S'
alias Pcs='pacman -S'
alias pcs='pacman -S'
alias PCSS='pacman -Ss'
alias Pcss='pacman -Ss'
alias pcss='pacman -Ss'
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
alias TW='tail \$(command -v' # use a close parenthesis ) to complete this alias
alias Tw='tail \$(command -v' # use a close parenthesis ) to complete this alias
alias tw='tail \$(command -v' # use a close parenthesis ) to complete this alias
alias V='v'
alias v='v'
alias UM='uname -m'
alias Um='uname -m'
alias um='uname -m'
EOM
[ ! -f "$HOME"/.bashrc ] ||grep -s EDITOR "$HOME"/.bashrc | grep -s "export" >>  root/.bashrc ||:
[ ! -f "$HOME"/.bashrc ] || grep -s proxy "$HOME"/.bashrc | grep -s "export" >>  root/.bashrc ||:
printf "%s\\n" "## .bashrc FE" >> root/.bashrc
}

_ADDcams_() {
_CFLHDR_ "$TMXRCHBNDS"/cams "### Example usage: 'cams 0 255 16 2048 r 90 2'
### Loop example: 'while true ; do cams ; done'
### Semantics: [camid [totalframes+1 [framespersecond [threshold [r[otate] [degrees [exitwait]]]]]]]
### Please run 'au ffmpeg imagemagick termux-api' before running this script.  Also ensure that Termux-api is installed, which is available at this https://github.com/termux/termux-api/actions/workflows/debug_build.yml webpage.
### VLC media player APK can be downloaded from these https://www.videolan.org/vlc/download-android.html and https://get.videolan.org/vlc-android/3.3.4/ webpages.
### More options in addition to image checking and rotation can be added by editing this file at the magick rotation command;  The command line options for magick are listed at this https://imagemagick.org/script/command-line-options.php webpage.
### Seven arguments are listed below, including their default values;  If run with no arguments, the default values will be used:"
cat >> "$TMXRCHBNDS"/cams <<- EOM
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
printf '\e[0;36m%s' "IM cd output/\$CAMD/\$CAMD\$TIMESTAMP: " && { cd output/"\$CAMD/\$CAMD\$TIMESTAMP" || exit 69 ; } && printf '\e[0;32m%s\n' "DONE"
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
## $INSTALLDIR$TMXRCHBNDR/cams FE
EOM
chmod 755 "$TMXRCHBNDS"/cams
}

_ADDcdtd_() {
_CFLHD_ "$TMXRCHBNDS"/cdtd "# Usage: \`. cdtd\` the dot sources \`cdtd\` which makes this shortcut script work."
printf "%s\\n" "#!/usr/bin/env bash
cd $HOME/storage/downloads && pwd
## $INSTALLDIR$TMXRCHBNDR/cdtd FE" >> "$TMXRCHBNDS"/cdtd
chmod 755 "$TMXRCHBNDS"/cdtd
}

_ADDcdth_() {
_CFLHD_ "$TMXRCHBNDS"/cdth "# Usage: \`. cdth\` the dot sources \`cdth\` which makes this shortcut script work."
printf "%s\\n" "#!/usr/bin/env bash
cd $HOME && pwd
## $INSTALLDIR$TMXRCHBNDR/cdth FE" > "$TMXRCHBNDS"/cdth
chmod 755 "$TMXRCHBNDS"/cdth
}

_ADDcdtmp_() {
_CFLHD_ "$TMXRCHBNDS"/cdtmp "# Usage: \`. cdtmp\` the dot sources \`cdtmp\` which makes this shortcut script work."
printf "%s\\n" "#!/usr/bin/env bash
cd $TMPDIR && pwd || exit 69
## $INSTALLDIR$TMXRCHBNDR/cdtmp FE" > "$TMXRCHBNDS"/cdtmp
chmod 755 "$TMXRCHBNDS"/cdtmp
}

_ADDch_() {
_CFLHDR_ "$TMXRCHBNDS"/ch "# This script creates and deletes the .hushlogin and .hushlogout files."
cat >> "$TMXRCHBNDS"/ch <<- EOM
declare -a ARGS

_TRPET_() {
printf "\\e[?25h\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\${ARGS[@]}"
}

_PRINTTAIL_() {
printf "\\e[0m%s \\e[1;32m%s \\e[0;32m%s\\e[1;34m: \\e[1;32m%s\\e[0m 🏁  \\n\\e[0m" "TermuxArch command" "\$STRNRG"  "version \$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s:DONE 📱 \007' "\$STRNRG"
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
printf "%s\\n" "Hushed login and logout: OFF"
elif [[ -f "\$HOME"/.hushlogin ]] || [[ -f "\$HOME"/.hushlogout ]]
then
touch "\$HOME"/.hushlogin "\$HOME"/.hushlogout
printf "%s\\n" "Hushed login and logout: ON"
else
touch "\$HOME"/.hushlogin "\$HOME"/.hushlogout
printf "%s\\n" "Hushed login and logout: ON"
fi
## $INSTALLDIR$TMXRCHBNDR/ch FE
EOM
chmod 755 "$TMXRCHBNDS"/ch
}

_ADDchperms.cache+gnupg_() {
_CFLHDR_ "$TMXRCHBNDS"/chperms.cache+gnupg
cat >> "$TMXRCHBNDS"/chperms.cache+gnupg <<- EOM
set -x
[[ -d "\$HOME"/.cache ]] && find "\$HOME"/.cache -type d -exec chmod 777 {} \; && find "\$HOME"/.cache -type f -exec chmod 666 {} \;
[[ -d "\$HOME/".gnupg ]] && find "\$HOME/".gnupg -type d -exec chmod 777 {} \; && find "\$HOME/".gnupg -type f -exec chmod 666 {} \;
set +x
## $INSTALLDIR$TMXRCHBNDR/chperms.cache+gnupg FE
EOM
chmod 755 "$TMXRCHBNDS"/chperms.cache+gnupg
}

_ADDcsystemctl_() {
_CFLHDR_ "$TMXRCHBNDS"/csystemctl "# Contributor https://github.com/petkar"
cat >> "$TMXRCHBNDS"/csystemctl <<- EOM
INSTALLDIR="$INSTALLDIR"
printf "\\e[38;5;148m%s\\e[0m\\n" "Installing /usr/bin/systemctl replacement: "
[ -f "/run/lock/${INSTALLDIR##*/}/csystemctl.lock" ] && printf "%s\\n" "Already installed $TMXRCHBNDR/systemctl replacement: DONE 🏁" && exit
declare COMMANDP
COMMANDP="\$(command -v python3)" || printf "%s\\n" "Command python3 can not be found: continuing..."
[[ "\${COMMANDP:-}" == *python3* ]] || { pc python3 || pci python3 ; }
SDATE="\$(date +%s)"
# path is $TMXRCHBNDR because updates overwrite /usr/bin/systemctl and may make systemctl-replacement obsolete
# backup original binary
mv -f /usr/bin/systemctl $INSTALLDIR/var/backups/${INSTALLDIR##*/}/systemctl.\$SDATE.bkp
printf "\\e[38;5;148m%s\\n\\e[0m" "Moved /usr/bin/systemctl to $INSTALLDIR/var/backups/${INSTALLDIR##*/}/systemctl.\$SDATE.bkp"
printf "%s\\n" "Getting replacement systemctl from https://raw.githubusercontent.com/TermuxArch/docker-systemctl-replacement/master/files/docker/systemctl3.py"
# Arch Linux package 'systemctl' updates will mot halt functioning as $TMXRCHBNDR precedes /usr/bin in the PATH
# download and copy to both directories $TMXRCHBNDR and /usr/bin
curl --fail --retry 2 https://raw.githubusercontent.com/TermuxArch/docker-systemctl-replacement/master/files/docker/systemctl3.py | tee /usr/bin/systemctl $TMXRCHBNDR/systemctl >/dev/null
chmod 755 /usr/bin/systemctl $TMXRCHBNDR/systemctl
:>"/run/lock/${INSTALLDIR##*/}/csystemctl.lock"
printf "\\e[38;5;148m%s\\e[1;32m%s\\e[0m\\n" "Installing systemctl replacement in $TMXRCHBNDR and /usr/bin: " "DONE 🏁"
## $INSTALLDIR$TMXRCHBNDR/csystemctl FE
EOM
chmod 755 "$TMXRCHBNDS"/csystemctl
}

_ADDcolorizebashrc_() {
_CFLHDR_ "$TMXRCHBNDS"/colorizebashrc "# Change always to never and vica versa in file '.bashrc'."
cat >> "$TMXRCHBNDS"/colorizebashrc <<- EOM
grep always "\$HOME"/.bashrc 1>/dev/null && sed -i 's/always/never/g' "\$HOME"/.bashrc || sed -i 's/never/always/g' "\$HOME"/.bashrc
grep always "\$HOME"/.bashrc || grep never "\$HOME"/.bashrc
## $INSTALLDIR$TMXRCHBNDR/colorizebashrc FE
EOM
chmod 755 "$TMXRCHBNDS"/colorizebashrc
}

_ADDes_() {
_CFLHDR_ "$TMXRCHBNDS"/es
cat >> "$TMXRCHBNDS"/es <<- EOM
if [[ -z "\${1:-}" ]]
then
ARGS=(".")
else
ARGS=("\$@")
fi
EOM
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in $INSTALLDIR; the command '$STARTBIN command addauser username' can create user accounts in $INSTALLDIR from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" && exit" "[ ! -x \"\$(command -v emacs)\" ] && { pc emacs || pci emacs ; } && emacs \"\${ARGS[@]}\" || emacs \"\${ARGS[@]}\"" "## $INSTALLDIR$TMXRCHBNDR/es FE" >> "$TMXRCHBNDS"/es
chmod 755 "$TMXRCHBNDS"/es
}

_ADDexd_() {
_CFLHDR_ "$TMXRCHBNDS"/exd "# Usage: \`. exd\` the dot sources \`exd\` which makes this shortcut script work. Reference https://github.com/SDRausty/TermuxArch/issues/59#issuecomment-381285151_"
cat >> "$TMXRCHBNDS"/exd <<- EOM
export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4712
## $INSTALLDIR$TMXRCHBNDR/exd FE
EOM
chmod 755 "$TMXRCHBNDS"/exd
}

_ADDfibs_() {
_CFLHDR_ "$TMXRCHBNDS"/fibs
cat >> "$TMXRCHBNDS"/fibs <<- EOM
find /proc/ -name maps 2>/dev/null | xargs awk '{print \$6}' | grep '\.so' | sort | uniq && exit
## $INSTALLDIR$TMXRCHBNDR/fibs FE
EOM
chmod 755 "$TMXRCHBNDS"/fibs
}

_ADDga_() {
_CFLHDR_ "$TMXRCHBNDS"/ga
cat >> "$TMXRCHBNDS"/ga <<- EOM
if [ -x "\$(command -v git)" ]
then
git add .
else
{ pc git || pci git ; }
git add .
fi
## $INSTALLDIR$TMXRCHBNDR/ga FE
EOM
chmod 755 "$TMXRCHBNDS"/ga
}

_ADDgcl_() {
_CFLHDR_ "$TMXRCHBNDS"/gcl "# Contributor reddit.com/u/ElectricalUnion"
printf "%s\\n" "{ [ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...\\e[0m\\n\" \"ＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} SIGNAL:\" \"  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the Arch Linux 'sudo' command:  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run '$STARTBIN command 'addauser user'' in native Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  \" ; } && exit 101
{ [ \"\$#\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...\\e[0m\\n\" \"Example usage: \" \"'\${0##*/} https://github.com/TermuxArch/TermuxArch' \" ; } && exit 101
_GITCLONE_() {
git clone --depth 1 \"\$@\" --single-branch || git clone --depth 1 \"\$@\" --single-branch || printf \"\\n\\e[1m%s\\n\" \"This command 'sudo pacman -Rdd ca-certificates-utils ; sudo pacman -S ca-certificates-utils ; sudo pacman -Syu' might resolve an 'error setting certificate verify locations:  CAfile:' error.\"
}
BASENAME=\"\${@#*//}\" # strip before double slash
BASENAME=\"\${BASENAME##*/}\" # strip before last slash
if [ -d \"\$BASENAME\" ]
then
printf 'Directory '%s' exists;  EXITING...\\n' \"\$BASENAME\"
exit
fi
[ -x \"\$(command -v git)\" ] || pc git || pci git
_GITCLONE_ \"\$@\"
## $INSTALLDIR$TMXRCHBNDR/gcl FE" >> "$TMXRCHBNDS"/gcl
chmod 755 "$TMXRCHBNDS"/gcl
}

_ADDgclone_() {
_CFLHDR_ "$TMXRCHBNDS"/gclone "# Usefull for cloning over very slow and sketchy Internet connections."
_PRTRTHLP_ "$TMXRCHBNDS"/gclone
_DPTCHHLP_ "$TMXRCHBNDS"/gclone
cat >> "$TMXRCHBNDS"/gclone <<- EOM
{ [ "\$#" = 0 ] && printf "\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...s\\e[0m\\n" "Example usage: " "'\${0##*/} https://github.com/TermuxArch/TermuxArch' " ; } && exit 101
_GCLONEMAIN_() {
BASENAME="\${@%/}" # strip trailing slash
BASENAME="\${BASENAME#*//}" # strip before double slash
REPONAME="\${BASENAME##*/}" # strip before last slash
{ [ -e "\$REPONAME-master" ] && { cd "\$REPONAME-master" || exit 69 ; } ; } || { [ -e "\$REPONAME-main" ] || { wget -c -O "\$REPONAME.zip" "\$*"/archive/main.zip && unzip "\$REPONAME.zip"  ; } && { cd "\$REPONAME-main" || exit 69 ; } ; } || { [ -e "\$REPONAME-master" ] || { wget -c -O "\$REPONAME.zip" "\$*"/archive/master.zip && unzip "\$REPONAME.zip" ; } && { cd "\$REPONAME-master" || exit 69 ; } ; }
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
## $INSTALLDIR$TMXRCHBNDR/gclone FE
EOM
chmod 755 "$TMXRCHBNDS"/gclone
}

_ADDgcm_() {
_CFLHDR_ "$TMXRCHBNDS"/gcm
cat >> "$TMXRCHBNDS"/gcm <<- EOM
if [ -x "\$(command -v git)" ]
then
git commit
else
{ pc git || pci git ; }
git commit
fi
## $INSTALLDIR$TMXRCHBNDR/gcm FE
EOM
chmod 755 "$TMXRCHBNDS"/gcm
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

_ADDgmu_() {
_CFLHDR_ "$TMXRCHBNDS"/gmu
cat >> "$TMXRCHBNDS"/gmu <<- EOM
if [ -x "\$(command -v git)" ]
then
git submodule update --init --recursive --remote || git submodule update --init --recursive --remote --verbose
else
{ pc git || pci git ; }
git submodule update --init --recursive --remote || git submodule update --init --recursive --remote --verbose
fi
## $INSTALLDIR$TMXRCHBNDR/gmu FE
EOM
chmod 755 "$TMXRCHBNDS"/gmu
}

_ADDgp_() {
_CFLHDR_ "$TMXRCHBNDS"/gp "# git push https://username:password@github.com/username/repository.git"
cat >> "$TMXRCHBNDS"/gp <<- EOM
if [ -x "\$(command -v git)" ]
then
git push
else
{ pc git || pci git ; }
git push
fi
## $INSTALLDIR$TMXRCHBNDR/gp FE
EOM
chmod 755 "$TMXRCHBNDS"/gp
}

_ADDgpl_() {
_CFLHDR_ "$TMXRCHBNDS"/gpl
cat >> "$TMXRCHBNDS"/gpl <<- EOM
if [ -x "\$(command -v git)" ]
then
git pull || git pull --verbose
else
{ pc git || pci git ; }
git pull || git pull --verbose
fi
## $INSTALLDIR$TMXRCHBNDR/gpl FE
EOM
chmod 755 "$TMXRCHBNDS"/gpl
}

_ADDgsu_() {
_CFLHDR_ "$TMXRCHBNDS"/gsu
cat >> "$TMXRCHBNDS"/gsu <<- EOM
if [ -x "\$(command -v git)" ]
then
git submodule update --init --recursive --remote || git submodule update --init --recursive --remote --verbose
else
{ pc git || pci git ; }
git submodule update --init --recursive --remote || git submodule update --init --recursive --remote --verbose
fi
## $INSTALLDIR$TMXRCHBNDR/gsu FE
EOM
chmod 755 "$TMXRCHBNDS"/gsu
}

_ADDhunf_ () {
_CFLHDR_ "$TMXRCHBNDS"/hunf
_PRTRTHLP_ "$TMXRCHBNDS"/hunf
printf "%s\\n%s\\n" "{ [ -x \"/usr/bin/hunspell\" ] || { pc hunspell hunspell-en_US || pci hunspell hunspell-en_US ; } ; } && /usr/bin/hunspell -p en_US \"\$@\" || /usr/bin/hunspell -p en_US \"\$@\"" "## $INSTALLDIR$TMXRCHBNDR/hunf FE" >> "$TMXRCHBNDS"/hunf
chmod 755 "$TMXRCHBNDS"/hunf
}

_ADDhunw_ () {
_CFLHDR_ "$TMXRCHBNDS"/hunw
_PRTRTHLP_ "$TMXRCHBNDS"/hunw
printf "%s\\n%s\\n" "{ [ -x \"/usr/bin/hunspell\" ] || { pc hunspell hunspell-en_US || pci hunspell hunspell-en_US ; } ; } && /usr/bin/hunspell -p en_US <<< \"\$@\" || /usr/bin/hunspell -p en_US <<< \"\$@\"" "## $INSTALLDIR$TMXRCHBNDR/hunw FE" >> "$TMXRCHBNDS"/hunw
chmod 755 "$TMXRCHBNDS"/hunw
}

_ADDinfo_ () {
_CFLHDR_ "$TMXRCHBNDS"/info
_PRTRTHLP_ "$TMXRCHBNDS"/info
printf "%s\\n%s\\n" "{ [ -x \"/usr/bin/info\" ] || { pc texinfo || pci texinfo ; } ; } && /usr/bin/info \"\$@\" || /usr/bin/info \"\$@\"" "## $INSTALLDIR$TMXRCHBNDR/info FE" >> "$TMXRCHBNDS"/info
chmod 755 "$TMXRCHBNDS"/info
}

_ADDmakelibguestfs_() {
_CFLHDR_ "$TMXRCHBNDS"/makelibguestfs "# Developed around [userspace mount #74](https://github.com/SDRausty/termux-archlinux/issues/74) contributor gordol and [Feature Request: mount loopback device #376](https://github.com/termux/termux-app/issues/376) contributor SDRausty, and at [make[2]: *** No rule to make target 'guestfs_protocol.c', needed by 'all'. Stop. #82](https://github.com/libguestfs/libguestfs/issues/82, et. al.) contributor rwmjones, et. al.  Reference https://libguestfs.org/guestfs-building.1.html#building-from-git"
_PRTRTHLP_ "$TMXRCHBNDS"/makelibguestfs
_DPTCHHLP_ "$TMXRCHBNDS"/makelibguestfs
cat >> "$TMXRCHBNDS"/makelibguestfs <<- EOM
# builtin help string variables begin
NMCMND="\$(uname -m)"
PSCMMT="(please quote multiple words)"
XLCD00="'\$SRPTNM f 'machine virtual'' \$PSCMMT"
XLCD0L="'\$SRPTNM find 'machine virtual'' \$PSCMMT"
XLCD01="'\$SRPTNM b libguestfs'"
XLCD02="'\$SRPTNM s libguestfs'"
XLCD03="'\$SRPTNM g 'guestfish --help'' \$PSCMMT"
XLCD04="'\$SRPTNM l 'guestfish --help'' \$PSCMMT"
# builtin help string variables end
HLPSTG="One and two letter arguments are good; i.e. Command \$XLCD00 is an equivalent of \$XLCD0L.  Command \$SRPTNM accepts these arguments:

b[uild]			build libguestfs.  Useful for building 'libguestfs' again.  This argument is a synonym for option 'make',

f[ind packages]★	find default 'machine virtual' search or find AUR packages with search terms, EXAMPLE: \$XLCD00,

g[uestfish 'cmd cmd']	run either guestfish shell (default) or run command commands if they are built.  This argument is a synonym for option 'libguestfs', EXAMPLE: \$XLCD03,

h[elp]			print this help screen,

he[lp building]★	present this https://libguestfs.org/guestfs-building.1.html webpage,

hel[p faq]★		present this https://libguestfs.org/guestfs-faq.1.html webpage,

l[ibguestfs 'cmd cmd']	run either guestfish shell (default) or run commands if they are built.  This argument is a synonym for option 'guestfish', EXAMPLE: \$XLCD04,

m[ake]			make libguestfs.  Useful for making 'libguestfs' again.  This argument is a synonym for option 'build',

s[how PKGBUILD]★	show the libguestfs PKGBUILD file or show a PKGBUILD file for a particular package, EXAMPLE: \$XLCD02,

v[irt-inspector 'cmd cmd']  run either virt-inspector (default) or run command 'virt-inspector 'cmd cmd'' if they are built,

★open and use an Android web browser to find Arch Linux AUR packages matching search term(s) or view a particular PKGBUILD package file.  "
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Ff]* ]] && { printf '\\e[0;32m%s' "Finding '\${2:-machine virtual}' AUR packages...  " && am start -a android.intent.action.VIEW -d "https://aur.archlinux.org/packages?O=0&K=\${2:-machine virtual}" ; exit ; } ; }
[ -n "\${1:-}" ] && { { [[ "\${1//-}" = [Gg]* ]] || [[ "\${1//-}" = [Ll]* ]] ; } && { [ -d "\$HOME"/libguestfs ] && cd "\$HOME"/libguestfs && printf '%s\n' "Running command '\$HOME/libguestfs/run \$HOME/libguestfs/fish/guestfish \${2:-}' in directory '\$PWD'..." && \$HOME/libguestfs/run "\$HOME/libguestfs/fish/guestfish \${2:-}" && exit || { printf '\\e[0;32m%s' "\$HLPSTG" ; exit ; } ; } ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Hh][Ee][Ll]* ]] && { printf '\\e[0;32m%s' "Presenting this 'https://libguestfs.org/guestfs-faq.1.html' webpage...  " && am start -a android.intent.action.VIEW -d "https://libguestfs.org/guestfs-faq.1.html" ; exit ; } ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Hh][Ee]* ]] && { printf '\\e[0;32m%s' "Presenting this 'https://libguestfs.org/guestfs-building.1.html' webpage...  " && am start -a android.intent.action.VIEW -d "https://libguestfs.org/guestfs-building.1.html" ; exit ; } ; }
[ -n "\${1:-}" ] && [[ "\${1//-}" = [Ss]* ]] && { printf '\\e[0;32m%s' "Showing PKGBUILD file for '\${2:-libguestfs}'...  " && am start -a android.intent.action.VIEW -d "https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=\${2:-libguestfs}" && exit ; }
[ -n "\${1:-}" ] && [[ "\${1//-}" = [Vv]* ]] && { [ -d "\$HOME"/libguestfs ] && cd "\$HOME"/libguestfs && printf '%s\n' "Running command '\$HOME/libguestfs/run \$HOME/libguestfs/fish/virt-inspector \${2:-}' in directory '\$PWD'..." && \$HOME/libguestfs/run "\$HOME/libguestfs/fish/guestfish \${2:-}" && exit || { printf '\\e[0;32m%s' "\$HLPSTG" ; exit ; } ; }
[ -n "\${1:-}" ] && { for ARG1 in '/' '?' {0..9} Aa Cc Dd Ee Hh Ii Jj Kk Oo Qq Rr Tt Uu Ww Xx Yy Zz ; do [[ "\${1//-}" = ["\$ARG1"]* ]] && { printf '\\e[0;32m%s' "\$HLPSTG" ; exit ; } ; done ; }
# makelibguestfs begin
[ -z "\${1:-}" ] && { { [ -f "\$HOME"/libguestfs/fish/guestfish.1 ] && { [ -x /usr/bin/man ] || { pc man || pci man ; } ; } && TMRCMDVL="man \$HOME/libguestfs/fish/guestfish.1" && printf '%s\n' "Running command '\$TMRCMDVL' in directory '\$PWD'..." && \$TMRCMDVL && exit ; } || printf "\\e[48;5;22m%s\\n" "Command \$SRPTNM is attempting to build and install 'libguestfs' for computer architecture '\$NMCMND'..." ; }
# libguestfs dependencies
GTFSDPND=(
acl
attr
augeas
autoconf
automake
bash
binutils
bison
btrfs-progs
bzip2
cdrtools
clang
coreutils
cpio
cryptsetup
curl
debootstrap
dhclient
dhcpcd
diffutils
dosfstools
e2fsprogs
exfatprogs
f2fs-tools
file
findutils
flex
gawk
gdb
gdisk
gettext
glibc
gperf
gptfdisk
grep
groff
grub
gzip
hivex
iproute2
iputils
jansson
jfsutils
kmod
less
libcap
libconfig
libtirpc
libtool
libxml2
linux
lrzip
lsof
lsscsi
lvm2
lzop
m4
make
man
mdadm
module-init-tools
mtools
multipath-tools
netpbm
nilfs-utils
ntfs-3g
ocaml
ocaml-findlib
pacman
parted
patch
pciutils
pcre2
perl
perl-module-build
perl-pod-parser
pkgconf
popt
procps
procps-ng
psmisc
python
python-pycodestyle
reiserfsprogs
rpcsvc-proto
rpm-tools
rsync
sed
squashfs-tools
strace
sudo
supermin
systemd
systemd-libs
tar
texinfo
udev
util-linux
valgrind
virt-install
vim
wget
which
xfsprogs
xorriso
xz
yara
)
NBRFCMDS=19
NMCMND="\$(uname -m)"
_SLCTRHPR_() {
_RCSNPTC0_() { printf "\\e[48;5;112m%s\\e[48;5;28m%s\\e[0;0;0m\\n" "[\$1/\$NBRFCMDS]C0" " Running complementary command '\${3:-}' for command '\${2:-}' in directory '\$PWD'...  " && { { \${3:-:} || _RCSRPTA1_ "\${1:-}" "\${2:-}" "\${3:-}" "\${4:-}" ; } ; printf "\\e[48;5;119m%s\\e[48;5;34m%s\\e[0;0;0m\\n" "[\$1/\$NBRFCMDS]C0" " Finished running complementary command '\${3:-}' for command '\${2:-}'." ; } ; }
_RCSRPTA0_() { printf "\\e[48;5;112m%s\\e[48;5;28m%s\\e[0;0;0m\\n" "[\$1/\$NBRFCMDS]A0" " Running alternate command '\${3:-}' for command '\${2:-}' in directory '\$PWD'...  " && { { \${3:-:} || _RCSRPTA1_ "\${1:-}" "\${2:-}" "\${3:-}" "\${4:-}" ; } ; printf "\\e[48;5;119m%s\\e[48;5;34m%s\\e[0;0;0m\\n" "[\$1/\$NBRFCMDS]A0" " Finished running alternate command '\${3:-}' for command '\${2:-}'." ; } ; }
_RCSRPTA1_() { printf "\\e[48;5;112m%s\\e[48;5;28m%s\\e[0;0;0m\\n" "[\$1/\$NBRFCMDS]A1" " Running alternate command '\${4:-}' for commands '\${2:-}' then '\${3:-}' in directory '\$PWD'...  " && { { \${4:-:}  || : ; } ; printf "\\e[48;5;119m%s\\e[48;5;34m%s\\e[0;0;0m\\n" "[\$1/\$NBRFCMDS]A1" " Finished running alternate command '\${4:-}' for commands '\${2:-}' then '\${3:-}''." ; } ; }
_RCSNPTNM_() { printf "\\e[48;5;112m%s\\e[48;5;28m%s\\e[0;0;0m\\n" "[\$1/\$NBRFCMDS]" " Running command '\$2' in directory '\$PWD'...  " && { { { \$2  && _RCSNPTC0_ "\${1:-}" "\${2:-}" "\${3:-}" "\${4:-}" ; } || printf '%s\n' "\${SRPTNM^^} SIGNAL:  \$2" ; } ; printf "\\e[48;5;119m%s\\e[48;5;34m%s\\e[0;0;0m\\n" "[\$1/\$NBRFCMDS]" " Finished running command '\$2'." ; } ; }
_RCSRPTNM_() { printf "\\e[48;5;112m%s\\e[48;5;28m%s\\e[0;0;0m\\n" "[\$1/\$NBRFCMDS]" " Running command '\$2' in directory '\$PWD'...  " && { { \$2  || _RCSRPTA0_ "\${1:-}" "\${2:-}" "\${3:-}" "\${4:-}" ; } ; printf "\\e[48;5;119m%s\\e[48;5;34m%s\\e[0;0;0m\\n" "[\$1/\$NBRFCMDS]" " Finished running command '\$2'." ; } ; }
_PRPCLANG_() { command -v clang 1>/dev/null && export CC=clang || { { pc clang || pci clang ; } && export CC=clang ; } ; }
_BULDQEMU_() { { QEMUPKGI=(acpica brltty capstone glusterfs libcacard libepoxy libiscsi libnfs liblouis libpulse libslirp libusb liburing libvirt libxkbcommon make ninja pkgconf pcsc-tools pixman python-sphinx spice spice-protocol virglrenderer sdl2 sdl2_image) && pc "\${QEMUPKGI[@]}" || pci "\${QEMUPKGI[@]}" ; } && { cd || exit 69 ; }
if [ -d qemu ]
then
cd qemu || exit 69
gpl
else
gcl https://gitlab.com/qemu-project/qemu.git
cd qemu || exit 69
fi
git pull --depth 1
if [ -d build ]
then
rm -rf build
mkdir -p build && { cd build || exit 69 ; }
else
mkdir -p build && { cd build || exit 69 ; }
fi
for TMRCMD in "../configure" "make" "sudo make install"
do
{ TMRCMDVL="\$TMRCMD" && printf '\\e[48;5;22m%s\\e[0m\n' "Running command '\$TMRCMDVL' in directory '\$PWD'..." && \$TMRCMDVL ; } || { TMRCMDVL="git pull --depth 1" && printf '\\e[48;5;22m%s\\e[0m\n' "Running command '\$TMRCMDVL' in directory '\$PWD' and exiting..." && \$TMRCMDVL ; exit 169 ; }
done
}
_CHECKFORQEMU_() {
_PACMANCKQEMU_() {
if [[ "\$NMCMND" = "$CPUABI8" ]] || [[ "\$NMCMND" = "aarch64" ]]
then
command -v qemu-system-aarch64 && command -v qemu-img
elif [[ "\$NMCMND" == "$CPUABI7" ]] || [[ "\$NMCMND" == "armv7" ]]
then
command -v qemu-system-arm && command -v qemu-img
elif [[ "\$NMCMND" == "$CPUABIX86" ]] || [[ "\$NMCMND" == i686 ]]
then
command -v qemu-system-i386 && command -v qemu-img
elif [[ "\$NMCMND" == "$CPUABIX8664" ]]
then
command -v qemu-system-x86_64 && command -v qemu-img
else
command -v qemu && command -v qemu-img
fi
}
_PACMANINQEMU_() {
if [[ "\$NMCMND" == "$CPUABI7" ]] || [[ "\$NMCMND" == "armv7" ]] || [[ "\$NMCMND" = "$CPUABI8" ]] || [[ "\$NMCMND" = "aarch64" ]] || [[ "\$NMCMND" == "$CPUABIX8664" ]]
then
{ pc qemu qemu-img qemu-tools || pci qemu qemu-img qemu-tools ; } || { printf "\\e[48;5;22m%s\\n" "\${SRPTNM^^} SIGNAL:  Missing qemu command(s) found:  Command '\$SRPTNM' is attempting to build and install 'qemu' a 'libguestfs' prerequisite for computer architecture '\$NMCMND'.  If you find a better and simpler resolution for command '\$SRPTNM', please open an issue and pull request at GitHub." && _BULDQEMU_ ; } || makeaurhelpers build qemu-git
elif [[ "\$NMCMND" == "$CPUABIX86" ]] || [[ "\$NMCMND" == i686 ]]
then
{ pc qemu || pci qemu ; } || { printf "\\e[48;5;22m%s\\n" "\${SRPTNM^^} SIGNAL:  Missing qemu command(s) found:  Command '\$SRPTNM' is attempting to build and install 'qemu' a 'libguestfs' prerequisite for computer architecture '\$NMCMND'.  If you find a better and simpler resolution for command '\$SRPTNM', please open an issue and pull request at GitHub." && _BULDQEMU_ ; } || makeaurhelpers build qemu-git
else
{ pc qemu qemu-img || pci qemu qemu-img ; } || { printf "\\e[48;5;22m%s\\n" "\${SRPTNM^^} SIGNAL:  Missing qemu command(s) found:  Command '\$SRPTNM' is attempting to build and install 'qemu' a 'libguestfs' prerequisite for computer architecture '\$NMCMND'.  If you find a better and simpler resolution for command '\$SRPTNM', please open an issue and pull request at GitHub." && _BULDQEMU_ ; } || makeaurhelpers build qemu-git
fi
}
_PACMANCKQEMU_ || { printf "\\e[48;5;22m%s\\n" "Command '\$SRPTNM' is attempting to install 'qemu' a 'libguestfs' prerequisite for computer architecture '\$NMCMND'.  If you find a better and simpler resolution for command '\$SRPTNM', please open an issue and pull request at GitHub..." && _PACMANINQEMU_ ; }
}
_CHCKFRPRREQUSTS_() { [ -f /usr/share/licenses/python-pycodestyle/LICENSE ] && [ -x /usr/bin/bison ] && [ -x /usr/bin/gdb ] && [ -x /usr/bin/libtool ] && [ -x /usr/bin/ocaml ] ; }
_INSTLLPRREQUSTS_() { pc \${GTFSDPND[@]} || pci \${GTFSDPND[@]} ; }
TMRCMDVL="_PRPCLANG_" && _RCSRPTNM_ 1 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
TMRCMDVL="_CHECKFORQEMU_" && _RCSRPTNM_ 2 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
_RCSRPTNM_ 3 "_CHCKFRPRREQUSTS_" "_INSTLLPRREQUSTS_" "echo \${SRPTNM^^} SIGNAL:  _CHCKFRPRREQUSTS_"
{ [ -f /run/lock/${INSTALLDIR##*/}/\$UID.libguestfs.cpan.lock ] && _RCSRPTNM_ 4 "echo file /run/lock/${INSTALLDIR##*/}/\$UID.libguestfs.cpan.lock exists" ; } || { _RCSNPTNM_ 4 "cpan -i Locale::TextDomain Module::Build Pod::Man Pod::Simple Test::More" "touch /run/lock/${INSTALLDIR##*/}/\$UID.libguestfs.cpan.lock" ; }
_RCSRPTNM_ 5 "cd \$HOME" "exit 69"
TMRCMDVL="gcl https://github.com/libguestfs/libguestfs" && _RCSRPTNM_ 6 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
_RCSRPTNM_ 7 "cd libguestfs" "exit 69"
TMRCMDVL="gpl" && _RCSRPTNM_ 8 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
TMRCMDVL="gsu" && _RCSRPTNM_ 9 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
# using patches is optional:
_PHLBGSTFS1_(){ [ -f /etc/os-release ] && TMRCMDVL="\$(grep -w ID /etc/os-release | cut -d"=" -f 2)" && sed -Ei "s/ARCH\ \|\ MANJARO\ \|/\${TMRCMDVL^^}\ \|\ MANJARO\ \|/g" m4/guestfs-appliance.m4 ; }
_PHLBGSTFS2_(){
if [ -f "\$HOME"/libguestfs/m4/patchfile  ]
then
cd "\$HOME"/libguestfs/m4 && patch guestfs-appliance.m4 patchfile ; cd "\$HOME"/libguestfs
else
printf '%s\n' "Patch file \$HOME/libguestfs/m4/patchfile is available at this https://listman.redhat.com/archives/libguestfs/2022-May/028941.html webpage.  No patch file found.  Exiting..."  && exit 101
fi
}
if [ -n "\${1:-}" ] && [[ "\${1//-}" = [Pp]*[1]* ]]
then
TMRCMDVL="_PHLBGSTFS1_" && _RCSRPTNM_ 10 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
elif [ -n "\${1:-}" ] && [[ "\${1//-}" = [Pp]*[Ii][Dd]* ]]
then
TMRCMDVL="_PHLBGSTFS2_" && _RCSRPTNM_ 10 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
else
TMRCMDVL="echo \${SRPTNM^^} SIGNAL:  no patch" && _RCSRPTNM_ 10 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
fi
# using patches end
TMRCMDVL="make -C appliance clean-supermin-appliance" && _RCSRPTNM_ 11 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
TMRCMDVL="make clean" && _RCSRPTNM_ 12 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
TMRCMDVL="autoupdate -f" && _RCSRPTNM_ 13 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
TMRCMDVL="autoreconf -i" && _RCSRPTNM_ 14 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
{ [ -f ./localconfigure ] &&  TMRCMDVL="./localconfigure" && _RCSRPTNM_ 15 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL" ; } || { TMRCMDVL="./configure CFLAGS=-fPIC --with-supermin-extra-options=\"--use-installed\"" && _RCSRPTNM_ 15 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL" ; }
TMRCMDVL="make"
_RCSRPTNM_ 16 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
TMRCMDVL="make quickcheck" && _RCSRPTNM_ 17 "\$TMRCMDVL" "echo \${SRPTNM^^} SIGNAL:  \$TMRCMDVL"
_RCSRPTNM_ 18 "\$HOME/libguestfs/run guestfish --help" "\${0##*/} h" "echo \${SRPTNM^^} SIGNAL:  \${0##*/} h"
printf "\\e[48;5;119m%s\\e[48;5;34m%s\\e[0;0;0m\\n" "[\$NBRFCMDS/\$NBRFCMDS]" " Please do NOT run 'make install' in directory '\$HOME/libguestfs' as this may create conflicting versions.  Use the '\$HOME/libguestfs/run' command instead.  Webpage https://libguestfs.org/guestfs-building.1.html#the-.-run-script has more information.  "
}

_SLCTRHPR_ \$@ || { printf '\\e[0;32m%s' "\$HLPSTG" ; exit ; }
## $INSTALLDIR$TMXRCHBNDR/makelibguestfs FE
EOM
chmod 755 "$TMXRCHBNDS"/makelibguestfs
}

_ADDmakeaurhelpers_() {
_CFLHDR_ "$TMXRCHBNDS"/makeaurhelpers "# add Arch Linux AUR helpers https://wiki.archlinux.org/index.php/AUR_helpers"
_PRTRTHLP_ "$TMXRCHBNDS"/makeaurhelpers
_DPTCHHLP_ "$TMXRCHBNDS"/makeaurhelpers
cat >> "$TMXRCHBNDS"/makeaurhelpers <<- EOM
NMKPKC="nice -n 20 makepkg -ACcfis --check --needed"
NMKPKN="nice -n 20 makepkg -ACcfis --check --needed --noconfirm"
NMKPKR="nice -n 20 makepkg -ACcfirs --check --needed --noconfirm"
{ [ -z "\${1:-}" ] && NMKPKG="\$NMKPKC" ; } || { { [[ "\${1//-}" = [Aa]* ]] || [[ "\${1//-}" = [Nn]* ]] || [[ "\${1//-}" = [Rr]* ]] || [[ "\${1//-}" = [Ss][Bb]* ]] || [[ "\${1//-}" = [Tt][Ss]* ]] ; } && NMKPKG="\$NMKPKN" ; } || { { [[ "\${1//-}" = [Ee]* ]] || [[ "\${1//-}" = [Gg]* ]] ; } && NMKPKG="\$NMKPKR" ; } || NMKPKG="\$NMKPKC"
# builtin help string variables begin
NMCMND="\$(uname -m)"
DFLTSG="Default: \"-A ignore incomplete arch field in PKGBUILD\" also sets arch=('any')."
SLCTSYRNG="AUR helper"
XNMPKC="NMKPKC=\"\$NMKPKC\""
XNMPKN="NMKPKN=\"\$NMKPKN\""
XNMPKR="NMKPKR=\"\$NMKPKR\""
XLCD00="\"\$SRPTNM f 'digital rain'\""
XLCD0L="\"\$SRPTNM find 'digital rain'\""
XLCD01="\"\$SRPTNM b greenrain\""
XLCD02="\"\$SRPTNM v greenrain\""
# builtin help string variables end
HLPSTG=" Command \$SRPTNM accepts these arguments:

a[ll AUR helpers]	build all the AUR helper packages with passing checksums in alphabetical order,

b[uild] package		build one Arch Linux packages from AUR.  EXAMPLE: \$XLCD01,

c[andy]			build a terminal candy from AUR,

f[ind] packages★	find AUR packages,  EXAMPLE: \$XLCD00,

g[hcup install]		build and install 'ghcup' (an installer for the general purpose language Haskell) AUR packages.  Command 'makeaurghcuphs' also installs command 'ghcup',

h[elp]			show this help screen,

l[ibguestfs install]	build and install 'libguestfs', access and modify virtual machine disk image packages.  Command 'makelibguestfs' also attempts to install command 'libguestfs',

m[ake makepkgs]		make Arch Linux makepkg related packages from AUR,

n[oconfirm install]	do not confirm install (\$SRPTNM installs packages by default with noconfirm except for individual package builds).  This option only applies to the main AUR helpers packages select menu,

r[everse build all]	build all the AUR helper packages with passing checksums in reverse alphabetical order, this option is like option 'a',

s[earch] packages★	search for AUR packages.  This option is a synonym for find,

sc[reensavers build]	build a terminal screensavers from AUR,

sb[uild] 		small build builds some of the smaller AUR helper packages,

tc[andies]		terminal candies builds all of the terminal candies from AUR,

tm[akepkgs]		total makepkgs builds all the Arch Linux makepkg related package from AUR,

ts[creensavers]		terminal screensavers builds all of the terminal screensavers from AUR,

v[iew] package★		view a PKGBUILD file for a particular package;  EXAMPLE: \$XLCD02.

One and two letter arguments are good; i.e. Command \$XLCD00 is an equivalent of the \$XLCD0L command (quote multiple words).  \${SRPTNM^^} NOTICE:  \$DFLTSG  Variables \$XNMPKC, \$XNMPKN and \$XNMPKR in file '\$SRPTNM' can be edited.

★open and use an Android web browser either to find an Arch Linux AUR package matching search term(s) or view a package PKGBUILD file.  "
[ -n "\${1:-}" ] && [[ "\${1:-}" = [Ff]* ]] && { am start -a android.intent.action.VIEW -d "https://aur.archlinux.org/packages?O=0&K=\${2:-AUR helper}" ; exit ; }
[ -n "\${1:-}" ] && [ -n "\${2:-}" ] && [[ "\${1:-}" = [Vv]* ]] && { am start -a android.intent.action.VIEW -d "https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=\${2:-}" ; exit ; }
[ -n "\${1:-}" ] && { for ARG1 in '/' '?' {0..9} Dd Hh Ii Jj Kk Oo Pp Qq Uu Ww Xx Yy Zz ; do [[ "\${1//-}" = ["\$ARG1"]* ]] && { printf '\\e[0;32m%s' "\$HLPSTG" ; exit ; } ; done ; }
for DRHLPR in AURHLPR AURHLPRD AURHLPRDPG AURHLPRDRN AURHLPRS AURHLPRSM GHCUPAURPKG CANDY GAME LIBGUESTFSD LIBGUESTFSP MAKEPKGS MKRPKGDS SCREENSAVERS ; do declare -A \$DRHLPR ; done
# depreciated aur helpers reason
AURHLPRDRN=(
[aget]="Validating source files with b2sums skipped"
[aura-git]="Validating source files with sha256sums skipped"
[auracle-git]="Validating source files with sha256sums skipped"
[aurh-git]="Validating source files with sha256sums skipped"
[aurman]="Validating source files with md5sums skipped"
[aurora-git]="Validating source files with md5sums skipped"
[aurs]="curl: (22) The requested URL returned error: 503"
[aurs-git]="Validating source files with sha512sum skipped"
[aurutils]="Validating source files with sha512sum skipped"
[baph]="Validating source files with md5sums skipped"
[foxaur]="curl: (22) The requested URL returned error: 503"
[gfoxaur]="curl: (22) The requested URL returned error: 503"
[goaur]="Validating source files with md5sums skipped"
[liteaur]="Validating source files with sha256sums FAILED"
[magico]="Validating source files with md5sums skipped"
[maur]="Validating source files with sha512sum skipped"
[pakku-git]="Validating source files with sha512sum skipped"
[pikaur-git]="Validating source files with md5sums skipped"
[pikaur-aurnews]="Validating source files with md5sums skipped"
[pkgbuilder-git]="Validating source files with md5sums skipped"
[repoctl-git]="Validating source files with sha512sum skipped"
[simpleaur-git]="Validating source files with sha512sum skipped"
[saurch-git]="fatal: repository 'http://vitali64.duckdns.org/git/utils/saurch.git/' not found"
[trizen-git]="Validating source files with sha512sum skipped"
[vam]="Validating source files with md5sums skipped"
[wfa-git]="Validating source files with md5sums skipped"
[yay-git]="Validating source files with sha512sum skipped"
[yayim]="curl: (60) SSL: no alternative certificate subject name matches target host name 'gitea.jojiiofficial.de'"
[yup]="Validating source files with sha256sums skipped"
[yup-bin]="Validating source files with sha256sums skipped"
[yup-git]="Validating source files with sha256sums skipped"
[zeus]="Validating source files with sha256sums FAILED"
[zur-git]="Validating source files with sha256sums skipped"
)
# pending aur helpers
AURHLPRDPG=(
[aura]="aura"
[aura-git]="aura"
[aurto]="aurto"
[pacaur]="pacaur"
[pacaur-git]="pacaur"
[paru]="paru"
[paru-git]="paru"
[pkgbuilder]="pkgbuilder"
[ram]="ram"
[repoctl]="repoctl"
[rua]="rua"
[stack-static]="stack"
[tulip-pm]="tulip"
[xaur]="xaur"
[yay]="yay"
[zur-git]="zur"
)
# depreciated aur helpers
AURHLPRD=(
[aura]="aura"
[aura-git]="aura"
[aurto]="aurto"
[aget]="aget"
[auracle-git]="auracle"
[aurh-git]="aurh"
[aurman]="aurman"
[aurora-git]="aurora"
[aurs]="aurs"
[aurs-git]="aurs"
[aurutils]="aurutils"
[baph]="baph"
[foxaur]="foxaur"
[gfoxaur]="gfoxaur"
[goaur]="goaur"
[liteaur]="liteaur"
[magico]="magico"
[maur]="maur"
[pakku-git]="pakku"
[pacaur]="pacaur"
[pacaur-git]="pacaur"
[paru]="paru"
[paru-git]="paru"
[pikaur-aurnews]="pikaur-aurnews"
[pikaur-git]="pikaur"
[pkgbuilder]="pkgbuilder"
[pkgbuilder-git]="pkgbuilder"
[ram]="ram"
[repoctl]="repoctl"
[repoctl-git]="repoctl"
[rua]="rua"
[simpleaur-git]="simpleaur"
[saurch-git]="saurch"
[stack-static]="stack"
[trizen-git]="trizen"
[tulip-pm]="tulip"
[vam]="vam"
[wfa-git]="wfa"
[xaur]="xaur"
[yay]="yay"
[yay-git]="yay"
[yayim]="yayim"
[yup]="yup"
[yup-bin]="yup"
[yup-git]="yup"
[zeus]="zeus"
[zeus-bin]="zeus"
[zur]="zur"
[zur-git]="zur"
)
# aur helpers
AURHLPRS=(
[aurget]="aurget"
[aurutils-git]="aur"
[blinky]="blinky"
[buildaur]="buildaur"
[buildaur-git]="buildaur"
[git-aurcheck]="git-aurcheck"
[haur]="haur"
[lightpkg]="lightpkg"
[liteaur-git]="liteaur"
[package-query]="package-query"
[package-query-git]="package-query"
[packer]="packer"
[pakka]="pakka"
[pakku]="pakku"
[pakku-gui]="pakku"
[pakku-gui-git]="pakku"
[paru-bin]="paru"
[paruz]="paruz"
[pbget]="pbget"
[pikaur]="pikaur"
[pkgbuild-introspection]="mksrcinfo"
[pkgbuild-introspection-git]="mksrcinfo"
[powerpill]="powerpill"
[popular-packages]="popular-packages"
[puyo]="puyo"
[repofish]="repofish"
[sakuri]="sakuri"
[trizen]="trizen"
[yaourt]="yaourt"
[yaah]="yaah"
[yay-bin]="yay"
)
# small build aur helpers
AURHLPRSM=(
[aurget]="aurget"
[haur]="haur"
[lightpkg]="lightpkg"
[liteaur-git]="liteaur"
[paruz]="paruz"
[pbget]="pbget"
[pikaur]="pikaur"
[sakuri]="sakuri"
[trizen]="trizen"
[yaah]="yaah"
[yay-bin]="yay"
)
# terminal candy
CANDY=(
[cowsay-bin]="cowsay"
[ternimal]="ternimal"
[nbsdgames-git]="nbsdgames"
[sl-git]="sl"
[sl-patch]="sl"
)
# one AUR game package
GAME=([nbsdgames-git]="nbsdgames")
# two AUR ghcup packages
GHCUPAURPKG=([ghcup-git]="ghcup" [ghcup-hs-bin]="ghcup")
# AUR libguestfs packages descriptions
# userspace mount #74 https://github.com/SDRausty/termux-archlinux/issues/74
LIBGUESTFSD=([guestfs-tools]="Tools for accessing and modifying guest disk images" [libguestfs-dev]="Library and tools for accessing and modifying virtual machine disk images, development version" [libguestfs-git]="Access and modify virtual machine disk image" [python-libguestfs]="Python bindings for libguestfs")
# AUR libguestfs packages
LIBGUESTFSP=([guestfs-tools]="" [libguestfs-dev]="libguestfs" [libguestfs-git]="libguestfs" [python-libguestfs]="libguestfs")
# AUR makepkg
MAKEPKGS=(
[dir-dlagent]="dir-dlagent"
[git-makepkg-templates-git]="/usr/share/makepkg-template/git.template"
[makepkg-git-lfs-proto]="/etc/makepkg-git-lfs.conf"
[makepkg-meta]="makepkg-meta"
[makepkg-nosudo]="/usr/share/libalpm/hooks/makepkg-nosudo.hook"
[pbget]="pbget"
[remakepkg]="remakepkg"
)
# AUR makepkgs descriptions
MKRPKGDS=(
[dir-dlagent]="A makepkg DLAGENT which forwards requests to configured directories"
[git-makepkg-templates-git]="makepkg-templates for git source packages"
[makepkg-git-lfs-proto]="Add Git-lfs support to makepkg. Use "git-lfs+" as protocol specifier in source url."
[makepkg-meta]="Easily create and install custom"
[makepkg-nosudo]="Use su instead of sudo in makepkg, for more convenient use in termux"
[makepkg-optimize-mold]="Supplemental build and packaging optimizations for makepkg"
[makepkg-optimize]="Supplemental build and packaging optimizations for makepkg"
[makepkg-tidy-ect]="A libmakepkg tidy script for loselessly compressing files using ect"
[makepkg-tidy-pdfsizeopt]="A libmakepkg tidy script for loselessly optimizing PDFs using pdfsizeopt"
[makepkg-tidy-scripts-git]="Collection of scripts for tidying packages created using makepkg. Includes optipng and upx support."
[makepkg-unreal]="Some shell functions to ease the installation of various Unreal games."
[pbget]="Retrieve PKGBUILDs and local source files from Git, ABS and the AUR for makepkg."
[remakepkg]="Apply changes to pacman packages"
)
# terminal screensavers
SCREENSAVERS=(
[asciiquarium-git]="asciiquarium"
[cmatrix-git]="cmatrix"
[digital-rain-git]="digital-rain"
[greenrain]="greenrain"
[neo-matrix]="neo-matrix"
[neo-matrix-git]="neo-matrix"
[pipes.c]="cpipes"
[termsaver-git]="termsaver"
[tmatrix]="tmatrix"
[tmatrix-git]="tmatrix"
[tty-clock-git]="tty-clock"
)
_ARHCMD_() {
{ [ -x /usr/bin/make ] && [ -x /usr/bin/strip ] ; } || { { pc base base-devel binutils git && makeaurfakeroottcp ; } || { pci base base-devel binutils git && makeaurfakeroottcp ; } ; }
# add dependencies for bash-pipes
if [ "\$AURHLPR" = bash-pipes ]
then
command -v "\$AURHLPR" >/dev/null || makeaurpipessh
fi
# add dependencies for bauerbill
if [ "\$AURHLPR" = bauerbill ]
then
command -v "\$AURHLPR" >/dev/null || {
[ -f /run/lock/${INSTALLDIR##*/}/gpg1D1F0DC78F173680.lock ] || { printf '\\e[0m%s\\n' "Command '\$SRPTNM' is running command 'gpg --keyserver keyserver.ubuntu.com --recv-keys 1D1F0DC78F173680'..." && gpg --keyserver keyserver.ubuntu.com --recv-keys 1D1F0DC78F173680 && :>/run/lock/${INSTALLDIR##*/}/gpg1D1F0DC78F173680.lock ; }
makeaurpython3aur
makeaurpython3colorsysplus
}
fi
# add dependencies for ghcup
if [[ "\$AURHLPR" = ghcup* ]]
then
command -v "\$AURHLPR" >/dev/null || { [ -x /usr/bin/numactl ] || pc numactl || pci numactl ; }
fi
# add dependencies for pacaur and pacaur-git
if [ "\$AURHLPR" = pacaur ] || [ "\$AURHLPR" = pacaur-git ]
then
command -v "\$AURHLPR" >/dev/null || {
{ [ -x /usr/bin/expac ] || pc expac || pci expac ; }
makeauraclegit
}
fi
# add dependencies for pbget
if [ "\$AURHLPR" = pbget ]
then
command -v "\$AURHLPR" >/dev/null || {
[ -f /run/lock/${INSTALLDIR##*/}/gpg1D1F0DC78F173680.lock ] || { printf '\\e[0m%s\\n' "Command '\$SRPTNM' is running command 'gpg --keyserver keyserver.ubuntu.com --recv-keys 1D1F0DC78F173680'..." && gpg --keyserver keyserver.ubuntu.com --recv-keys 1D1F0DC78F173680 && :>/run/lock/${INSTALLDIR##*/}/gpg1D1F0DC78F173680.lock ; }
makeaurpython3xcgf
makeaurpython3memoizedb
makeaurpython3xcpf
makeaurpython3aur
makeaurpm2ml
}
fi
# add dependencies for popular-packages
if [ "\$AURHLPR" = popular-packages ]
then
command -v "\$AURHLPR" >/dev/null || makeaurpackagequery
fi
# add dependencies for powerpill
if [ "\$AURHLPR" = powerpill ]
then
command -v "\$AURHLPR" >/dev/null || {
makeaurpackagequery
[ -x /usr/bin/aria2c ] || { pc aria2 || pci aria2 ; }
makeaurpython3xcgf
makeaurpython3memoizedb
makeaurpython3xcpf
makeaurpm2ml
}
fi
# add dependencies for stack-static
if [ "\$AURHLPR" = stack-static ]
then	# import stack-static key
command -v "\$AURHLPR" >/dev/null || {
[ -f /run/lock/${INSTALLDIR##*/}/gpg575159689BEFB442.lock ] || { printf '\\e[0m%s\\n' "Command '\$SRPTNM' is running command 'gpg --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442'..." && gpg --keyserver keyserver.ubuntu.com --recv-keys 575159689BEFB442 && :>/run/lock/${INSTALLDIR##*/}/gpg575159689BEFB442.lock ; }
}
fi
# add dependencies for xaur
if [ "\$AURHLPR" = xaur ]
then
command -v "\$AURHLPR" >/dev/null || {
makeaurpyinstaller
}
fi
# add dependencies for zur
if [ "\$AURHLPR" = zur ]
then
command -v "\$AURHLPR" >/dev/null || {
[ -x /usr/bin/zig ] || pc zig || pci zig
makeauraclegit
}
fi
_CHKAURHLPR_ "\$@"
}
# check if AUR command is on PATH
_CHKAURHLPR_() {
[ -n "\${2:-}" ] && [[ "\${BLDPKG:-}" = 0 ]] && CHKRHLPR="\$2" || CHKRHLPR="\${AURHLPRS[\$AURHLPR]}"
if command -v "\$CHKRHLPR" >/dev/null || [ -f "\$CHKRHLPR" ]
then
RCHLXPKG="\$(pacman -Ql "\$CHKRHLPR" | head -n 1 | cut -d" " -f 1)"
printf '%s' "Found command and/or file '\$CHKRHLPR'.  The '\$CHKRHLPR' command and/or file belongs to Arch Linux package '\${RCHLXPKG:-UNKNOWN}'.  "
[ -z "\${TALL:-}" ] || \$CHKRHLPR
[[ "\$DALL" = [Aa]* ]] || [[ "\$DALL" = [Rr]* ]] || [[ "\$DALL" = [Ss][Bb]* ]] || [[ "\$DALL" = [Ss][Cc]* ]] || [[ "\$DALL" = [Tt][Mm]* ]] || [[ "\$DALL" = [Tt][Cc]* ]] || [[ "\$DALL" = [Tt][Ss]* ]] || exit 0
else
_CLONEAURHLPR_
fi
}
# clone AUR package
_CLONEAURHLPR_() {
if [ -d "\$AURHLPR" ]
then
{ printf "%s" "Repository '\$AURHLPR' is already cloned...  " && _MAKEAURHLPR_ ; } || _PRTERROR_
else
{ printf "%s\\n" "Cloning git repository from 'https://aur.archlinux.org/\$AURHLPR' into directory '\$HOME/\$AURHLPR'..." && cd && gcl https://aur.archlinux.org/"\$AURHLPR" && _MAKEAURHLPR_ ; } || _PRTERROR_
fi
}
# make AUR package
_MAKEAURHLPR_() {
cd "\$HOME/\$AURHLPR" || exit 196
{ [ ! -f PKGBUILD ] && exit 198 ; } || { PKGBUILDVL="\$(<"\$HOME/\$AURHLPR/"PKGBUILD)" && VLGRPPBD="\$(awk 'BEGIN { found = 0; } ; /depends=\(/ { if (!found) { found = 1; \$0 = substr(\$0, index(\$0, "=\\(") + 2); }; } ; /\)/ { if (found) { found = 2; \$0 = substr(\$0, 0, index(\$0, "\\)") - 1); } ; } ; { if (found) { print; if (found == 2) found = 0; } ; }' <<< "\$PKGBUILDVL" 2>/dev/null)" && printf '\\e[0;32m%s\\e[0m  ' "Showing dependencies '\$(xargs <<< "\$VLGRPPBD")' for Arch Linux AUR package '\$AURHLPR'." ; }
printf "%s\\n" "Attempting to build and install Arch Linux AUR package '\$AURHLPR' for architecture \$NMCMND with '\$SRPTNM':  Running command '\$NMKPKG' in directory '\$PWD':  Please be patient..."
\$NMKPKG || _PRTERROR_
}
# print error help message
_PRTERROR_() {
printf "\\n\\e[1;31merror: \\e[1;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s) and run '\$STRNRG' again.  You can use the TermuxArch command 'pci' to ensure that the system is up to date.  The command 'gpg --keyserver keyserver.ubuntu.com --recv-keys 71A1D0EF' can be used to import gpg keys.  In order to resolve 'unauthenticated git protocol on port 9418 is no longer supported' the command 'git config --global url."https://".insteadOf git://' can be used.  Running command '\$STRNRG' again with the same menu selection may resolve the errors previously encountered automatically as well."
}
_SLCTRHPR_() {
printf "Please set the Arch Linux AUR package for command '%s \$SLCTSYRNG' to build and install.  \${SRPTNM^^} NOTICE:  \$DFLTSG  The \$SLCTSYRNG to install can be selected by name or number from this menu:\\n" "\$SRPTNM"
select AURHLPR in exit \$(for AURHLP in "\${!AURHLPRS[@]}" ; do printf '%s\n' "\$AURHLP" ; done | sort -n);
do
{ [[ "\$REPLY" = 0 ]] || [[ "\$REPLY" = 1 ]] || [[ "\$REPLY" = [Ee]* ]] || [[ "\$REPLY" = [Qq]* ]] ; } && printf '%s\\n' "Exiting..." && exit
{ [[ "\${!AURHLPRS[@]}" =~ (^|[[:space:]])"\$AURHLPR"($|[[:space:]]) ]] || { [[ "\${!AURHLPRS[@]}" =~ (^|[[:space:]])"\$REPLY"($|[[:space:]]) ]] && AURHLPR="\$REPLY" ; } ; } && printf "\\e[0;32m%s  " "Option '\$REPLY \$AURHLPR' was picked from the menu.  The chosen Arch Linux \$SLCTSYRNG for architecture \$NMCMND to build and install is '\$AURHLPR'..." && _ARHCMD_ && break || printf "%s" "Answer '\$REPLY' was chosen.  Please select the Arch Linux \$SLCTSYRNG to build and install by name or number from this menu.  Type e or q and tap enter to exit the '\$SRPTNM' command"
done
exit
}
[ -n "\${1:-}" ] && DALL="\${1//-}" && DALL="\${1:0:2}" || DALL=1
[ -n "\${1:-}" ] && [[ "\${1//-}" = [Aa]* ]] && { for AURHLPR in \$(for AURHLP in "\${!AURHLPRS[@]}"; do printf '%s\n' "\$AURHLP" ; done | sort -n) ; do printf '%s\\n' "Attempting to build \$SLCTSYRNG '\$AURHLPR'..." && { _ARHCMD_ ||: ; } ; done ; } && exit
[ -n "\${1:-}" ] && [[ "\${1//-}" = [Bb]* ]] && { [ -n "\${2:-}" ] && AURHLPR="\$2" && BLDPKG=0 && printf '%s\\n' "Attempting to build AUR package '\$AURHLPR'..." && _ARHCMD_ \$@ || _SLCTRHPR_ \$ARGS ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Cc]* ]] && AURHLPRSTG=\$(declare -p CANDY) && eval AURHLPRS="\${AURHLPRSTG#*=}" && SLCTSYRNG="candy" && _SLCTRHPR_ \$ARGS ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Ee]* ]] && TALL=0 && AURHLPRSTG=\$(declare -p GAME) && eval AURHLPRS="\${AURHLPRSTG#*=}" && SLCTSYRNG="extra" && _SLCTRHPR_ \$ARGS ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Gg]* ]] && TALL=0 && AURHLPRSTG=\$(declare -p GHCUPAURPKG) && eval AURHLPRS="\${AURHLPRSTG#*=}" && SLCTSYRNG="ghcup install" && _SLCTRHPR_ \$ARGS ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Ll]* ]] && AURHLPRSTG=\$(declare -p LIBGUESTFSP) && eval AURHLPRS="\${AURHLPRSTG#*=}" && SLCTSYRNG="libguestfs install" && _SLCTRHPR_ \$ARGS ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Mm]* ]] && AURHLPRSTG=\$(declare -p MAKEPKGS) && eval AURHLPRS="\${AURHLPRSTG#*=}" && SLCTSYRNG="make makepkgs" && _SLCTRHPR_ \$ARGS ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Rr]* ]] && { for AURHLPR in \$(for AURHLP in "\${!AURHLPRS[@]}"; do printf '%s\n' "\$AURHLP" ; done | sort -nr) ; do printf '%s\\n' "Attempting to build \$SLCTSYRNG '\$AURHLPR'..." && { _ARHCMD_ ||: ; } ; done ; } && exit ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Ss][Bb]* ]] && { for AURHLPR in \$(for AURHLP in "\${!AURHLPRSM[@]}"; do printf '%s\n' "\$AURHLP" ; done | sort -n) ; do printf '%s\\n' "Attempting to build \$SLCTSYRNG '\$AURHLPR'..." && { _ARHCMD_ ||: ; } ; done ; } && exit ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Ss][Cc]* ]] && TALL=0 && AURHLPRSTG=\$(declare -p SCREENSAVERS) && eval AURHLPRS="\${AURHLPRSTG#*=}" && SLCTSYRNG="screensavers build" && _SLCTRHPR_ \$ARGS ; }
[ -n "\${1:-}" ] && [[ "\${1:-}" = [Ss]* ]] && { am start -a android.intent.action.VIEW -d "https://aur.archlinux.org/packages?O=0&K=\${2:-AUR helper}" ; exit ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Tt][Cc]* ]] && AURHLPRSTG=\$(declare -p CANDY) && eval AURHLPRS="\${AURHLPRSTG#*=}" && SLCTSYRNG="candy" && { for AURHLPR in \$(for AURHLP in "\${!AURHLPRS[@]}"; do printf '%s\n' "\$AURHLP" ; done | sort -n) ; do printf '%s\\n' "Attempting to build \$SLCTSYRNG '\$AURHLPR'..." && { _ARHCMD_ ||: ; } ; done ; } ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Tt][Hh]* ]] && for TSTHRNSS in h b c e f g l m n s sb a r tc tm ts ; do "\$0" "\$TSTHRNSS" ||: ; done ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Tt][Mm]* ]] && AURHLPRSTG=\$(declare -p MAKEPKGS) && eval AURHLPRS="\${AURHLPRSTG#*=}" && SLCTSYRNG="makepkg" && { for AURHLPR in \$(for AURHLP in "\${!AURHLPRS[@]}"; do printf '%s\n' "\$AURHLP" ; done | sort -n) ; do printf '%s\\n' "Attempting to build \$SLCTSYRNG '\$AURHLPR'..." && { _ARHCMD_ ||: ; } ; done ; } && exit ; }
[ -n "\${1:-}" ] && { [[ "\${1//-}" = [Tt][Ss]* ]] && TALL=0 && AURHLPRSTG=\$(declare -p SCREENSAVERS) && eval AURHLPRS="\${AURHLPRSTG#*=}" && SLCTSYRNG="screensaver" && { for AURHLPR in \$(for AURHLP in "\${!AURHLPRS[@]}"; do printf '%s\n' "\$AURHLP" ; done | sort -n) ; do printf '%s\\n' "Attempting to build \$SLCTSYRNG '\$AURHLPR'..." && { _ARHCMD_ ||: ; } ; done ; } ; }
{ [ -z "\${1:-}" ] || [[ "\${1//-}" = [Nn]* ]] ; } && _SLCTRHPR_ || { printf '\\e[0;32m%s' "\$HLPSTG" ; exit ; }
## $INSTALLDIR$TMXRCHBNDR/makeaurhelpers FE
EOM
chmod 755 "$TMXRCHBNDS"/makeaurhelpers
}

_ADDmakeaurfakeroottcp_() {
_CFLHDR_ "$TMXRCHBNDS"/makeaurfakeroottcp "# build and install fakeroot-tcp"
_PRTRTHLP_ "$TMXRCHBNDS"/makeaurfakeroottcp
_DPTCHHLP_ "$TMXRCHBNDS"/makeaurfakeroottcp
cat >> "$TMXRCHBNDS"/makeaurfakeroottcp <<- EOM
_DOMAKEFAKEROOTTCP_() {
_PRTERROR_() {
printf "\\n\\e[1;31merror: \\e[1;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s), and run '\$STRNRG' again." && exit 104
}
[ ! -f "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" ] && patchmakepkg || printf "\\e[0;33m%s\\e[0m\\n" "Lock file "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" found;  Continuing..."
printf "%s\\n" "Preparing to build and install fakeroot-tcp with \${0##*/} version $VERSIONID: "
if { [ ! "\$(command -v automake)" ] || [ ! "\$(command -v git)" ] || [ ! "\$(command -v gcc -v)" ] || [ ! "\$(command -v libtool)" ] || [ ! "\$(command -v po4a)" ] ; }
then
pci automake base base-devel fakeroot git gcc libtool po4a || printf "\\n\\e[1;31mＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} SIGNAL:  \\e[7;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s) by running command 'pci automake base base-devel fakeroot git gcc go libtool po4a' as root user in a new Termux session.  You can do this without closing this session by running command \"$STARTBIN command 'pci automake base base-devel fakeroot git gcc go libtool po4a'\"in a new Termux session. Then return to this session and run '\$STRNRG' again."
fi
cd
[ -d fakeroot-tcp ] || gcl https://aur.archlinux.org/fakeroot-tcp.git
cd fakeroot-tcp || exit 196
printf "%s\\n" "Running command 'nice -n 20 makepkg -ACcfis --check --needed';  Attempting to build and install Arch Linux AUR package 'fakeroot-tcp' with '\${0##*/}' version $VERSIONID.  Please be patient..."
{ nice -n 20 makepkg -ACcfis --check --needed && libtool --finish /usr/lib/libfakeroot && :>"/run/lock/${INSTALLDIR##*/}/makeaurfakeroottcp.lock" ; } || _PRTERROR_
printf "%s\\n" "Building and installing fakeroot-tcp: DONE 🏁"
}
[ ! -f "/run/lock/${INSTALLDIR##*/}/makeaurfakeroottcp.lock" ] && _DOMAKEFAKEROOTTCP_ || printf "%s\\n" "Please remove file "/run/lock/${INSTALLDIR##*/}/makeaurfakeroottcp.lock" in order to rebuild fakeroot-tcp with \${0##*/} version $VERSIONID."
## $INSTALLDIR$TMXRCHBNDR/makeaurfakeroottcp FE
EOM
chmod 755 "$TMXRCHBNDS"/makeaurfakeroottcp
}

_ADDmakeaurghcuphs_() {
_CFLHDR_ "$TMXRCHBNDS"/makeaurghcuphs
_PRTRTHLP_ "$TMXRCHBNDS"/makeaurghcuphs
_DPTCHHLP_ "$TMXRCHBNDS"/makeaurghcuphs
cat >> "$TMXRCHBNDS"/makeaurghcuphs <<- EOM
[ -x /usr/bin/ghcup ] && printf "\\e[0;32m%s\\e[0m\\n" "The command 'ghcup' is already installed!  Please use the command 'ghcup':  Exiting..." && exit
[ -f /usr/lib/libnuma.so ] || { pc numactl || pci numactl ; } || { printf "\\n\\e[1;31mＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} SIGNAL:  \\e[7;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s) by running command 'pci numactl' as proot root user.  You might be able to bring this about without closing this session.  Please try running command: $STARTBIN command 'pci numactl' in a new Termux PRoot session.  This should install the neccessary packages to make 'ksh'.  Then return to this session, and run '\${0##*/}' again." && exit 120 ; }
pikaur ghcup-hs --noconfirm || { [ -f /usr/bin/pikaur ] || makeaurpikaur && pikaur ghcup-hs --noconfirm ; }
## $INSTALLDIR$TMXRCHBNDR/makeaurghcuphs FE
EOM
chmod 755 "$TMXRCHBNDS"/makeaurghcuphs
}

_ADDmakeaurrustup_() {
_CFLHDR_ "$TMXRCHBNDS"/makeaurrustup
_PRTRTHLP_ "$TMXRCHBNDS"/makeaurrustup
_DPTCHHLP_ "$TMXRCHBNDS"/makeaurrustup
cat >> "$TMXRCHBNDS"/makeaurrustup <<- EOM
[ -x /usr/bin/rustup ] && printf "\\e[0;32m%s\\e[0m\\n" "The command 'rustup' is already installed!  Please use the command 'rustup':  Exiting..." && exit
{ pc rustup --noconfirm || pci rustup --noconfirm ; } || yay rustup --noconfirm
## $INSTALLDIR$TMXRCHBNDR/rustup FE
EOM
chmod 755 "$TMXRCHBNDS"/makeaurrustup
}

_ADDmakeaurtllocalmgr_() {
_CFLHDR_ "$TMXRCHBNDS"/makeaurtllocalmgr
_PRTRTHLP_ "$TMXRCHBNDS"/makeaurtllocalmgr
_DPTCHHLP_ "$TMXRCHBNDS"/makeaurtllocalmgr
cat >> "$TMXRCHBNDS"/makeaurtllocalmgr <<- EOM
[ -x /usr/bin/tllocalmgr ] && printf "\\e[0;32m%s\\e[0m\\n" "The command 'tllocalmgr' is already installed!  Please use the command 'tllocalmgr':  Exiting..." && exit
yay tllocalmgr --noconfirm || { [ ! -x /usr/bin/yay ] && makeauryay && yay tllocalmgr --noconfirm ; }
## $INSTALLDIR$TMXRCHBNDR/makeaurtllocalmgr FE
EOM
chmod 755 "$TMXRCHBNDS"/makeaurtllocalmgr
}

_ADDmakeauryay_() {
_CFLHDR_ "$TMXRCHBNDS"/makeauryay "# build and install command yay; Contributors https://github.com/cb125 and https://github.com/SampsonCrowley"
_PRTRTHLP_ "$TMXRCHBNDS"/makeauryay
_DPTCHHLP_ "$TMXRCHBNDS"/makeauryay
cat >> "$TMXRCHBNDS"/makeauryay <<- EOM
_PRTERROR_() {
printf "\\n\\e[1;31mＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} SIGNAL:  \\e[1;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct thiserror the error(s) and/or warning(s), and run '\${0##*/}' again."
exit 100
}
[ -x /usr/bin/yay ] && printf "\\e[0;32m%s\\e[0m\\n" "The command 'yay' is already installed!  Please use the command 'yay':  Exiting..." && exit
_PRMAKE_() {
printf "\\e[1;32m==> \\e[1;37mRunning command \\e[1;32mnice -n 20 makepkg -ACcfis --check --needed --noconfirm\\e[1;37m...\\n"
}
printf "\\e[0;32m%s\\e[0m\\n" "Building and installing 'yay':"
if [[ -n "\${PREFIX:-}" ]]
then
: # pull requests are requested to automate install missing Termux packages
else
[ ! -f "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" ] && patchmakepkg
if { [ ! "\$(command -v fakeroot)" ] || [ ! "\$(command -v git)" ] ; }
then
pci base base-devel fakeroot gcc git || pci base base-devel fakeroot gcc git || { printf "\\n\\e[1;31mＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} SIGNAL:  \\e[7;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s);  The command 'pci base base-devel fakeroot gcc git go' can be run as proot root user in a new Termux session and might resolve this issue.  You might be able to do this without closing this session.  Please try running command: $STARTBIN command 'pci base base-devel fakeroot gcc git go' in a new Termux PRoot session.  Then return to this session, and run '\${0##*/}' again." && exit 120 ; }
fi
cd
[ -d yay-bin ] || gcl https://aur.archlinux.org/yay-bin.git
{ { cd yay-bin || exit 69 ; } && _PRMAKE_ && nice -n 20 makepkg -ACcfis --check --needed --noconfirm ; } || { printf "\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n" "ＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} SIGNAL:  " "The command 'nice -n 20 makepkg -ACcfis --check --needed --noconfirm' did not run as expected; " "EXITING..." && exit 124 ; }
printf "\\e[0;32m%s\\n%s\\n%s\\e[1;32m%s\\e[0m\\n" "Paths that can be followed after building 'yay' are 'yay cmatrix --noconfirm' which builds a matrix screensaver.  The commands 'yay pikaur|pikaur-git|tpac' build more AUR installers which can also be used to download AUR repositories and build packages like with 'yay' in your Android smartphone, tablet, wearable and more.  Did you know that 'android-studio' is available with the command 'yay android'?" "If you have trouble importing keys, this command 'gpg --keyserver keyserver.ubuntu.com --recv-keys 71A1D0EFCFEB6281FD0437C71A1D0EFCFEB6281F' might help.  Change the number to the number of the key being imported." "Building and installing yay: " "DONE 🏁"
fi
## $INSTALLDIR$TMXRCHBNDR/makeauryay FE
EOM
chmod 755 "$TMXRCHBNDS"/makeauryay
}

_PREPFILEFCTN_() { _PRTPATCHHELP_ "$3" && printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf '\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...\\n' \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" && exit 0" "_PRNTWAIT_() { printf '\\e[0;32mCommand \\e[1;32m%s\\e[0;32m is attempting to make and install command \\e[1;32m%s\\e[0;32m, %s.  Please be patient...\\n' \"'\${0##*/}'\" \"'$1'\"  \"$4\" ; }" "[ -x /usr/bin/\"$1\" ] && { printf '\\e[0;32m%s, command \\e[1;32m%s\\e[0;32m is installed!  Please use the command \\e[1;32m%s\\e[0;32m to continue.  ' \"${4^}\" \"'$1'\" \"'$1'\" && exit ; }" "_PRNTWAIT_ && [ -x /usr/bin/make ] || { pc base base-devel || pci base base-devel ; }" "{ [ -f /run/lock/\"${INSTALLDIR##*/}\"/patchmakepkg.lock ] || patchmakepkg ; } && ${5:-} cd && { [ -x \"$2\" ] || { gcl https://aur.archlinux.org/\"$2\" && printf '\\e[0;32mCommand \\e[1;32m%s\\e[0;32m is continuing to make and install command \\e[1;32m%s\\e[0;32m, %s;  Please be patient...\\n' \"'\${0##*/}'\" \"'$1'\"  \"$4\" ; } ; } && { cd \"$2\" || exit 69 ; } && makepkg -ACcfis --check --needed --noconfirm && \"$1\" -h ||:" "## $INSTALLDIR/$3 FE" >> "$3" ; }

_PREPFILEFCTN1_() { _PRTPATCHHELP_ "$3" && printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf '\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...\\n' \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in /${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" && exit 0" "_PRNTWAIT_() { printf '\\e[0;32mCommand \\e[1;32m%s\\e[0;32m is attempting to make and install Arch Linux package \\e[1;32m%s\\e[0;32m, %s;  Please be patient...\\n' \"'\${0##*/}'\" \"'$2'\"  \"$4\" ; }" "[ -e \"$1\" ] && { printf '\\e[0;32m%s, package \\e[1;32m%s\\e[0;32m is installed!  Nothing to do for command \\e[1;32m%s\\e[0;32m.  ' \"${4^}\" \"'$2'\" \"'\${0##*/}'\" && exit ; }" "_PRNTWAIT_ && [ -x /usr/bin/make ] || { pc base base-devel || pci base base-devel ; }" "{ [ -f /run/lock/\"${INSTALLDIR##*/}\"/patchmakepkg.lock ] || patchmakepkg ; } && ${5:-} cd && { [ -x \"$2\" ] || { gcl https://aur.archlinux.org/\"$2\" && printf '\\e[0;32mCommand \\e[1;32m%s\\e[0;32m is continuing to make and install command \\e[1;32m%s\\e[0;32m, %s;  Please be patient...\\n' \"'\${0##*/}'\" \"'$1'\"  \"$4\" ; } ; } && { cd \"$2\" || exit 69 ; } && makepkg -ACcfis --check --needed --noconfirm" "## $INSTALLDIR/$3 FE" >> "$3" ; }

_PREPFILEFCTNS0_() { _PRTPATCHHELP_ "$3" && printf "%s\\n%s\\n%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf '\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...\\n' \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" && exit 0" "{ [ -x /usr/bin/\"$1\" ] && printf '\\e[0;32mCommand \\e[1;32m%s\\e[0;32m is installed!  Please use the command \\e[1;32m%s\\e[0;32m to continue.  ' \"'$1'\" \"'$1'\" && exit ; }" "_PRNTWAIT_() { printf '\\e[0;32mCommand \\e[1;32m%s\\e[0;32m is attempting to make and install package \\e[1;32m%s\\e[0;32m;  Please be patient...\\n' \"'\${0##*/}'\" \"'$2'\" ; }" "[ -x /usr/bin/make ] || { pc base base-devel || pci base base-devel ; }" "[ -f /run/lock/\"${INSTALLDIR##*/}\"/patchmakepkg.lock ] || patchmakepkg" >> "$3" ; }

_PREPFILEFCTNS_() { printf "%s\\n" "{ { [ -e \"$1\" ] && printf '\\e[0;32mPackage \\e[1;32m%s\\e[0;32m is installed;  Continuing...  ' \"'$2'\"  ; } || { ${5:-} cd && { [ -e \"$1\" ] || gcl https://aur.archlinux.org/\"$2\" ; } && { cd \"$2\" || exit 69 ; } && _PRNTWAIT_ && makepkg -ACcfis --check --needed --noconfirm ; } ; }" >> "$3" ; }

_PREPFILEFTN0_() { _CFLHDR_ "$TMXRCHBNDS"/makeaur"$3" "# Command '$3' attempts to make and install command '$1' $4" && _PREPFILEFCTN_ "$1" "$2" "$TMXRCHBNDS/makeaur$3" "$4" "${5:-}" && chmod 755 "$TMXRCHBNDS"/makeaur"$3" ; }

_PREPFILEFTN1_() { _CFLHDR_ "$TMXRCHBNDS"/makeaur"$3" "# Command '$3' attempts to make and install Arch Linux package '$3' $4" && _PREPFILEFCTN1_ "$1" "$2" "$TMXRCHBNDS/makeaur$3" "$4" "${5:-}" && chmod 755 "$TMXRCHBNDS"/makeaur"$3" ; }

_ADDmakeaurpacaur_() { _PREPFILEFTN0_ pacaur pacaur pacaur "an AUR helper that minimizes user interaction" "{ [ -x /usr/bin/expac ] || pc expac --noconfirm || pci expac ; } && { makeauraclegit ||: ; } && { printf '\\e[0m[1/1]  ' ; makeaurjqgit ||: ; } &&" ; }

_ADDmakeaurjqgit_() { _PREPFILEFTN0_ jq jq-git jqgit "Command line JSON processor" "" ; }

_ADDmakeaurpipessh_() { _PREPFILEFTN0_ pipes.sh pipes.sh pipessh "Animated pipes terminal screensaver" "" ; }

_ADDmakeaurpyinstaller_() { _PREPFILEFTN0_ pyinstaller pyinstaller pyinstaller "" "makeaurpyinstallerhookscontrib && makeaurpythonaltgraph &&" ; }

_ADDmakeaurpyinstallerhookscontrib_() { _PREPFILEFTN1_ "/usr/lib/python3.10/site-packages/_pyinstaller_hooks_contrib/__init__.py" pyinstaller-hooks-contrib pyinstallerhookscontrib "" ; }

_ADDmakeaurpacaurgit_() { _PREPFILEFTN0_ pacaur pacaur-git pacaurgit "an AUR helper that minimizes user interaction" "{ [ -x /usr/bin/cmake ] || { pc cmake expac || pci cmake expac ; } ; } && { printf '\\e[0m[1/1]  ' ; makeauraclegit ||: ; } &&" ; }

_ADDmakeaurpbget_() { _PREPFILEFTN0_ pbget pbget pbget "retrieve PKGBUILD and local source files from Git, ABS and the AUR for makepkg" "{ [ -f /usr/lib/python3.10/site-packages/pyxdg-0.27-py3.10.egg-info/PKG-INFO ] || pc python-pyxdg ; } && { printf '\\e[0m[1/4]  ' ; makeaurpython3memoizedb ||: ; } && { printf '[2/4]  ' ; makeaurpython3xcgf ||: ; } && { printf '[2/4]  ' ; makeaurpython3xcpf ||: ; } && { printf '[3/4]  ' ; makeaurpm2ml ||: ; } && { printf '[4/4]  ' ; makeaurpython3aur ||: ; } &&" ; }

_ADDmakeaurpythonaltgraph_() { _PREPFILEFTN0_ python-altgraph python-altgraph pythonaltgraph "" ; }

_ADDmakeaurpython3colorsysplus_() { _PREPFILEFTN1_ "/usr/lib/python3.10/site-packages/colorsysplus/__init__.py" python3-colorsysplus python3colorsysplus "an extension of the standard colorsys module with support for CMYK, terminal colors, ANSI and more" ; }

_ADDmakeaurpython3memoizedb_() { _PREPFILEFTN1_ "/usr/lib/python3.10/site-packages/MemoizeDB.py" python3-memoizedb python3memoizedb "a generic data retrieval memoizer that uses an sqlite database to cache data" ; }

_ADDmakeaurpython3xcgf_() { _PREPFILEFTN1_ "/usr/lib/python3.10/site-packages/XCGF.py" python3-xcgf python3xcgf "Xyne's common Pacman functions, for internal use" ; }

_ADDmakeaurpython3xcpf_() { _PREPFILEFTN1_ "/usr/lib/python3.10/site-packages/XCPF/ArchPkg.py" python3-xcpf python3xcpf "Xyne's common Pacman functions, for internal use" "[ -f /run/lock/${INSTALLDIR##*/}/gpg1D1F0DC78F173680.lock ] || { printf '\\e[0m%s\\n' \"Command '\${0##*/}' is running command gpg --keyserver keyserver.ubuntu.com --recv-keys 1D1F0DC78F173680\" && gpg --keyserver keyserver.ubuntu.com --recv-keys 1D1F0DC78F173680 && :>/run/lock/${INSTALLDIR##*/}/gpg1D1F0DC78F173680.lock ; } &&" ; }

_ADDmakeaurpm2ml_() { _PREPFILEFTN1_ "/usr/lib/python3.10/site-packages/pm2ml.py" pm2ml pm2ml "generate metalinks for downloading Pacman packages and databases" ; }

_ADDmakeaurpython3aur_() { _PREPFILEFTN1_ "/usr/lib/python3.10/site-packages/AUR/AurPkg.py" python3-aur python3aur "AUR-related modules and helper utilities (aurploader, aurquery, aurtomatic" ; }

_ADDmakeaurpackagequery_() { _PREPFILEFTN0_  package-query package-query packagequery "Query ALPM and AUR" "{ [ -x /usr/bin/wget ] || { pc wget || pci wget ; } ; } &&" ; }

_ADDmakeauraclegit_() { _PREPFILEFTN0_ aur auracle-git aclegit "a flexible client for the AUR" ; }
_ADDmakeaurto_() { _PREPFILEFTN0_ aurto aurto to "an AUR tool for managing an auto-updating local 'aurto' package repositories using aurutils" ; }
_ADDmakeaurutils_() { _PREPFILEFTN0_ aur aurutils utils "an AUR helper for the arch user repository" ; }
_ADDmakeaurutilsgit_() { _PREPFILEFTN0_ aur aurutils-git utilsgit "an AUR helper for the arch user repository (git version)" ; }
_ADDmakeaurbauerbill_() { _PREPFILEFTN0_ bauerbill bauerbill bauerbill "an extension of Powerpill with AUR and ABS support" ; }
_ADDmakeaurghcuphsdep_() { # depreciated
_PREPFILEFTN0_ ghcup ghcup-hs-bin ghcuphs "the Haskell language ghcup-hs installer" "{ [ -f /usr/lib/libnuma.so ] || { pc numactl || pci numactl ; } &&" ; }
_ADDmakeaurpakku_() { _PREPFILEFTN0_ pakku pakku pakku "a Pacman wrapper and AUR helper with a Pacman-like user interface" "{ [ -e /usr/lib/python3.10/site-packages/asciidoc/utils.py ] || { pc asciidoc || pci asciidoc ; } ; } &&" ; }
_ADDmakeaurpakkugit_() { _PREPFILEFTN0_ pakku pakku-git pakkugit "a Pacman wrapper and AUR helper with a Pacman-like user interface (git version)" "{ [ -e /usr/lib/python3.10/site-packages/asciidoc/utils.py ] || { pc asciidoc || pci asciidoc ; } ; } &&" ; }
_ADDmakeaurpakkugui_() { _PREPFILEFTN0_ pakku pakku-gui pakkugui "a GTK frontend for pakku" "{ [ -e /usr/lib/python3.10/site-packages/asciidoc/utils.py ] || { pc asciidoc || pci asciidoc ; } ; } &&" ; }
_ADDmakeaurpakkuguigit_() { _PREPFILEFTN0_ pakku pakku-gui-git pakkuguigit "a GTK frontend for pakku (git version)" "{ [ -e /usr/lib/python3.10/site-packages/asciidoc/utils.py ] || { pc asciidoc || pci asciidoc ; } ; } &&" ; }
_ADDmakeaurparu_() { _PREPFILEFTN0_ paru paru paru "a feature packed AUR helper" ; }
_ADDmakeaurparubin_() { _PREPFILEFTN0_ paru paru-bin parubin  "a feature packed AUR helper" ; }
_ADDmakeaurparugit_() { _PREPFILEFTN0_ paru paru-git parugit  "a feature packed AUR helper (git version)" ; }
_ADDmakeaurparuz_() { _PREPFILEFTN0_ paruz paruz paruz "a fzf terminal UI for paru or pacman" ; }
_ADDmakeaurpikaur_() { _PREPFILEFTN0_ pikaur pikaur pikaur "an AUR helper which asks all questions before installing/building. Inspired by pacaur, yaourt and yay" ; }
_ADDmakeaurpikaurgit_() { _PREPFILEFTN0_ pikaur pikaur-git pikaurgit "an AUR helper which asks all questions before installing/building. Inspired by pacaur, yaourt and yay (git version)" ; }
_ADDmakeaurpkgbuilder_() { _PREPFILEFTN0_ pkgbuilder pkgbuilder pkgbuilder "a Python AUR helper/library" ; }
_ADDmakeaurpkgbuildergit_() { _PREPFILEFTN0_ pkgbuilder pkgbuilder-git pkgbuildergit "a Python AUR helper/library (git version)" ; }
_ADDmakeaurpopularpackages_() { _PREPFILEFTN0_ popular-packages popular-packages popularpackages "which lists popular packages not (yet) installed" ; }
_ADDmakeaurpowerpill_() { _PREPFILEFTN0_ powerpill powerpill powerpill "pacman wrapper for faster downloads" "{ [ -e /usr/share/doc/fmt/index.html ] || { pc fmt || pci fmt ; } ; } &&" ; }
_ADDmakeaurpuyo_() { _PREPFILEFTN0_ puyo puyo puyo "an assistant for managing packages on Arch Linux" "makeauryay &&" ; }
_ADDmakeaurrepoctl_() { _PREPFILEFTN0_ repoctl repoctl repoctl "an AUR helper that also simplifies managing local Pacman repositories" ; }
_ADDmakeaurrepoctlgit_() { _PREPFILEFTN0_ repoctl repoctl-git repoctlgit "an AUR helper that also simplifies managing local Pacman repositories (development version)" ; }
_ADDmakeaurrepofish_() { _PREPFILEFTN0_ repofish repofish repofish "that my friends told me to make available this script I wrote to manage my local archlinux repo and AUR packages, so here it is" ; }
_ADDmakeaurshellcheckbin_() { _PREPFILEFTN0_ shellcheck shellcheck-bin shellcheckbin "a shell script analysis tool (binary release, static)" ; }
_ADDmakeaurshellcheckgit_() { _PREPFILEFTN0_ shellcheck shellcheck-git shellcheckgit "a shell script analysis tool (latest git commit)" ; }
_ADDmakeaurshellcheckgitstatic_() { _PREPFILEFTN0_ shellcheck shellcheck-git-static shellcheckgitstatic "a shellcheck-static, but using the latest-commit builds maintained by the author" ; }
_ADDmakeaurtrizen_() { _PREPFILEFTN0_ trizen trizen trizen "the Trizen AUR Package Manager, a lightweight pacman wrapper and AUR helper" ; }
_ADDmakeaurtrizengit_() { _PREPFILEFTN0_ trizen trizen-git trizengit "the Trizen AUR Package Manager, a lightweight pacman wrapper and AUR helper (git version)" ; }
_ADDmakeaurtpac_() { _PREPFILEFTN0_ tpac tpac tpac  "a trizen wrapper to mimic yaourt's search feature" ; }
_ADDmakeauryaah_() { _PREPFILEFTN0_ yaah yaah yaah "Yet Another AUR Helper" ; }
_ADDmakeaurzigzag_() { _PREPFILEFTN0_ zig-zag zig-zag zig-zag "a programming language prioritizing robustness, optimality, and clarity" ; }

_ADDmakefakeroottcp_() {
_CFLHDR_ "$TMXRCHBNDS"/makefakeroottcp "# build and install fakeroot-tcp"
_PRTRTHLP_ "$TMXRCHBNDS"/makefakeroottcp
_DPTCHHLP_ "$TMXRCHBNDS"/makefakeroottcp
printf "\\n%s\\n" "makeaurhelpers build fakeroot-tcp" "## $INSTALLDIR$TMXRCHBNDR/makefakeroottcp FE" >> "$TMXRCHBNDS"/makefakeroottcp
chmod 755 "$TMXRCHBNDS"/makefakeroottcp
}

_ADDmakeksh_() {
_CFLHDR_ "$TMXRCHBNDS"/makeksh "# build and install the ksh shell; Inspired by https://github.com/termux/termux-api/issues/436"
_PRTRTHLP_ "$TMXRCHBNDS"/makeksh
_DPTCHHLP_ "$TMXRCHBNDS"/makeksh
cat >> "$TMXRCHBNDS"/makeksh <<- EOM
_PRTERROR_() {
printf "\\n\\e[1;31merror: \\e[1;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s), and run '\$STRNRG' again."
exit 100
}
printf "\\e[0;32m%s\\e[0m\\n" "Building and installing 'ksh':"
if [[ -n "\${PREFIX:-}" ]]
then
: # pull requests are requested to automate install missing Termux packages
else
if { [ ! -f /usr/bin/make ] || [ ! -f /usr/bin/git ] || [ ! -f /usr/bin/bison ] ; }
then
pc bison base base-devel gcc git || pci bison base base-devel gcc git || { printf "\\n\\e[1;31mＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} SIGNAL:  \\e[7;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s) by running command 'pci bison base base-devel gcc git' as proot root user.  You might be able to bring this about without closing this session.  Please try running command: $STARTBIN command 'pci base base-devel gcc git' in a new Termux PRoot session.  This should install the neccessary packages to make 'ksh'.  Then return to this session, and run '\${0##*/}' again." && exit 120 ; }
fi
cd
[ -d ksh ] || gcl https://github.com/ksh-community/ksh
{ { cd ksh || exit 69 ; } && nice -n 20 ./bin/package make ; } || { printf "\\e[1;31m%s\\e[1;37m%s\\e[1;31mEXITING...\\n" "ＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} SIGNAL:  " "The commands 'cd ksh && nice -n 20 ./bin/package make' did not run as expected; " && exit 124 ; }
find "\$HOME"/ksh/arch/*/bin -type f -executable ||: # printf "\\e[1;31m%s\\e[1;37m%s\\n" "ＴｅｒｍｕｘＡｒｃｈ \${SRPTNM^^} SIGNAL:  " "The command 'find arch/*/bin -type f -executable' did not run as expected; CONTINUING..." && _PRTERROR_
fi
## $INSTALLDIR$TMXRCHBNDR/makeksh FE
EOM
chmod 755 "$TMXRCHBNDS"/makeksh
}

_ADDmakeyay_() {
_CFLHDR_ "$TMXRCHBNDS"/makeyay "# build and install command yay"
_PRTRTHLP_ "$TMXRCHBNDS"/makeyay
_DPTCHHLP_ "$TMXRCHBNDS"/makeyay
printf "\\n%s\\n" "makeaurhelpers build yay-bin" "## $INSTALLDIR$TMXRCHBNDR/makeyay FE" >> "$TMXRCHBNDS"/makeyay
chmod 755 "$TMXRCHBNDS"/makeyay
}

_ADDmemav_() {
_CFLHDR_ "$TMXRCHBNDS"/memav
_PRTRTHLP_ "$TMXRCHBNDS"/memav
printf "%s\\n%s\\n" "grep -i available /proc/meminfo" "## $INSTALLDIR$TMXRCHBNDR/memav FE" >> "$TMXRCHBNDS"/memav
chmod 755 "$TMXRCHBNDS"/memav
}

_ADDmemfree_() {
_CFLHDR_ "$TMXRCHBNDS"/memfree
_PRTRTHLP_ "$TMXRCHBNDS"/memfree
printf "%s\\n%s\\n" "grep -i free /proc/meminfo" "## $INSTALLDIR$TMXRCHBNDR/memfree FE" >> "$TMXRCHBNDS"/memfree
chmod 755 "$TMXRCHBNDS"/memfree
}

_ADDmeminfo_() {
_CFLHDR_ "$TMXRCHBNDS"/meminfo
_PRTRTHLP_ "$TMXRCHBNDS"/meminfo
printf "%s\\n%s\\n" "cat /proc/meminfo" "## $INSTALLDIR$TMXRCHBNDR/meminfo FE" >> "$TMXRCHBNDS"/meminfo
chmod 755 "$TMXRCHBNDS"/meminfo
}

_ADDmemmem_() {
_CFLHDR_ "$TMXRCHBNDS"/memmem
_PRTRTHLP_ "$TMXRCHBNDS"/memmem
printf "%s\\n%s\\n" "grep -i mem /proc/meminfo" "## $INSTALLDIR$TMXRCHBNDR/memmem FE" >> "$TMXRCHBNDS"/memmem
chmod 755 "$TMXRCHBNDS"/memmem
}

_ADDmemtot_() {
_CFLHDR_ "$TMXRCHBNDS"/memtot
_PRTRTHLP_ "$TMXRCHBNDS"/memtot
printf "%s\\n%s\\n" "grep -i total /proc/meminfo" "## $INSTALLDIR$TMXRCHBNDR/memtot FE" >> "$TMXRCHBNDS"/memtot
chmod 755 "$TMXRCHBNDS"/memtot
}

_ADDmota_() {
cat > etc/mota <<- EOM
printf "\\n\\e[1;34m%s\\n%s\\e[0;34m%s\\n\\e[1;34m%s\\e[0;34m%s\\n\\e[1;34m%s\\e[0;34m%s\\n\\e[1;34m%s\\e[0;34m%s\\n\\n\\e[1;34m%s\\e[0m%s\\n\\e[1;34m%s\\e[0m%s\\n\\e[1;34m%s\\e[0m%s\\n\\e[1;34m%s\\e[0;34m%s\\e[1;34m%s\\e[0;34m%s\\n\\e[1;34m%s\\e[0m%s\\n\\e[1;34m%s\\e[0m%s\\n\\n" "Welcome to Arch Linux in Termux PRoot!" "Install a package: " "pacman -S package" "More  information: " "pacman -[D|F|Q|R|S|T|U]h" "Search   packages: " "pacman -Ss query" "Upgrade  packages: " "pacman -Syu" "Chat:	" "wiki.termux.com/wiki/Community" "Discus:	" "github.com/login/repo/discussions" "GitHub:	" "$MOTTECGIT" "Help:	" "help man " "and " "info man" "IRC:	" "$MOTTECIRC" "Rev:	" "github.com/login/repo/releases"
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
printf "\\n\\e[1;34mPlease share your Arch Linux in Termux PRoot experience!\\n\\n\\e[1;34mChat:	\\e[0mwiki.termux.com/wiki/Community\\n\\e[1;34mDiscus:	\\e[0mgithub.com/login/repo/discussions\\n\\e[1;34mGitHub:	\\e[0m%s\\n\\e[1;34mHelp:	\\e[0;34mhelp man \\e[1;34mand \\e[0;34minfo man\\n\\e[1;34mIRC:	\\e[0m%s\\n\\e[1;34mRev:	\\e[0mgithub.com/login/repo/releases\\n\\n\\e[0m" "$MOTTECGIT" "$MOTTECIRC"
EOM
}

_ADDopen4root_() {
_CFLHDR_ "$TMXRCHBNDS"/open4root "# Open programs in '$TMXRCHBNDR' for root login."
cat >> "$TMXRCHBNDS"/open4root <<- EOM
sed -i 's/UID\" = 0/UID\" = -1/g' $TMXRCHBNDR/* ||:
sed -i 's/EUID == 0/EUID == -1/g' $TMXRCHBNDR/* ||:
## $INSTALLDIR$TMXRCHBNDR/open4root FE
EOM
chmod 755 "$TMXRCHBNDS"/open4root
}

_ADDorcaconf_() {
_CFLHDR_ "$TMXRCHBNDS"/orcaconf "# Contributor https://github.com/JanuszChmiel" "# Reference https://github.com/SDRausty/termux-archlinux/issues/66 Let us expand setupTermuxArch so users can install Orca screen reader (assistive technology) and also have VNC support added easily."
cat >> "$TMXRCHBNDS"/orcaconf <<- EOM
[[ -f "/run/lock/${INSTALLDIR##*/}/orcaconf.lock" ]] && printf "%s\\n" "Already configured orca: DONE 🏁" && exit
_INSTALLORCACONF_() {
[[ ! -f "/run/lock/${INSTALLDIR##*/}/orcaconfinstall.lock" ]] && { nice -n 18 pci espeak-ng mate mate-extra orca pulseaudio-alsa tigervnc || nice -n 18 pci espeak-ng mate mate-extra orca pulseaudio-alsa tigervnc ; } && :>"/run/lock/${INSTALLDIR##*/}/orcaconfinstall.lock" || printf "%s\\n" "_INSTALLORCACONF_ \${0##*/} did not completed as expected; Continuing..."
}
_INSTALLORCACONF_ || _INSTALLORCACONF_ || { printf "%s\\n" "_INSTALLORCACONF_ \${0##*/} did not completed as expected.  Please check for errors and run \${0##*/} again." && exit ; }
csystemctl || printf "\\e[1;31m%s\\e[0m\\n" "command 'csystemctl' did not completed as expected"
[[ ! -f "/run/lock/${INSTALLDIR##*/}/orcaconf.lock" ]] && :>"/run/lock/${INSTALLDIR##*/}/orcaconf.lock"
orcarun || printf "\\e[1;31m%s\\e[0m\\n" "command 'orcarun' did not completed as expected"
## $INSTALLDIR$TMXRCHBNDR/orcaconf FE
EOM
chmod 755 "$TMXRCHBNDS"/orcaconf
_ADDorcarun_() {
_CFLHDR_ "$TMXRCHBNDS"/orcarun "# Contributor https://github.com/JanuszChmiel " "# Reference https://github.com/SDRausty/termux-archlinux/issues/66 Let's expand setupTermuxArch so users can install Orca screen reader (assistive technology) and also have VNC support added easily."
cat >> "$TMXRCHBNDS"/orcarun <<- EOM
if ! command Xvnc
then
orcaconf
else
Xvnc -localhost -geometry 1024x768 -depth 24 -SecurityTypes=None
fi
## $INSTALLDIR$TMXRCHBNDR/orcarun FE
EOM
chmod 755 "$TMXRCHBNDS"/orcarun
}
_ADDorcarun_
}

_ADDpatchmakepkg_() {
_CFLHDR_ "$TMXRCHBNDS"/patchmakepkg "# patch makepkg;  Contributor https://github.com/petkar"
_PRTPATCHHELP_ "$TMXRCHBNDS"/patchmakepkg
cat >> "$TMXRCHBNDS"/patchmakepkg <<- EOM
[ -f "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" ] && printf "%s\\n" "Nothing to do;  Already patched command 'makepkg': DONE 🏁" && exit
printf "Patching makepkg: \\n"
SDATE="\$(date +%s)"
BKPDIR="$INSTALLDIR/var/backups/${INSTALLDIR##*/}/"
[ -d "\$BKPDIR" ] || mkdir -p "\$BKPDIR"
cp /bin/makepkg "\$BKPDIR/makepkg.\$SDATE.bkp"
if [ "\$(awk 'FNR==232{print \$0}' /bin/makepkg)" != "#" ]
then
sed -ie 's/fakeroot -- bash/bash/g' /bin/makepkg
sed -ir 's/\$(fakeroot -v)/fakeroot -v/g' /bin/makepkg
# sed append to beginning of lines
sed -ie 240,241's/.*/# &/' /bin/makepkg
sed -ie 1195,1199's/.*/# &/' /bin/makepkg
fi
# copy makepkg to $TMXRCHBNDR to update proof it (fail safe measure)
cp /bin/makepkg $TMXRCHBNDR/makepkg
# create lock file to update proof patchmakepkg
:>"/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock"
printf "Patching makepkg: DONE 🏁\\n"
## $INSTALLDIR$TMXRCHBNDR/patchmakepkg FE
EOM
chmod 755 "$TMXRCHBNDS"/patchmakepkg
}

_ADDpacmandblock_() {
_CFLHDR_ "$TMXRCHBNDS"/pacmandblock "# When using the alternate elogin or euser option to login with $STARTBIN as user 'pacman' does not behave as expected;  Hence 'pacman' is blocked when the alternate login feature is used."
cat >> "$TMXRCHBNDS"/pacmandblock <<- EOM
LOCKFILE="/var/lib/pacman/db.lck"
if [ ! -f "\$LOCKFILE" ]
then
printf "%s" "Creating file \$LOCKFILE: "
:>"\$LOCKFILE"
printf "%s\\n" "DONE"
elif [ -f "\$LOCKFILE" ]
then
printf "%s" "Deleting file \$LOCKFILE: "
rm -f "\$LOCKFILE"
printf "%s\\n" "DONE"
fi
## $INSTALLDIR$TMXRCHBNDR/pacmandblock FE
EOM
chmod 755 "$TMXRCHBNDS"/pacmandblock
}

_ADDpc_() {
_CFLHDR_ "$TMXRCHBNDS"/pc "# pacman install packages wrapper without system update"
cat >> "$TMXRCHBNDS"/pc <<- EOM
declare -g ARGS="\$@"
_PRINTTAIL_() {
printf "\\e[0;32m%s \\e[1;32m%s \\e[0;32m%s\\e[1;34m: \\e[1;32m%s\\e[0m 🏁  \\n\\n\\e[0m" "TermuxArch command" "\$STRNRG" "version \$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s:DONE 📱 \007' "\$STRNRG"
}
_TRPET_() {
printf "\\e[?25h\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\$ARGS"
}
trap _TRPET_ EXIT
## pc begin ####################################################################
printf '\033]2;  🔑 TermuxArch %s 📲 \007' "\$STRNRG"
printf "\\e[1;32m==> \\e[1;37mRunning TermuxArch command \\e[1;32m%s \\e[0;32m%s\\e[1;37m...\\n" "\$STRNRG" "version \$VERSIONID"
[ "\$UID" -eq 0 ] && SUDOCONF="" || SUDOCONF="sudo"
if [[ -z "\${1:-}" ]]
then
printf "\\e[1;31m%s \\e[0m\\n" "Run command '\${0##*/}' with at least one argument;  Exiting..."
else
nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -S "\$@" || nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -S "\$@"
fi
## $INSTALLDIR$TMXRCHBNDR/pc FE
EOM
chmod 755 "$TMXRCHBNDS"/pc
}

_ADDpci_() {
_CFLHDR_ "$TMXRCHBNDS"/pci "# pacman install packages wrapper with system update"
cat >> "$TMXRCHBNDS"/pci <<- EOM
declare ARGS="\$@"
_PRINTTAIL_() {
printf "\\e[0;32m%s \\e[1;32m%s \\e[0;32m%s\\e[1;34m: \\e[1;32m%s\\e[0m 🏁  \\n\\n\\e[0m" "TermuxArch command" "\$STRNRG" "version \$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s:DONE 📱 \007' "\$STRNRG"
}
_TRPET_() {
printf "\\e[?25h\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\$ARGS"
}
trap _TRPET_ EXIT
## pci begin ###################################################################
printf '\033]2;  🔑 TermuxArch %s 📲 \007' "\$STRNRG"
printf "\\e[1;32m==> \\e[1;37mRunning TermuxArch command \\e[1;32m%s \\e[0;32m%s\\e[1;37m...\\n" "\$STRNRG" "version \$VERSIONID"
[ "\$UID" -eq 0 ] && SUDOCONF="" || SUDOCONF="sudo"
nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Syu "\$@" || nice -n 20 \$SUDOCONF pacman --needed --noconfirm --color=always -Su "\$@"
## $INSTALLDIR$TMXRCHBNDR/pci FE
EOM
chmod 755 "$TMXRCHBNDS"/pci
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
_CFLHDR_ "$TMXRCHBNDS"/pinghelp
_PRTRTHLP_ "$TMXRCHBNDS"/pinghelp
printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "_PRTSYG_() { printf '%s\\n' \"Signal received:  Continuing...\" ; }" "ARGONE=\"\${1-www.github.com}\"" "ISCOMCAR=\"\$(command -v ping)\"" "printf '%s\\n' \"\$ISCOMCAR\"" "{ SHUFREST=\"\$(shuf -n 1 -i 2-8)\" && printf '\\n%s\\n' \"Running command '/system/bin/ping -c 2 -i \$SHUFREST \$ARGONE':\" && /system/bin/ping -c 2 -i \"\$SHUFREST\" \"\$ARGONE\" ; } || _PRTSYG_" "{ SHUFREST=\"\$(shuf -n 1 -i 2-8)\" && printf '\\n%s\\n' \"Running command '$PREFIX/bin/ping -c 2 -i \$SHUFREST \$ARGONE':\" && $PREFIX/bin/ping -c 2 -i \"\$SHUFREST\" \"\$ARGONE\" ; } || _PRTSYG_" "{ SHUFREST=\"\$(shuf -n 1 -i 2-8)\" && printf '\\n%s\\n' \"Running command '/bin/ping -c 2 -i \$SHUFREST \$ARGONE':\" && /bin/ping -c 2 -i \"\$SHUFREST\" \"\$ARGONE\" ; } || _PRTSYG_" "{ SHUFREST=\"\$(shuf -n 1 -i 2-8)\" && printf '\\n%s\\n' \"Running command '/usr/bin/ping -c 2 -i \$SHUFREST \$ARGONE':\" && /usr/bin/ping -c 2 -i \"\$SHUFREST\" \"\$ARGONE\" ; } || _PRTSYG_" "{ printf '\\n%s\\n' \"Running command 'curl -I \$ARGONE 80':\" && curl -I \"\$ARGONE\" ; } || _PRTSYG_" "{ printf '\\n%s\\n' \"Running command 'dig \$ARGONE':\" && dig \"\$ARGONE\" ; } || _PRTSYG_" "{ printf '\\n%s\\n' \"Running command 'telnet \$ARGONE 79':\" && telnet \"\$ARGONE\" 80 ; } || _PRTSYG_" >> "$TMXRCHBNDS"/pinghelp
printf "%s\\n%s\\n" "printf '\\n%s\\n' \"These packages 'dnsutils', 'lynx', 'net-tools' and 'strace' can be helpful in diagnosing network issues.  The 'dig' and 'telnet' command can assist as well.\"" "## $INSTALLDIR$TMXRCHBNDR/pinghelp FE" >> "$TMXRCHBNDS"/pinghelp
chmod 755 "$TMXRCHBNDS"/pinghelp
}

_ADDresolvconf_() {
[ -d run/systemd/resolve ] || mkdir -p run/systemd/resolve
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
[ -d etc ] || mkdir -p etc
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

_ADDstriphtmlcodefromfile_() { _CFLHDR_ "$TMXRCHBNDS"/striphtmlcodefromfile "#strip html code from file" ; printf "%s\\n%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in $INSTALLDIR; the command '$STARTBIN command addauser username' can create user accounts in $INSTALLDIR from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" && exit" "[ -x \"\$(command -v sed)\" ] || { pc sed || pci sed ; }" "sed -n '/^$/!{s/<[^>]*>//g;p;}' \"\$@\"" "## $INSTALLDIR$TMXRCHBNDR/striphtmlcodefromfile FE" >> "$TMXRCHBNDS"/striphtmlcodefromfile ; chmod 755 "$TMXRCHBNDS"/striphtmlcodefromfile ; }

_ADDt_() {
_CFLHDR_ "$TMXRCHBNDS"/t
printf "%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" && exit" >> "$TMXRCHBNDS"/t
printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "if [ -x /usr/bin/tree ] || [ -x \"\${PREFIX:-}\"/bin/tree ]" "then" "tree \"\$@\"" "else" "{ pc tree || pci tree ; } && tree \"\$@\"" "fi" "## $INSTALLDIR$TMXRCHBNDR/t FE" >> "$TMXRCHBNDS"/t
chmod 755 "$TMXRCHBNDS"/t
}

_ADDtlmgrinstaller_() {
_CFLHDR_ "$TMXRCHBNDS"/tlmgrinstaller "# install TexLive installer"
printf "%s\\n" "[ -d /usr/local/texlive ] || mkdir -p /usr/local/texlive" >> "$TMXRCHBNDS"/tlmgrinstaller
printf "%s\\n" "_GETINSTALLER_() { { [ -d /usr/local/texlive/install-tl ] || mkdir -p /usr/local/texlive/install-tl ; } && { { [ -f /usr/local/texlive/install-tl/install-tl.zip ] && [ -f /usr/local/texlive/install-tl/install-tl.zip.sha512 ] || wget -c -P /usr/local/texlive/install-tl https://mirror.math.princeton.edu/pub/CTAN/systems/texlive/tlnet/install-tl.zip.sha512 https://mirror.math.princeton.edu/pub/CTAN/systems/texlive/tlnet/install-tl.zip ; } && { cd /usr/local/texlive/install-tl || exit 69 ; } && { sha512sum -c install-tl.zip.sha512 || { rm -f install-tl.zip* && printf '%s\\n' \"Files were corrupt and were deleted;  Please try again.  Exiting...  \" && exit 189 ; } ; } && unzip -n install-tl.zip ; } && { CDDIR=\"\$(find . -maxdepth 1 | tail -n 1)\" && { cd \"\$CDDIR\" || exit 69 ; } && printf '%s\\n' \"\$PWD\" && ls && printf '%s\\n' \"Please be patient.  Command '\${0##*/}' continuing...\" && perl install-tl && printf '%s\\n' \"\$PWD\" | tee dir.pth > dir.tmp ; } ; }" >> "$TMXRCHBNDS"/tlmgrinstaller
printf "%s\\n" "_PRINTHELP_() { printf '\\n%s\\n' \"The command '${0##*/} re' adds TEX environment variables automatically to BASH init files in the Arch Linux in Termux PRoot environment.  Please exit this shell and login again.  If logging in again does not add TEX environment variables, then please run command '${0##*/} re' in order to add TEX environment variables to the BASH init files in Termux PRoot.  Command '${0##*/} h' has more information.  \" ; }" >> "$TMXRCHBNDS"/tlmgrinstaller
printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "printf '%s\\n' \"Command '\${0##*/}';  Begun...  \"" "{ command -v tlmgr && printf '%s\\n' \"The command 'tlmgr' is installed;  Continuing...  \" ; } || if [ -x /usr/bin/perl ] && [ -x /usr/bin/wget ] && [ -x /usr/bin/unzip ]" "then" "_GETINSTALLER_" "else" "{ { pc perl wget unzip || pci perl wget unzip ; } || { pkg i perl wget unzip || { pkg up && pkg i perl wget unzip ; } ; } ; } && _GETINSTALLER_" "fi" "_PRINTHELP_" >> "$TMXRCHBNDS"/tlmgrinstaller
printf "%s\\n" "INSDIR=\"\$(find /usr/local/texlive/install-tl/ -maxdepth 1 -type d | tail -n 1)\"" >> "$TMXRCHBNDS"/tlmgrinstaller
printf "%s\\n" "[ -d /usr/local/texlive/install-tl ] && { [ -f \"\$INSDIR\"/dir.pth ] && [ -f \"\$INSDIR\"/dir.tmp ] && rm -f \"\$INSDIR\"/dir.tmp || printf '\\n%s\\n' \"Running command '\$INSDIR/install-tl';  Continuing...  \" && \"\$INSDIR\"/install-tl && exit 0 ; }" >> "$TMXRCHBNDS"/tlmgrinstaller
printf "%s\\n" "## $INSTALLDIR$TMXRCHBNDR/tlmgrinstaller FE" >> "$TMXRCHBNDS"/tlmgrinstaller
chmod 755 "$TMXRCHBNDS"/tlmgrinstaller
}

_ADDtop_() {
_CFLHDR_ "$TMXRCHBNDS"/top
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" && exit" "{ [ -f /system/bin/top ] && /system/bin/top && exit ; } || { printf \"%s\\n\" \"The command '\${0##*/}' is currently disabled in Termux PRoot.   Please open an issue and PR should a better resolution for '\${0##*/}' in Termux PRoot be found.  Running command 'ps aux':\" && ps aux && printf \"%s\\n\" \"Running command 'nproc':\" && nproc && printf \"%s\\n\" \"Running command 'nproc --all':\" && nproc --all && ps aux | cut -d:  -f2- | grep -v TIME | grep -v '\-bash' | grep -v cut | grep -v ps\ aux | grep -v sort | cut -c 4- | sort && exit ; }" "## $INSTALLDIR$TMXRCHBNDR/top FE" >> "$TMXRCHBNDS"/top
chmod 755 "$TMXRCHBNDS"/top
}

_ADDtimings_() {
_CFLHDR_ "$TMXRCHBNDS"/timings "# Developed at [Terminal output speed issues](https://github.com/termux/termux-app/issues/603) Contributor evg-zhabotinsky"
cat >> "$TMXRCHBNDS"/timings <<- EOM
dd if=/dev/urandom bs=1K count=100 | hexdump -C >500KBfile.txt
for TIMING in 0 1 2 3; do
printf '%s\n' \$TIMING
sleep 1
time nice -n 20 cat 500KBfile.txt
sleep 2
done
rm -f 500KBfile.txt
## $INSTALLDIR$TMXRCHBNDR/timings FE
EOM
chmod 755 "$TMXRCHBNDS"/timings
}

_ADDthstartarch_() {
_CFLHDR_ "$TMXRCHBNDS"/th"$STARTBIN"
_PRTRTHLP_ "$TMXRCHBNDS"/th"$STARTBIN"
cat >> "$TMXRCHBNDS"/th"$STARTBIN" <<- EOM
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
## $INSTALLDIR$TMXRCHBNDR/th$STARTBIN FE
EOM
chmod 755 "$TMXRCHBNDS"/th"$STARTBIN"
}

_ADDtools_() {	# developing implementaion; working system tools that work can be added to array PRFXTOLS
if [[ -z "${EDO01LCR:-}" ]]
then
if [[ "$CPUABI" = "$CPUABIX86" ]]
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
cp "$WHICHSTOOL" "$INSTALLDIR$TMXRCHBNDR/$STOOL" && printf "%s\\n" "cp $WHICHSTOOL $INSTALLDIR$TMXRCHBNDR/$STOOL: continuing..."
}
for STOOL in ${PRFXTOLS[@]}
do
WHICHSTOOL="$(command -v "$STOOL" || printf "1")"
if [ ! -f "$INSTALLDIR$TMXRCHBNDR/$STOOL" ]
then
_CPSTOOL_
else
if [ "$WHICHSTOOL" != 1 ]
then
if ! diff "$WHICHSTOOL" "$INSTALLDIR$TMXRCHBNDR/$STOOL"
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
_CFLHDR_ "$TMXRCHBNDS"/tour "# A short tour that shows a few of the new featires of this system."
cat >> "$TMXRCHBNDS"/tour <<- EOM
printf "\\e[1;32m==> \\e[1;37mPlease hide the virtual keyboard.  Beginning a short tour that shows a few of the new featires of this system.  Running command \\e[1;32mexport\\e[1;37m...\\n\\n"
sleep 4
export
sleep 2
printf "\\n\\e[1;32m==> \\e[1;37mRunning command \\e[1;32mls -alRr --color=always %s\\e[1;37m...\\n\\n" "\$HOME"
sleep 1
ls -alRr --color=always "\$HOME"
sleep 4
printf "\\n\\e[1;32m==> \\e[1;37mRunning command \\e[1;32mcat %s/.bash_profile\\e[1;37m...\\n\\n" "\$HOME"
sleep 1
cat "\$HOME"/.bash_profile
sleep 4
printf "\\n\\e[1;32m==> \\e[1;37mRunning command \\e[1;32mcat %s/.bashrc\\e[1;37m...\\n\\n" "\$HOME"
sleep 1
cat "\$HOME"/.bashrc
sleep 4
printf "\\n\\e[1;32m==> \\e[1;37mRunning command \\e[1;32mcat $TMXRCHBNDR/pci\\e[1;37m...\\n\\n"
sleep 1
cat $TMXRCHBNDR/pci
sleep 4
printf "\\n\\e[1;32m==> \\e[1;37mRunning command \\e[1;32mcat $TMXRCHBNDR/README.md\\e[1;37m...\\n\\n"
sleep 1
cat $TMXRCHBNDR/README.md
printf "\\e[1;32m\\n%s \\e[38;5;121m%s \\n\\n\\e[4;38;5;129m%s\\e[0m\\n\\n\\e[1;34m%s \\e[38;5;135m%s\\e[0m\\n\\n" "==>" "Short tour is complete. Scroll up if you wish to study the output.  Run this script again at a later time, and it might be surprising at how this environment changes over time. " "If you are new to *nix, http://tldp.org has documentation." "IRC: " "https://$MOTTECIRC"
## $INSTALLDIR$TMXRCHBNDR/tour FE
EOM
chmod 755 "$TMXRCHBNDS"/tour
}

CCHDRX="$CACHEDIR$CACHEDIRSUFIX"
_ADDtrim_() {
_CFLHDR_ "$TMXRCHBNDS"/trim
cat >> "$TMXRCHBNDS"/trim <<- EOM
[ -f "$INSTALLDIR"/run/lock/"${INSTALLDIR##*/}"/pacman.cachedir.lock ] || { touch "$CCHDRX" && sed -Ei 's/.*#CacheDir.*/CacheDir    = ${CCHDRX//\//\\\/}/g' /etc/pacman.conf && :>"$INSTALLDIR"/run/lock/"${INSTALLDIR##*/}"/pacman.cachedir.lock ; }
printf "\\e[1;32m==> \\e[1;37mRunning command \\e[1;32m%s\\e[1;37m…\\n" "\${0##*/}"
[ "\$UID" -eq 0 ] && SUTRIM="" || SUTRIM="sudo"
_DTRM_() {
printf "%s\\n" "Triming installation files in directory '$INSTALLDIR' and populating cache in directory '$CACHEDIR'.  The command '${0##*/} ref' can be used to repopulate cache directory '$INSTALLDIR/var/cache/pacman/pkg/':"
[ -d "$CACHEDIR$CACHEDIRSUFIX" ] || { mkdir -p "$CACHEDIR$CACHEDIRSUFIX" && printf '%s' "mkdir -p $CACHEDIR$CACHEDIRSUFIX && " ; }
printf "%s\\n" "[1/3] find $INSTALLDIR -maxdepth 1 -type f -name \"*.tar.gz*\" -exec mv {} $CACHEDIR \;"
find $INSTALLDIR -maxdepth 1 -type f -name "*.tar.gz*" -exec mv {} "$CACHEDIR" \; || _PMFSESTRING_ "find $INSTALLDIR -maxdepth 1 -type f -exec mv {} $CACHEDIR \;"
printf "%s\\n" "[2/3] find /var/cache/pacman/pkg/ -maxdepth 1 -type f -exec mv {} $CACHEDIR$CACHEDIRSUFIX \;"
find /var/cache/pacman/pkg/ -maxdepth 1 -type f -exec mv {} "$CACHEDIR$CACHEDIRSUFIX" \; || _PMFSESTRING_ "find /var/cache/pacman/pkg/ -maxdepth 1 -type f -exec mv {} $CACHEDIR$CACHEDIRSUFIX \;"
printf "%s" "[3/3] paccache -r --keep 1 -c $CACHEDIR$CACHEDIRSUFIX"
paccache -r --keep 1 -c "$CACHEDIR$CACHEDIRSUFIX" || _PMFSESTRING_ "paccache -r --keep 1 -c $CACHEDIR$CACHEDIRSUFIX"
printf "%s\\n\\n" "The command '${0##*/} ref' repopulates the installation package files in directory '$INSTALLDIR' from cache directory '$CACHEDIR' and updates the TermuxArch files to the newest published version.  "
}
_PMFSESTRING_() {
printf "\\e[1;31m%s\\e[1;37m%s\\n\\n" "Signal generated in '\$1'; Cannot complete task; " "Continuing..."
printf "\\e[1;34m%s\\e[0;34m%s\\e[1;34m%s\\e[0;34m%s\\e[1;34m%s\\e[0m\\n\\n" "  If you find improvements for " "${0##*/}" " and " "\$0" " please open an issue and accompanying pull request."
}
_SUTRIM_() {
nice -n 19 \$SUTRIM pacman -Scc --noconfirm --color=always || _PMFSESTRING_ "\${SUTRIM}pacman -Scc \${0##*/}"
}
[ -d "$CACHEDIR" ] || mkdir -p "$CACHEDIR"
if [ -f "$CACHEDIR"DLTCCH ]
then
if grep 0 "$CACHEDIR"DLTCCH
then
_DPRGLL_() {
printf "%s\\\\n" "[1/6] rm -rf /boot/"
rm -rf /boot/
printf "%s\\\\n" "[2/6] rm -rf /usr/lib/firmware"
rm -rf /usr/lib/firmware
printf "%s\\\\n" "[3/6] rm -rf /usr/lib/modules"
rm -rf /usr/lib/modules
printf "%s\\\\n" "[4/6] \$SUTRIM"
_SUTRIM_
printf "%s\\\\n" "[5/6] rm -f /var/cache/pacman/pkg/*pkg*"
rm -f /var/cache/pacman/pkg/*pkg* || _PMFSESTRING_ "\${0##*/} rm -f /var/cache/pacman/pkg/*pkg*"
printf "%s\\n" "[6/6] find $INSTALLDIR -maxdepth 1 -type f -name \"*.tar.gz*\" -delete"
find $INSTALLDIR -maxdepth 1 -type f -name "*.tar.gz*" -delete || _PMFSESTRING_ "\${0##*/} find $INSTALLDIR -maxdepth 1 -type f -delete"
}
printf '%s\n' "Found 0 in file ${CACHEDIR}DLTCCH" && _DPRGLL_
else
printf '%s' "0 NOT found in file ${CACHEDIR}DLTCCH.  " && _DTRM_
fi
else
_DTRM_
fi
printf '%s' "File ${CACHEDIR}DLTCCH not found.  If file ${CACHEDIR}DLTCCH is present with a 0, all the pkg cache files will be removed and trimming steps [1/6]-[6/6] will be used instead of steps [1/3]-[3/3].  Command 'cw \${0##*/})' has more information.  "
## $INSTALLDIR$TMXRCHBNDR/trim FE
EOM
chmod 755 "$TMXRCHBNDS"/trim
}

_ADDv_() {
_CFLHDR_ "$TMXRCHBNDS"/v
cat >> "$TMXRCHBNDS"/v <<- EOM
if [[ -z "\${1:-}" ]]
then
ARGS=(".")
else
ARGS=("\$@")
fi
EOM
printf "%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...\\n\" \"Cannot run '\${0##*/}' as root user;\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/}; the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux; a default user account is created during setup; the default username 'user' can be used to access the PRoot system employing a user account; command '$STARTBIN help' has more information;  \" && exit" >> "$TMXRCHBNDS"/v
printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "if [ -x /usr/bin/vim ] || [ -x \"\${PREFIX:-}\"/bin/vim ]" "then" "vim \"\${ARGS[@]}\"" "else" "{ pc vim || pci vim ; } && vim \"\${ARGS[@]}\"" "fi" "## $INSTALLDIR$TMXRCHBNDR/v FE" >> "$TMXRCHBNDS"/v
chmod 755 "$TMXRCHBNDS"/v
}

_ADDwe_() {
_CFLHDR_ usr/bin/we "# Watch available entropy on device." "# cat /proc/sys/kernel/random/entropy_avail Contributor https://github.com/cb125"
cat >> usr/bin/we <<- EOM
declare -a ARGS

_TRPWE_() {
printf "\\e[?25h\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\${ARGS[@]}"
}

_PRINTTAIL_() {
printf "\\n\\e[0;32m%s \\e[1;32m%s \\e[0;32m%s\\e[1;34m: \\e[1;32m%s\\e[0m 🏁  \\n\\n\\e[0m" "TermuxArch command" "\$STRNRG" "version \$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch command %s:DONE 📱 \007' "\$STRNRG"
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
printf '\033]2; TermuxArch command Watch Entropy '%s' 📲  \007' "\$STRNRG"
printf "\\n\\e[1;32mTermuxArch command Watch Entropy '%s':\\n" "\$STRNRG"
}

_PRINTTAIL_() {
printf "\\n\\n\\e[1;32mTermuxArch command Watch Entropy 🏁 \\n\\n"
printf '\033]2; TermuxArch command Watch Entropy 🏁 \007'
}

_PRINTUSAGE_() {
printf "\\n\\e[0;32mUsage:  \\e[1;32mwe \\e[0;32m Watch Entropy sequential.\\n\\n	\\e[1;32mwe sequential\\e[0;32m Watch Entropy sequential.\\n\\n	\\e[1;32mwe simple\\e[0;32m Watch Entropy simple.\\n\\n	\\e[1;32mwe verbose\\e[0;32m Watch Entropy verbose.\\n\\n"'\033]2; TermuxArch command Watch Entropy 📲  \007'
}

infif() {
if [[ \$entropy0 = "inf" ]] || [[ \$entropy0 = "" ]] || [[ \$entropy0 = 0 ]]
then
entropy0=1000
printf "\\e[1;32m∞^∞infifinfif2minfifinfifinfifinfif∞=1\\e[0;32minfifinfifinfifinfif\\e[0;32m∞==0infifinfifinfifinfif\\e[0;32minfifinfifinfif∞"
fi
}

en0=\$((\${entropy0}*\$multi))

esleep() {
int=\$(printf "%s\\n" "\$i/\$entropy0" | bc -l)
for i in {1..5}; do
if (( \$(printf "%s\\n" "\$int > 0.1"|bc -l) ))
then
tmp=\$(printf "%s\\n" "\${int}/100" | bc -l)
int=\$tmp
fi
if (( \$(printf "%s\\n" "\$int > 0.1"|bc -l) ))
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
printf "\\e[1;34mInstalling \\e[0;32mbc\\e[1;34m...\\n\\n\\e[1;32m"
{ pc bc || pci bc ; }
printf "\\n\\e[1;34mInstalling \\e[0;32mbc\\e[1;34m: \\e[1;32mDONE 🏁\\n\\e[0m"
fi
else
tbcif=\$(command -v bc) ||:
if [[ \$tbcif = "" ]]
then
printf "\\e[1;34mInstalling \\e[0;32mbc\\e[1;34m...\\n\\n\\e[1;32m"
apt install bc --yes
printf "\\n\\e[1;34mInstalling \\e[0;32mbc\\e[1;34m: \\e[1;32mDONE 🏁\\n\\e[0m"
fi
fi
}

entropysequential() {
printf '\033]2; TermuxArch Watch Entropy Sequential '%s' 📲  \007' "\$STRNRG"
printf "\\n\\e[1;32mTermuxArch Watch Entropy Sequential '%s':\\n" "\$STRNRG"
for i in \$(seq 1 \$en0); do
entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null)
infif
printf "\\e[1;30m \$en0 \\e[0;32m\$i \\e[1;32m\${entropy0}\\n"
1sleep
done
}

entropysimple() {
printf '\033]2; TermuxArch Watch Entropy Simple '%s' 📲  \007' "\$STRNRG"
printf "\\n\\e[1;32mTermuxArch Watch Entropy Simple '%s':\\n" "\$STRNRG"
for i in \$(seq 1 \$en0); do
entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null)
infif
printf "\\e[1;32m\${entropy0} "
1sleep
done
}

entropyverbose() {
printf '\033]2; TermuxArch Watch Entropy Verbose '%s' 📲  \007' "\$STRNRG"
printf "\\n\\e[1;32mTermuxArch Watch Entropy Verbose '%s':\\n" "\$STRNRG"
for i in \$(seq 1 \$en0); do
entropy0=\$(cat /proc/sys/kernel/random/entropy_avail 2>/dev/null)
infif
printf "\\e[1;30m \$en0 \\e[0;32m\$i \\e[1;32m\${entropy0} \\e[0;32m#E&&√♪"
esleep
sleep \$int
entropy1=\$(cat /proc/sys/kernel/random/uuid)
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
## $INSTALLDIR$TMXRCHBNDR/we FE
EOM
chmod 755 usr/bin/we
}

_ADDyt_() {
_CFLHDR_ "$TMXRCHBNDS"/yt
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31mExiting...\\n\" \"Cannot run '\$STRNRG' as root user :\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/} : the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux : a default user account is created during setup : the default username 'user' can be used to access the PRoot system employing a user account : command '$STARTBIN help' has more information :  \" && exit" "
if [ -x /usr/bin/youtube-dl ]
then
youtube-dl \"\${ARGS[@]}\"
else
pc youtube-dl  || pci youtube-dl
youtube-dl \"\${ARGS[@]}\"
fi
" "## $INSTALLDIR$TMXRCHBNDR/yt FE" >> "$TMXRCHBNDS"/yt
chmod 755 "$TMXRCHBNDS"/yt
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
if [[ "$ARCTEVAR" = "$CPUABIX8664" ]]
then
MOTTECBBS="BBS: bbs.archlinux.org"
MOTTECGIT="github.com/archlinux"
MOTTECIRC="wiki.archlinux.org/index.php/IRC_channel"
elif [[ "$ARCTEVAR" = "$CPUABIX86" ]]
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
[ -f "$INSTALLDIR"/run/lock/"${INSTALLDIR##*/}"/pacman.conf.lock ] || {
[ -f "$INSTALLDIR"/etc/pacman.conf ] && { sed -i 's/^CheckSpace/\#CheckSpace/g' "$INSTALLDIR/etc/pacman.conf" && sed -i 's/^#Color/Color/g' "$INSTALLDIR/etc/pacman.conf" && :>"$INSTALLDIR"/run/lock/"${INSTALLDIR##*/}"/pacman.conf.lock ; } ; }
}
# archlinuxconfig.bash FE
