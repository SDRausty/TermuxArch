

ftchstnd ()
{
	if [[ $(getprop ro.product.cpu.abi) -ne x86_64 ]] || [[ $(getprop ro.product.cpu.abi) -ne x86 ]];then
		ftchstnd
	else
		adjustmd5file
		getimage
	fi
		----
		if [[ $dm = wget ]];then 
		#	wget -N --show-progress http://$mirror$path$file.md5 
			wget -N http://$mirror$path$file.md5 
			wget -c --show-progress http://$mirror$path$file 
		else
			curl -q -L --fail --retry 4 -O http://$mirror$path$file.md5 -O http://$mirror$path$file
		fi
}
