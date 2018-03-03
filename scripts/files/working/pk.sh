	if [ $(getprop ro.product.cpu.abi) = x86 ] || [ $(getprop ro.product.cpu.abi) = x86_64 ];then
		pacman-key --init
		echo disable-scdaemon > /etc/pacman.d/gnupg/gpg-agent.conf
		if [ $(getprop ro.product.cpu.abi) = x86 ];then
			pacman -S archlinux32-keyring --noconfirm ||:
		else
			pacman -S archlinux-keyring --noconfirm ||:
		fi
		pacman-key --populate
		pacman -Syu sed --noconfirm ||:
	else
		pacman-key --init
		echo disable-scdaemon > /etc/pacman.d/gnupg/gpg-agent.conf
		pacman-key --populate
		pacman -Syu archlinux-keyring --noconfirm ||:
	fi
	
