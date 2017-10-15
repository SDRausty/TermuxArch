# [TermuxArch](https://github.com/sdrausty/TermuxArch)

# -rwxrwx--- [setupTermuxArch.sh](https://github.com/sdrausty/TermuxArch/blob/master/setupTermuxArch.sh)

You can use `setupTermuxArch.sh` 📲 to install [Arch Linux](http://mirror.archlinuxarm.org/os/) in [Termux](https://wiki.termux.com/) on Android and Chrome. This setup script will attempt to set Arch Linux up in your Termux environment. It  will generate many error messages \"tar: Ignoring unknown extended header keyword 'SCHILY.fflags'\" && one \"tar: Exiting with failure status due to previous errors\" message.

Ignore these messages, and please wait patiently as tar decompresses the download once completed. When successfully completed, you will be at the bash prompt in Arch Linux in Termux. Run each of the following command lines separately. Running them all at once may generate errors; Hint, copy and paste the following: 

```
cd && git clone https://github.com/sdrausty/TermuxArch
./TermuxArch/setupTermuxArch.sh

```

![Linux on Android](./archntoau.png)

