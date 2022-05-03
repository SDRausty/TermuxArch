#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################

_MRCOUNTRIESx86_() {
MRCOUNTRIESx86=("Belarus" "France" "Germany" "Greece" "Russia" "Switzerland" "United States")
}

_MRCOUNTRIESx86_64_() {
MRCOUNTRIESx86_64=("Worldwide" "Australia" "Austria" "Bangladesh" "Belarus" "Belgium" "Bosnia and Herzegovina" "Brazil" "Bulgaria" "Canada" "Chile" "China" "Colombia" "Croatia" "Czechia" "Denmark" "Ecuador" "Finland" "France" "Georgia" "Germany" "Greece" "Hong Kong" "Hungary" "Iceland" "India" "Indonesia" "Iran" "Ireland" "Israel" "Italy" "Japan" "Kazakhstan" "Kenya" "Latvia" "Lithuania" "Luxembourg" "Moldova" "Netherlands" "New Caledonia" "New Zealand" "North Macedonia" "Norway" "Pakistan" "Paraguay" "Philippines" "Poland" "Portugal" "Romania" "Russia" "Serbia" "Singapore" "Slovakia" "Slovenia" "South Africa" "South Korea" "Spain" "Sweden" "Switzerland" "Taiwan" "Thailand" "Turkey" "Ukraine" "United Kingdom" "United States" "Vietnam")
}

_BLOOM_() { # Bloom = 'setupTermuxArch manual verbose'
[[ -d "$HOME"/TermuxArchBloom ]] && _RMBLOOMQ_
mkdir -p "$HOME"/TermuxArchBloom
cp {LICENSE,archlinuxconfig.bash,espritfunctions.bash,fbindsfunctions.bash,getimagefunctions.bash,initkeyfunctions.bash,knownconfigurations.bash,maintenanceroutines.bash,necessaryfunctions.bash,setupTermuxArch,printoutstatements.bash} "$HOME"/TermuxArchBloom
cd "$HOME"/TermuxArchBloom || exit 69
printf "\\e[1;34m%s\\e[1;32m%s\\e[0m 📲\\n\\n" "TermuxArch Bloom option via " "setupTermuxArch bloom"
ls -agl
printf "\\n\\e[1;34m%s\\e[1;32m%s\\e[1;34m%s\\e[1;32m%s\\e[1;34m%s\\e[1;32m%s\\e[1;34m.  " "Use " "cd ~/TermuxArchBloom" " to continue.  Edit any of these files;  Then use " "bash ${0##*/} [options]" " to run the files in " "~/TermuxArchBloom"
if [ "$ELCR" = 0 ]
then
{ [[ -d "$INSTALLDIR" ]] && [[ -d "$INSTALLDIR"/root/bin ]] && [[ -d "$INSTALLDIR"/var/binds ]] && [[ -f "$INSTALLDIR"/bin/we ]] && [[ -f "$INSTALLDIR"/usr/bin/env ]] ; } && printf "\\n\\e[0;33m%s\\e[1;33m%s\\e[0;32m%s.\\n\\n" "ＴｅｒｍｕｘＡｒｃｈ NOTICE!  " "The root directory structure of ~/${INSTALLDIR##*/} appears correct; Cannot continue '${0##*/} $ARGS' to create the directory skeleton!  " "Command '${0##*/} bloom customdir' can be appended with customdir.  The command '${0##*/} bloom customdir' can continue building the skeleton structure.  The commands '${0##*/} re[fresh]' will update the TermuxArch files in '~/${INSTALLDIR##*/}' to the most recent version.  Commands '${0##*/} h[e[lp]]' and '$STARTBIN h[elp]' have more information" && exit
## Create ~/TermuxArchBloom directory and Arch Linux in Termux PRoot root directory skeleton.
_PREPTERMUXARCH_
_NAMESTARTARCH_
_SPACEINFO_
_PREPINSTALLDIR_
tree 2>/dev/null || find . -type f -print | sed 's@.*/@@' | sort
fi
exit
}

_EDITFILES_() {
if [[ "$USEREDIT" = "vi" ]]
then
sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vi instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local mirror.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local mirror.\n# Choose only one mirror.  Use;x to save your work.\n# Comment out the Geo-IP mirror	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vi instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use;x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$INSTALLDIR"/etc/locale.gen
elif [[ "$USEREDIT" = "vim" ]]
then
sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local mirror.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local mirror.\n# Choose only one mirror.  Use;x to save your work.\n# Please comment out only one Geo-IP mirror	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use;x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$INSTALLDIR"/etc/locale.gen
elif [[ "$USEREDIT" = "nvim" ]]
then
sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch neovim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local mirror.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local mirror.\n# Choose only one mirror.  Use;x to save your work.\n# Comment out the Geo-IP mirror	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch neovim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use;x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$INSTALLDIR"/etc/locale.gen
else
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch edit instructions:	 Locate the Geo-IP mirror.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Choose only one mirror.\n# Delete # to uncomment your local mirror.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
fi
}

_EDITORS_() {
# populate array of all available Termux editors
AEDS=("emacs" "joe" "jupp" "nano" "ne" "nvim" "micro" "vi" "vim" "zile")
for OEAEDS in ${!AEDS[@]}
do
if [[ -e "$PREFIX/bin/${AEDS[$OEAEDS]}" ]]	# if editor is found
then	# add editor to USEREDTR
USEREDTR+=("${AEDS[$OEAEDS]}")
fi
done
for i in "${!USEREDTR[@]}"
do
_EDQ_
if [[ "$EINDEX" = 1 ]]
then
break
fi
done
}

_EDQ_() {
printf "\\e[0;32m"
for EDQINDEX in "${USEREDTR[@]}"
do
if [[ "$EDQINDEX" = "vi" ]]
then
_EDQ2_
EINDEX=1
break
fi
_EDQA_ "$USEREDTR"
if [[ "$EINDEX" = 1 ]]
then
break
fi
done
}

_EDQA_() {
USEREDIT="${USEREDTR[$i]}"
EINDEX=1
}

_EDQAQUESTION_() {
while true
do
printf "\\n"
if [[ "$OPT" = BLOOM ]] || [[ "$OPT" = MANUAL ]]
then
printf "The following editor(s) %s\\b\\b are present.  Would you like to use '\\e[1;32m%s\\e[0;32m' to edit '\\e[1;32msetupTermuxArchConfigs.bash\\e[0;32m'?  " "$USEREDTR" "${USEREDTR[$i]}"
read -n 1 -p "Answer yes or no [Y|n]. "  yn
else
printf "Change the worldwide mirror to a mirror that is geographically nearby.  Please choose only ONE active mirror in the mirrors file that you are about to edit.  The following editor(s) \\b\\b are present.  Would you like to use '\\e[1;32m%s\\e[0;32m' to edit the Arch Linux configuration files?  " "$USEREDTR" "${USEREDTR[$i]}"
read -n 1 -p "Answer yes or no [Y|n]. "  yn
fi
if [[ "$YN" = [Yy]* ]] || [[ "$YN" = "" ]]
then
USEREDIT="${USEREDTR[$i]}"
EINDEX=1
break
elif [[ "$YN" = [Nn]* ]]
then
break
else
printf "\\nYou answered \\e[1;36m%s\\e[1;32m.\\n" "$YN"
printf "\\nAnswer yes or no [Y|n].  \\n"
fi
done
}

_EDQ2_() {
while true
do
if [[ "$OPT" = BLOOM ]] || [[ "$OPT" = MANUAL ]]
then
printf "\\n\\e[1;34m  Would you like to use \\e[1;32mnano\\e[1;34m or \\e[1;32mvi\\e[1;34m to edit \\e[1;32msetupTermuxArchConfigs.bash\\e[1;34m?  "
read -n 1 -p "Answer nano or vi [n|V]? "  nv
else
printf "\\e[1;34m  Change the worldwide mirror to a mirror  that is geographically nearby.  Choose only ONE active mirror   in the mirror    file that you are about to edit.  Would you like to use \\e[1;32mnano\\e[1;34m or \\e[1;32mvi\\e[1;34m to edit the Arch Linux configuration files?  "
read -n 1 -p "Answer nano or vi [n|V]? "  nv
fi
if [[ "$NV" = [Nn]* ]]
then
USEREDIT=nano
_NANOIF_
EINDEX=1
break
elif [[ "$NV" = [Vv]* ]] || [[ "$NV" = "" ]]
then
USEREDIT="vi"
EINDEX=1
break
else
printf "\\nYou answered \\e[36;1m%s\\e[1;32m.\\n\\nAnswer nano or vi [n|v].  \\n" "$NV"
fi
done
printf "\\n"
}

_NANOIF_() {
if [ ! -x "$PREFIX"/bin/nano ]
then
apt -o APT::Keep-Downloaded-Packages="true" install "nano" -y
if [ ! -x "$PREFIX"/bin/nano ]
then
printf "\\n\\e[7;1;31m%s\\e[0;1;32m %s\\n\\n\\e[0m" "PREREQUISITE EXCEPTION!" "RUN ${0##*/} $ARGS AGAIN..."
printf "\\e]2;%s %s\\007" "RUN ${0##*/} $ARGS" "AGAIN..."
exit
fi
fi
}

_RMBLOOMQ_() {
if [[ -d "$HOME"/TermuxArchBloom ]]
then
printf "\\n\\n\\e[0;33m%s\\e[1;33m%s\\e[0;33m%s\\e[1;30m%s\\e[0;33m%s\\n" "ＴｅｒｍｕｘＡｒｃｈ  " "DIRECTORY NOTICE!  ~/${INSTALLDIR##*}TermuxArchBloom " "directory detected;  " "setupTermuxArch bloom" " will continue."
while true
do
printf "\\n\\e[1;30m"
read -n 1 -p "Refresh $HOME/TermuxArchBloom? [Y|n] " RBUANSWER
if [[ "$RBUANSWER" = [Ee]* ]] || [[ "$RBUANSWER" = [Nn]* ]] || [[ "$RBUANSWER" = [Qq]* ]]
then
printf "\\n"
exit $?
elif [[ "$RBUANSWER" = [Yy]* ]] || [[ "$RBUANSWER" = "" ]]
then
printf "\\e[30m%s\\n" "Uninstalling $HOME/TermuxArchBloom..."
if [[ -d "$HOME"/TermuxArchBloom ]]
then
rm -rf "$HOME"/TermuxArchBloom
fi
printf "%s\\n\\n" "Uninstalling $HOME/TermuxArchBloom done."
break
else
printf "\\n%s\\e[33;1m%s\\e[30m.\\n\\nAnswer \\e[32mYes\\e[30m or \\e[1;31mNo\\e[30m. [\\e[32mY\\e[30m|\\e[1;31mn\\e[30m]\\n" "You answered " "$RBUANSWER"
fi
done
fi
}

_TASPINNER_() {	# print spinner; derivation based on https://github.com/ringohub/sh-spinner and https://github.com/vozdev/termux-setup
INCREMNT=1
if [[ -z "${1:-}" ]]
then
SPINNERL="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
elif [[ "${1//-}" = clock ]]
then
SPINNERL="🕛🕐🕑🕓🕔🕕🕖🕗🕘🕙🕚"
elif [[ "${1//-}" = moon ]]
then
SPINNERL="🌑🌒🌓🌔🌕🌖🌗🌘"
fi
SPINDLAY="0.$(shuf -i 4-8 -n 1)"
printf "\\e[?25l"
while :
do
printf "  \\b\\b\\b%s\\b" "${SPINNERL:INCREMNT++%${#SPINNERL}:1}"
sleep "$SPINDLAY"
done
}

_TAMATRIX_() {	# partial implemintation; print TermuxArch source code as matrix
_DOTAMSTRIX_() {
printf "\\e[?25l\\e[1;32m%s" "$(tr -d '\n' < "$0")"
# split a string from file and print this split string
for EMSTRING in "${TAMATARR[@]}"
do
printf "\\e[0;32m%s" "$EMSTRING"
sleep 0.0"$(shuf -i 0-999 -n 1)"
done
}
IFS=';' read -ra TAMATARR <<< "$(tr -d '\n' < "$0")"
if [[ -n "${MATRIXLCR:-}" ]]
then
TAMATRIXENDLCR=0
while :
do
_DOTAMSTRIX_
done
else
_DOTAMSTRIX_
fi
cat "$0"
_TAMATRIXEND_
}

_TAMATRIXEND_() {	# print 'setupTermuxArch mat[rix]' ending
. "$0" h
tail -n 18 "$0"
. "$0" help
printf "\\e[1;32mPlease run 'bash %s' again at a later time.  Also think about opening an issue and a pull request in order to enhance this feature;  Thank you for using '%s', and please enjoy using Linux on device!  " "${0##*/} $ARGS" "${0##*/} $ARGS"
exit
}

_WAKELOCK_() {
_PRINTWLA_
am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService > /dev/null || _PSGI1ESTRING_ "am startservice _WAKELOCK_ necessaryfunctions.bash ${0##/*}; Continuing..."
_PRINTDONE_
}

_WAKEUNLOCK_() {
_PRINTWLD_
am startservice --user 0 -a com.termux.service_wake_unlock com.termux/com.termux.app.TermuxService > /dev/null || _PSGI1ESTRING_ "am startservice _WAKEUNLOCK_ necessaryfunctions.bash ${0##/*}; Continuing..."
_PRINTDONE_
}
# espritfunctions.bash FE
