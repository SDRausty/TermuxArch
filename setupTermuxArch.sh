#!/data/data/com.termux/files/usr/bin/sh -e
# Copyright 2017 (c) all rights reserved \
# by SDRausty https://sdrausty.github.io/termux-arch
# Contributers @Soph1a7 et al.
#####################################################################
bin=startArch.sh
mirror=os.archlinuxarm.org
#If you need to change your mirror, only change the os.archlinuxarm.org to your desired mirror location
printf "This setup script will attempt to set Arch Linux up in your Termux environment.\n"
sleep 1
printf "\nWhen successfully completed, you will be at the bash prompt in Arch Linux in Termux.\n"
sleep 1
printf "\nThe script will now install the required tools for Arch installation\n\n"
apt-get -qq install --yes proot wget bsdtar
printf "\n\nNow downloading the Arch image. This may take a while depending on your internet speed, be patient.\n\n"
mkdir -p $HOME/arch
cd $HOME/arch
if [ "$(uname -m)" = "aarch64" ];then
wget -c -q --show-progress http://$mirror/os/ArchLinuxARM-aarch64-latest.tar.gz.md5
wget -c -q --show-progress http://$mirror/os/ArchLinuxARM-aarch64-latest.tar.gz
printf "\nChecking md5sum. This may take a while. Please be patient.\n\n"
if md5sum -c ArchLinuxARM-aarch64-latest.tar.gz.md5; then
	printf "\nUncompressing ArchLinuxARM-aarch64-latest.tar.gz\n"
	printf "\nThis will take much longer. Please be patient.\n"
	proot --link2symlink bsdtar -xpf ArchLinuxARM-aarch64-latest.tar.gz 2>/dev/null||:
else
	printf "\nmd5sum missmatch! Removing the arch directory contents\n"
	printf "\nPlease execute the script and try again\n"
	printf "\nIf this keeps failing, please change your mirror on line 7 with an editor like nano\n"
	printf "\nUse https://archlinuxarm.org/about/mirrors to choose an available mirror in accordance with your 🌎 geographic location.\n"
	rm -rf $HOME/arch/*
	printf "\nExiting...\n"
	exit 1
fi
elif [ "$(uname -m)" = "armv7l" ];then
wget -c -q --show-progress http://$mirror/os/ArchLinuxARM-armv7-latest.tar.gz.md5
wget -c -q --show-progress http://$mirror/os/ArchLinuxARM-armv7-latest.tar.gz
printf "\nChecking md5sum. This may take a while. Please be patient.\n\n"
if md5sum -c ArchLinuxARM-armv7-latest.tar.gz.md5; then
	printf "\nUncompressing ArchLinuxARM-armv7-latest.tar.gz\n"
	printf "\nThis will take much longer. Please be patient.\n"
	proot --link2symlink bsdtar -xpf ArchLinuxARM-armv7-latest.tar.gz 2>/dev/null||:
else
	printf "\nmd5sum missmatch! Removing the arch directory contents\n"
	printf "\nPlease execute the script and try again\n"
	printf "\nIf this keeps failing, please change your mirror on line 7 with an editor like nano\n"
	printf "\nUse https://archlinuxarm.org/about/mirrors to choose an available mirror in accordance with your 🌎 geographic location.\n"
	rm -rf $HOME/arch/*
	printf "\nExiting...\n"
	exit 1
fi
else
	printf "\nERROR Unknown architecture version! There might still be hope.\n"
	printf "\n👉 Check for other available architectures at http://mirror.archlinuxarm.org/os/ and see if any match your device.\n"
	printf "\n👉 If you find a match, then please submit a pull request at https://github.com/sdrausty/TermuxArch/pulls with script modifications.\n"
	printf "\n👉 Alternatively, submit a modification request at https://github.com/sdrausty/TermuxArch/issues if you find an architecture match. Please include output from \`uname -mo\` on the device in order to expand architecture autodetection for \`setupTermuxArch.sh\`.\n"
	exit 1
fi
rm etc/resolv*
cat > etc/resolv.conf <<- EOM
nameserver 8.8.8.8
nameserver 8.8.4.4
EOM
cat > $bin <<- EOM
#!/data/data/com.termux/files/usr/bin/bash
proot --link2symlink -0 -r ~/arch -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
EOM
chmod 700 $bin
printf "\nUse \`pacman -Syu\` to update your Arch Linux in Termux distribution. Adjust your /etc/pacman.d/mirrorlist file in accordance with your 🌎 geographic location.\n"
printf "\n👉 Use \`./arch/$bin\` from your \$HOME directory to launch Arch Linux in Termux for futuresessions.\n"
printf "\n👉 This can be abbreviated to \`!.\` at the bash prompt after login into Termux.\n"
printf "\nThank you for using \`setupTermuxArch.sh\` to install Arch Linux in Termux!\n"
$HOME/arch/$bin
printf "\n👉 Use \`./arch/$bin\` from your \$HOME directory to launch Arch Linux in Termux for future sessions.\n"
printf "\n👉 This can be abbreviated to \`!.\` at the bash prompt after login into Termux.\n"
printf "\nThank you for using \`setupTermuxArch.sh\` to install Arch Linux in Termux!"
