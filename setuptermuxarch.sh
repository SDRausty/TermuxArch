#!/data/data/com.termux/files/usr/bin/bash
# Copyright 2017 (c) all rights reserved 
# by SDRausty https://sdrausty.github.io/termux-arch
echo "This setup script will attempt to set Arch Linux up in your Termux environment."
echo 
sleep 4
echo "It  will generate many error messages \"tar: Ignoring unknown extended header keyword 'SCHILY.fflags'\" && one \"tar: Exiting with failure status due to previous errors\" message."
sleep 3
echo 
echo "Ignore these messages, and please wait patiently as tar decompresses the download once completed."
echo 
sleep 2
echo "When successfully completed, you will be at the bash prompt in Arch Linux in Termux."
sleep 1
pkg up
pkg install proot tar
echo
mkdir -p $HOME/arch
cd $HOME/arch
        echo "Downloading arch-image."
	echo
        if [ "$(uname -m)" = "aarch64" ];then
            wget -c http://mirror.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz -O arch.tar.gz
        elif [ "$(uname -m)" = "armv7l" ];then
            wget -c http://mirror.archlinuxarm.org/os/ArchLinuxARM-armv7-latest.tar.gz -O arch.tar.gz
        else
            echo "Unknown architecture version for this setup script! There is hope."
            echo "Please check for other available architectures at http://mirror.archlinuxarm.org/os/"
            exit 1
        fi
    echo "While decompressing the arch image tar will probably echo, "tar: Ignoring unknown extended header keyword 'SCHILY.fflags'" && "tar: Exiting with failure status due to previous errors""
    sleep 2
    echo "Please ignore these messages and wait patiently as tar decompresses the download."
    sleep 2
    proot --link2symlink tar -xf arch.tar.gz||:
bin=startArch
echo "Writing launch script."
cat > $bin <<- EOM
#!/data/data/com.termux/files/usr/bin/bash
proot --link2symlink -0 -r ~/arch -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[termux@arch \W]\$ ' LANG=$LANG PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash --login
EOM
echo "Making $bin executable."
chmod 700 $bin
echo "Launch Arch Linux in Termux with ./arch/$bin"
$HOME/arch/$bin
