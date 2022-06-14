#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
declare -a USRINITFILES	# declare array for user init files
USRINITFILES=(BASH_PROFILEFILE BASHRCFILE CSHRCFILE EMACSITFILE GITCONFIGFILE INITRCFILE INPUTRCFILE VIMRCFILE PROFILEFILE ZSHRCFILE)
_ADDADDS_() {
_ADDREADME_
_ADDae_
_ADDauser_
printf '\e[0;32mGenerating dot files:  \e[1;32mBEGUN…\n'
_ADDbash_logout_
_ADDbash_profile_
_ADDbashrc_
_ADDbindexample.prs_
_ADDcams_
_ADDcshrc_
_ADDcdtd_
_ADDcdth_
_ADDcdtmp_
_ADDch_
_ADDchperms.cache+gnupg_
_ADDcsystemctl_
_ADDcolorizebashrc_
_ADDes_
_ADDexd_
_ADDfibs_
_ADDga_
_ADDgcl_
_ADDgclone_
_ADDgcm_
_ADDgitconfig_
_ADDgp_
_ADDgpl_
_ADDgsu_
_ADDgmu_
_ADDhunf_
_ADDhunw_
_ADDinfo_
_ADDinitfbinds_
_ADDinitrc_
_ADDinputrc_
_ADDkeys_
_ADDmakelibguestfs_
_ADDmakeauraclegit_
_ADDmakeaurto_
_ADDmakeaurbauerbill_
_ADDmakeaurfakeroottcp_
_ADDmakeaurghcuphs_
_ADDmakeaurhelpers_
_ADDmakeaurjqgit_
_ADDmakeaurpacaur_
_ADDmakeaurpacaurgit_
_ADDmakeaurpackagequery_
_ADDmakeaurpakku_
_ADDmakeaurpakkugit_
_ADDmakeaurpakkugui_
_ADDmakeaurpakkuguigit_
_ADDmakeaurparu_
_ADDmakeaurparubin_
_ADDmakeaurparugit_
_ADDmakeaurparuz_
_ADDmakeaurpbget_
_ADDmakeaurpikaur_
_ADDmakeaurpikaurgit_
_ADDmakeaurpipessh_
_ADDmakeaurpkgbuilder_
_ADDmakeaurpkgbuildergit_
_ADDmakeaurpm2ml_
_ADDmakeaurpowerpill_
_ADDmakeaurpopularpackages_
_ADDmakeaurpyinstaller_
_ADDmakeaurpyinstallerhookscontrib_
_ADDmakeaurpythonaltgraph_
_ADDmakeaurpython3colorsysplus_
_ADDmakeaurpython3memoizedb_
_ADDmakeaurpython3xcgf_
_ADDmakeaurpython3xcpf_
_ADDmakeaurpython3aur_
_ADDmakeaurpuyo_
_ADDmakeaurrepoctl_
_ADDmakeaurrepoctlgit_
_ADDmakeaurrepofish_
_ADDmakeaurrustup_
_ADDmakeaurshellcheckbin_
_ADDmakeaurshellcheckgit_
_ADDmakeaurshellcheckgitstatic_
_ADDmakeaurtrizen_
_ADDmakeaurtrizengit_
_ADDmakeaurutils_
_ADDmakeaurutilsgit_
_ADDmakeauryaah_
_ADDmakeauryay_
_ADDmakeaurzigzag_
_ADDmakefakeroottcp_
_ADDmakeksh_
_ADDmakeyay_
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
if [ -n "${VLORALCR:-}" ]
then
_ADDprofileetc_
_ADDprofileusretc_
fi
_ADDresolvconf_
_PREPMOTS_
_ADDmota_
_ADDmotd_
_ADDmoto_
_ADDstriphtmlcodefromfile_
_ADDt_
_ADDtlmgrinstaller_
[ -f $TMXRCHBNDS/top ] ||  _ADDtop_
_ADDthstartarch_
_ADDtimings_
# _ADDtools_
_ADDtour_
_ADDtrim_
_ADDv_
_ADDwe_
_ADDyt_
_ADDzshrc_
}
_ADDauser_() {
_CFLHDR_ $TMXRCHBNDS/addauser "# add Arch Linux in TermuxArch PRoot QEMU user"
cat >> $TMXRCHBNDS/addauser <<- EOM
_HUSDIRC_() {
if [ "\$UID" != 0 ]
then
WHOAMI="\$(whoami)"
printf "\\\\e[1;31mUSAGE:\\\\e[1;37m  %s\\\\e[1;31m:  Exiting...\\\\e[0m\\\\n" "Script '\${0##*/}' should be run using the root account, not the '\$WHOAMI' account.  Alternatively '\${0##*/}' can be used with the 'sudo' command, 'sudo \${0##*/} user'"
exit 202
fi
if [ \$# = 0 ]
then
printf "\\\\e[1;31mUSAGE: \\\\e[1;37m'addauser username'\\\\e[1;32m: Exiting...\\\\n"
exit 201
fi
if [[ -d "/home/\$1" ]]
then
printf "\\\\e[1;33mDirectory: \\\\e[1;37m'/home/%s exists'\\\\e[0;32m: Exiting...\\\\n" "\$1"
else
_FUNADDU_ "\$@"
fi
}
_FUNADDU_() {
command -v sudo 1>/dev/null || { "$TMXRCHBNDR"/pc sudo || "$TMXRCHBNDR"/pc sudo ; }
printf "\\\\e[0;32m%s\\\\n\\\\e[1;32m" "Adding Arch Linux in TermuxArch PRoot QEMU user '\$1' and creating Arch Linux in TermuxArch PRoot QEMU user \$1's home directory in /home/\$1..."
[ -f /etc/sudoers ] || :>/etc/sudoers
sed -i "/# %wheel ALL=(ALL) NOPASSWD: ALL/ s/^# *//" /etc/sudoers
sed -i "/# ALL ALL=(ALL) ALL/ s/^# *//" /etc/sudoers
sed -i "s/# ALL ALL=(ALL) ALL/ALL ALL=(ALL) NOPASSWD: ALL/g" /etc/sudoers
printf '%s\\n' "\$1    ALL=(ALL) ALL" >> /etc/sudoers
grep -q 'ftp_proxy' /etc/sudoers || printf "%s\\\\n" 'Defaults env_keep += "ftp_proxy http_proxy https_proxy"' >> /etc/sudoers
sed -i "s/required/sufficient/g" /etc/pam.d/su
sed -i "s/^#auth/auth/g" /etc/pam.d/su
useradd -k /root -m -s /bin/bash "\$1" -U
usermod "\$1" -aG wheel
chage -I -1 -m 0 -M -1 -E -1 "\$1"
passwd -d "\$1"
chmod 775 "/home/\$1"
sed -i "s/\$1:x/\$1:/g" /etc/passwd
printf "\\\\e[0;32m%s\\\\e[1;32m%s\\\\e[0;32m%s\\\\e[1;32m%s\\\\e[0;32m%s\\\\e[1;32m%s\\\\e[0;32m%s\\\\e[1;32m%s\\\\e[0;32m%s\\\\e[0m\\\\n" "Added Arch Linux in TermuxArch PRoot QEMU user " "'\$1'" " and configured user '\$1' for use with the Arch Linux command 'sudo'.  Created Arch Linux user \$1's home directory in /home/\$1.  To use this account run " "'$STARTBIN login \$1'" " from the shell in Termux.  To add user accounts you can use " "'addauser \$1'" " in Arch Linux and " "'$STARTBIN c[ommand] addauser \$1'" " in a default Termux shell.  Please do not nest proot in proot by using '$STARTBIN' in '$STARTBIN' as this is known to cause issues for users of PRoot."
}
_PMFSESTRING_() {
printf "\\\\e[1;31m%s\\\\e[0;31m%s\\\\e[0;36m%s\\\\n\\\\n" "Signal generated in '\$1'; " "Cannot complete task; " "Continuing..."
printf "\\\\e[1;34m%s\\\\e[0;34m%s\\\\e[1;34m%s\\\\e[0;34m%s\\\\e[1;34m%s\\\\e[0m\\\\n\\\\n" "  If you find improvements for " "${0##*}" " and " "\${0##*}" " please open an issue and an accompanying pull request."
}
_HUSDIRC_ "\$@"
## $INSTALLDIR$TMXRCHBNDR/addauser FE
EOM
chmod 755 $TMXRCHBNDS/addauser
}

_ADDkeys_() {
if [[ "$CPUABI" = "$CPUABIX86" ]]
then	# set customized commands for Arch Linux 32 architecture
X86INT="_CURLDWND_() { { [ \"\${CURLDWNDVAR_:-}\" = 0 ] && curl -C - --insecure --fail --retry 4 -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\".sig -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\" ; } || { curl -C - --fail --retry 4 -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\".sig -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\" || { CURLDWNDVAR_=0 && printf '%s\\n' \"Running command 'curl --insecure';  Continuing...\" && curl -C - --insecure --fail --retry 4 -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\".sig -OL https://archive.archlinux32.org/packages/\"\$UPGDPAKG\" ; } ; } ; }

UPGDPKGS=(\"a/archlinux-keyring/archlinux-keyring-20191219-1.0-any.pkg.tar.xz\" \"a/archlinux32-keyring/archlinux32-keyring-20191230-1.0-any.pkg.tar.xz\" \"g/glibc/glibc-2.28-1.1-i686.pkg.tar.xz\" \"l/linux-api-headers/linux-api-headers-5.3.1-2.0-any.pkg.tar.xz\" \"l/libarchive/libarchive-3.3.3-1.0-i686.pkg.tar.xz\" \"o/openssl/openssl-1.1.1.d-2.0-i686.pkg.tar.xz\" \"p/pacman/pacman-5.2.1-1.4-i686.pkg.tar.xz\" \"z/zstd/zstd-1.4.4-1.0-i686.pkg.tar.xz\" \"/c/coreutils/coreutils-8.31-3.0-i686.pkg.tar.xz\" \"w/which/which-2.21-5.0-i686.pkg.tar.xz\" \"g/grep/grep-3.3-3.0-i686.pkg.tar.xz\" \"g/gzip/gzip-1.10-3.0-i686.pkg.tar.xz\" \"l/less/less-551-3.0-i686.pkg.tar.xz\" \"s/sed/sed-4.7-3.0-i686.pkg.tar.xz\" \"u/unzip/unzip-6.0-13.1-i686.pkg.tar.xz\")

cp -f /usr/lib/{libcrypto.so.1.0.0,libssl.so.1.0.0} \"\$TMPDIR\"
cd /var/cache/pacman/pkg/ || exit 196
_DWLDFILE_() { { printf \"%s\\n\\n\" \"Downloading signature file and file '\${UPGDPAKG##*/}' from https://archive.archlinux32.org.\" && _CURLDWND_ && printf \"%s\\n\\n\" \"Finished downloading signature file and file '\${UPGDPAKG##*/}' from https://archive.archlinux32.org.\" ; } || _PRTERROR_ ; }
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep1.lock ] && [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep2.lock ] && [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep3.lock ] && [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep4.lock ] && [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep5.lock ]
then
printf \"\\n%s\\n\" \"Downloading transition package and signature files from https://archive.archlinux32.org;  DONE  \"
else
printf \"%s\\n\" \"Downloading files: '\$(printf \"%s \" \"\${UPGDPKGS[@]##*/}\")' from https://archive.archlinux32.org.\"
for UPGDPAKG in \${UPGDPKGS[@]}
do
if [[ -f /var/cache/pacman/pkg/\"\${UPGDPAKG##*/}\" ]]
then
printf \"%s\\n\" \"File '\${UPGDPAKG##*/}' is already downloaded.\"
else
_DWLDFILE_ || _DWLDFILE_
fi
done
fi

_PMUEOEP1_() {
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep1.lock ]
then
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\n\" \"[\$2/6]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} --needed --noconfirm\" \" has already been successfully run; Continuing...\"
else
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running command \${0##*/} [\$2/6] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} --needed --noconfirm\"
pacman -U /var/cache/pacman/pkg/\"\${UPGDPKGS[\$1]##*/}\" --needed --noconfirm && :>/var/run/lock/"${INSTALLDIR##*/}"/kpmueoep1.lock
fi
}

_PMUEOEP2_() { # depreciated
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep2.lock ]
then
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\n\" \"[\$3/6]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} --needed --noconfirm\" \" has already been successfully run; Continuing...\"
else
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running command \${0##*/} [\$3/6] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} --needed --noconfirm\"
pacman -U /var/cache/pacman/pkg/\"\${UPGDPKGS[\$1]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$2]##*/}\" --needed --noconfirm && :>/var/run/lock/"${INSTALLDIR##*/}"/kpmueoep2.lock
fi
}

_PMUEOEP3_() {
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep3.lock ]
then
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[\$4/6]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} --needed --noconfirm\" \" has already been successfully run; Continuing...\"
else
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running command \${0##*/} [\$4/6] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} --needed --noconfirm\"
pacman -U /var/cache/pacman/pkg/\"\${UPGDPKGS[\$1]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$2]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$3]##*/}\" --needed --noconfirm && :>/var/run/lock/"${INSTALLDIR##*/}"/kpmueoep3.lock
fi
}

_PMUEOEP4_() {
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep4.lock ]
then
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[\$5/6]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} --needed --noconfirm\" \" has already been successfully run; Continuing...\"
else
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running command \${0##*/} [\$5/6] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} --needed --noconfirm\"
pacman -U /var/cache/pacman/pkg/\"\${UPGDPKGS[\$1]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$2]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$3]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$4]##*/}\" --needed --noconfirm && :>/var/run/lock/"${INSTALLDIR##*/}"/kpmueoep4.lock
fi
}

_PMUEOEP5_() {
if [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpmueoep5.lock ]
then
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[\$6/6]  The command \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} \${UPGDPKGS[\$5]##*/} --needed --noconfirm\" \" has already been successfully run; Continuing...\"
else
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[0m...\\n\" \"Running command \${0##*/} [\$6/6] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -U \${UPGDPKGS[\$1]##*/} \${UPGDPKGS[\$2]##*/} \${UPGDPKGS[\$3]##*/} \${UPGDPKGS[\$4]##*/} \${UPGDPKGS[\$5]##*/} --needed --noconfirm\"
pacman -U /var/cache/pacman/pkg/\"\${UPGDPKGS[\$1]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$2]##*/}\" /var/cache/pacman/pkg/\"\${UPGDPKGS[\$3]##*/}\" \"\${UPGDPKGS[\$4]##*/}\" \"\${UPGDPKGS[\$5]##*/}\" --needed --noconfirm && :>/var/run/lock/"${INSTALLDIR##*/}"/kpmueoep5.lock
fi
}
[ -f /etc/pacman.conf ] || cp /etc/pacman.conf /var/backups/"${INSTALLDIR##*/}"/etc/pacman.conf."$SDATE".bkp
{ [ -x /system/bin/sed ] && /system/bin/sed -i '/^LocalFileSigLevel/s/.*/SigLevel    = Never/' /etc/pacman.conf ; } || sed -i '/^LocalFileSigLevel/s/.*/SigLevel    = Never/' /etc/pacman.conf
_PMUEOEP1_ 1 1
_KEYSGENMSG_
printf \"\\e[1;32m==> \\e[1;37mRunning command %s \\e[1;32mpacman -Ss keyring --color=always\\e[1;37m...\\n\" \"\${0##*/}\"
pacman -Ss keyring --color=always || _PRTERROR_
_PMUEOEP5_ 9 10 11 12 13 2
_PMUEOEP4_ 2 3 7 8 3
_PMUEOEP3_ 4 5 6 4
mv -f \"\$TMPDIR\"/{libcrypto.so.1.0.0,libssl.so.1.0.0} /usr/lib/
sed -i '/^Architecture/s/.*/Architecture = i686/' /etc/pacman.conf
sed -i '/^SigLevel/s/.*/SigLevel    = Never/' /etc/pacman.conf
sed -i 's/^HoldPkg/\#HoldPkg/g' /etc/pacman.conf
if [ ! -f /var/run/lock/"${INSTALLDIR##*/}"/keyring.lock ]
then
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running command \${0##*/} [5/6] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -S archlinux-keyring archlinux32-keyring --needed --noconfirm\"
_KEYSGENMSG_
{ { pacman -S archlinux-keyring archlinux32-keyring --needed --noconfirm || pacman -Sy archlinux-keyring archlinux32-keyring --needed --noconfirm ; } && sed -i '/^SigLevel/s/.*/SigLevel    = Required DatabaseOptional/' /etc/pacman.conf && PACMANQ_=\"\$(pacman -Qo /usr/lib/libblkid.so)\" && { [[ \"\$(printf $\{PACMANQ_/libsutil-linux})\" == *libsutil-linux* ]] || pacman -Rdd libutil-linux --noconfirm || _PRTERROR_ ; } && :>/var/run/lock/"${INSTALLDIR##*/}"/keyring.lock ; }
else
printf \"\\n\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\e[0m\\n\" \"[5/6]  The command \" \"pacman -S archlinux-keyring archlinux32-keyring --needed --noconfirm\" \" has already been successfully run; Continuing...\"
fi
rm -f /etc/ssl/certs/ca-certificates.crt
sed -i '/^LocalFileSigLevel/s/.*/SigLevel    = Optional/' /etc/pacman.conf
sed -i '/^SigLevel/s/.*/SigLevel    = Optional/' /etc/pacman.conf
printf \"\\n\\e[1;32m==> \\e[1;37m%s\\e[1;32m%s\\e[1;37m...\\n\" \"Running command \${0##*/} [6/6] $ARCHITEC ($CPUABI) architecture upgrade ; \" \"pacman -Su --needed --noconfirm ; Starting full system upgrade\"
pacman -Sy || pacman -Sy || sudo pacman -Sy"
X86IPT=" "
X86INK=":"
else	# Arch Linux architectures armv7, aarch64 and x86_64 use these options
X86INT=":"
X86IPT="(1/2)"
X86INK="[ \"\${#ARGS}\" = 0 ] || { printf \"\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning command \\\\e[1;32mpacman -S %s --needed --noconfirm --color=always\\\\e[1;37m...\\\\n\" \"\$ARGS\" && pacman -S \$ARGS --needed --noconfirm --color=always || _PRTERROR_ ; }
printf \"\\\\n\\\\e[1;32m(2/2) \\\\e[0;34mWhen \\\\e[1;37mGenerating pacman keyring master key\\\\e[0;34m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this part of the install procedure.  In order to generate some entropy quickly, play a multimedia file on this device.  \\\\n\\\\nThe program \\\\e[1;32mpacman-key\\\\e[0;34m will want as much entropy as possible when generating keys.  Entropy is also created through tapping, sliding, one, two and more fingers tapping with short and long taps.  When \\\\e[1;37mAppending keys from archlinux.gpg\\\\e[0;34m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Put even simpler, just do something on device.  Browsing files will create entropy on device.  Slowly swiveling this device in space and time will accelerate the installation process.  This method alone might not generate enough entropy (a measure of randomness in a closed system) for the process to complete quickly.  The command \\\\e[1;32m~%s/bin/we\\\\e[0;34m can be used to generate and watch entropy on device in a new Termux session.\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning command \\\\e[1;32mpacman-key --populate\\\\e[1;37m...\\\\n\" \"$DARCH\"
{ [ -f /var/run/lock/"${INSTALLDIR##*/}"/kpp.lock ] && printf '\\e[1;32m==> \\e[1;37mAlready populated with command \\e[1;32mpacman-key --populate\\e[1;37m...\\n' ; } || { printf '\\e[1;32m==> \\e[1;37mRunning command \\e[1;32mpacman-key --populate\\e[1;37m...\\n' && { $ECHOEXEC pacman-key --populate && :>/var/run/lock/"${INSTALLDIR##*/}"/kpp.lock ; } || _PRTERROR_ ; }
printf \"\\\\e[1;32m==>\\\\e[1;37m Running command \\\\e[1;32mpacman -Ss keyring --color=always\\\\e[1;37m...\\\\n\"
pacman -Ss keyring --color=always"
fi
_CFLHDR_ $TMXRCHBNDS/keys
cat >> $TMXRCHBNDS/keys <<- EOM
declare -a KEYRINGS

_KEYSGENMSG_() {
printf "\\\\n\\\\e[1;32m%s \\\\e[0;34mWhen \\\\e[1;37mGenerating pacman keyring master key\\\\e[0;34m appears on the screen, the installation process can be accelerated.  The system desires a lot of entropy at this part of the install procedure.  To generate as much entropy as possible quickly, watch and listen to a file on your device.  \\\\n\\\\nThe program \\\\e[1;32mpacman-key\\\\e[0;34m will want as much entropy as possible when generating keys.  Entropy is also created through tapping, sliding, one, two and more fingers tapping with short and long taps.  When \\\\e[1;37mAppending keys from archlinux.gpg\\\\e[0;34m appears on the screen, use any of these simple methods to accelerate the installation process if it is stalled.  Put even simpler, just do something on device.  Browsing files will create entropy on device.  Slowly swiveling this device in space and time will accelerate the installation process.  This method alone might not generate enough entropy (a measure of randomness in a closed system) for the process to complete quickly.  You can use \\\\e[1;32m~%s/bin/we\\\\e[0;34m in a new Termux session to generate and watch entropy on device.\\\\e[0m\\\\n" "$X86IPT" "$DARCH"
}

_GENEN_() {
printf "\\\\e[0;32mGenerating entropy on device;  \\\\e[1;32mPlease wait a moment...  "
GENENN=16
for GNNT in \$(seq 1 \$GENENN)
do
nice -n 20 ls -alR /usr >/dev/null &
nice -n 20 find /usr >/dev/null &
nice -n 20 cat /dev/urandom >/dev/null &
done
}

_PRINTTAIL_() {
printf "\\\\n\\\\e[0;32m%s \\\\e[1;32m%s \\\\e[0;32m%s\\\\e[1;34m: \\\\e[1;32m%s\\\\e[0m 🏁  \\\\n\\\\n\\\\e[0m" "TermuxArch command" "\$STRNRG" "version \$VERSIONID" "DONE 📱"
printf '\033]2;  🔑 TermuxArch %s: DONE 📱 \007'  "'\$STRNRG'"
}

_PRTERROR_() {
printf "\\n\\e[1;31merror: \\e[1;37m%s\\e[0m\\n\\n" "Please study the first lines of the error output and correct the error(s) and/or warning(s) and run '\$STRNRG' again."
}

_TRPET_() {
printf "\\\\e[?25h\\\\e[0m"
set +Eeuo pipefail
_PRINTTAIL_ "\${KEYRINGS[@]}"
}
trap _TRPET_ EXIT

## keys begin ##################################################################
KEYSUNAM_="\$(uname -m)"
if [[ -z "\${1:-}" ]] || [[ "\$KEYSUNAM_" = aarch64 ]]
then
KEYRINGS[0]="archlinux-keyring"
KEYRINGS[1]="archlinuxarm-keyring"
KEYRINGS[2]="ca-certificates-utils"
elif [[ "\$1" = x86 ]] || [[ "\$KEYSUNAM_" = x86 ]]
then
KEYRINGS[0]="archlinux-keyring"
KEYRINGS[1]="archlinux32-keyring"
KEYRINGS[2]="ca-certificates-utils"
elif [[ "\$1" = x86_64 ]] || [[ "\$KEYSUNAM_" = x86_64 ]]
then
KEYRINGS[0]="archlinux-keyring"
KEYRINGS[1]="ca-certificates-utils"
else
KEYRINGS=""
fi
ARGS="\${KEYRINGS[@]}"
printf '\033]2;  🔑 TermuxArch %s 📲 \007' "'\$STRNRG'"
printf "\\\\e[1;32m==> \\\\e[1;37mRunning command \\\\e[1;32m%s \\\\e[0;32m%s\\\\e[1;37m...\\\\n" "\$STRNRG" "version \$VERSIONID"
_GENEN_ ; kill \$! &
_KEYSGENMSG_
_DOPSY_() {
printf "\\\\n\\\\e[1;32m==> \\\\e[1;37mRunning command \\\\e[1;32mpacman -Sy\\\\e[1;37m...\\\\n"
$ECHOEXEC $ECHOSYNC pacman -Sy || $ECHOEXEC $ECHOSYNC pacman -Sy || sudo $ECHOEXEC $ECHOSYNC pacman -Sy
}
_DOPSY_ || _DOPSY_ || _PRTERROR_
_DOKPI_() {
if [ ! -f "/run/lock/${INSTALLDIR##*/}/kpi.lock" ]
then
printf "\\\\e[1;32m==> \\\\e[1;37mRunning command \\\\e[1;32mpacman-key --init\\\\e[1;37m...\\\\n"
{ $ECHOEXEC pacman-key --init && :>"/run/lock/${INSTALLDIR##*/}/kpi.lock" ; } || _PRTERROR_
else
printf "\\\\e[1;32m==> \\\\e[1;37mAlready initialized with command \\\\e[1;32mpacman-key --init\\\\e[1;37m...\\\\n"
fi
}
_DOKPI_ || _DOKPI_
umask 000
chmod 4777 /usr/bin/newuidmap
chmod 755 /etc/pacman.d/gnupg
umask 022
_DOPP_() {
{ [ -f "/var/run/lock/${INSTALLDIR##*/}/kpp.lock" ] && printf "\\\\e[1;32m==> \\\\e[1;37mAlready populated with command \\\\e[1;32mpacman-key --populate\\\\e[1;37m...\\\\n" ; } || { printf "\\\\e[1;32m==> \\\\e[1;37mRunning command \\\\e[1;32mpacman-key --populate\\\\e[1;37m...\\\\n" && { $ECHOEXEC pacman-key --populate && :>"/var/run/lock/${INSTALLDIR##*/}/kpp.lock"; } || _PRTERROR_ ; }
}
_DOPP_ || _DOPP_
printf "\\\\e[1;32m==> \\\\e[1;37mRunning command \\\\e[1;32mpacman -Ss keyring --color=always\\\\e[1;37m...\\\\n"
pacman -Ss keyring --color=always || pacman -Ss keyring --color=always || _PRTERROR_
$X86INT
$X86INK
## $INSTALLDIR$TMXRCHBNDR/keys FE
EOM
chmod 755 $TMXRCHBNDS/keys
}

_ADDcshrc_() { :>root/.cshrc ; }
_ADDinitrc_() { printf '%s\n' "" > root/.initrc ; }
_ADDinputrc_() {
INPUTRCFILE="$(printf '%s\n' "set bell-style none
set colored-stats on
set colored-completion-prefix on
set completion-ignore-case on
set completion-prefix-display-length 3
set completion-query-items 32
# set editing-mode vi
set enable-keypad on
set enable-meta-key on
set expand-tilde off
set horizontal-scroll-mode on
set input-meta on
set match-hidden-files off
set mark-symlinked-directories on
set output-meta on
set print-completions-horizontally on
set show-all-if-ambiguous on
set show-all-if-unmodified on
# set show-mode-in-prompt on
set visible-stats on")"
_COMPAREFILE_ "$INPUTRCFILE" ".inputrc" "root"
}

_ADDprofile_() {
PROFILEFILE="$(printf '%s\n' "export TMPDIR=\"/tmp\"")"
_COMPAREFILE_ "$PROFILEFILE" ".profile" "root"
}

_ADDzshrc_() { :>root/.zshrc ; }

_COMPAREFILE_() { # compare and write file if differ
_WRITENEWFILE_() { printf '%s\n' "$1" > "$3/$2" && printf '\e[0;32mFile \e[0;32m%s \e[0;32m%s.\n' "$3/$2" "${@: -1}" ; }
if [ -f "$3/$2" ] # file exists
then # compare
if [[ "$1" != "$(<"$3"/"$2")" ]] # data differs
then # write file
_WRITENEWFILE_ "$@" "updated"
else
printf '\e[0;32mData in file \e[1;32m%s\e[0;32m is equal.\n' "$3/$2"
fi
else # write data to file if it does not exist
_WRITENEWFILE_ "$@" "created"
fi
}

_DOPROXY_() {
[[ -f "$HOME"/.bash_profile ]] && grep -s "proxy" "$HOME"/.bash_profile | grep -s "export" >> root/bin/"$BINFNSTP" ||:
[[ -f "$HOME"/.bashrc ]] && grep -s "proxy" "$HOME"/.bashrc  | grep -s "export" >> root/bin/"$BINFNSTP" ||:
[[ -f "$HOME"/.profile ]] && grep -s "proxy" "$HOME"/.profile | grep -s "export" >> root/bin/"$BINFNSTP" ||:
}

_MAKESTARTBIN_() {
_CFLHDR_ "$STARTBIN"
printf "%s\\n" "${FLHDRP[@]}" >> "$STARTBIN"
cat >> "$STARTBIN" <<- EOM
_CHCKUSER_() { [ -d "$INSTALLDIR/home/\$2" ] || _PRNTUSGE_ "\$@" ; }
_COMMANDGNE_() { printf "\\e[1;48;5;138mＴｅｒｍｕｘＡｒｃｈ %s\\e[0m  " "\${SRPTNM^^} NOTICE:  Please run '\${0##*/}' and 'bash \${0##*/}' from the BASH shell in native Termux:  EXITING..." && exit 202 ; }
if [ -w /root ]
then
_COMMANDGNE_
fi
_PRINTUSAGE_() {
printf "\\n\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN" "  starts Arch Linux in $TXPRQUON with PRoot QEMU root login.  This account is reserved for system administration.  Please use any system administrator account with care."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN c[ommand] command" "  runs an Arch Linux command from a Termux shell as PRoot QEMU root login.  Quoting multiple commands can assit when passing multiple arguments; i.e. " "$STARTBIN c 'whoami ; cat -n /etc/pacman.d/mirrorlist'" ".  Please pass commands through the system administrator account with caution."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN e[login|user] user" "  login as user.  Uses alternate elogin and euser option to login as user.  This option is preferred for working with programs that have already been installed, and for working with the 'cp' and 'git' commands.  Please use " "$STARTBIN c 'addauser user'" " first to create this user and the user's home directory."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN l[ogin]|u[ser] user" "  login as user.  This option is preferred when installing software from a user account with the 'sudo' command, and when using the 'makeaur*' commands.  Please use 'addauser user' first to create this user and the user's home directory."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n" "$STARTBIN r[aw]" "  construct the " "$STARTBIN " "proot statement from exec.../bin/.  For example " "$STARTBIN r su " "will exec 'su' in Arch Linux.  After installing the appropriate packages in Arch Linux, easy PRoot QEMU root shell access is possible with option raw:

~ $ $STARTBIN r bash
~ $ $STARTBIN r dash
~ $ $STARTBIN+x86 r csh
~ $ $STARTBIN+x86 r ksh
~ $ $STARTBIN+x864 r sh
~ $ $STARTBIN+x864 r zsh

Command '${0##*/} qemu [options]' assists in installing alternate architectures.  Variable PROOTSTMNT has more information about the PRoot QEMU init statement options 'grep -h PROOTSTMNT ~/TermuxArchBloom/* | grep \=' if you wish to modify the PRoot QEMU init statement extensively.  The PRoot QEMU init statement can also be modified on-the-fly simply by using the /var/binds/ directory once logged into the Arch Linux in TermuxArch PRoot QEMU environment."
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\\n\\e[0m" "$STARTBIN s[u] user command" "  executes commands as Arch Linux user from a Termux shell.  This option is preferred when installing software from a user account with the 'sudo' command, and when using the 'makeaur*' commands.  Quoting multiple commands can assit when passing multiple arguments:  " "$STARTBIN s user 'whoami ; cat -n /etc/pacman.d/mirrorlist'" ".  Please use " "$STARTBIN c 'addauser user'" " first to create a login and the login's home directory."
printf '\\033]2;%s\\007' "TermuxArch $STARTBIN $@ 📲; DONE 🏁"
}
_PRNTUSGE_() { _PRINTUSAGE_ && printf "\\e[0;33m%s\\e[0;32m%s\\e[1;31m%s\\e[0m" "It appears that user '\$2' does not exist in the Arch Linux in TermuxArch PRoot QEMU system!  " "Command '\${0##*/} command 'addauser \$2'' can create user account '\$2' in the TermuxArch PRoot QEMU system.   Command '\${0##*/} login \$2' can be run once more to login to the TermuxArch PRoot QEMU environment as user '\$2'." "  EXITING…  " ; exit 69 ; }
## [] Default Arch Linux in TermuxArch  PRoot QEMU root login.
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
printf "\\e[0;33m%s\\e[1;30m%s\\e[0;0m%s\\e[1;30m%s\\e[0;31m%s\\e[1;30m%s\\e[0m" "Please use at least one more argument to continue.  The command '\${0##*/} help' has more information;" "  Possible substitute command '" "\${0##*/} c 'addauser \$1'" "';" "  Exiting" "...  "
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
printf "%s" "File ~/${INSTALLDIR##*/}/var/lib/pacman/db.lck exists;  The TermuxArch 'pacmandblock' command can be used to alter the lock state.  Please use '$STARTBIN' and '$STARTBIN l[ogin] username' to install software in Arch Linux in TermuxArch PRoot QEMU: "
else
printf "%s" "Creating file ~/${INSTALLDIR##*/}/var/lib/pacman/db.lck;  The TermuxArch 'pacmandblock' command can be used to alter the lock state.  Please use '$STARTBIN' and '$STARTBIN l[ogin] username' to install software in the Arch Linux in TermuxArch PRoot QEMU environment:  "
:>"$INSTALLDIR/var/lib/pacman/db.lck"
printf "%s\\n" "Continuing..."
fi
printf "%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n%s\\n" "if [ -f \"$INSTALLDIR/var/lock/${INSTALLDIR##*/}/\$\$elock\" ]" "then" "if [ -f \"$INSTALLDIR/var/lib/pacman/db.lck\" ]" "then" "printf \"%s\" \"Deleting file '~/${INSTALLDIR##*/}/var/lib/pacman/db.lck'.  The TermuxArch 'pacmandblock' command can be used to alter the lock state.  Please use '$STARTBIN' and '$STARTBIN l[ogin] username' to install software in the Arch Linux in TermuxArch PRoot QEMU environment:  \"" "rm -f \"$INSTALLDIR/var/lib/pacman/db.lck\"" "printf \"%s\\\\n\" \"DONE\"" "fi" "rm -f \"$INSTALLDIR/var/lock/${INSTALLDIR##*}\$\$elock\"" "fi" "[ ! -f "$INSTALLDIR/home/\$2/.hushlogout" ] && [ ! -f "$INSTALLDIR/home/\$2/.chushlogout" ] && . /etc/moto" "h # write session history to file HOME/.historyfile" "## .bash_logout FE" > "$INSTALLDIR/home/\$2/.bash_logout"
## $INSTALLDIR$TMXRCHBNDR/keys FE
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
## [raw ARGS] Construct the '$STARTBIN' proot statement.
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
printf "%s\\n" "Please use this command \"$STARTBIN c '\${@:3}'\" for the Arch Linux in TermuxArch PRoot QEMU \$2 user account;  Exiting..."
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

_MAKEFINISHSETUP_() {
_DOKEYS_() {
if [[ "$CPUABI" = "$CPUABIX86" ]]
then
DOKYSKEY="$TMXRCHBNDR/keys x86"
elif [[ "$CPUABI" = "$CPUABIX8664" ]]
then
DOKYSKEY="$TMXRCHBNDR/keys x86_64"
else
DOKYSKEY="$TMXRCHBNDR/keys"
fi
}
_DOKYLGEN_() {
DOKYSKEY=""
LOCGEN=":"
}
_LOCALEGENPACNEW_() {
if [ ! -f var/run/lock/"${INSTALLDIR##*/}"/locale.gen.pacnew.lock ]
then
if [ -f "${INSTALLDIR##*/}"etc/locale.gen.pacnew ]
then
cp -f etc/locale.gen var/backups/"${INSTALLDIR##*/}"/etc/locale.gen."$SDATE".bkp && cp -f etc/locale.gen.pacnew etc/locale.gen && :>var/run/lock/"${INSTALLDIR##*/}"/locale.gen.pacnew.lock
fi
fi
}
if [[ "${LCR:-}" -eq 5 ]] || [[ -z "${LCR:-}" ]]	# LCR equals 5 or is undefined
then
_DOKEYS_
_LOCALEGENPACNEW_
LOCGEN="locale-gen || locale-gen"
elif [[ "${LCR:-}" -eq 1 ]] || [[ "${LCR:-}" -eq 2 ]] || [[ "${LCR:-}" -eq 3 ]] || [[ "${LCR:-}" -eq 4 ]] 	# LCR equals 1 or 2 or 3 or 4
then
_DOKYLGEN_
_LOCALEGENPACNEW_
fi
_CFLHDR_ "root/bin/$BINFNSTP"
printf "%s\\n" "_PMFSESTRING_() {
printf \"\\e[1;31m%s\\e[1;37m%s\\e[1;32m%s\\e[1;37m%s\\n\\n\" \"Signal generated in \" \"'\$1'\" \"; Cannot complete task;  \" \"Continuing...\"
printf \"\\e[1;34m%s\\e[0;34m%s\\e[1;34m%s\\e[0;34m%s\\e[1;34m%s\\n\\n\" \"  If you find better resolves for \" \"setupTermuxArch\" \" and \" \"\$0\" \", please open an issue and accompanying pull request.\"
}
_PMGPSSTRING_() {
printf \"\\n\\e[1;34m:: \\e[1;32m%s\\n\" \"Processing system for $NASVER $ARCTEVAR, and removing redundant packages for TermuxArch PRoot QEMU...\"
}" >> root/bin/"$BINFNSTP"
_DOPROXY_
[ -d "$INSTALLDIR/run/lock/${INSTALLDIR##*/}" ] || mkdir -p "$INSTALLDIR/run/lock/${INSTALLDIR##*/}"
printf "%s\\n" "$DOKYSKEY" >> root/bin/"$BINFNSTP"
if  [[ -z "${LCR:-}" ]] || [[ "${LCR:-}" -eq 5 ]]
then
if [[ "$CPUABI" = "$CPUABIX8664" ]]
then
printf "%s\\n" "pacman -Su keychain glibc grep gzip pacman-contrib sed sudo --needed --noconfirm --color=always || pacman -Su keychain glibc grep gzip pacman-contrib sed sudo --needed --noconfirm --color=always || _PMFSESTRING_ \"pacman -Su keychain glibc grep gzip sed sudo $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
elif [[ "$CPUABI" = "$CPUABIX86" ]]
then
printf "%s\\n" "pacman -Su keychain glibc pacman-contrib sed sudo --needed --noconfirm --color=always || pacman -Su keychain glibc sed sudo --needed --noconfirm --color=always || _PMFSESTRING_ \"pacman -Su keychain glibc pacman-contrib sed sudo $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
else
printf "%s\\n" "pacman -Su keychain glibc pacman-contrib --needed --noconfirm --color=always || pacman -Su keychain glibc pacman -S pacman-contrib --needed --noconfirm --color=always || _PMFSESTRING_ \"pacman -Su keychain glibc $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
fi
fi
printf "%s\\n" "printf \"\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\n\" \"To generate locales in a preferred language, you can use the native Android menu commands \" \"Settings > System > Input & Language > Language \" \"in Android;  Then run \" \"${0##*/} refresh\" \" for a full system refresh, which includes the locale generation function; For a quick refresh you can use \" \"${0##*/} r\" \".  For a refresh with user directories \" \"${0##*/} re\" \" can be used.\"
$LOCGEN || _PMFSESTRING_ \"LOCGEN $BINFNSTP ${0##/*}.  Please run '$LOCGEN' again in the installed system.\"" >> root/bin/"$BINFNSTP"
printf "%s\\n" "[ -d /home/user ] || printf \"\\n\\e[1;32m==> \\e[1;37mRunning TermuxArch command \\e[1;32maddauser user\\e[1;37m...\\n\"" >> root/bin/"$BINFNSTP"
printf "%s\\n" "[ -d /home/user ] || "$TMXRCHBNDR"/addauser user || _PMFSESTRING_ \"addauser user $BINFNSTP ${0##/*}\"" >> root/bin/"$BINFNSTP"
if [[ "${LCR:-}" -eq 3 ]] || [[ "${LCR:-}" -eq 4 ]]
then
printf "%s\\n" "locale-gen || locale-gen" >> root/bin/"$BINFNSTP"
fi
printf "%s\\n" "# $BINFNSTP FE" >> root/bin/"$BINFNSTP"
chmod 700 root/bin/"$BINFNSTP"
}

_MAKESETUPBIN_() {
_CFLHDR_ root/bin/setupbin.bash
printf "%s\\n" "set +Eeuo pipefail" >> root/bin/setupbin.bash
printf "%s\\n" "$PROOTSTMNT /root/bin/$BINFNSTP ||:" >> root/bin/setupbin.bash
printf "%s\\n" "# setupbin.bash FE" >> root/bin/setupbin.bash
chmod 700 root/bin/setupbin.bash
}

_SETLANGUAGE_() { ## Function _SETLANGUAGE_ uses device system settings to set locales.  Generating locales in a preferred language should be simple if an exact language match was found.  "Settings > System > Input & Language > Language" sets the system language in Android which can be migrated into this system with one of the refresh options;  Command 'setupTermuxArch re' will attempt to update the TermuxArch system overlay with a quick refresh to the newest published version, and attempt to regenerate locales in your preferred language automatically.
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
printf "\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\e[0;32m%s\\e[1;32m%s\\n" "Setting locales to " "Language " ">> $ULANGUAGE << " "Region" " Please wait a moment."
}

_SETLOCALE_() { ## Function _SETLOCALE_ uses device system settings to set locales.  Generating locales in a preferred language should be simple if an exact language match was found.  "Settings > System > Input & Language > Language" sets the system language in Android which can be migrated into this system with one of the refresh options;  Command 'setupTermuxArch re' will attempt to update the TermuxArch system overlay with a quick refresh to the newest published version, and attempt to regenerate locales in your preferred language automatically.
printf "%s\\n" "##  File locale.conf was generated by ${0##*/} at ${FTIME//-}." > etc/locale.conf
for LC_N in "${!LC_TYPE[@]}"
do
printf "%s\\n" "${LC_TYPE[LC_N]}=$ULANGUAGE.UTF-8" >> etc/locale.conf
done
set +e
if grep "$ULANGUAGE"\\.UTF-8 etc/locale.gen 1>/dev/null
then
sed -i "/\\#$ULANGUAGE.UTF-8 UTF-8/{s/#//g;s/@/-at-/g;}" etc/locale.gen && printf "\\e[0;32mFound an exact match for language \\e[1;32m>> %s <<\\e[0;32m to continue locale configuration.  Command \\e[1;32m%s refresh\\e[0;32m generates locales from device.  Command \\e[1;32mlocale-gen\\e[0;32m generates locales." "$ULANGUAGE" "${0##*/}"
else
printf "\\e[0;33mCould not find an exact match for language \\e[1;33m>> %s <<\\e[0;33m in file /etc/locale.gen.  Please edit files /etc/locale.conf, /etc/locale.gen and .profile.  Then run the command \\e[1;33mlocale-gen\\e[0;33m to generate locales.  " "$ULANGUAGE"
fi
}
# initkeyfunctions.bash FE
