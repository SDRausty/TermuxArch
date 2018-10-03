#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosted sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/README has info about this project. 
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# _STANDARD_="function name" && STANDARD="variable name" are under construction.
################################################################################

_FTCHIT_() {
 	_PRINT_DOWNLOADING_FTCHIT_ 
	if [[ "$dm" = aria2 ]];then
		aria2c -c -Z "$PRTCL"://"$CMIRROR$path$SRMFILE" "$PRTCL"://"$CMIRROR$path$file"
	elif [[ "$dm" = axel ]];then
		axel "$PRTCL"://"$CMIRROR$path$SRMFILE"
		axel "$PRTCL"://"$CMIRROR$path$file"
	elif [[ "$dm" = lftp ]] ; then
		lftpget -c "$PRTCL"://"$CMIRROR$path$SRMFILE" "$PRTCL"://"$CMIRROR$path$file"
	elif [[ "$dm" = wget ]];then 
		wget "$DMVERBOSE" -c --show-progress -N "$PRTCL"://"$CMIRROR$path$SRMFILE" http://"$CMIRROR$path$file" 
	else
		curl "$DMVERBOSE" -C - --fail --retry 4 -OL "$PRTCL"://"$CMIRROR$path$SRMFILE" -O http://"$CMIRROR$path$file" 
	fi
}

_FTCHSTND_() {
	FSTND=1
	_PRINTCONTACTING_ 
	if [[ "$dm" = aria2 ]];then
		aria2c http://"$CMIRROR" 1>"$TAMPDIR/global2localmirror"
		NLCMIRROR="$(grep Redirecting "$TAMPDIR/global2localmirror" | awk {'print $8'})" 
		_PRINTDONE_ 
		_PRINTDOWNLOADINGFTCH_ 
		aria2c -c -m 4 -Z "$NLCMIRROR$path$SRMFILE" "$NLCMIRROR$path$file"
	elif [[ "$dm" = axel ]];then
		axel -vv http://"$CMIRROR" 1 > "$TAMPDIR/global2localmirror"
		NLCMIRR="$(grep downloading "$TAMPDIR/global2localmirror" | awk {'print $5'})" 
		NLCMIRROR="${NLCMIRR::-3}"
		_PRINTDONE_ 
		_PRINTDOWNLOADINGFTCH_ 
		axel -a http://"$NLCMIRROR$path$SRMFILE"
		axel -a http://"$NLCMIRROR$path$file"
	elif [[ "$dm" = lftp ]] ; then
		lftp -e get http://"$CMIRROR" 2>&1 | tee>"$TAMPDIR/global2localmirror"
		NLCMI="$(grep direct "$TAMPDIR/global2localmirror" | awk {'print $5'})" 
		NLCMIRR="${NLCMI//\`}"
		NLCMIRROR="${NLCMIRR//\'}"
		_PRINTDONE_ 
		_PRINTDOWNLOADINGFTCH_ 
		lftpget -c "$NLCMIRROR$path$SRMFILE" "$NLCMIRROR$path$file"
	elif [[ "$dm" = wget ]];then 
		wget -v -O/dev/null "$CMIRROR" 2>"$TAMPDIR/global2localmirror"
		NLCMIRROR="$(grep Location "$TAMPDIR/global2localmirror" | awk {'print $2'})" 
		_PRINTDONE_ 
		_PRINTDOWNLOADINGFTCH_ 
		wget "$DMVERBOSE" -c --show-progress "$NLCMIRROR$path$SRMFILE" "$NLCMIRROR$path$file" 
	else
		curl -v "$CMIRROR" 2>"$TAMPDIR/global2localmirror"
		_FMIRROR_
		curl "$DMVERBOSE" -C - --fail --retry 4 -OL "$NLCMIRROR$path$SRMFILE" -O "$NLCMIRROR$path$file"
	fi
}

_FMIRROR_() {
	NLCMIRROR="$(grep Location "$TAMPDIR/global2localmirror" | awk {'print $3'})" 
	_PRINTDONE_ 
	_PRINTDOWNLOADINGFTCH_ 
}

_GETIMAGE_() {
	_PRINTDOWNLOADINGX86_ 
	if [[ "$dm" = aria2 ]]
	then
		aria2c "$PRTCL"://"$CMIRROR$path$SRMFILE"
		_ISX86_
		aria2c -c "$PRTCL"://"$CMIRROR$path$file"
	elif [[ "$dm" = axel ]]
	then
		axel "$PRTCL"://"$CMIRROR$path$SRMFILE"
		_ISX86_
		axel "$PRTCL"://"$CMIRROR$path$file"
	elif [[ "$dm" = lftp ]]
	then
		lftpget "$PRTCL"://"$CMIRROR$path$SRMFILE"
		_ISX86_
		lftpget -c "$PRTCL"://"$CMIRROR$path$file"
	elif [[ "$dm" = wget ]]
	then 
		wget "$DMVERBOSE" -N --show-progress "$PRTCL"://"$CMIRROR$path$SRMFILE"
		_ISX86_
		wget "$DMVERBOSE" -c --show-progress "$PRTCL"://"$CMIRROR$path$file" 
	else
		curl "$DMVERBOSE" --fail --retry 4 -OL "$PRTCL"://"$CMIRROR$path$SRMFILE"
		_ISX86_
		curl "$DMVERBOSE" -C - --fail --retry 4 -OL "$PRTCL"://"$CMIRROR$path$file" 
	fi
}

_ISX86_() {
	if [[ "$CPUABI" = "$CPUABIX86" ]];then
		file="$(grep i686 $SRMFILE | awk {'print $2'})"
	else
		file="$(grep boot $SRMFILE | awk {'print $2'})"
	fi
	sed '2q;d' $SRMFILE > "$file".md5
	rm $SRMFILE
	_PRINTDOWNLOADINGX86TWO_ 
}

# EOF
