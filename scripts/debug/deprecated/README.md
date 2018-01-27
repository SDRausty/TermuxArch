Obsolete README.md Sat Nov 25 20:20:33 EST 2017
These debugging scripts are a pleasure to use: 

1) `raf.sh` does one iteration of Arch Linux in Termux install and purge from start to finish. It runs `setupTermuxArch.sh`, then removes all files that were installed.  A word of warning, the script can malfunction and wipe all the data in the `$HOME` directory if you run more than one session at a time.  To reproduce this effect, run two sessions of `raf.sh` simultaneously. Finish one. Then exit the other.  Please use `raf.sh` with caution, ideally on a device dedicated to debugging.  

2) `sraf.sh` has a much simpler function. It is to remove `$HOME/arch` completely.  Please use `sraf.sh` with caution, ideally on a device dedicated to debugging.  
