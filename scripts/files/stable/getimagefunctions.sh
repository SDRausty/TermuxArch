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
	#cmirror="http://mirror.archlinuxarm.org/"
	cmirror="http://os.archlinuxarm.org/"
	if [[ $dm = wget ]];then 
		printf "\033[0;32mContacting mirror \033[1;32m$cmirror.  "
		curl -v $cmirror 2>gmirror
		nmirror=$(grep Location gmirror | awk {'print $3'}) 
		rm gmirror
		printdownloadingftch 
		wget $dmverbose -N --show-progress $nmirror$path$file.md5 
		wget $dmverbose -N --show-progress $nmirror$path$file 
	else
		printf "\033[0;32mContacting mirror \033[1;32m$cmirror.  "
		curl -v $cmirror 2>gmirror
		nmirror=$(grep Location gmirror | awk {'print $3'}) 
		rm gmirror
		printdownloadingftch 
		curl $dmverbose --fail --retry 4 -O $nmirror$path$file.md5 -O $nmirror$path$file
	fi
}

getimage ()
{
	if [[ $dm = wget ]];then 
		printdownloadingx86 
		wget $dmverbose -N --show-progress http://$mirror${path}md5sums.txt
		file=$(grep boot md5sums.txt | awk {'print $2'})
		sed '2q;d' md5sums.txt > $file.md5
		rm md5sums.txt
		printdownloadingx86two 
		wget $dmverbose -c --show-progress http://$mirror$path$file 
	else
		printdownloadingx86 
		curl $dmverbose -C - --fail --retry 4 -O http://$mirror${path}md5sums.txt
		file=$(grep boot md5sums.txt | awk {'print $2'})
		sed '2q;d' md5sums.txt > $file.md5
		rm md5sums.txt
		printdownloadingx86two 
		curl $dmverbose -C - --fail --retry 4 -O http://$mirror$path$file 
	fi
}

