#!/usr/bin/env bash
## Copyright 2017-2022 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
## Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
## https://sdrausty.github.io/TermuxArch/README has info about this project.
## https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.
################################################################################
_FTCHIT_() {
_PRINT_DOWNLOADING_FTCHIT_
if [[ "$DM" = aria2 ]]
then
aria2c --continue -Z http://"$CMIRROR/$RPATH/$IFILE".md5 http://"$CMIRROR/$RPATH/$IFILE"
elif [[ "$DM" = axel ]]
then
axel -a --no-clobber http://"$CMIRROR/$RPATH/$IFILE".md5 ||:
axel -a --no-clobber http://"$CMIRROR/$RPATH/$IFILE" ||:
elif [[ "$DM" = lftp ]]
then
lftpget -c http://"$CMIRROR/$RPATH/$IFILE".md5 http://"$CMIRROR/$RPATH/$IFILE"
elif [[ "$DM" = wget ]]
then
wget "$DMVERBOSE" --continue --show-progress -N http://"$CMIRROR/$RPATH/$IFILE".md5 http://"$CMIRROR/$RPATH/$IFILE"
else
curl "$DMVERBOSE" -C - --fail --retry 4 -OL {"http://$CMIRROR/$RPATH/$IFILE.md5,http://$CMIRROR/$RPATH/$IFILE"}
fi
}

_FTCHSTND_() {
FSTND=1
_PRINTCONTACTING_
if [[ "$DM" = aria2 ]]
then
aria2c http://"$CMIRROR" 1>"$TMPDIR/global2localmirror"
NLCMIRROR="$(grep Redirecting "$TMPDIR/global2localmirror" | awk {'print $8'})"
_PRINTDONE_
_PRINTDOWNLOADINGFTCH_
aria2c --continue -m 4 -Z "$NLCMIRROR/$RPATH/$IFILE".md5 "$NLCMIRROR/$RPATH/$IFILE"
elif [[ "$DM" = axel ]]
then
axel -vv http://"$CMIRROR" 1 > "$TMPDIR/global2localmirror"
NLCMIRR="$(grep downloading "$TMPDIR/global2localmirror" | awk {'print $5'})"
NLCMIRROR="${NLCMIRR::-3}"
_PRINTDONE_
_PRINTDOWNLOADINGFTCH_
axel -a --no-clobber http://"$NLCMIRROR/$RPATH/$IFILE".md5 ||:
axel -a --no-clobber http://"$NLCMIRROR/$RPATH/$IFILE" ||:
elif [[ "$DM" = lftp ]]
then
lftp -e get http://"$CMIRROR" 2>&1 | tee>"$TMPDIR/global2localmirror"
NLCMI="$(grep direct "$TMPDIR/global2localmirror" | awk {'print $5'})"
NLCMIRR="${NLCMI//\`}"
NLCMIRROR="${NLCMIRR//\'}"
_PRINTDONE_
_PRINTDOWNLOADINGFTCH_
lftpget -c "$NLCMIRROR/$RPATH/$IFILE".md5 "$NLCMIRROR/$RPATH/$IFILE"
elif [[ "$DM" = wget ]]
then
wget -v -O/dev/null "$CMIRROR" 2>"$TMPDIR/global2localmirror"
NLCMIRROR="$(grep Location "$TMPDIR/global2localmirror" | awk {'print $2'})"
_PRINTDONE_
_PRINTDOWNLOADINGFTCH_
wget "$DMVERBOSE" --continue --show-progress "$NLCMIRROR/$RPATH/$IFILE".md5 "$NLCMIRROR/$RPATH/$IFILE"
else
curl -v "$CMIRROR" &> "$TMPDIR/global2localmirror"
NLCMIRROR="$(grep Location "$TMPDIR/global2localmirror" | awk {'print $3'})"
NLCMIRROR="${NLCMIRROR%$'\r'}" # remove trailing carrage return: strip bash variable of non printing characters
_PRINTDONE_
_PRINTDOWNLOADINGFTCH_
curl "$DMVERBOSE" -C - --fail --retry 4 -OL {"$NLCMIRROR/$RPATH/$IFILE.md5,$NLCMIRROR/$RPATH/$IFILE"}
fi
rm -f "$TMPDIR/global2localmirror"
}

_GETIMAGE_() {
_PRINTDOWNLOADINGX86_
if [[ "$DM" = aria2 ]]
then
aria2c http://"$CMIRROR/$RPATH/$IFILE".md5
_ISX86_
aria2c --continue http://"$CMIRROR/$RPATH/$IFILE"
elif [[ "$DM" = axel ]]
then
axel -a --no-clobber http://"$CMIRROR/$RPATH/$IFILE".md5 ||:
_ISX86_
axel -a --no-clobber http://"$CMIRROR/$RPATH/$IFILE" ||:
elif [[ "$DM" = lftp ]]
then
lftpget http://"$CMIRROR/$RPATH"/md5sums.txt || lftpget http://"$CMIRROR/$RPATH"/md5sums.txt
_ISX86_
lftpget -c http://"$CMIRROR/$RPATH/$IFILE" || lftpget -c http://"$CMIRROR/$RPATH/$IFILE"
elif [[ "$DM" = wget ]]
then
wget "$DMVERBOSE" -N --show-progress http://"$CMIRROR/$RPATH/"md5sums.txt
_ISX86_
wget "$DMVERBOSE" --continue --show-progress http://"$CMIRROR/$RPATH/$IFILE"
else
curl "$DMVERBOSE" --fail --retry 4 -OL http://"$CMIRROR/$RPATH"/md5sums.txt
_ISX86_
curl "$DMVERBOSE" -C - --fail --retry 4 -OL http://"$CMIRROR/$RPATH/$IFILE"
fi
}

_ISX86_() {
if [[ "$CPUABI" = "$CPUABIX86" ]]
then
IFILE="$(grep i686 md5sums.txt | awk {'print $2'} ||:)"
else
IFILE="$(grep boot md5sums.txt | awk {'print $2'} ||:)"
fi
sed '2q;d' md5sums.txt > "$IFILE".md5 2>/dev/null ||:
rm -f md5sums.txt
rm -f \.md5
_PRINTDOWNLOADINGX86TWO_
}
# getimagefunctions.bash FE
