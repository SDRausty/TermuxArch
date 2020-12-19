#!/usr/bin/env bash
## Copyright 2017-2020 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
_ISOCOUNTRYCODES_() {
declare -A ISOCOUNTRYCODES
ISOCOUNTRYCODES=([af]="Afghanistan" [ax]="Åland Islands" [al]="Albania" [dz]="Algeria" [as]="American Samoa" [ad]="Andorra" [ao]="Angola" [ai]="Anguilla" [aq]="Antarctica" [ag]="Antigua and Barbuda" [ar]="Argentina" [am]="Armenia" [aw]="Aruba" [au]="Australia" [at]="Austria" [az]="Azerbaijan" [bs]="The Bahamas" [bh]="Bahrain" [bd]="Bangladesh" [bb]="Barbados" [by]="Belarus" [be]="Belgium" [bz]="Belize" [bj]="Benin" [bm]="Bermuda" [bt]="Bhutan" [bo]="Bolivia" [bq]="Bonaire, Sint Eustatius and Saba" [ba]="Bosnia and Herzegovina" [bw]="Botswana" [bv]="Bouvet Island" [br]="Brazil" [io]="The British Indian Ocean Territory" [bn]="Brunei Darussalam" [bg]="Bulgaria" [bf]="Burkina Faso" [bi]="Burundi" [cv]="Cabo Verde" [kh]="Cambodia" [cm]="Cameroon" [ca]="Canada" [ky]="The Cayman Islands" [cf]="The Central African Republic" [td]="Chad" [cl]="Chile" [cn]="China" [cx]="Christmas Island" [cc]="The Cocos (Keeling) Islands" [co]="Colombia" [km]="The Comoros" [cd]="The Democratic Republic of the Congo" [cg]="The Congo" [ck]="The Cook Islands" [cr]="Costa Rica" [ci]="C&ocirc;te d'Ivoire" [hr]="Croatia" [cu]="Cuba" [cw]="Cura&ccedil;ao" [cy]="Cyprus" [cz]="Czechia" [dk]="Denmark" [dj]="Djibouti" [dm]="Dominica" [do]="The Dominican Republic" [ec]="Ecuador" [eg]="Egypt" [sv]="El Salvador" [gq]="Equatorial Guinea" [er]="Eritrea" [ee]="Estonia" [sz]="Eswatini" [et]="Ethiopia" [fk]="The  Falkland Islands [Malvinas]" [fo]="The Faroe Islands" [fj]="Fiji" [fi]="Finland" [fr]="France" [gf]="French Guiana" [pf]="French Polynesia" [tf]="The French Southern Territories" [ga]="Gabon" [gm]="The Gambia" [ge]="Georgia" [de]="Germany" [gh]="Ghana" [gi]="Gibraltar" [gr]="Greece" [gl]="Greenland" [gd]="Grenada" [gp]="Guadeloupe" [gu]="Guam" [gt]="Guatemala" [gg]="Guernsey" [gn]="Guinea" [gw]="Guinea-Bissau" [gy]="Guyana" [ht]="Haiti" [hm]="Heard Island and McDonald Islands" [va]="The Holy See" [hn]="Honduras" [hk]="Hong Kong" [hu]="Hungary" [is]="Iceland" [in]="India" [id]="Indonesia" [ir]="Iran (Islamic Republic of)" [iq]="Iraq" [ie]="Ireland" [im]="Isle of Man" [il]="Israel" [it]="Italy" [jm]="Jamaica" [jp]="Japan" [je]="Jersey" [jo]="Jordan" [kz]="Kazakhstan" [ke]="Kenya" [ki]="Kiribati" [kp]="The Democratic People's Republic of Korea" [kr]="The Republic of Korea" [kw]="Kuwait" [kg]="Kyrgyzstan" [la]="The Lao People's Democratic Republic" [lv]="Latvia" [lb]="Lebanon" [ls]="Lesotho" [lr]="Liberia" [ly]="Libya" [li]="Liechtenstein" [lt]="Lithuania" [lu]="Luxembourg" [mo]="Macao" [mk]="Republic of North Macedonia" [mg]="Madagascar" [mw]="Malawi" [my]="Malaysia" [mv]="Maldives" [ml]="Mali" [mt]="Malta" [mh]="The Marshall Islands" [mq]="Martinique" [mr]="Mauritania" [mu]="Mauritius" [yt]="Mayotte" [mx]="Mexico" [fm]="Micronesia (Federated States of)" [md]="The Republic of Moldova" [mc]="Monaco" [mn]="Mongolia" [me]="Montenegro" [ms]="Montserrat" [ma]="Morocco" [mz]="Mozambique" [mm]="Myanmar" [na]="Namibia" [nr]="Nauru" [np]="Nepal" [nl]="The Netherlands" [nc]="New Caledonia" [nz]="New Zealand" [ni]="Nicaragua" [ne]="The Niger" [ng]="Nigeria" [nu]="Niue" [nf]="Norfolk Island" [mp]="The Northern Mariana Islands" [no]="Norway" [om]="Oman" [pk]="Pakistan" [pw]="Palau" [ps]="Palestine, State of" [pa]="Panama" [pg]="Papua New Guinea" [py]="Paraguay" [pe]="Peru" [ph]="The Philippines" [pn]="Pitcairn" [pl]="Poland" [pt]="Portugal" [pr]="Puerto Rico" [qa]="Qatar" [re]="R&eacute;union" [ro]="Romania" [ru]="The Russian Federation" [rw]="Rwanda" [bl]="Saint Barth&eacute;lemy" [sh]="Saint Helena, Ascension and Tristan da Cunha" [kn]="Saint Kitts and Nevis" [lc]="Saint Lucia" [mf]="Saint Martin (French part)" [pm]="Saint Pierre and Miquelon" [vc]="Saint Vincent and the Grenadines" [ws]="Samoa" [sm]="San Marino" [st]="Sao Tome and Principe" [sa]="Saudi Arabia" [sn]="Senegal" [rs]="Serbia" [sc]="Seychelles" [sl]="Sierra Leone" [sg]="Singapore" [sx]="Sint Maarten (Dutch part)" [sk]="Slovakia" [si]="Slovenia" [sb]="Solomon Islands" [so]="Somalia" [za]="South Africa" [gs]="South Georgia and the South Sandwich Islands" [ss]="South Sudan" [es]="Spain" [lk]="Sri Lanka" [sd]="The Sudan" [sr]="Suriname" [sj]="Svalbard and Jan Mayen" [se]="Sweden" [ch]="Switzerland" [sy]="Syrian Arab Republic" [tw]="Taiwan (Province of China)" [tj]="Tajikistan" [tz]="Tanzania, United Republic of" [th]="Thailand" [tl]="Timor-Leste" [tg]="Togo" [tk]="Tokelau" [to]="Tonga" [tt]="Trinidad and Tobago" [tn]="Tunisia" [tr]="Turkey" [tm]="Turkmenistan" [tc]="The Turks and Caicos Islands" [tv]="Tuvalu" [ug]="Uganda" [ua]="Ukraine" [ae]="The United Arab Emirates" [gb]="The United Kingdom of Great Britain and Northern Ireland" [um]="The United States Minor Outlying Islands" [us]="The United States of America" [uy]="Uruguay" [uz]="Uzbekistan" [vu]="Vanuatu" [ve]="Venezuela (Bolivarian Republic of)" [vn]="Viet Nam" [vg]="Virgin Islands (British)" [vi]="Virgin Islands (U.S.)" [wf]="Wallis and Futuna" [eh]="Western Sahara" [ye]="Yemen" [zm]="Zambia" [zw]="Zimbabwe")
USERCOUNTRYCODE="$(getprop gsm.operator.iso-country || getprop gsm.sim.operator.iso-country)"
printf "%s\\n" "Looking for ISO country code match;  Please wait a moment..."
# if grep -i "$USERCOUNTRYCODE" <<< "${ISOCOUNTRYCODES[@]}" 1>/dev/null
if [[ ! -z ${ISOCOUNTRYCODES[$USERCOUNTRYCODE]:-} ]]
then
printf '%s' "Found ISO country code match [$USERCOUNTRYCODE]=\"${ISOCOUNTRYCODES[$USERCOUNTRYCODE]}\";  "
else
printf '%s' "Could not find ISO country code match for ${USERCOUNTRYCODE:-UNKNOWNCOUNTRYCODE};  "
fi
printf "%s\\n" "Looking for ISO country code match;  DONE!  Continuing..."
}

_MRCOUNTRIESx86_() {
MRCOUNTRIESx86="("Belarus" "France" "Germany" "Greece" "Russia" "Switzerland" "United States")"
}

_MRCOUNTRIESx86_64_() {
MRCOUNTRIESx86_64="("Worldwide" "Australia" "Austria" "Bangladesh" "Belarus" "Belgium" "Bosnia and Herzegovina" "Brazil" "Bulgaria" "Canada" "Chile" "China" "Colombia" "Croatia" "Czechia" "Denmark" "Ecuador" "Finland" "France" "Georgia" "Germany" "Greece" "Hong Kong" "Hungary" "Iceland" "India" "Indonesia" "Iran" "Ireland" "Israel" "Italy" "Japan" "Kazakhstan" "Kenya" "Latvia" "Lithuania" "Luxembourg" "Moldova" "Netherlands" "New Caledonia" "New Zealand" "North Macedonia" "Norway" "Pakistan" "Paraguay" "Philippines" "Poland" "Portugal" "Romania" "Russia" "Serbia" "Singapore" "Slovakia" "Slovenia" "South Africa" "South Korea" "Spain" "Sweden" "Switzerland" "Taiwan" "Thailand" "Turkey" "Ukraine" "United Kingdom" "United States" "Vietnam")"
}

_BLOOM_() { # Bloom = `setupTermuxArch manual verbose`
[[ -d "$HOME"/TermuxArchBloom ]] && _RMBLOOMQ_
mkdir -p "$HOME"/TermuxArchBloom
cp *sh "$HOME"/TermuxArchBloom
cp setupTermuxArch "$HOME"/TermuxArchBloom
cd "$HOME"/TermuxArchBloom
printf "\\e[1;34m%s\\e[1;32m%s\\e[0m 📲\\n\\n" "TermuxArch Bloom option via " "setupTermuxArch bloom"
ls -agl
printf "\\n\\e[1;34m%s\\e[1;32m%s\\e[1;34m%s\\e[1;32m%s\\e[1;34m%s\\e[1;32m%s\\e[1;34m.\\e[0m\\n" "Use " "cd ~/TermuxArchBloom" " to continue.  Edit any of these files;  Then use " "bash ${0##*/} [options]" " to run the files in " "~/TermuxArchBloom"
printf '\033]2;  TermuxArch Bloom option via `setupTermuxArch bloom` 📲 \007'
}

_EDITFILES_() {
if [[ "$USEREDIT" = "vi" ]]
then
sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vi instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP CMIRROR.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://CMIRROR.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local CMIRROR.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local CMIRROR.\n# Choose only one CMIRROR.  Use :x to save your work.\n# Comment out the Geo-IP CMIRROR	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vi instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$INSTALLDIR"/etc/locale.gen
elif [[ "$USEREDIT" = "vim" ]]
then
sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP CMIRROR.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://CMIRROR.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local CMIRROR.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local CMIRROR.\n# Choose only one CMIRROR.  Use :x to save your work.\n# Please comment out only one Geo-IP CMIRROR	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch vim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$INSTALLDIR"/etc/locale.gen
elif [[ "$USEREDIT" = "nvim" ]]
then
sed -i -e 1,4d "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch neovim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# 17j then i opens edit mode for the Geo-IP CMIRROR.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://CMIRROR.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap ESC to return to command mode in vi.\n# CTRL+d and CTRL+b to find your local CMIRROR.\n# / for search, N and n for next match.\n# Tap x to delete # to uncomment your local CMIRROR.\n# Choose only one CMIRROR.  Use :x to save your work.\n# Comment out the Geo-IP CMIRROR	end G	top gg\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch neovim instructions:	CTR+r is redo.\n# Use the hjkl keys to navigate. <h down j up k l>\n# Numbers are multipliers.  The u is undelete/undo.\n# Tap i for insert, ESC to return to command mode in vi.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Tap x to delete # to uncomment your favorite language(s).\n# Enter the # hash/num/pounds symbol to comment out locales.\n# CTRL+d and CTRL+b for PGUP & PGDN.\n# top gg	bottom G\n# / for search, N and n for next match.\n# Choose as many as you like.  Use :x to save your work.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\n#' "$INSTALLDIR"/etc/locale.gen
else
sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\n# TermuxArch edit instructions:	 Locate the Geo-IP CMIRROR.\n# Enter the # hash/num/pounds symbol to comment it out: \n# Server = http://CMIRROR.archlinuxarm.org/$arch/$repo.\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\n# Choose only one CMIRROR.\n# Delete # to uncomment your local CMIRROR.\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$INSTALLDIR"/etc/pacman.d/mirrorlist
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
printf "The following editor(s) $USEREDTR\\b\\b are present.  Would you like to use \`\\e[1;32m${USEREDTR[$i]}\\e[0;32m\` to edit \`\\e[1;32msetupTermuxArchConfigs.bash\\e[0;32m\`?  "
read -n 1 -p "Answer yes or no [Y|n]. "  yn
else
printf "Change the worldwide CMIRROR to a CMIRROR that is geographically nearby.  Choose only ONE active CMIRROR in the CMIRRORs file that you are about to edit.  The following editor(s) $USEREDTR\\b\\b are present.  Would you like to use \`\\e[1;32m${USEREDTR[$i]}\\e[0;32m\` to edit the Arch Linux configuration files?  "
read -n 1 -p "Answer yes or no [Y|n]. "  yn
fi
if [[ "$yn" = [Yy]* ]] || [[ "$yn" = "" ]]
then
USEREDIT="${USEREDTR[$i]}"
EINDEX=1
break
elif [[ "$yn" = [Nn]* ]]
then
break
else
printf "\\nYou answered \\e[1;36m$yn\\e[1;32m.\\n"
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
printf "\\e[1;34m  Change the worldwide CMIRROR to a CMIRROR that is geographically nearby.  Choose only ONE active CMIRROR in the CMIRRORs file that you are about to edit.  Would you like to use \\e[1;32mnano\\e[1;34m or \\e[1;32mvi\\e[1;34m to edit the Arch Linux configuration files?  "
read -n 1 -p "Answer nano or vi [n|V]? "  nv
fi
if [[ "$nv" = [Nn]* ]]
then
USEREDIT=nano
_NANOIF_
EINDEX=1
break
elif [[ "$nv" = [Vv]* ]] || [[ "$nv" = "" ]]
then
USEREDIT=vi
EINDEX=1
break
else
printf "\\nYou answered \\e[36;1m$nv\\e[1;32m.\\n\\nAnswer nano or vi [n|v].  \\n"
fi
done
printf "\\n"
}

_NANOIF_() {
if [[ ! -x "$PREFIX"/bin/nano ]]
then
apt -o APT::Keep-Downloaded-Packages="true" install "nano" -y
if [[ ! -x "$PREFIX"/bin/nano ]]
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
printf "\\n\\n\\e[0;33m%s\\e[1;33m%s\\e[0;33m%s\\e[1;30m%s\\e[0;33m%s\\n" "TermuxArch:  " "DIRECTORY WARNING!  ~/${INSTALLDIR##*}TermuxArchBloom " "directory detected;  " "setupTermuxArch bloom" " will continue."
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
SPINDLAY="0.$(shuf -i 1-4 -n 1)"
printf "\\e[?25l"
while :
do
printf "  \\b\\b\\b%s\\b" "${SPINNERL:INCREMNT++%${#SPINNERL}:1}"
sleep $SPINDLAY
done
}

_TAMATRIXEND_() {	# print TermuxArch source code as matrix ending
# Information about VT100 terminal codes such as \\e[?25l is available at this https://wiki.bash-hackers.org/scripting/terminalcodes website.
printf "\\e[0;32m"
. "$0" help
tail -n 32 "$0"
. "$0" h
printf "\\e[0m"
printf "\\e[?25h"
}

_TAMATRIX_() {	# partial implemintation; print TermuxArch source code as matrix
_DOTAMSTRIX_() {
printf "\\e[?25l\\e[1;32m%s" "$(tr -d '\n' < $0)"
# split a string from file and print this split string
for EMSTRING in "${TAMATARR[@]}"
do
printf "\\e[0;32m%s" "$EMSTRING"
sleep 0.0"$(shuf -i 0-999 -n 1)"
done
}
IFS=';' read -ra TAMATARR <<< "$(tr -d '\n' < $0)"
if [[ ! -z "${MATRIXLCR:-}" ]]
then
TAMATRIXENDLCR=0
while :
do
_DOTAMSTRIX_
done
else
_DOTAMSTRIX_
fi
_TAMATRIXEND_
}

_WAKELOCK_() {
_PRINTWLA_
am startservice --user 0 -a com.termux.service_wake_lock com.termux/com.termux.app.TermuxService > /dev/null || _PSGI1ESTRING_ "am startservice _WAKELOCK_ necessaryfunctions.bash ${0##/*} : Continuing..."
_PRINTDONE_
}

_WAKEUNLOCK_() {
_PRINTWLD_
am startservice --user 0 -a com.termux.service_wake_unlock com.termux/com.termux.app.TermuxService > /dev/null || _PSGI1ESTRING_ "am startservice _WAKEUNLOCK_ necessaryfunctions.bash ${0##/*} : Continuing..."
_PRINTDONE_
}
## espritfunctions.bash EOF
