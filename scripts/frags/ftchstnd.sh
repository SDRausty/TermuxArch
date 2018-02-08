
ftchstnd ()
{
		if [[ $dm = wget ]];then 
			wget -q -N --show-progress http://$mirror$path$file.md5 
			wget -q -c --show-progress http://$mirror$path$file 
		else
			curl -q -L --fail --retry 4 -O http://$mirror$path$file.md5 -O http://$mirror$path$file
		fi
}
