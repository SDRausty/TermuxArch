#!/bin/env bash
# Copyright 2017-2019 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project. 
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
################################################################################

_FTCHIT_() {
 	_PRINT_DOWNLOADING_FTCHIT_ 
	if [[ "$DM" = aria2 ]]
	then
		aria2c -c -Z http://"$CMIRROR$RPATH$IFILE".md5 http://"$CMIRROR$RPATH$IFILE"
	elif [[ "$DM" = axel ]]
	then
		axel http://"$CMIRROR$RPATH$IFILE".md5 
		axel http://"$CMIRROR$RPATH$IFILE"
	elif [[ "$DM" = lftp ]]
	then
		lftpget -c http://"$CMIRROR$RPATH$IFILE".md5 http://"$CMIRROR$RPATH$IFILE"
	elif [[ "$DM" = wget ]]
	then 
		wget "$DMVERBOSE" -c --show-progress -N http://"$CMIRROR$RPATH$IFILE".md5 http://"$CMIRROR$RPATH$IFILE" 
	else
		curl "$DMVERBOSE" -C - --fail --retry 4 -OL http://"$CMIRROR$RPATH$IFILE".md5 -O http://"$CMIRROR$RPATH$IFILE" 
	fi
}

_FTCHSTND_() {
	FSTND=1
	_PRINTCONTACTING_ 
	if [[ "$DM" = aria2 ]]
	then
		aria2c http://"$CMIRROR" 1>"$TAMPDIR/global2localmirror"
		NLCMIRROR="$(grep Redirecting "$TAMPDIR/global2localmirror" | awk {'print $8'})" 
		_PRINTDONE_ 
		_PRINTDOWNLOADINGFTCH_ 
		aria2c -c -m 4 -Z "$NLCMIRROR$RPATH$IFILE".md5 "$NLCMIRROR$RPATH$IFILE"
	elif [[ "$DM" = axel ]]
	then
		axel -vv http://"$CMIRROR" 1 > "$TAMPDIR/global2localmirror"
		NLCMIRR="$(grep downloading "$TAMPDIR/global2localmirror" | awk {'print $5'})" 
		NLCMIRROR="${NLCMIRR::-3}"
		_PRINTDONE_ 
		_PRINTDOWNLOADINGFTCH_ 
		axel -a http://"$NLCMIRROR$RPATH$IFILE".md5 
		axel -a http://"$NLCMIRROR$RPATH$IFILE"
	elif [[ "$DM" = lftp ]]
	then
		lftp -e get http://"$CMIRROR" 2>&1 | tee>"$TAMPDIR/global2localmirror"
		NLCMI="$(grep direct "$TAMPDIR/global2localmirror" | awk {'print $5'})" 
		NLCMIRR="${NLCMI//\`}"
		NLCMIRROR="${NLCMIRR//\'}"
		_PRINTDONE_ 
		_PRINTDOWNLOADINGFTCH_ 
		lftpget -c "$NLCMIRROR$RPATH$IFILE".md5 "$NLCMIRROR$RPATH$IFILE"
	elif [[ "$DM" = wget ]]
	then 
		wget -v -O/dev/null "$CMIRROR" 2>"$TAMPDIR/global2localmirror"
		NLCMIRROR="$(grep Location "$TAMPDIR/global2localmirror" | awk {'print $2'})" 
		_PRINTDONE_ 
		_PRINTDOWNLOADINGFTCH_ 
		wget "$DMVERBOSE" -c --show-progress "$NLCMIRROR$RPATH$IFILE".md5 "$NLCMIRROR$RPATH$IFILE" 
	else
		curl -v "$CMIRROR" &> "$TAMPDIR/global2localmirror"
		_FMIRROR_
		curl "$DMVERBOSE" -C - --fail --retry 4 -O "${NLCMIRROR::-2}$RPATH$IFILE".md5 -O "${NLCMIRROR::-2}$RPATH$IFILE"
	fi
}

_FMIRROR_() {
	NLCMIRROR="$(grep Location "$TAMPDIR/global2localmirror" | awk {'print $3'})" 
	_PRINTDONE_ 
	_PRINTDOWNLOADINGFTCH_ 
}

_GETIMAGE_() {
	_PRINTDOWNLOADINGX86_ 
	if [[ "$DM" = aria2 ]]
	then
		aria2c http://"$CMIRROR$RPATH$IFILE".md5 
		_ISX86_
		aria2c -c http://"$CMIRROR$RPATH$IFILE"
	elif [[ "$DM" = axel ]]
	then
		axel http://"$CMIRROR$RPATH$IFILE".md5 
		_ISX86_
		axel http://"$CMIRROR$RPATH$IFILE"
	elif [[ "$DM" = lftp ]]
	then
		lftpget http://"$CMIRROR$RPATH"md5sums.txt
		_ISX86_
		lftpget -c http://"$CMIRROR$RPATH$IFILE"
	elif [[ "$DM" = wget ]]
	then 
		wget "$DMVERBOSE" -N --show-progress http://"$CMIRROR$RPATH"md5sums.txt
		_ISX86_
		wget "$DMVERBOSE" -c --show-progress http://"$CMIRROR$RPATH$IFILE" 
	else
		curl "$DMVERBOSE" --fail --retry 4 -OL http://"$CMIRROR$RPATH"md5sums.txt
		_ISX86_
		curl "$DMVERBOSE" -C - --fail --retry 4 -OL http://"$CMIRROR$RPATH$IFILE" 
	fi
}

_ISX86_() {
	if [[ "$CPUABI" = "$CPUABIX86" ]]
	then
		file="$(grep i686 md5sums.txt | awk {'print $2'})"
	else
		file="$(grep boot md5sums.txt | awk {'print $2'})"
	fi
	sed '2q;d' md5sums.txt > "$IFILE".md5
	rm md5sums.txt
	_PRINTDOWNLOADINGX86TWO_ 
}
# getimagefunctions.bash EOF
