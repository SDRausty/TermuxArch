#!/data/data/com.termux/files/usr/bin/sh -e
# Copyright 2017 (c) all rights reserved \ 
# by SDRausty https://sdrausty.github.io/termux-arch
# Contributers @Soph1a7 et al.
#####################################################################
bin=startArch.sh
mirror=mirror.archlinuxarm.org
echo "This setup script will attempt to set Arch Linux up in your Termux environment."
echo 
sleep 2
echo "When successfully completed, you will be at the bash prompt in Arch Linux in Termux."
sleep 1
pkg install proot tar wget
echo
mkdir -p $HOME/arch
cd $HOME/arch
echo "Downloading arch-image."
echo
if [ "$(uname -m)" = "aarch64" ];then
wget -c http://$mirror/os/ArchLinuxARM-aarch64-latest.tar.gz.md5
wget -c http://$mirror/os/ArchLinuxARM-aarch64-latest.tar.gz
echo "Checking md5sum. This may take a while. Please be patient."
if md5sum -c ArchLinuxARM-aarch64-latest.tar.gz.md5; then
	echo "Uncompressing ArchLinuxARM-aarch64-latest.tar.gz"
	echo "This will take much longer. Please be patient."
	proot --link2symlink tar -xf ArchLinuxARM-aarch64-latest.tar.gz 2>/dev/null||:
else
	echo "ERROR md5sum missmatch: Remove $HOME/arch with all downloads. Alternatively, also change \`mirror=$mirror\` in line 7 and then restart \`setupTermuxArch.sh\`. See https://archlinuxarm.org/about/mirrors for a list of available mirrors please."
	exit 1
fi
elif [ "$(uname -m)" = "armv7l" ];then
wget -c http://$mirror/os/ArchLinuxARM-armv7-latest.tar.gz.md5
wget -c http://$mirror/os/ArchLinuxARM-armv7-latest.tar.gz
echo "Checking md5sum. This may take a while. Please be patient."
if md5sum -c ArchLinuxARM-armv7-latest.tar.gz.md5; then
	echo "Uncompressing ArchLinuxARM-armv7-latest.tar.gz"
	echo "This will take much longer. Please be patient."
	proot --link2symlink tar -xf ArchLinuxARM-armv7-latest.tar.gz 2>/dev/null||:
else
	echo "ERROR md5sum missmatch: Remove $HOME/arch with all downloads. Alternatively, also change \`mirror=$mirror\` in line 7 and then restart \`setupTermuxArch.sh\`. See https://archlinuxarm.org/about/mirrors for a list of available mirrors please."
	exit 1
fi
else
	echo "ERROR Unknown architecture version for \`setupTermuxArch.sh\`! There still is hope. Check for other available architectures at http://os.archlinuxarm.org/os/ and submit a request at https://github.com/sdrausty/TermuxArch/issues including output from \`uname -mo\` on the device in order to expand architecture autodetection for \`setupTermuxArch.sh\` is possible."
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
echo 
echo "Use \`pacman -Syu\` to update your Arch Linux in Termux distribution. Adjust your /etc/pacman.d/mirrorlist file in accordance 🌎 with your geographic location." 
echo
echo "Thank you for using \`setupTermuxArch.sh\` to install Arch Linux in Termux. Use \`./arch/$bin\` from your \$HOME directory to launch Arch Linux in Termux for future sessions. This can be abbreviated to \`!.\` +enter/return at the bash prompt after login into Termux ☺"
$HOME/arch/$bin
echo "Thank you for using \`setupTermuxArch.sh\` to install Arch Linux in Termux. Use \`./arch/$bin\` from your \$HOME directory to launch Arch Linux in Termux for future sessions. This can be abbreviated to \`!.\` +enter/return at the bash prompt after login into Termux ☺"
