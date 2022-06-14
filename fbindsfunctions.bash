#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
_ADDinitfbinds_() {
FBINDFUNCS=(
_ADDfbindkvm_
_ADDfbindprocpcidevices_
_ADDfbindprocshmem_
_ADDfbindprocuptime_
_ADDfbindprocstat_
_ADDfbindprocversion_
_ADDbindprocloadavg_
_ADDbindprocvmstat_
_ADDfbindsysdevices_
)
for FBINDFUNC in "${FBINDFUNCS[@]}"
do
"$FBINDFUNC"
done
}

_ADDfbindprocpcidevices_() {
:>var/binds/fbindprocpcidevices
}

_ADDfbindprocshmem_() {
printf "%s\\n" "------ Message Queues --------
key        msqid      owner      perms      used-bytes   messages

------ Shared Memory Segments --------
key        shmid      owner      perms      bytes      nattch     status

------ Semaphore Arrays --------
key        semid      owner      perms      nsems" > var/binds/fbindprocshmem
}

_ADDfbindprocstat_() {
NESSOR="$(grep cessor /proc/cpuinfo)"
NCESSOR="${NESSOR: -2}"
if [ "$NCESSOR"  -le 3 ]
then
_ADDfbindprocstat4_
elif [ "$NCESSOR"  -le 5 ]
then
_ADDfbindprocstat6_
else
_ADDfbindprocstat8_
fi
}

_ADDfbindprocstat4_() {
printf "%s\\n" "cpu  4232003 351921 6702657 254559583 519846 1828 215588 0 0 0
cpu0 1595013 127789 2759942 61446568 310224 1132 92124 0 0 0
cpu1 1348297 91900 1908179 63099166 110243 334 78861 0 0 0
cpu2 780526 73446 1142504 64682755 61240 222 32586 0 0 0
cpu3 508167 58786 892032 65331094 38139 140 12017 0 0 0
intr 182663754 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 23506963 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 13479102 0 0 0 0 0 0 0 108 0 0 0 0 0 0 0 0 0 178219 72133 5 0 1486834 0 0 0 8586048 0 0 0 0 0 0 0 0 0 0 2254 0 0 0 0 29 3 7501 38210 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 4610975 0 0 0 0 0 1 0 78471 0 0 0 0 0 0 0 0 0 0 0 0 0 0 305883 0 15420 0 3956500 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8937474 0 943938 0 0 0 0 0 0 0 0 0 0 0 0 12923 0 0 0 34931 5 0 2922124 848989 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 12502497 0 0 3270275 0 0 0 0 0 0 0 0 0 0 0 1002881 0 0 0 0 0 0 17842 0 44011 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1975390 0 0 0 0 0 0 0 0 0 0 0 0 4968 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1340 2 762 0 0 0 50 42 0 27 82 0 0 0 0 14 28 0 0 0 0 14277 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1974794 0 142 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 367 81
ctxt $(shuf -n 1 -i 465697-473465697)
btime $BINDPROCUPTIM0
processes $(shuf -n 1 -i 32-32768)
procs_running 3
procs_blocked 0
softirq 71223290 12005 18257219 222294 2975533 4317 4317 7683319 19799901 40540 22223845" > var/binds/fbindprocstat
}

_ADDfbindprocstat6_() {
printf "%s\\n" "cpu  148928556 146012 6648853 2086709554 4518337 0 1314039 293017 0 0
cpu0 24948069 38092 1137251 347724817 1169568 0 30231 21138 0 0
cpu1 16545576 29411 890111 356315677 971747 0 41593 115368 0 0
cpu2 82009143 11955 2705377 286616379 473751 0 1239704 114343 0 0
cpu3 9487436 29342 673090 364602319 631633 0 843 11690 0 0
cpu4 6696319 23709 584149 367425424 501898 0 890 12546 0 0
cpu5 9242011 13500 658872 364024935 769737 0 775 17929 0 0
intr 3438098651 134 26 0 0 0 0 3 0 0 0 0 581717 74 0 0 3669554 0 0 0 0 0 0 0 0 0 150777509 19 0 843288252 7923 0 0 0 256 0 4 0 13323712 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
ctxt $(shuf -n 1 -i 789017-1109789017)
btime $BINDPROCUPTIM0
processes $(shuf -n 1 -i 32-32768)
procs_running 5
procs_blocked 0
softirq 3644958646 1 2007831497 2340 995352344 1834998 0 97563 249921452 0 389918451" > var/binds/fbindprocstat
}

_ADDfbindprocstat8_() {
printf "%s\\n" "cpu  10278859 1073916 12849197 97940412 70467 2636 323477 0 0 0
cpu0 573749 46423 332546 120133 32 79 5615 0 0 0
cpu1 489409 40445 325756 64094 0 59 5227 0 0 0
cpu2 385758 36997 257949 50488114 40123 39 4021 0 0 0
cpu3 343254 34729 227718 47025740 30205 20 2566 0 0 0
cpu4 3063160 288232 4291656 58418 27 940 146236 0 0 0
cpu5 2418517 277690 3105779 60431 48 751 67052 0 0 0
cpu6 1671400 189460 2302016 61521 23 402 49717 0 0 0
cpu7 1333612 159940 2005777 61961 9 346 43043 0 0 0
intr 607306752 0 0 113 0 109 0 0 26 0 0 4 0 0 0 0 0 0 0 0 0 67750564 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 51073258 0 0 0 0 0 0 0 160 0 0 0 0 0 0 0 0 0 51831 2 5 0 24598 0 0 0 15239501 0 0 0 0 0 0 0 0 0 0 1125885 0 0 0 0 5966 3216 120 2 0 0 5990 0 24741 0 37 0 0 0 0 0 0 0 0 0 0 0 0 15262980 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 42742 16829690 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 19844763 0 8873762 0 0 0 0 0 0 0 0 6 0 0 0 49937 0 0 0 2768306 5 0 3364052 3755518 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 41435584 0 0 3939101 0 0 0 0 0 0 0 0 0 0 0 1894201 0 0 0 0 0 0 864195 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8961077 3996222 0 0 0 0 0 0 0 0 0 0 0 0 66386 0 0 0 0 0 0 87497 0 285431 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 11217187 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 3578 0 0 0 0 0 301 300 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 117 14 0 0 0 0 0 95 0 0 0 0 0 0 0 27 0 2394 0 0 0 0 62 0 0 0 0 0 857124 0 1 0 0 0 0 20 3990685 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5021 481 4
ctxt $(shuf -n 1 -i 9697753-1589697753)
btime $BINDPROCUPTIM0
processes $(shuf -n 1 -i 64-4194304)
procs_running 7
procs_blocked 0
softirq 204699421 2536598 39636497 522981 4632002 29263706 104522 6736991 41332715 232221 79701188" > var/binds/fbindprocstat
}

_ADDfbindprocuptime_() {
INVNUM="$(shuf -n 1 -i 0-1)"
DIVNUM="$(shuf -n 1 -i 0-1)"
[ "$INVNUM" = 0 ] && ADDSUB="-" || ADDSUB="+"
[ "$DIVNUM" = 0 ] && DIVISOR=" / 2" || DIVISOR=""
BINDPROCUPTIM2="$(shuf -n 1 -i 10000-33333)"
BINDPROCUPTIM0="$(((BINDPROCUPTIM2 * 3)$DIVISOR))"
BINDPROCUPTIM1="$(shuf -n 1 -i 33-66)"
BINDPROCUPTIM3="$((BINDPROCUPTIM1 $ADDSUB $(shuf -n 1 -i 0-33)))"
printf "%s.%02d %s.%02d\\n" "$BINDPROCUPTIM0" "$BINDPROCUPTIM1" "$BINDPROCUPTIM2" "$BINDPROCUPTIM3" > var/binds/fbindprocuptime
}

_ADDfbindprocversion_() {
printf "%s\\n" "Linux version $UNAMER (root@localhost) (gcc version $UNAMER (prerelease) (GCC) ) #1 SMP PREEMPT $(date +%a" "%b" "%d" "%X" UTC "%Y)" > var/binds/fbindprocversion
}

_ADDbindexample.prs_() {
_CFLHDRS_ var/binds/bindexample.prs "# Before regenerating the start script with \`setupTermuxArch re[fresh]\`, first copy this file to another name such as \`fbinds.prs\`.  Then add as many proot statements as you want; The init script will parse file \`fbinds.prs\` at refresh adding these proot options to \`$STARTBIN\`.  The space before the last double quote is necessary.  Examples are included for convenience:"
printf "%s\\n" "## PRoot bind usage: PROOTSTMNT+=\"-b host_path:guest_path \"
## PROOTSTMNT+=\"-q $PREFIX/bin/${COMMS:-qemu-x86_64} \"
## PROOTSTMNT+=\"-b /proc:/proc \"
## [ -r /dev/shm ] || PROOTSTMNT+=\"-b $INSTALLDIR/tmp:/dev/shm \"
## ~/${INSTALLDIR##*/}$TMXRCHBNDR/bindexample.prs FE" >> var/binds/bindexample.prs
}

_ADDfbindkvm_() {
:>var/binds/fbindkvm
chmod 666 var/binds/fbindkvm
}

_ADDbindprocloadavg_() {
printf "%s" "0.$(shuf -n 1 -i 48-64) 0.$(shuf -n 1 -i 32-48) 0.$(shuf -n 1 -i 24-32) 1/$(shuf -n 1 -i 128-1024) $(shuf -n 1 -i 333333-999999)
" > var/binds/fbindprocloadavg
}

_ADDbindprocvmstat_() {
printf "%s\\n" "nr_free_pages $(shuf -n 1 -i 9216-18432)
nr_zone_inactive_anon 196744
nr_zone_active_anon 301503
nr_zone_inactive_file 2457066
nr_zone_active_file 729742
nr_zone_unevictable 164
nr_zone_write_pending 8
nr_mlock 34
nr_page_table_pages 6925
nr_kernel_stack 13216
nr_bounce 0
nr_zspages 0
nr_free_cma 0
numa_hit 672391199
numa_miss 0
numa_foreign 0
numa_interleave 62816
numa_local 672391199
numa_other 0
nr_inactive_anon 196744
nr_active_anon 301503
nr_inactive_file 2457066
nr_active_file 729742
nr_unevictable 164
nr_slab_reclaimable 132891
nr_slab_unreclaimable 38582
nr_isolated_anon 0
nr_isolated_file 0
workingset_nodes 25623
workingset_refault 46689297
workingset_activate 4043141
workingset_restore 413848
workingset_nodereclaim 35082
nr_anon_pages 599893
nr_mapped 136339
nr_file_pages 3086333
nr_dirty 8
nr_writeback 0
nr_writeback_temp 0
nr_shmem 13743
nr_shmem_hugepages 0
nr_shmem_pmdmapped 0
nr_file_hugepages 0
nr_file_pmdmapped 0
nr_anon_transparent_hugepages 57
nr_unstable 0
nr_vmscan_write 57250
nr_vmscan_immediate_reclaim 2673
nr_dirtied 79585373
nr_written 72662315
nr_kernel_misc_reclaimable 0
nr_dirty_threshold 657954
nr_dirty_background_threshold 328575
pgpgin 372097889
pgpgout 296950969
pswpin 14675
pswpout 59294
pgalloc_dma 4
pgalloc_dma32 101793210
pgalloc_normal 614157703
pgalloc_movable 0
allocstall_dma 0
allocstall_dma32 0
allocstall_normal 184
allocstall_movable 239
pgskip_dma 0
pgskip_dma32 0
pgskip_normal 0
pgskip_movable 0
pgfree 716918803
pgactivate 68768195
pgdeactivate 7278211
pglazyfree 1398441
pgfault 491284262
pgmajfault 86567
pglazyfreed 1000581
pgrefill 7551461
pgsteal_kswapd 130545619
pgsteal_direct 205772
pgscan_kswapd 131219641
pgscan_direct 207173
pgscan_direct_throttle 0
zone_reclaim_failed 0
pginodesteal 8055
slabs_scanned 9977903
kswapd_inodesteal 13337022
kswapd_low_wmark_hit_quickly 33796
kswapd_high_wmark_hit_quickly 3948
pageoutrun 43580
pgrotated 200299
drop_pagecache 0
drop_slab 0
oom_kill 0
numa_pte_updates 0
numa_huge_pte_updates 0
numa_hint_faults 0
numa_hint_faults_local 0
numa_pages_migrated 0
pgmigrate_success 768502
pgmigrate_fail 1670
compact_migrate_scanned 1288646
compact_free_scanned 44388226
compact_isolated 1575815
compact_stall 863
compact_fail 392
compact_success 471
compact_daemon_wake 975
compact_daemon_migrate_scanned 613634
compact_daemon_free_scanned 26884944
htlb_buddy_alloc_success 0
htlb_buddy_alloc_fail 0
unevictable_pgs_culled 258910
unevictable_pgs_scanned 3690
unevictable_pgs_rescued 200643
unevictable_pgs_mlocked 199204
unevictable_pgs_munlocked 199164
unevictable_pgs_cleared 6
unevictable_pgs_stranded 6
thp_fault_alloc 10655
thp_fault_fallback 130
thp_collapse_alloc 655
thp_collapse_alloc_failed 50
thp_file_alloc 0
thp_file_mapped 0
thp_split_page 612
thp_split_page_failed 0
thp_deferred_split_page 11238
thp_split_pmd 632
thp_split_pud 0
thp_zero_page_alloc 2
thp_zero_page_alloc_failed 0
thp_swpout 4
thp_swpout_fallback 0
balloon_inflate 0
balloon_deflate 0
balloon_migrate 0
swap_ra 9661
swap_ra_hit 7872" > var/binds/fbindprocvmstat
}

_ADDfbindsysdevices_() {
:>var/binds/fbindsysdevices
chmod 666 var/binds/fbindsysdevices
}
# fbindsfunctions.bash FE
