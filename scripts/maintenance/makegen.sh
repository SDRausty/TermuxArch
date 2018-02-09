#!/bin/sh -e
# Copyright 2017-2018 by SDRausty. All rights reserved.
# Website for this project at https://sdrausty.github.io/TermuxArch
# See https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank You 
#############################################################################

cdir=${PWD##*/}        
#cdir=${pwd |sed 's!.*/!!'}
date=`date +%Y%m%d`
time=`date +%H:%M:%S`
utime=`date +%s`
ntime=`date +%N`
echo Running on $date branch master $ntime. 

printf "This script will generate a checksum and tar.gz files in \$PROJECT/gen.\n\n"
if [ ! -d "../../../gen" ] ; then
mkdir -p ../../../gen
fi
pwd
ls -al se*
printf "\n"
msg="v0.6.1 id$ntime"
echo "printf \"$msg\""
ms="		printf \"$msg\""
sed -i "/v0.6.1/c\\$ms" setupTermuxArch.sh 
cp setupTermuxArch.sh ..
#echo "echo "TermuxArch v0.5.$(date +%N)"" >> ../setupTermuxArch.sh 
ntime=`date +%N`
echo "$(date +%N)" 
md5sum *sh > termuxarchchecksum.md5 
cd ..
bsdtar -czv -f setupTermuxArch.tar.gz --strip-components 1 $cdir/*
pwd
ls -al se*
printf "Generated tar.gz file with internal md5 checksum.\n\n"
rm $cdir/termuxarchchecksum.md5
md5sum setupTermuxArch.tar.gz > setupTermuxArch.md5
ls -al se*
printf "Generated md5 checksum for tar.gz file.\n\n"
mv se* ../../gen
ls -al  ../../gen
printf "Deposited entire project in \$PROJECT/gen.\n\n"
printf  "$cdir\n\n"
ls -al $cdir
printf "\nGenerated checksums and tar.gz in \$PROJECT/gen.\n\n"
