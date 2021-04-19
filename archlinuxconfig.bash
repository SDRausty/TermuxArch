#!/usr/bin/env bash
## Copyright 2017-2021 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
_ADDAUSER_() {
_CFLHDR_ usr/local/bin/addauser "# add Arch Linux in Termux PRoot user"
cat >> usr/local/bin/addauser <<- EOM
_HUSDIRC_() {
if [ "\$UID" != 0 ]
then
WHOAMI="\$(whoami)"
printf "\\\\e[1;31mUSAGE:\\\\e[1;37m %s\\\\e[1;32m: Exiting...\\\\e[0m\\\\n" "Script '\${0##*/}' should be run using the root account, not the '\$WHOAMI' account.  Alternatively '\${0##*/}' can be used with the 'sudo' command;  'sudo \${0##*/} user'."
exit 202
fi
if [ \$# = 0 ]
then
printf "\\\\e[1;31mUSAGE: \\\\e[1;37m'addauser username'\\\\e[1;32m: Exiting...\\\\n"
exit 201
fi
if [[ ! -d "/home/\$@" ]]
then
_FUNADDU_ "\$@"
else
printf "\\\\e[1;33mDirectory: \\\\e[1;37m'/home/\$@ exists'\\\\e[0;32m: Exiting...\\\\n"
fi
}
_FUNADDU_() {
[[ ! "\$(command -v sudo)" ]] 2>/dev/null && (pc sudo || pc sudo)
printf "\\\\e[0;32m%s\\\\n\\\\e[1;32m" "Adding Arch Linux in Termux PRoot user '\$1' and creating Arch Linux in Termux PRoot user \$1's home directory in /home/\$1..."
[[ ! -f /etc/sudoers ]] && touch /etc/sudoers
sed -i "/# %wheel ALL=(ALL) NOPASSWD: ALL/ s/^# *//" /etc/sudoers
sed -i "/# ALL ALL=(ALL) ALL/ s/^# *//" /etc/sudoers
sed -i "s/# ALL ALL=(ALL) ALL/ALL ALL=(ALL) NOPASSWD: ALL/g" /etc/sudoers
grep -q 'ftp_proxy' /etc/sudoers && : || printf "%s\\\\n" 'Defaults env_keep += "ftp_proxy http_proxy https_proxy"' >> /etc/sudoers
sed -i "s/required/sufficient/g" /etc/pam.d/su
sed -i "s/^#auth/auth/g" /etc/pam.d/su
useradd -k /root -m -s /bin/bash "\$1" -U
usermod "\$1" -aG wheel
chage -I -1 -m 0 -M -1 -E -1 "\$1"
passwd -d "\$1"
chmod 775 "/home/\$1"
chown -R "\$1:\$1" "/home/\$1"
sed -i "s/\$1:x/\$1:/g" /etc/passwd
printf "\\\\e[0;32m%s\\\\e[1;32m%s\\\\e[0;32m%s\\\\e[1;32m%s\\\\e[0;32m%s\\\\e[1;32m%s\\\\e[0;32m%s\\\\e[1;32m%s\\\\e[0;32m%s\\\\e[0m\\\\n" "Added Arch Linux in Termux PRoot user " "'\$1'" " and configured user '\$1' for use with the Arch Linux command 'sudo'.  Created Arch Linux user \$1's home directory in /home/\$1.  To use this account run " "'$STARTBIN login \$1'" " from the shell in Termux.  To add user accounts you can use " "'addauser \$1'" " in Arch Linux and " "'$STARTBIN c[ommand] addauser \$1'" " in the default Termux shell.  Please do not nest proot in proot by using '$STARTBIN' in '$STARTBIN' as this is known to cause issues for users of PRoot."
}
_PMFSESTRING_() {
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;32m%s\\\\e[1;37m%s\\\\n\\\\n" "Signal generated in '\$1' : Cannot complete task : " "Continuing..."
printf "\\\\e[1;34m%s\\\\e[0;34m%s\\\\e[1;34m%s\\\\e[0;34m%s\\\\e[1;34m%s\\\\e[0m\\\\n\\\\n" "  If you find improvements for " "${0##*}" " and " "\${0##*}" " please open an issue and an accompanying pull request."
}
_HUSDIRC_ "\$@"
## addauser EOF
EOM
chmod 700 usr/local/bin/addauser
}

_ADDMOTA_() {
cat > etc/mota <<- EOM
printf "\\\\n\\\\e[1;34m%s\\\\n%s\\\\e[0;34m%s\\\\n\\\\e[1;34m%s\\\\e[0;34m%s\\\\n\\\\e[1;34m%s\\\\e[0;34m%s\\\\n\\\\e[1;34m%s\\\\e[0;34m%s\\\\n\\\\n\\\\e[1;34m%s\\\\e[0m%s\\\\n\\\\e[1;34m%s\\\\e[0;34m%s\\\\e[1;34m%s\\\\e[0;34m%s\\\\n\\\\e[1;34m%s\\\\e[0m%s\\\\n\\\\e[1;34m%s\\\\e[0m%s\\\\n\\\\n" "Welcome to Arch Linux in Termux PRoot!" "Install a package: " "pacman -S package" "More  information: " "pacman -[D|F|Q|R|S|T|U]h" "Search   packages: " "pacman -Ss query" "Upgrade  packages: " "pacman -Syu" "Chat:	" "wiki.termux.com/wiki/Community" "Help:	" "info query " "and " "man query" "GitHub:	" "$MOTTECGIT" "IRC:	" "$MOTTECIRC"
EOM
}

_ADDMOTD_() {
cat > etc/motd <<- EOM
Welcome to Arch Linux in Termux PRoot!
Install a package: pacman -S package
More  information: pacman -[D|F|Q|R|S|T|U]h
Search   packages: pacman -Ss query
Upgrade  packages: pacman -Syu

$MOTTECBBS
Chat:	wiki.termux.com/wiki/Community
GitHub:	$MOTTECGIT
Help:	info query and man query
IRC:	$MOTTECIRC
EOM
}

_ADDMOTO_() {
cat > etc/moto <<- EOM
printf "\\\\n\\\\e[1;34mPlease Share Your Arch Linux in Termux PRoot Experience!\\\\n\\\\n\\\\e[1;34mChat:	\\\\e[0mwiki.termux.com/wiki/Community\\\\n\\\\e[1;34mHelp:	\\\\e[0;34minfo query \\\\e[1;34mand \\\\e[0;34mman query\\\\n\\\\e[1;34mGitHub:	\\\\e[0m%s\\\\n\\\\e[1;34mIRC:	\\\\e[0m%s\\\\n\\\\n\\\\e[0m" "$MOTTECGIT" "$MOTTECIRC"
EOM
}

_ADDOPEN4ROOT_() {
_CFLHDR_ usr/local/bin/open4root "# open TermuxArch programs for root user"
cat >> usr/local/bin/open4root <<- EOM
sed -i 's/UID\" = 0/UID\" = -1/g' /usr/local/bin/*
EOM
chmod 700 usr/local/bin/open4root
}

_ADDREADME_() {
_CFLHDR_ usr/local/bin/README.md
cat > usr/local/bin/README.md <<- EOM
The HOME/bin directory contains shortcut commands that automate and ease using the command line.  Some of these commands are listed here:

* Command 'csystemctl' replaces systemctl with https://github.com/TermuxArch/docker-systemctl-replacement,
* Command 'keys' installs Arch Linux keys,
* Command 'makeyay' creates the 'yay' command, and also patches the 'makepkg' command,
* Command 'patchmakepkg' patches the 'makepkg' command,
* Command 'tour' runs a short tour of the Arch Linux system directories,
* Command 'trim' removes downloaded packages from the Arch Linux system directories.

This file can be expanded so the beginning user can get to know the Linux experience easier.  Would you like to create an issue along with a pull request to add information to this file so that the beginning user can get to know the Arch Linux in Termux PRoot experience easier?  If you do want to expand this file to enhance this experience, visit these links:

* Comments are welcome at https://github.com/TermuxArch/TermuxArch/issues ✍
* Pull requests are welcome at https://github.com/TermuxArch/TermuxArch/pulls ✍
<!--bin/README.md EOF-->
EOM
}

_ADDae_() {
_CFLHDR_ usr/local/bin/ae "# Developed at [pacman-key --populate archlinux hangs](https://github.com/SDRausty/TermuxArch/issues/33) Contributor cb125"
cat >> usr/local/bin/ae <<- EOM
watch cat /proc/sys/kernel/random/entropy_avail
## ae EOF
EOM
chmod 700 usr/local/bin/ae
}

_ADDabrowser_() {
_CFLHDR_ usr/local/bin/abrowser "# Developed at [Android 11 (with Termux storage permission denied) question; What's the source for the shortcut to the file manager of the settings app?](https://www.reddit.com/r/termux/comments/msq7lm/android_11_with_termux_storage_permission_denied/) Contributors DutchOfBurdock xeffyr"
cat >> usr/local/bin/abrowser <<- EOM
am start -a android.intent.action.VIEW -d "content://com.android.externalstorage.documents/root/primary"
## abrowser EOF
EOM
chmod 700 usr/local/bin/abrowser
}

_ADDmakeaurhelpers_() {
_CFLHDR_ usr/local/bin/makeaurhelpers "# add Arch Linux AUR helpers https://wiki.archlinux.org/index.php/AUR_helpers"
cat >> usr/local/bin/makeaurhelpers <<- EOM
_CLONEAURHELPER_() {
cd "\$HOME/aurhelpers"
if [[ ! -d "\$AURHELPER" ]]
then
printf "%s\\\\n\\\\n" "Cloning repository '\$AURHELPER' from https://aur.archlinux.org." && gcl https://aur.archlinux.org/\${AURHELPER}.git && printf "%s\\\\n\\\\n" "Finished cloning repository '\$AURHELPER' from https://aur.archlinux.org." && _MAKEAURHELPER_ || _PRTERROR_
else
printf "%s\\\\n" "Repository '\$AURHELPER' is already cloned." && _MAKEAURHELPER_ || _PRTERROR_
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
pci expac
AURHELPER=auracle-git
_CLONEAURHELPER_
fi
if [ "\$AURHELPER" = bauerbill ]
then
pci python-pyxdg
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
cd "\$HOME/aurhelpers/\$AURHELPER"
printf "%s\\\\n" "Running command 'nice -n 20 makepkg -irs --noconfirm';  Building and attempting to install '\$AURHELPER' with '\${0##*/}' $VERSIONID.  Please be patient..."
nice -n 20 makepkg -irs --noconfirm || nice -n 20 makepkg -irs --noconfirm || _PRTERROR_
}

_PRTERROR_() {
printf "\\\\n\\\\e[1;31merror: \\\\e[1;37m%s\\\\e[0m\\\\n\\\\n" "Please correct the error(s) and/or warning(s) and run '\${0##*/}' again."
}

[ ! -d "\$HOME/aurhelpers" ] && mkdir -p "\$HOME/aurhelpers"
UNAMEM="\$(uname -m)"
if [ "\$UNAMEM" = x86_64 ]
then
AURHELPERS=(stack-static aura-git auracle-git aurutils bauerbill pacaur pakku paru pbget pikaur-git pkgbuilder puyo repoctl repofish rua trizen yaah yayim)
elif [ "\$UNAMEM" = i386 ]
then
AURHELPERS=(auracle-git aurutils bauerbill pacaur pakku paru pbget pikaur-git pkgbuilder puyo repoctl repofish rua trizen yaah yayim)
else
AURHELPERS=(aurutils bauerbill pacaur pakku paru pbget pikaur-git pkgbuilder puyo repoctl repofish trizen yaah yayim)
fi
# command yay || makeyay
echo _DONEAURHELPER_ pikaur
# _DONEAURHELPER_ pikaur
# _DOAURHELPERS_
## makeaurhelpers EOF
EOM
chmod 700 usr/local/bin/makeaurhelpers
}

_ADDbash_logout_() {
cat > root/.bash_logout <<- EOM
[ ! -f "\$HOME"/.hushlogout ] && [ ! -f "\$HOME"/.chushlogout ] && . /etc/moto
h # write session history to file HOME/.historyfile
## .bash_logout EOF
EOM
}

_ADDbash_profile_() {
[ -e root/.bash_profile ] && _DOTHRF_ "root/.bash_profile"
printf "%s\\n%s\\n" "PATH=\"\$HOME/bin:\$PATH:/usr/sbin:/sbin:/bin\"" "[[ -f "\$HOME"/.bashrc ]] && . "\$HOME"/.bashrc" > root/.bash_profile
cat >> root/.bash_profile <<- EOM
if [ ! -e "\$HOME"/.hushlogin ] && [ ! -e "\$HOME"/.chushlogin ]
then
[ -e /etc/mota ] && . /etc/mota
fi
if [ -e "\$HOME"/.chushlogin ]
then
rm -f "\$HOME"/.chushlogin
fi
PS1="[\[\e[38;5;148m\]\u\[\e[1;0m\]\A\[\e[1;38;5;112m\]\W\[\e[0m\]]$ "
export GPG_TTY="\$(tty)"
EOM
for i in "${!LC_TYPE[@]}"
do
printf "%s=\"%s\"\\n" "export ${LC_TYPE[i]}" "$ULANGUAGE.UTF-8" >> root/.bash_profile
done
[[ -f "$HOME"/.bash_profile ]] && grep proxy "$HOME"/.bash_profile | grep -s "export" >> root/.bash_profile ||:
cat >> root/.bash_profile <<- EOM
export TZ="$(getprop persist.sys.timezone)"
## .bash_profile EOF
EOM
}

_ADDbashrc_() {
[ -e root/.bashrc ] && _DOTHRF_ "root/.bashrc"
cat > root/.bashrc <<- EOM
alias ..='cd ../.. && pwd'
alias ...='cd ../../.. && pwd'
alias ....='cd ../../../.. && pwd'
alias .....='cd ../../../../.. && pwd'
alias C='cd .. && pwd'
alias c='cd .. && pwd'
alias CUO='curl -O --retry 4'
alias cuo='curl -O --retry 4'
alias CUOL='curl -JOL --retry 4'
alias cuol='curl -JOL --retry 4'
alias D='nice -n 20 du -hs'
alias d='nice -n 20 du -hs'
alias E='exit'
alias e='exit'
alias F='grep -n --color=always'
alias f='grep -n --color=always'
alias Fr='grep -nr --color=always'
alias fr='grep -nr --color=always'
alias G='ga ; gcm ; gp'
alias g='ga ; gcm ; gp'
alias GITS='git show'
alias gits='git show'
alias GCA='git commit -a -S'
alias gca='git commit -a -S'
alias GCAM='git commit -a -S -m'
alias gcam='git commit -a -S -m'
alias H='history >> \$HOME/.historyfile'
alias h='history >> \$HOME/.historyfile'
alias J='jobs'
alias j='jobs'
alias I='whoami'
alias i='whoami'
alias L='ls -al --color=always'
alias l='ls -al --color=always'
alias LS='ls --color=always'
alias ls='ls --color=always'
alias LR='ls -alR --color=always'
alias lr='ls -alR --color=always'
alias MKDIP='mkdir -p'
alias mkdip='mkdir -p'
alias N='nano'
alias n='nano'
alias N2='nice -n -20'
alias n2='nice -n -20'
alias P='pwd'
alias p='pwd'
alias PACMAN='pacman --color=always'
alias pacman='pacman --color=always'
alias PCS='pacman -S --color=always'
alias pcs='pacman -S --color=always'
alias PCSS='pacman -Ss --color=always'
alias pcss='pacman -Ss --color=always'
alias Q='exit'
alias q='exit'
alias V='v'
alias v='v'
alias UM='uname -m'
alias um='uname -m'
EOM
[ -f "$HOME"/.bashrc ] && grep -s proxy "$HOME"/.bashrc | grep -s "export" >>  root/.bashrc ||:
cat >> root/.bashrc <<- EOM
## .bashrc EOF
EOM
}

_ADDcdtd_() {
_CFLHD_ usr/local/bin/cdtd "# Usage: \`. cdtd\` the dot sources \`cdtd\` which makes this shortcut script work."
cat > usr/local/bin/cdtd <<- EOM
#!/usr/bin/env bash
cd "$HOME/storage/downloads" && pwd
## cdtd EOF
EOM
chmod 700 usr/local/bin/cdtd
}

_ADDcdth_() {
_CFLHD_ usr/local/bin/cdth "# Usage: \`. cdth\` the dot sources \`cdth\` which makes this shortcut script work."
cat > usr/local/bin/cdth <<- EOM
#!/usr/bin/env bash
cd "$HOME" && pwd
## cdth EOF
EOM
chmod 700 usr/local/bin/cdth
}

_ADDcdtmp_() {
_CFLHD_ usr/local/bin/cdtmp "# Usage: \`. cdtmp\` the dot sources \`cdtmp\` which makes this shortcut script work."
cat > usr/local/bin/cdtmp <<- EOM
#!/usr/bin/env bash
cd "$PREFIX/tmp" && pwd
## cdtmp EOF
EOM
chmod 700 usr/local/bin/cdtmp
}

_ADDch_() {
_CFLHDR_ usr/local/bin/ch "# This script creates .hushlogin and .hushlogout files."
cat >> usr/local/bin/ch <<- EOM
declare -a ARGS

_TRPET_() { # on exit
printf "\\\\e[?25h\\\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\$ARGS[@]"
}

_PRINTTAIL_() {
printf "\\\\e[0m%s \\\\e[1;32m%s \\\\e[0;32m%s\\\\e[1;34m: \\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\e[0m" "TermuxArch command" "\${0##*/} \$ARGS"  "version \$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s:DONE 📱 \007' "\${0##*/} \$ARGS"
}

trap _TRPET_ EXIT
## ch begin ####################################################################

if [[ -z "\${1:-}" ]]
then
ARGS=""
else
ARGS="\$@"
fi

printf "\\\\e[1;32m==> \\\\e[0mRunning \\\\e[1;32m%s\\\\e[0;32m%s\\\\e[1;37m...\\\\n\\\\n" "\${0##*/} \$ARGS " "version \$VERSIONID"

if [[ -f "\$HOME"/.hushlogin ]] && [[ -f "\$HOME"/.hushlogout ]]
then
rm -f "\$HOME"/.hushlogin "\$HOME"/.hushlogout
printf "%s\\\\n\\\\n" "Hushed login and logout: OFF"
elif [[ -f "\$HOME"/.hushlogin ]] || [[ -f "\$HOME"/.hushlogout ]]
then
touch "\$HOME"/.hushlogin "\$HOME"/.hushlogout
printf "%s\\\\n\\\\n" "Hushed login and logout: ON"
else
touch "\$HOME"/.hushlogin "\$HOME"/.hushlogout
printf "%s\\\\n\\\\n" "Hushed login and logout: ON"
fi
## ch EOF
EOM
chmod 700 usr/local/bin/ch
}

_ADDchperms.cache+gnupg_() {
_CFLHDR_ usr/local/bin/chperms.cache+gnupg
cat >> usr/local/bin/chperms.cache+gnupg <<- EOM
[[ -d "\$HOME/.cache" ]] && find "\$HOME/.cache" -type d -exec chmod 777 {} \; && find "\$HOME/.cache" -type f -exec chmod 666 {} \;
[[ -d "\$HOME/.gnupg" ]] && find "\$HOME/.gnupg" -type d -exec chmod 777 {} \; && find "\$HOME/.gnupg" -type f -exec chmod 666 {} \;
EOM
chmod 700 usr/local/bin/chperms.cache+gnupg
}

_ADDcsystemctl_() {
_CFLHDR_ usr/local/bin/csystemctl "# Contributor https://github.com/petkar"
cat >> usr/local/bin/csystemctl <<- EOM
INSTALLDIR="$INSTALLDIR"
printf "\\\\e[38;5;148m%s\\\\e[0m\\\\n" "Installing /usr/bin/systemctl replacement: "
[ -f "/run/lock/${INSTALLDIR##*/}/csystemctl.lock" ] && printf "%s\\\\n" "Already installed /usr/local/bin/systemctl replacement: DONE 🏁" && exit
declare COMMANDP
COMMANDP="\$(command -v python3)" || printf "%s\\\\n" "Command python3 can not be found: continuing..."
[[ "\${COMMANDP:-}" == *python3* ]] || pci python3
SDATE="\$(date +%s)"
# path is /usr/local/bin because updates overwrite /usr/bin/systemctl and may make systemctl-replacement obsolete
# backup original binary
mv -f /usr/bin/systemctl $INSTALLDIR/var/backups/${INSTALLDIR##*/}/systemctl.\$SDATE.bkp
printf "\\\\e[38;5;148m%s\\\\n\\\\e[0m" "Moved /usr/bin/systemctl to $INSTALLDIR/var/backups/${INSTALLDIR##*/}/systemctl.\$SDATE.bkp"
printf "%s\\\\n" "Getting replacement systemctl from https://raw.githubusercontent.com/TermuxArch/docker-systemctl-replacement/master/files/docker/systemctl3.py"
# Arch Linux package 'systemctl' updates will mot halt functioning as /usr/local/bin precedes /usr/bin in the PATH
# download and copy to both directories /usr/local/bin and /usr/bin
curl --fail --retry 2 https://raw.githubusercontent.com/TermuxArch/docker-systemctl-replacement/master/files/docker/systemctl3.py | tee /usr/bin/systemctl /usr/local/bin/systemctl >/dev/null
chmod 700 /usr/bin/systemctl /usr/local/bin/systemctl
touch "/run/lock/${INSTALLDIR##*/}/csystemctl.lock"
printf "\\\\e[38;5;148m%s\\\\e[1;32m%s\\\\e[0m\\\\n" "Installing systemctl replacement in /usr/local/bin and /usr/bin: " "DONE 🏁"
## csystemctl EOF
EOM
chmod 700 usr/local/bin/csystemctl
}

_ADDdfa_() {
_CFLHDR_ usr/local/bin/dfa
cat >> usr/local/bin/dfa <<- EOM
DFUNIT="\$(df | awk 'FNR == 1 {print \$2}')"
DFDATA="\$(df)"
USRSPACE="\$(df | grep "/data" | awk {'print \$4'} | sort | tail -n 1)"
ARGS="\$USRSPACE \$DFUNIT"
printf "\\\\e[0;33m%s\\\\n\\\\e[0m" "\$USRSPACE \$DFUNIT of free user space is available on this device."
## dfa EOF
EOM
chmod 700 usr/local/bin/dfa
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
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user :\" \" the command 'addauser username' creates user accounts in $INSTALLDIR : the command '$STARTBIN command addauser username' can create user accounts in $INSTALLDIR from Termux : a default user account is created during setup : the default username 'user' can be used to access the PRoot system employing a user account : command '$STARTBIN help' has more information : \" \"exiting...\" && exit" "[ ! -x \"\$(command -v emacs)\" ] && pci emacs && emacs \"\${ARGS[@]}\" || emacs \"\${ARGS[@]}\"" "## v EOF" >> usr/local/bin/es
chmod 700 usr/local/bin/es
}

_ADDexd_() {
_CFLHDR_ usr/local/bin/exd "# Usage: \`. exd\` the dot sources \`exd\` which makes this shortcut script work."
cat >> usr/local/bin/exd <<- EOM
export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4712
## exd EOF
EOM
chmod 700 usr/local/bin/exd
}

_ADDfbindprocpcidevices.prs_() {
touch var/binds/fbindprocpcidevices
_CFLHDRS_ var/binds/fbindprocpcidevices.prs
cat >> var/binds/fbindprocpcidevices.prs <<- EOM
# bind an empty /proc/bus/pci/devices file
PROOTSTMNT+="-b $INSTALLDIR/var/binds/fbindprocpcidevices:/proc/bus/pci/devices "
## fbindprocpcidevices.prs EOF
EOM
}

_ADDfbindprocshmem.prs_() {
cat > var/binds/fbindprocshmem <<- EOM
------ Message Queues --------
key        msqid      owner      perms      used-bytes   messages

------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status

------ Semaphore Arrays --------
key        semid      owner      perms      nsems
EOM
_CFLHDRS_ var/binds/fbindprocshmem.prs
cat >> var/binds/fbindprocshmem.prs <<- EOM
PROOTSTMNT+="-b $INSTALLDIR/var/binds/fbindprocshmem:/proc/shmem "
## fbindprocshmem.prs EOF
EOM
}

_ADDfbindprocstat_() { # Chooses the appropriate four or eight processor stat file.
NESSOR="$(grep cessor /proc/cpuinfo)"
NCESSOR="${NESSOR: -1}"
if [[ "$NCESSOR" -le "3" ]] 2>/dev/null
then
_ADDfbindprocstat4_
else
_ADDfbindprocstat8_
fi
}

_ADDfbindprocstat4_() {
cat > var/binds/fbindprocstat <<- EOM
cpu  4232003 351921 6702657 254559583 519846 1828 215588 0 0 0
cpu0 1595013 127789 2759942 61446568 310224 1132 92124 0 0 0
cpu1 1348297 91900 1908179 63099166 110243 334 78861 0 0 0
cpu2 780526 73446 1142504 64682755 61240 222 32586 0 0 0
cpu3 508167 58786 892032 65331094 38139 140 12017 0 0 0
intr 182663754 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 23506963 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 13479102 0 0 0 0 0 0 0 108 0 0 0 0 0 0 0 0 0 178219 72133 5 0 1486834 0 0 0 8586048 0 0 0 0 0 0 0 0 0 0 2254 0 0 0 0 29 3 7501 38210 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4610975 0 0 0 0 0 1 0 78471 0 0 0 0 0 0 0 0 0 0 0 0 0 0 305883 0 15420 0 3956500 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8937474 0 943938 0 0 0 0 0 0 0 0 0 0 0 0 12923 0 0 0 34931 5 0 2922124 848989 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 12502497 0 0 3270275 0 0 0 0 0 0 0 0 0 0 0 1002881 0 0 0 0 0 0 17842 0 44011 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1975390 0 0 0 0 0 0 0 0 0 0 0 0 4968 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1340 2 762 0 0 0 50 42 0 27 82 0 0 0 0 14 28 0 0 0 0 14277 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1974794 0 142 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 367 81
ctxt 473465697
btime 1533498667
processes 800170
procs_running 2
procs_blocked 0
softirq 71223290 12005 18257219 222294 2975533 4317 4317 7683319 19799901 40540 22223845
EOM
}

_ADDfbindprocstat6_() {
cat > var/binds/fbindprocstat <<- EOM
# cat /proc/stat
cpu  148928556 146012 6648853 2086709554 4518337 0 1314039 293017 0 0
cpu0 24948069 38092 1137251 347724817 1169568 0 30231 21138 0 0
cpu1 16545576 29411 890111 356315677 971747 0 41593 115368 0 0
cpu2 82009143 11955 2705377 286616379 473751 0 1239704 114343 0 0
cpu3 9487436 29342 673090 364602319 631633 0 843 11690 0 0
cpu4 6696319 23709 584149 367425424 501898 0 890 12546 0 0
cpu5 9242011 13500 658872 364024935 769737 0 775 17929 0 0
intr 3438098651 134 26 0 0 0 0 3 0 0 0 0 581717 74 0 0 3669554 0 0 0 0 0 0 0 0 0 150777509 19 0 843288252 7923 0 0 0 256 0 4 0 13323712 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt 1109789017
btime 1499444193
processes 6613836
procs_running 3
procs_blocked 0
softirq 3644958646 1 2007831497 2340 995352344 1834998 0 97563 249921452 0 389918451
EOM
}

_ADDfbindprocstat8_() {
cat > var/binds/fbindprocstat <<- EOM
cpu  10278859 1073916 12849197 97940412 70467 2636 323477 0 0 0
cpu0 573749 46423 332546 120133 32 79 5615 0 0 0
cpu1 489409 40445 325756 64094 0 59 5227 0 0 0
cpu2 385758 36997 257949 50488114 40123 39 4021 0 0 0
cpu3 343254 34729 227718 47025740 30205 20 2566 0 0 0
cpu4 3063160 288232 4291656 58418 27 940 146236 0 0 0
cpu5 2418517 277690 3105779 60431 48 751 67052 0 0 0
cpu6 1671400 189460 2302016 61521 23 402 49717 0 0 0
cpu7 1333612 159940 2005777 61961 9 346 43043 0 0 0
intr 607306752 0 0 113 0 109 0 0 26 0 0 4 0 0 0 0 0 0 0 0 0 67750564 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 51073258 0 0 0 0 0 0 0 160 0 0 0 0 0 0 0 0 0 51831 2 5 0 24598 0 0 0 15239501 0 0 0 0 0 0 0 0 0 0 1125885 0 0 0 0 5966 3216 120 2 0 0 5990 0 24741 0 37 0 0 0 0 0 0 0 0 0 0 0 0 15262980 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 42742 16829690 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 19844763 0 8873762 0 0 0 0 0 0 0 0 6 0 0 0 49937 0 0 0 2768306 5 0 3364052 3700518 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 41435584 0 0 3939101 0 0 0 0 0 0 0 0 0 0 0 1894201 0 0 0 0 0 0 864195 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8961077 3996222 0 0 0 0 0 0 0 0 0 0 0 0 66386 0 0 0 0 0 0 87497 0 285431 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 11217187 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3578 0 0 0 0 0 301 300 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 117 14 0 0 0 0 0 95 0 0 0 0 0 0 0 27 0 2394 0 0 0 0 62 0 0 0 0 0 857124 0 1 0 0 0 0 20 3990685 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5021 481 4
ctxt 1589697753
btime 1528042653
processes 1400085
procs_running 5
procs_blocked 0
softirq 204699421 2536598 39636497 522981 4632002 29263706 104522 6736991 41332715 232221 79701188
EOM
}

_ADDfbindprocuptime_() {
printf "%s\\\\n" "350735.47 234388.90" > var/binds/fbindprocuptime
}

_ADDfbindprocversion_() {
cat > var/binds/fbindprocversion <<- EOM
Linux version $UNAMER (root@localhost) (gcc version 4.9.x 20150123 (prerelease) (GCC) ) #1 SMP PREEMPT $(date +%a" "%b" "%d" "%X" UTC "%Y)
EOM
_CFLHDRS_ var/binds/fbindprocversion.prs
cat >> var/binds/fbindprocversion.prs <<- EOM
# bind kernel information when /proc/version is accessed
PROOTSTMNT+="-b $INSTALLDIR/var/binds/fbindprocversion:/proc/version "
## fbindprocversion.prs EOF
EOM
}

_ADDbindexample_() {
_CFLHDRS_ var/binds/bindexample.prs "# Before regenerating the start script with \`setupTermuxArch re[fresh]\`, first copy this file to another name such as \`fbinds.prs\`.  Then add as many proot statements as you want; The init script will parse file \`fbinds.prs\` at refresh adding these proot options to \`$STARTBIN\`.  The space before the last double quote is necessary.  Examples are included for convenience:"
cat >> var/binds/bindexample.prs <<- EOM
# PRoot bind usage: PROOTSTMNT+="-b host_path:guest_path " # the space before the last double quote is necessary
# PROOTSTMNT+="-q $PREFIX/bin/qemu-x86_64 "
# PROOTSTMNT+="-b /proc/:/proc/ "
# [[ ! -r /dev/shm ]] && PROOTSTMNT+="-b $INSTALLDIR/tmp:/dev/shm "
## bindexample.prs EOF
EOM
}

_ADDfbinds_() { # Checks if /proc/stat is usable.
if [[ ! -r /proc/stat ]]
then
_ADDfbindprocstat_
_ADDfbindprocversion_
fi
}

_ADDfibs_() {
_CFLHDR_ usr/local/bin/fibs
cat >> usr/local/bin/fibs <<- EOM
find /proc/ -name maps 2>/dev/null | xargs awk '{print \$6}' 2>/dev/null | grep '\.so' | sort | uniq && exit
## fibs EOF
EOM
chmod 700 usr/local/bin/fibs
}

_ADDga_() {
_CFLHDR_ usr/local/bin/ga
cat >> usr/local/bin/ga <<- EOM
if [[ ! -x "\$(command -v git)" ]]
then
pci git
git add .
else
git add .
fi
## ga EOF
EOM
chmod 700 usr/local/bin/ga
}

_ADDgcl_() {
_CFLHDR_ usr/local/bin/gcl "# Contributor https://reddit.com/u/ElectricalUnion"
cat >> usr/local/bin/gcl <<- EOM
if [ "\$UID" = 0 ]
then
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ERROR:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..."
else
if [[ ! -x "\$(command -v git)" ]]
then
pci git
git clone --depth 1 "\$@" --single-branch
else
git clone --depth 1 "\$@" --single-branch
fi
fi
## gcl EOF
EOM
chmod 700 usr/local/bin/gcl
}

_ADDgcm_() {
_CFLHDR_ usr/local/bin/gcm
cat >> usr/local/bin/gcm <<- EOM
if [[ ! -x "\$(command -v git)" ]]
then
pci git
git commit
else
git commit
fi
## gcm EOF
EOM
chmod 700 usr/local/bin/gcm
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
touch "$INSTALLDIR/root/.gitconfig"
fi
}

_ADDgpl_() {
_CFLHDR_ usr/local/bin/gpl
cat >> usr/local/bin/gpl <<- EOM
if [[ ! -x "\$(command -v git)" ]]
then
pci git
git pull
else
git pull
fi
## gpl EOF
EOM
chmod 700 usr/local/bin/gpl
}

_ADDgp_() {
_CFLHDR_ usr/local/bin/gp "# git push https://username:password@github.com/username/repository.git"
cat >> usr/local/bin/gp <<- EOM
if [[ ! -x "\$(command -v git)" ]]
then
pci git
git push
else
git push
fi
## gp EOF
EOM
chmod 700 usr/local/bin/gp
}

_ADDinfo_ () {
_CFLHDR_ usr/local/bin/info
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user :\" \" the command 'addauser username' creates user accounts in $INSTALLDIR : the command '$STARTBIN command addauser username' can create user accounts in $INSTALLDIR from Termux : a default user account is created during setup : the default username 'user' can be used to access the PRoot system employing a user account : command '$STARTBIN help' has more information : \" \"exiting...\" && exit" "[ ! -x \"/bin/info\" ] && pci texinfo && /bin/info \"\$@\" || /bin/info \"\$@\"" "## info EOF" >> usr/local/bin/info
chmod 700 usr/local/bin/info
}

_ADDinputrc_() {
cat > root/.inputrc <<- EOM
set bell-style none
EOM
}

_ADDkeys_() {
if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = i386 ]]
then	# set customized commands for Arch Linux 32 architecture
X86INT="UPGDPKGS=(\"a/archlinux-keyring/archlinux-keyring-20191219-1.0-any.pkg.tar.xz\" \"a/archlinux32-keyring/archlinux32-keyring-20191230-1.0-any.pkg.tar.xz\" \"g/glibc/glibc-2.28-1.1-i686.pkg.tar.xz\" \"l/linux-api-headers/linux-api-headers-5.3.1-2.0-any.pkg.tar.xz\" \"l/libarchive/libarchive-3.3.3-1.0-i686.pkg.tar.xz\" \"o/openssl/openssl-1.1.1.d-2.0-i686.pkg.tar.xz\" \"p/pacman/pacman-5.2.1-1.4-i686.pkg.tar.xz\" \"z/zstd/zstd-1.4.4-1.0-i686.pkg.tar.xz\" \"/c/coreutils/coreutils-8.31-3.0-i686.pkg.tar.xz\" \"w/which/which-2.21-5.0-i686.pkg.tar.xz\" \"g/grep/grep-3.3-3.0-i686.pkg.tar.xz\" \"g/gzip/gzip-1.10-3.0-i686.pkg.tar.xz\" \"l/less/less-551-3.0-i686.pkg.tar.xz\" \"s/sed/sed-4.7-3.0-i686.pkg.tar.xz\" \"u/unzip/unzip-6.0-13.1-i686.pkg.tar.xz\")
cp -f /usr/lib/{libcrypto.so.1.0.0,libssl.so.1.0.0} /tmp
cd /tmp
printf \"%s\\n\" \"Downloading files: '\$(printf \"%s \" \"\${UPGDPKGS[@]##*/}\")' from https://archive.archlinux32.org.\"
for UPGDPAKG in \${UPGDPKGS[@]}
do
if [[ ! -f \"\${UPGDPAKG##*/}\" ]]
then
printf \"%s\\n\\n\" \"Downloading file '\${UPGDPAKG##*/}' from https://archive.archlinux32.org.\" && curl -C - --fail --retry 4 -OL https://archive.archlinux32.org/packages/\$UPGDPAKG && printf \"%s\\n\\n\" \"Finished downloading file '\${UPGDPAKG##*/}' from https://archive.archlinux32.org.\" || _PRTERROR_
else
printf \"%s\\n\" \"File '\${UPGDPAKG##*/}' is already downloaded.\"
fi
done

_PMUEOEP2_() {
if [ ! -f "/var/run/lock/${INSTALLDIR##*/}/kpmueoep2.lock" ]
then
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [\$3/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} --noconfirm\"
pacman -U \"\${UPGDPKGS[\$1]##*/}\" \"\${UPGDPKGS[\$2]##*/}\" --noconfirm && touch "/var/run/lock/${INSTALLDIR##*/}/kpmueoep2.lock"
else
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\n\" \"[\$3/7]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} --noconfirm\" \" has already been successfully run; Continuing...\"
fi
}

_PMUEOEP3_() {
if [ ! -f "/var/run/lock/${INSTALLDIR##*/}/kpmueoep3.lock" ]
then
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [\$4/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} --noconfirm\"
pacman -U \"\${UPGDPKGS[\$1]##*/}\" \"\${UPGDPKGS[\$2]##*/}\" \"\${UPGDPKGS[\$3]##*/}\" --noconfirm && touch "/var/run/lock/${INSTALLDIR##*/}/kpmueoep3.lock"
else
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[\$4/7]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} --noconfirm\" \" has already been successfully run; Continuing...\"
fi
}

_PMUEOEP4_() {
if [ ! -f "/var/run/lock/${INSTALLDIR##*/}/kpmueoep4.lock" ]
then
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [\$5/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} --noconfirm\" ; pacman -U \"\${UPGDPKGS[\$1]##*/}\" \"\${UPGDPKGS[\$2]##*/}\" \"\${UPGDPKGS[\$3]##*/}\" \"\${UPGDPKGS[\$4]##*/}\" --noconfirm && touch "/var/run/lock/${INSTALLDIR##*/}/kpmueoep4.lock"
else
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[\$5/7]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} --noconfirm\" \" has already been successfully run; Continuing...\"
fi
}

_PMUEOEP5_() {
if [ ! -f "/var/run/lock/${INSTALLDIR##*/}/kpmueoep5.lock" ]
then
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[0m...\\n\" \"Running \${0##*/} [\$6/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} \${UPGDPKGS[\$5]##*/} --noconfirm\" ; pacman -U \"\${UPGDPKGS[\$1]##*/}\" \"\${UPGDPKGS[\$2]##*/}\" \"\${UPGDPKGS[\$3]##*/}\" \"\${UPGDPKGS[\$4]##*/}\" \"\${UPGDPKGS[\$5]##*/}\" --noconfirm && touch "/var/run/lock/${INSTALLDIR##*/}/kpmueoep5.lock"
else
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[\$6/7]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} \${UPGDPKGS[\$5]##*/} --noconfirm\" \" has already been successfully run; Continuing...\"
fi
}

_PMUEOEP2_ 0 1 1
_KEYSGENMSG_
printf \"\\e[1;32m==> \\e[1;37mRunning \${0##*/} \\e[1;32mpacman -Ss keyring --color=always\\e[1;37m...\\n\"
pacman -Ss keyring --color=always || _PRTERROR_
_PMUEOEP5_ 9 10 11 12 13 2
_PMUEOEP4_ 2 3 7 8 3
_PMUEOEP3_ 4 5 6 4
mv -f /tmp/{libcrypto.so.1.0.0,libssl.so.1.0.0} /usr/lib/
sed -i '/^Architecture/s/.*/Architecture = i686/' /etc/pacman.conf
sed -i '/^SigLevel/s/.*/SigLevel    = Never/' /etc/pacman.conf
sed -i 's/^HoldPkg/\#HoldPkg/g' /etc/pacman.conf
if [ ! -f "/var/run/lock/${INSTALLDIR##*/}/kkeyring.lock" ]
then
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [5/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -S archlinux-keyring archlinux32-keyring --noconfirm\"
_KEYSGENMSG_
pacman -S archlinux-keyring archlinux32-keyring --noconfirm && touch "/var/run/lock/${INSTALLDIR##*/}/kkeyring.lock" || _PRTERROR_
else
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[5/7]  The command \" \"pacman -S archlinux-keyring archlinux32-keyring --noconfirm\" \" has already been successfully run; Continuing...\"
fi
sed -i '/^SigLevel/s/.*/SigLevel    = Required DatabaseOptional/' /etc/pacman.conf
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [6/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -S pacman --noconfirm\"
pacman -S pacman --noconfirm || _PRTERROR_
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running \${0##*/} [7/7] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -Su --noconfirm ; Starting full system upgrade\"
rm -f /etc/ssl/certs/ca-certificates.crt
pacman -Su --noconfirm || pacman -Su --noconfirm"
X86IPT=" "
X86INK=":"
else	# architecture versions armv5, armv7, aarch64 and x86_64 of Arch Linux use these options
X86INT=":"
X86IPT="(1/2)"
X86INK="printf \"\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman -S %s --noconfirm --color=always\\\\e[1;37m...\\\\n\" \"\${ARGS[@]} \"
pacman -S \"\${KEYRINGS[@]}\" --noconfirm --color=always || pacman -S \"\${KEYRINGS[@]}\" --noconfirm --color=always
printf \"\\\\n\\\\e[1;32m(2/2) \\\\e[0;34mWhen \\\\e[1;37mGenerating pacman keyring master key\\\\e[0;34m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this part of the install procedure.  To generate as much entropy as possible quickly, watch and listen to a file on your device.  \\\\n\\\\nThe program \\\\e[1;32mpacman-key\\\\e[0;34m will want as much entropy as possible when generating keys.  Entropy is also created through tapping, sliding, one, two and more fingers tapping with short and long taps.  When \\\\e[1;37mAppending keys from archlinux.gpg\\\\e[0;34m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Put even simpler, just do something on device.  Browsing files will create entropy on device.  Slowly swiveling the device in space and time will accelerate the installation process.  This method alone might not generate enough entropy (a measure of randomness in a closed system) for the process to complete quickly.  Use \\\\e[1;32mbash ~%s/bin/we \\\\e[0;34min a new Termux session to watch entropy on device.\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman-key --populate\\\\e[1;37m...\\\\n\" \"$DARCH\"
$ECHOEXEC pacman-key --populate
printf \"\\\\e[1;32m==>\\\\e[1;37m Running \\\\e[1;32mpacman -Ss keyring --color=always\\\\e[1;37m...\\\\n\"
pacman -Ss keyring --color=always"
fi
_CFLHDR_ usr/local/bin/keys
cat >> usr/local/bin/keys <<- EOM
declare -a KEYRINGS

_KEYSGENMSG_() {
printf "\\\\n\\\\e[1;32m%s \\\\e[0;34mWhen \\\\e[1;37mGenerating pacman keyring master key\\\\e[0;34m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this part of the install procedure.  To generate as much entropy as possible quickly, watch and listen to a file on your device.  \\\\n\\\\nThe program \\\\e[1;32mpacman-key\\\\e[0;34m will want as much entropy as possible when generating keys.  Entropy is also created through tapping, sliding, one, two and more fingers tapping with short and long taps.  When \\\\e[1;37mAppending keys from archlinux.gpg\\\\e[0;34m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Put even simpler, just do something on device.  Browsing files will create entropy on device.  Slowly swiveling the device in space and time will accelerate the installation process.  This method alone might not generate enough entropy (a measure of randomness in a closed system) for the process to complete quickly.  You can use \\\\e[1;32mbash ~%s/bin/we \\\\e[0;34min a new Termux session to watch entropy on device.\\\\e[0m\\\\n" "$X86IPT" "$DARCH"
}

_GENEN_() {	# This for loop generates entropy on device.
N=16 # Number of loop generations for generating entropy.
for I in "\$(seq 1 "\$N")"; do
nice -n 20 ls -alR /usr >/dev/null &
nice -n 20 find /usr >/dev/null &
nice -n 20 cat /dev/urandom >/dev/null &
done
}

_PRINTTAIL_() {
printf "\\\\n\\\\e[0;32m%s %s %s\\\\e[1;34m: \\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\e[0m" "TermuxArch \${0##*/}" "\${ARGS[@]}" "\$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s: DONE 📱 \007'  "'\${0##*/} \${ARGS[@]}'"
}

_PRTERROR_() {
printf "\\n\\e[1;31merror: \\e[1;37m%s\\e[0m\\n\\n" "Please correct the error(s) and/or warning(s) and run '\${0##*/} \${ARGS[@]}' again."
}

_TRPET_() { # on exit
printf "\\\\e[?25h\\\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\$KEYRINGS[@]"
}

trap _TRPET_ EXIT
## keys begin ##################################################################
if [[ -z "\${1:-}" ]]
then
KEYRINGS[0]="archlinux-keyring"
KEYRINGS[1]="archlinuxarm-keyring"
KEYRINGS[2]="ca-certificates-utils"
elif [[ "\$1" = x86 ]]
then
KEYRINGS[0]="archlinux-keyring"
KEYRINGS[1]="archlinux32-keyring"
KEYRINGS[2]="ca-certificates-utils"
elif [[ "\$1" = x86_64 ]]
then
KEYRINGS[0]="archlinux-keyring"
KEYRINGS[1]="ca-certificates-utils"
else
KEYRINGS=""
fi
ARGS="\${KEYRINGS[@]}"
printf '\033]2;  🔑 TermuxArch %s 📲 \007' "'\${0##*/} \${ARGS[@]}'"
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32m%s \\\\e[0;32m%s\\\\e[1;37m...\\\\n" "\${0##*/} \${ARGS[@]}" "v\$VERSIONID"
_GENEN_ ; kill \$! &
_KEYSGENMSG_
_DOPSY_() {
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman -Sy\\\\e[1;37m...\\\\n"
$ECHOEXEC $ECHOSYNC pacman -Sy
}
_DOPSY_ || _DOPSY_ || _PRTERROR_
_DOKPI_() {
if [ ! -f "/run/lock/${INSTALLDIR##*/}/kpi.lock" ]
then
printf "\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman-key --init\\\\e[1;37m...\\\\n"
$ECHOEXEC pacman-key --init && touch "/run/lock/${INSTALLDIR##*/}/kpi.lock" || _PRTERROR_
else
printf "\\\\e[1;32m==> \\\\e[1;37mAlready initialized with command \\\\e[1;32mpacman-key --init\\\\e[1;37m...\\\\n"
fi
}
_DOKPI_ || _DOKPI_
umask 000
chmod 4777 /usr/bin/newgidmap
chmod 4777 /usr/bin/newuidmap
chmod 700 /etc/pacman.d/gnupg
umask 022
_DOPP_() {
if [ ! -f "/var/run/lock/${INSTALLDIR##*/}/kpp.lock" ]
then
printf "\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman-key --populate\\\\e[1;37m...\\\\n"
$ECHOEXEC pacman-key --populate && touch "/var/run/lock/${INSTALLDIR##*/}/kpp.lock" || _PRTERROR_
else
printf "\\\\e[1;32m==> \\\\e[1;37mAlready populated with command \\\\e[1;32mpacman-key --populate\\\\e[1;37m...\\\\n"
fi
}
_DOPP_ || _DOPP_
printf "\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mpacman -Ss keyring --color=always\\\\e[1;37m...\\\\n"
pacman -Ss keyring --color=always || _PRTERROR_
$X86INT
$X86INK
## keys EOF
EOM
chmod 700 usr/local/bin/keys
}

_ADDmakefakeroottcp_() {
_CFLHDR_ usr/local/bin/makefakeroottcp "# build and install fakeroot-tcp"
cat >> usr/local/bin/makefakeroottcp <<- EOM
_DOMAKEFAKEROOTTCP_() {
_PRTERROR_() {
printf "\\n\\e[1;31merror: \\e[1;37m%s\\e[0m\\n\\n" "Please correct the error(s) and/or warning(s) if possible, and run '\${0##*/} \${ARGS[@]}' again."
exit
}
if [ "\$UID" = 0 ]
then
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ERROR:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..."
else
[ ! -f "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" ] && patchmakepkg || printf "\\\\e[0;33m%s\\\\e[0m\\\\n" "Lock file "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" found;  Continuing..."
printf "%s\\\\n" "Preparing to build and install fakeroot-tcp with \${0##*/} $VERSIONID: "
if ([[ ! "\$(command -v automake)" ]] || [[ ! "\$(command -v git)" ]] || [[ ! "\$(command -v gcc -v)" ]] || [[ ! "\$(command -v libtool)" ]] || [[ ! "\$(command -v po4a)" ]]) 2>/dev/null
then
pci automake base base-devel fakeroot git gcc libtool po4a || printf "\\n\\e[1;31mERROR: \\e[7;37m%s\\e[0m\\n\\n" "Please correct the error(s) and/or warning(s) by running command 'pci automake base base-devel fakeroot git gcc go libtool po4a' as root user.  You can do this without closing this session by running command \"$STARTBIN command 'pci automake base base-devel fakeroot git gcc go libtool po4a'\"in a new Termux session. Then you can return to this session and run '\${0##*/} \${ARGS[@]}' again."
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
touch "/run/lock/${INSTALLDIR##*/}/makefakeroottcp_FUNDOPKGBUILD_.lock"
}
cd fakeroot-tcp
[ ! -f "/run/lock/${INSTALLDIR##*/}/makefakeroottcp_FUNDOPKGBUILD_.lock" ] && _FUNDOPKGBUILD_
printf "%s\\\\n" "Running command 'nice -n 20 makepkg -irs';  Building and attempting to install 'fakeroot-tcp' with '\${0##*/}' $VERSIONID.  Please be patient..."
nice -n 20 makepkg -irs || _PRTERROR_
libtool --finish /usr/lib/libfakeroot || _PRTERROR_
touch "/run/lock/${INSTALLDIR##*/}/makefakeroottcp.lock"
fi
printf "%s\\\\n" "Building and installing fakeroot-tcp: DONE 🏁"
}
[ ! -f "/run/lock/${INSTALLDIR##*/}/makefakeroottcp.lock" ] && _DOMAKEFAKEROOTTCP_ || printf "%s\\\\n" "Please remove file "/run/lock/${INSTALLDIR##*/}/makefakeroottcp.lock" in order to rebuild fakeroot-tcp with \${0##*/} $VERSIONID."
## makefakeroottcp EOF
EOM
chmod 700 usr/local/bin/makefakeroottcp
}

_ADDmakeyay_() {
_CFLHDR_ usr/local/bin/makeyay "# build and install command yay; Contributors https://github.com/cb125 and https://github.com/SampsonCrowley"
cat >> usr/local/bin/makeyay <<- EOM
_PRTERROR_() {
printf "\\n\\e[1;31merror: \\e[1;37m%s\\e[0m\\n\\n" "Please correct the error(s) and/or warning(s) if possible, and run '\${0##*/} \${ARGS[@]}' again."
exit
}
if [ "\$UID" = 0 ]
then
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;31m%s\\\\e[0m\\\\n" "ERROR:" "  Script '\${0##*/}' should not be used as root:  The command 'addauser' creates user accounts in Arch Linux in Termux PRoot and configures these user accounts for the command 'sudo':  The 'addauser' command is intended to be run by the Arch Linux in Termux PRoot root user:  To use 'addauser' directly from Termux you can run \"$STARTBIN command 'addauser user'\" in Termux to create this account in Arch Linux Termux PRoot:  The command '$STARTBIN help' has more information about using '$STARTBIN':  " "Exiting..."
else
_PRMAKE_() {
printf "\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mnice -n 20 makepkg -irs --noconfirm\\\\e[1;37m...\\\\n"
}
printf "\\\\e[0;32m%s\\\\e[0m\\\\n" "Building and installing 'yay':"
[ ! -f "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" ] && patchmakepkg
if ([[ ! "\$(command -v fakeroot)" ]] || [[ ! "\$(command -v git)" ]] || [[ ! "\$(command -v go)" ]]) 2>/dev/null
then
pci base base-devel fakeroot gcc git go || pci base base-devel fakeroot gcc git go || printf "\\n\\e[1;31mERROR: \\e[7;37m%s\\e[0m\\n\\n" "Please correct the error(s) and/or warning(s) by running command 'pci base base-devel fakeroot gcc git go' as root user.  You can do this without closing this session by running command \" $STARTBIN command 'pci base base-devel fakeroot gcc git go' \"in a new Termux session. Then you can return to this session and run '\${0##*/} \${ARGS[@]}' again."
fi
cd
[ ! -d yay ] && gcl https://aur.archlinux.org/yay.git
cd yay && _PRMAKE_ && nice -n 20 makepkg -irs --noconfirm || printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\n" "ERROR: " "The command 'nice -n 20 makepkg -irs --noconfirm' did not run as expected; CONTINUING..."
printf "\\\\e[0;32m%s\\\\n%s\\\\n%s\\\\e[1;32m%s\\\\e[0m\\\\n" "Paths that can be followed after building 'yay' are 'yay cmatrix' which builds matrix screensavers.  The commands 'yay pikaur|pikaur-git|tpac' build more aur installers which can also be used to download aur repositories and build packages like with 'yay' in your Android smartphone, tablet, wearable and more.  Did you know that 'android-studio' is available with the command 'yay android'?" "If you have trouble importing keys, this command 'gpg --keyserver keyserver.ubuntu.com --recv-keys 71A1D0EFCFEB6281FD0437C71A1D0EFCFEB6281F' might help.  Change the number to the number of the key being imported." "Building and installing yay: " "DONE 🏁"
fi
## makeyay EOF
EOM
chmod 700 usr/local/bin/makeyay
}

_ADDorcaconf_() {
_CFLHDR_ usr/local/bin/orcaconf "# Contributor https://github.com/JanuszChmiel" "# Reference https://github.com/SDRausty/termux-archlinux/issues/66 Let us expand setupTermuxArch so users can install Orca screen reader (assistive technology) and also have VNC support added easily."
cat >> usr/local/bin/orcaconf <<- EOM
[[ -f "/run/lock/${INSTALLDIR##*/}/orcaconf.lock" ]] && printf "%s\\\\n" "Already configured orca: DONE 🏁" && exit
_INSTALLORCACONF_() {
[[ ! -f "/run/lock/${INSTALLDIR##*/}/orcaconfinstall.lock" ]] && (nice -n 18 pci espeak-ng mate mate-extra orca pulseaudio-alsa tigervnc || nice -n 18 pci espeak-ng mate mate-extra orca pulseaudio-alsa tigervnc) && touch "/run/lock/${INSTALLDIR##*/}/orcaconfinstall.lock" || printf "%s\\n" "_INSTALLORCACONF_ \${0##*/} did not completed as expected; Continuing..."
}
_INSTALLORCACONF_ || _INSTALLORCACONF_ || (printf "%s\\n" "_INSTALLORCACONF_ \${0##*/} did not completed as expected.  Please check for errors and run \${0##*/} again." && exit)
csystemctl || printf "\\e[1;31m%s\\e[0m\\n" "command 'csystemctl' did not completed as expected"
[[ ! -f "/run/lock/${INSTALLDIR##*/}/orcaconf.lock" ]] && touch "/run/lock/${INSTALLDIR##*/}/orcaconf.lock"
orcarun || printf "\\e[1;31m%s\\e[0m\\n" "command 'orcarun' did not completed as expected"
## orcaconf EOF
EOM
chmod 700 usr/local/bin/orcaconf
_ADDorcarun_() {
_CFLHDR_ usr/local/bin/orcarun "# Contributor https://github.com/JanuszChmiel " "# Reference https://github.com/SDRausty/termux-archlinux/issues/66 Let's expand setupTermuxArch so users can install Orca screen reader (assistive technology) and also have VNC support added easily."
cat >> usr/local/bin/orcarun <<- EOM
if ! command Xvnc
then
orcaconf
else
Xvnc -localhost -geometry 1024x768 -depth 24 -SecurityTypes=None
fi
## orcarun EOF
EOM
chmod 700 usr/local/bin/orcarun
}
_ADDorcarun_
}

_ADDpatchmakepkg_() {
_CFLHDR_ usr/local/bin/patchmakepkg "# patch makepkg;  Contributor https://github.com/petkar"
cat >> usr/local/bin/patchmakepkg <<- EOM
[ -f "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock" ] && printf "%s\\\\n" "Found /run/lock/${INSTALLDIR##*/}/patchmakepkg.lock file;  Already patched makepkg:  DONE 🏁" && exit
printf "%s\\\\n" "Attempting to patch makepkg: "
SDATE="\$(date +%s)"
BKPDIR="$INSTALLDIR/var/backups/${INSTALLDIR##*/}/"
[ ! -d "\$BKPDIR" ] && mkdir -p "\$BKPDIR"
cp /bin/makepkg "\$BKPDIR/makepkg.\$SDATE.bkp"
if [ "\$(awk 'FNR==232{print \$0}' /bin/makepkg)" != "#" ]
then
sed -ie 's/fakeroot -- bash/bash/g' /bin/makepkg
sed -ir 's/\$(fakeroot -v)/fakeroot -v/g' /bin/makepkg
# sed append to beginning of lines
sed -ie 232,234's/.*/# &/' /bin/makepkg
sed -ie 236's/.*/# &/' /bin/makepkg
sed -ie 1178,1189's/.*/# &/' /bin/makepkg
fi
# copy makepkg to /usr/local/bin to update proof it (fail safe measure)
cp /bin/makepkg /usr/local/bin/makepkg
# create lock file to update proof patchmakepkg
touch "/run/lock/${INSTALLDIR##*/}/patchmakepkg.lock"
printf "%s\\\\n" "Attempting to patch makepkg: DONE 🏁"
## patchmakepkg EOF
EOM
chmod 700 usr/local/bin/patchmakepkg
}

_ADDpc_() {
_CFLHDR_ usr/local/bin/pc "# pacman install packages wrapper without system update"
cat >> usr/local/bin/pc <<- EOM
declare -g ARGS="\$@"
umask 0022
_TRPET_() { # on exit
printf "\\\\e[?25h\\\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\$ARGS"
}

_PRINTTAIL_() {
printf "\\\\e[0;32m%s %s %s\\\\e[1;34m: \\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\e[0m" "TermuxArch \${0##*/}" "\$ARGS" "\$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s:DONE 📱 \007' "\${0##*/} \$ARGS"
}

trap _TRPET_ EXIT
## pc begin ####################################################################
printf '\033]2;  🔑 TermuxArch %s 📲 \007' "\${0##*/} \$ARGS"
printf "\\\\e[1;32m==> \\\\e[1;37mRunning TermuxArch command \\\\e[1;32m%s \\\\e[0;32m%s\\\\e[1;37m...\\\\n" "\${0##*/} \$ARGS" "v\$VERSIONID"
[ "\$UID" -eq 0 ] && SUDOCONF="" || SUDOCONF="sudo"
if [[ -z "\${1:-}" ]]
then
printf "\\\\e[1;31m%s \\\\e[0m\\\\n" "Run command '\${0##*/}' with at least one argument: exiting..."
elif [[ "\$1" = "a" ]]
then
\$SUDOCONF pacman --noconfirm --color=always -S base base-devel "\${@:2}"
elif [[ "\$1" = "ae" ]]
then
\$SUDOCONF pacman --noconfirm --color=always -S base base-devel emacs "\${@:2}"
elif [[ "\$1" = "a8" ]]
then
\$SUDOCONF pacman --noconfirm --color=always -S base base-devel emacs jdk8-openjdk "\${@:2}"
else
\$SUDOCONF pacman --noconfirm --color=always -S "\$@"
fi
## pc EOF
EOM
chmod 700 usr/local/bin/pc
}

_ADDpci_() {
_CFLHDR_ usr/local/bin/pci "# pacman install packages wrapper with system update"
cat >> usr/local/bin/pci <<- EOM
declare ARGS="\$@"
umask 0022
_TRPET_() { # on exit
printf "\\\\e[?25h\\\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\$ARGS"
}

_PRINTTAIL_() {
printf "\\\\e[0;32m%s %s %s\\\\e[1;34m: \\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\e[0m" "TermuxArch \${0##*/}" "\$ARGS" "\$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s:DONE 📱 \007' "\${0##*/} \$ARGS"
}

trap _TRPET_ EXIT
## pci begin ###################################################################
[ "\$UID" -eq 0 ] && SUDOCONF="" || SUDOCONF="sudo"
printf "\\\\e[1;32m==> \\\\e[1;37mRunning TermuxArch command \\\\e[1;32m%s \\\\e[0;32m%s\\\\e[1;37m...\\\\n" "\${0##*/} \$ARGS" "v\$VERSIONID"
if [[ -z "\${1:-}" ]]
then
\$SUDOCONF pacman --noconfirm --color=always -Syu
elif [[ "\$1" = "e" ]]
then
\$SUDOCONF pacman --noconfirm --color=always -Syu base base-devel emacs "\${@:2}"
elif [[ "\$1" = "e8" ]]
then
\$SUDOCONF pacman --noconfirm --color=always -Syu base base-devel emacs jdk8-openjdk "\${@:2}"
elif [[ "\$1" = "e10" ]]
then
\$SUDOCONF pacman --noconfirm --color=always -Syu base base-devel emacs jdk10-openjdk "\${@:2}"
else
\$SUDOCONF pacman --noconfirm --color=always -Syu "\$@"
fi
## pci EOF
EOM
chmod 700 usr/local/bin/pci
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

_ADDprofile_() {
[ -e "$HOME"/.profile ] && ([ -e root/.profile ] && _DOTHRF_ "root/.profile") && (grep -s proxy "$HOME"/.profile | grep -s "export" > root/.profile) ||:
touch root/.profile
}

_ADDresolvconf_() {
[ ! -d run/systemd/resolve ] && mkdir -p run/systemd/resolve
cat > run/systemd/resolve/resolv.conf <<- EOM
nameserver 8.8.8.8
nameserver 8.8.4.4
EOM
_ADDTORESOLVE_() {
cat >> etc/resolv.conf <<- EOM
nameserver 8.8.8.8
nameserver 8.8.4.4
EOM
}
_CHECKRESOLVE_() {
[ ! -d etc ] && mkdir -p etc
if [ -f etc/resolv.conf ]
then
if ! grep -q 'nameserver 8.8.8.8' etc/resolv.conf
then
_ADDTORESOLVE_
fi
fi
}
_CHECKRESOLVE_
}

_ADDstriphtmlcodefromfile_() { _CFLHDR_ usr/local/bin/striphtmlcodefromfile "#strip html code from file" ; printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = \"0\" ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user :\" \" the command 'addauser username' creates user accounts in $INSTALLDIR : the command '$STARTBIN command addauser username' can create user accounts in $INSTALLDIR from Termux : a default user account is created during setup : the default username 'user' can be used to access the PRoot system employing a user account : command '$STARTBIN help' has more information : \" \"exiting...\" && exit" "[ ! -x \"\$(command -v tree)\" ] && pci sed && sed || sed -n '/^$/!{s/<[^>]*>//g;p;}' \"\$@\"" "## striphtmlcodefromfile EOF" >> usr/local/bin/striphtmlcodefromfile ; chmod 700 usr/local/bin/striphtmlcodefromfile ; }

_ADDt_() {
_CFLHDR_ usr/local/bin/t
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user :\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/} : the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux : a default user account is created during setup : the default username 'user' can be used to access the PRoot system employing a user account : command '$STARTBIN help' has more information : \" \"exiting...\" && exit" "[ ! -x \"\$(command -v tree)\" ] && pci tree && tree \"\$@\" || tree \"\$@\"" "## t EOF" >> usr/local/bin/t
chmod 700 usr/local/bin/t
}

_ADDtimings_() {
_CFLHDR_ usr/local/bin/timings "# Developed at [Terminal output speed issues](https://github.com/termux/termux-app/issues/603) Contributor evg-zhabotinsky"
cat >> usr/local/bin/timings <<- EOM
dd if=/dev/urandom bs=1K count=100 | hexdump -C >500KBfile.txt
for TIMING in 0 1 2 3; do
echo \$TIMING
sleep 1
time nice -n 20 cat 500KBfile.txt
sleep 2
done
## timings EOF
EOM
chmod 700 usr/local/bin/timings
}

_ADDthstartarch_() {
_CFLHDR_ usr/local/bin/th"$STARTBIN"
cat >> usr/local/bin/th"$STARTBIN" <<- EOM
_PRTERROR_() {
printf "\\e[1;31mERROR :\\e[1;37m%s\\e[0m\\n" " Please run '\${0##*/}' again."
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
## th"$STARTBIN" EOF
EOM
chmod 700 usr/local/bin/th"$STARTBIN"
}

_ADDtools_() {	# developing implementaion : working system tools that work can be added to array PRFXTOLS
if [[ -z "${EDO01LCR:-}" ]]
then
if [[ "$CPUABI" = "$CPUABIX86" ]] || [[ "$CPUABI" = i386 ]]
then	# set customized commands for Arch Linux 32 architecture
PRFXTOLS=(awk top)
else
PRFXTOLS=(top)
fi
elif [[ $EDO01LCR = 0 ]]
then
PRFXTOLS="am awk dpkg getprop grep gzip ping ps sed top which $(compgen -c|grep termux- || find $PREFIX/bin -type f -executable -name termux-)"
fi
for STOOL in ${PRFXTOLS[@]}
do
WHICHSTOOL="$(which $STOOL)" && cp "$WHICHSTOOL" "$INSTALLDIR/usr/local/bin/$STOOL" && printf "%s\\n" "cp $WHICHSTOOL $INSTALLDIR/usr/local/bin/$STOOL: continuing..." || printf "%s\\n" "System tool $STOOL cannot be found: continuing..."
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
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mls -alRr --color=always \$HOME\\\\e[1;37m...\\\\n\\\\n"
sleep 1
ls -alRr --color=always "\$HOME"
sleep 4
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mcat \$HOME/.bash_profile\\\\e[1;37m...\\\\n\\\\n"
sleep 1
cat "\$HOME"/.bash_profile
sleep 4
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mcat \$HOME/.bashrc\\\\e[1;37m...\\\\n\\\\n"
sleep 1
cat "\$HOME"/.bashrc
sleep 4
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32mcat /usr/local/bin/pci\\\\e[1;37m...\\\\n\\\\n"
sleep 1
cat /usr/local/bin/pci
printf "\\\\e[1;32m\\\\n%s \\\\e[38;5;121m%s \\\\n\\\\n\\\\e[4;38;5;129m%s\\\\e[0m\\\\n\\\\n\\\\e[1;34m%s \\\\e[38;5;135m%s\\\\e[0m\\\\n\\\\n" "==>" "Short tour is complete; Scroll up if you wish to study the output.  Run this script again at a later time, and it might be surprising at how this environment changes over time. " "If you are new to *nix, http://tldp.org has documentation." "IRC: " "https://wiki.archlinux.org/index.php/IRC_channel"
## tour EOF
EOM
chmod 700 usr/local/bin/tour
}

_ADDtrim_() {
_CFLHDR_ usr/local/bin/trim
cat >> usr/local/bin/trim <<- EOM
printf "\\\\e[1;32m==> \\\\e[1;37mRunning \\\\e[1;32m%s\\\\e[1;37m...\\\\n\\\\n" "\${0##*/}"
_PMFSESTRING_() {
printf "\\\\e[1;31m%s\\\\e[1;37m%s\\\\e[1;32m%s\\\\e[1;37m%s\\\\n\\\\n" "Signal generated in '\$1' : Cannot complete task : " "Continuing..."
printf "\\\\e[1;34m%s\\\\e[0;34m%s\\\\e[1;34m%s\\\\e[0;34m%s\\\\e[1;34m%s\\\\e[0m\\\\n\\\\n" "  If you find improvements for " "setupTermuxArch" " and " "\$0" " please open an issue and accompanying pull request."
}
_SUTRIM_() {
\$SUTRIM pacman -Sc --noconfirm --color=always || _PMFSESTRING_ "\${SUTRIM}pacman -Sc \${0##*/}"
}
if [[ "\$UID" -eq 0 ]]
then
SUTRIM=""
else
SUTRIM="sudo "
fi
printf "%s\\\\n" "[1/5] rm -rf /boot/"
rm -rf /boot/
printf "%s\\\\n" "[2/5] rm -rf /usr/lib/firmware"
rm -rf /usr/lib/firmware
printf "%s\\\\n" "[3/5] rm -rf /usr/lib/modules"
rm -rf /usr/lib/modules
printf "%s\\\\n" "[4/5] \$SUTRIM"
_SUTRIM_
printf "%s\\\\n" "[5/5] rm -f /var/cache/pacman/pkg/*xz"
rm -f /var/cache/pacman/pkg/*xz || _PMFSESTRING_ "rm -f \${0##*/}"
printf "\\\\n\\\\e[1;32m%s\\\\e[0m\\\\n\\\\n" "\${0##*/} trim \$@: Done"
## trim EOF
EOM
chmod 700 usr/local/bin/trim
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
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user :\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/} : the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux : a default user account is created during setup : the default username 'user' can be used to access the PRoot system employing a user account : command '$STARTBIN help' has more information : \" \"exiting...\" && exit" "[ ! -x \"\$(command -v vim)\" ] && pci vim && vim \"\${ARGS[@]}\" || vim \"\${ARGS[@]}\"" "## v EOF" >> usr/local/bin/v
chmod 700 usr/local/bin/v
}

_ADDwe_() {
_CFLHDR_ usr/bin/we "# Watch available entropy on device." "# cat /proc/sys/kernel/random/entropy_avail Contributor https://github.com/cb125"
cat >> usr/bin/we <<- EOM
declare -a ARGS

_TRPWE_() { # on exit
printf "\\\\e[?25h\\\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\$ARGS[@]"
}

_PRINTTAIL_() {
printf "\\\\n\\\\e[0m%s \\\\e[0;32m%s %s %s\\\\e[1;34m: \\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\e[0m" "TermuxArch" "\${0##*/}" "\$ARGS"  "\$VERSIONID" "DONE 📱"
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
pci bc
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
## we EOF
EOM
chmod 700 usr/bin/we
}

_ADDyt_() {
_CFLHDR_ usr/local/bin/yt
printf "%s\\n%s\\n%s\\n" "[ \"\$UID\" = 0 ] && printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;31m%s\\n\" \"Cannot run '\${0##*/}' as root user :\" \" the command 'addauser username' creates user accounts in ~/${INSTALLDIR##*/} : the command '$STARTBIN command addauser username' can create user accounts in ~/${INSTALLDIR##*/} from Termux : a default user account is created during setup : the default username 'user' can be used to access the PRoot system employing a user account : command '$STARTBIN help' has more information : \" \"exiting...\" && exit" "[ ! -x \"\$(command -v youtube-dl)\" ] && pci youtube-dl && youtube-dl \"\$@\" || youtube-dl \"\$@\" " "## yt EOF" >> usr/local/bin/yt
chmod 700 usr/local/bin/yt
}

_DOMODdotfiles_() {
# Are you familiar with metacarpals syndrome?  Metacarpals can flare from vibrations.  To disable the silent bell feature replace the contents of this function with a colon (:) as in this example:
# 	_DOMODexample_() {
# 		:
# 	}
_MODdotfile_() {
_MODdotfNF_() {
printf "\\e[0;33mline %s can not be found in %s file \\e[0;34m: adding line %s to %s file \\e[0m\\n" "'$MODFILEADD'" "/${INSTALLDIR##*/}/root/$MODFILENAME" "'$MODFILEADD'" "/${INSTALLDIR##*/}/root/$MODFILENAME"
printf "$MODFILEADD\\n" >> "$INSTALLDIR/root/$MODFILENAME"
}
# add MODFILEADD to file /root/MODFILENAME
[[ -f "$INSTALLDIR/root/$MODFILENAME" ]] && (_DOTHRF_ "root/$MODFILENAME" && ! grep -q "$MODFILEADD" "$INSTALLDIR/root/$MODFILENAME" && _MODdotfNF_ || printf "\\e[0;34mline %s found in %s file\\e[0m\\n" "'$MODFILEADD'" "/${INSTALLDIR##*/}/root/$MODFILENAME") || _MODdotfNF_
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

_PREPPACMANCONF_() {
if [ -f "$INSTALLDIR"/etc/pacman.conf ] # file is found
then # rewrite file for PRoot environment
sed -i 's/^CheckSpace/\#CheckSpace/g' "$INSTALLDIR/etc/pacman.conf"
sed -i 's/^#Color/Color/g' "$INSTALLDIR/etc/pacman.conf"
else
_PSGI1ESTRING_ "Cannot find file $INSTALLDIR/etc/pacman.conf : _PREPPACMANCONF_ archlinuxconfig.bash ${0##*/}"
fi
}

_PREPMOTS_() {
if [[ "$CPUABI" = "$CPUABIX86_64" ]]
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
# archlinuxconfig.bash EOF
