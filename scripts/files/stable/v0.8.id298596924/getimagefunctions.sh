#!/bin/bash -e
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

adjustmd5file ()
{
	if [[ $dm = wget ]];then 
		printdownloading2 
		wget $dmverbose -N --show-progress http://$mirror${path}md5sums.txt
	else
		printdownloading2 
		curl $dmverbose --fail --retry 4 -O -L http://$mirror${path}md5sums.txt
	fi
	filename=$(ls *tar.gz)
	sed '2q;d' md5sums.txt > $filename.md5
	rm md5sums.txt
}

ftchit ()
{
	if [[ $dm = wget ]];then 
		printdownloadingftchit 
		wget $dmverbose -N --show-progress http://$mirror$path$file.md5 
		wget $dmverbose -c --show-progress http://$mirror$path$file 
	else
		printdownloadingftchit 
		curl $dmverbose -C - --fail --retry 4 -O http://$mirror$path$file.md5 -O http://$mirror$path$file ||:
	fi
}

ftchstnd ()
{
	#cmirror="http://mirror.archlinuxarm.org/"
	cmirror="http://os.archlinuxarm.org/"
	if [[ $dm = wget ]];then 
		printf "Contacting mirror $cmirror.  "
		curl -v $cmirror 2>gmirror
		nmirror=$(grep Location gmirror | awk {'print $3}') 
		rm gmirror
		printdownloadingftch 
		wget $dmverbose -N --show-progress $nmirror$path$file.md5 
		wget $dmverbose -N --show-progress $nmirror$path$file 
	else
		printf "Contacting mirror $cmirror.  "
		curl -v $cmirror 2>gmirror
		nmirror=$(grep Location gmirror | awk {'print $3}') 
		rm gmirror
		printdownloadingftch 
		curl $dmverbose --fail --retry 4 -O $nmirror$path$file.md5 -O $nmirror$path$file
	fi
}

getimage ()
{
	if [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		if [[ $dm = wget ]];then 
			wget -A tar.gz -m -nd -np http://$mirror$path
		else
			printf "Defaulting to \`wget\` for x86_64 system image download.\n\n"
			wget -A tar.gz -m -nd -np http://$mirror$path
		fi
	else
		if [[ $dm = wget ]];then 
			wget $dmverbose -c --show-progress http://$mirror$path$file 
		else
			curl $dmverbose -C - --fail --retry 4 -O -L  http://$mirror$path$file 
		fi
	fi
}

