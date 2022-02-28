#!/usr/bin/env bash
## Copyright 2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################

_ADDfbindprocpcidevices.prs_() {
:>var/binds/fbindprocpcidevices
_CFLHDRS_ var/binds/fbindprocpcidevices.prs
cat >> var/binds/fbindprocpcidevices.prs <<- EOM
# bind an empty /proc/bus/pci/devices file
PROOTSTMNT+="-b $INSTALLDIR/var/binds/fbindprocpcidevices:/proc/bus/pci/devices "
## ~/${INSTALLDIR##*/}/usr/local/bin/prs FE
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
## ~/${INSTALLDIR##*/}/usr/local/bin/prs FE
EOM
}

_ADDfbindprocstat_() {
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
intr 607306752 0 0 113 0 109 0 0 26 0 0 4 0 0 0 0 0 0 0 0 0 67750564 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 51073258 0 0 0 0 0 0 0 160 0 0 0 0 0 0 0 0 0 51831 2 5 0 24598 0 0 0 15239501 0 0 0 0 0 0 0 0 0 0 1125885 0 0 0 0 5966 3216 120 2 0 0 5990 0 24741 0 37 0 0 0 0 0 0 0 0 0 0 0 0 15262980 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 42742 16829690 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 19844763 0 8873762 0 0 0 0 0 0 0 0 6 0 0 0 49937 0 0 0 2768306 5 0 3364052 3755518 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 41435584 0 0 3939101 0 0 0 0 0 0 0 0 0 0 0 1894201 0 0 0 0 0 0 864195 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8961077 3996222 0 0 0 0 0 0 0 0 0 0 0 0 66386 0 0 0 0 0 0 87497 0 285431 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 11217187 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3578 0 0 0 0 0 301 300 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 117 14 0 0 0 0 0 95 0 0 0 0 0 0 0 27 0 2394 0 0 0 0 62 0 0 0 0 0 857124 0 1 0 0 0 0 20 3990685 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5021 481 4
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
## ~/${INSTALLDIR##*/}/usr/local/bin/prs FE
EOM
}

_ADDbindexample_() {
_CFLHDRS_ var/binds/bindexample.prs "# Before regenerating the start script with \`setupTermuxArch re[fresh]\`, first copy this file to another name such as \`fbinds.prs\`.  Then add as many proot statements as you want; The init script will parse file \`fbinds.prs\` at refresh adding these proot options to \`$STARTBIN\`.  The space before the last double quote is necessary.  Examples are included for convenience:"
cat >> var/binds/bindexample.prs <<- EOM
## PRoot bind usage: PROOTSTMNT+="-b host_path:guest_path "
## PROOTSTMNT+="-q $PREFIX/bin/qemu-x86-64 "
## PROOTSTMNT+="-b /proc:/proc "
## [[ ! -r /dev/shm ]] && PROOTSTMNT+="-b $INSTALLDIR/tmp:/dev/shm "
## ~/${INSTALLDIR##*/}/usr/local/bin/prs FE
EOM
}

_ADDfbinds_() {
if [[ ! -r /proc/stat ]]
then
_ADDfbindprocstat_
_ADDfbindprocversion_
fi
}

# fbindsfunctions.bash FE
