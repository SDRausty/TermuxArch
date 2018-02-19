#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

ftchit ()
{
	if [[ $dm = wget ]];then 
		printdownloadingftchit 
		wget $dmverbose -N --show-progress http://$mirror$path$file.md5 
		wget $dmverbose -c --show-progress http://$mirror$path$file 
	else
		printdownloadingftchit 
		curl $dmverbose -C - --fail --retry 4 -O http://$mirror$path$file.md5 -O http://$mirror$path$file 
	fi
}

ftchstnd ()
{
	printf "\033[0;34mContacting worldwide mirror \033[0;32m$cmirror\033[0;34m.  "
	if [[ $dm = wget ]];then 
		wget -v -O/dev/null $cmirror 2>gmirror
		nmirror=$(grep Location gmirror | awk {'print $2'}) 
		rm gmirror
		printdownloadingftch 
		wget $dmverbose -N --show-progress $nmirror$path$file.md5 
		wget $dmverbose -N --show-progress $nmirror$path$file 
	else
		curl -v $cmirror 2>gmirror
		nmirror=$(grep Location gmirror | awk {'print $3'}) 
		rm gmirror
		printdownloadingftch 
		curl $dmverbose --fail --retry 4 -O $nmirror$path$file.md5 -O $nmirror$path$file
	fi
}

getimage ()
{
	printdownloadingx86 
	if [[ $dm = wget ]];then 
		wget $dmverbose -N --show-progress http://$mirror${path}md5sums.txt
		if [ $(getprop ro.product.cpu.abi) = x86 ];then
			file=$(grep i686 md5sums.txt | awk {'print $2'})
		else
			file=$(grep boot md5sums.txt | awk {'print $2'})
		fi
		sed '2q;d' md5sums.txt > $file.md5
		rm md5sums.txt
		printdownloadingx86two 
		wget $dmverbose -c --show-progress http://$mirror$path$file 
	else
		curl $dmverbose --fail --retry 4 -OL http://$mirror${path}md5sums.txt
		if [ $(getprop ro.product.cpu.abi) = x86 ];then
			file=$(grep i686 md5sums.txt | awk {'print $2'})
		else
			file=$(grep boot md5sums.txt | awk {'print $2'})
		fi
		sed '2q;d' md5sums.txt > $file.md5
		rm md5sums.txt
		printdownloadingx86two 
		curl $dmverbose -C - --fail --retry 4 -OL http://$mirror$path$file 
	fi
}

