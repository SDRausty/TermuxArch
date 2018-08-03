#!/bin/env bash
# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
# https://sdrausty.github.io/TermuxArch/README has information about this project. 
################################################################################

callsystem () {
	mkdir -p "$installdir"
	cd "$installdir"
	detectsystem 
}

copystartbin2path () {
	if [[ ":$PATH:" == *":$HOME/bin:"* ]] && [[ -d "$HOME"/bin ]]; then
		BPATH="$HOME"/bin
	else
		BPATH="$PREFIX"/bin
	fi
	cp "$installdir/$startbin" "$BPATH"
	printf "\\e[0;34m 🕛 > 🕦 \\e[1;32m$startbin \\e[0mcopied to \\e[1m$BPATH\\e[0m.\\n\\n"
}

copystartbin2pathq () {
	while true; do
	printf "\\e[0;34m 🕛 > 🕚 \\e[0mCopy \\e[1m$startbin\\e[0m to \\e[1m$BPATH\\e[0m?  "'\033]2; 🕛 > 🕚 Copy to $PATH [Y|n]?\007'
	read -p "Answer yes or no [Y|n] " answer
	if [[ "$answer" = [Yy]* ]] || [[ "$answer" = "" ]];then
		cp "$installdir/$startbin" "$BPATH"
		printf "\\n\\e[0;34m 🕛 > 🕦 \\e[0mCopied \\e[1m$startbin\\e[0m to \\e[1m$BPATH\\e[0m.\\n\\n"
		break
	elif [[ "$answer" = [Nn]* ]] || [[ "$answer" = [Qq]* ]];then
		printf "\\n"
		break
	else
		printf "\\n\\e[0;34m 🕛 > 🕚 \\e[0mYou answered \\e[33;1m$answer\\e[0m.\\n\\n\\e[0;34m 🕛 > 🕚 \\e[0mAnswer yes or no [Y|n]\\n\\n"
	fi
	done
}

detectsystem () {
	printdetectedsystem
	if [[ "$cpuabi" = "$cpuabi5" ]];then
		armv5l
	elif [[ "$cpuabi" = "$cpuabi7" ]];then
		detectsystem2 
	elif [[ "$cpuabi" = "$cpuabi8" ]];then
		aarch64
	elif [[ "$cpuabi" = "$cpuabix86" ]];then
		i686 
	elif [[ "$cpuabi" = "$cpuabix8664" ]];then
		x86_64
	else
		printmismatch 
	fi
}

detectsystem2 () {
	if [[ "$(getprop ro.product.device)" == *_cheets ]];then
		armv7lChrome 
	else
		armv7lAndroid  
	fi
}

editfiles () {
	if [[ "${ceds[$i]}" = "applets/vi" ]];then
		sed -i -e 1,4d "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vi instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# 17j then i opens edit mode for the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap ESC to return to command mode in vi.\\n# CTRL+d and CTRL+b to find your local mirror.\\n# / for search, N and n for next match.\\n# Tap x to delete # to uncomment your local mirror.\\n# Choose only one mirror.  Use :x to save your work.\\n# Comment out the Geo-IP mirror	end G	top gg\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vi instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# Tap i for insert, ESC to return to command mode in vi.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap x to delete # to uncomment your favorite language(s).\\n# Enter the # hash/num/pounds symbol to comment out locales.\\n# CTRL+d and CTRL+b for PGUP & PGDN.\\n# top gg	bottom G\\n# / for search, N and n for next match.\\n# Choose as many as you like.  Use :x to save your work.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n#' "$installdir"/etc/locale.gen
	elif [[ "${ceds[$i]}" = "vim" ]];then
		sed -i -e 1,4d "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# 17j then i opens edit mode for the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap ESC to return to command mode in vi.\\n# CTRL+d and CTRL+b to find your local mirror.\\n# / for search, N and n for next match.\\n# Tap x to delete # to uncomment your local mirror.\\n# Choose only one mirror.  Use :x to save your work.\\n#Comment out the Geo-IP mirror	end G	top gg\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch vim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# Tap i for insert, ESC to return to command mode in vi.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap x to delete # to uncomment your favorite language(s).\\n# Enter the # hash/num/pounds symbol to comment out locales.\\n# CTRL+d and CTRL+b for PGUP & PGDN.\\n# top gg	bottom G\\n# / for search, N and n for next match.\\n# Choose as many as you like.  Use :x to save your work.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n#' "$installdir"/etc/locale.gen
	elif [[ "${ceds[$i]}" = "nvim" ]];then
		sed -i -e 1,4d "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch neovim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# 17j then i opens edit mode for the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap ESC to return to command mode in vi.\\n# CTRL+d and CTRL+b to find your local mirror.\\n# / for search, N and n for next match.\\n# Tap x to delete # to uncomment your local mirror.\\n# Choose only one mirror.  Use :x to save your work.\\n# Comment out the Geo-IP mirror	end G	top gg\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch neovim instructions:	CTR+r is redo.\\n# Use the hjkl keys to navigate. <h down j up k l>\\n# Numbers are multipliers.  The u is undelete/undo.\\n# Tap i for insert, ESC to return to command mode in vi.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Tap x to delete # to uncomment your favorite language(s).\\n# Enter the # hash/num/pounds symbol to comment out locales.\\n# CTRL+d and CTRL+b for PGUP & PGDN.\\n# top gg	bottom G\\n# / for search, N and n for next match.\\n# Choose as many as you like.  Use :x to save your work.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n#' "$installdir"/etc/locale.gen
	else
		sed -i '1i# # # # # # # # # # # # # # # # # # # # # # # # # # #\\n# TermuxArch edit instructions:	 Locate the Geo-IP mirror.\\n# Enter the # hash/num/pounds symbol to comment it out: \\n# Server = http://mirror.archlinuxarm.org/$arch/$repo.\\n# Long tap KEYBOARD in the side pane to see ESC, CTR...\\n# Choose only one mirror.\\n# Delete # to uncomment your local mirror.\\n# # # # # # # # # # # # # # # # # # # # # # # # # # #' "$installdir"/etc/pacman.d/mirrorlist
	fi
}
	
lkernid () {
	ur="$("$PREFIX"/bin/applets/uname -r)"
	declare -i KERNEL_VERSION="$(echo "$ur" |awk -F'.' '{print $1}')"
	declare -i MAJOR_REVISION="$(echo "$ur" |awk -F'.' '{print $2}')"
	declare -- tmp="$(echo "$ur" |awk -F'.' '{print $3}')"
	declare -- MINOR_REVISION="$(echo "${tmp:0:3}" |sed 's/[^0-9]*//g')"
	if [[ "$KERNEL_VERSION" -le 2 ]]; then
		kid=1
	else
		if [[ "$KERNEL_VERSION" -eq 3 ]]; then
			if [[ "$MAJOR_REVISION" -lt 2 ]]; then
				kid=1
			else
				if [[ "$MAJOR_REVISION" -eq 2 ]] && [[ "$MINOR_REVISION" -eq 0 ]]; then
					kid=1
				fi
			fi
		fi
	fi
}

lkernid 

mainblock () { 
	namestartarch 
	nameinstalldir
	spaceinfo
	callsystem 
	printwld 
	termux-wake-unlock
	printdone 
	printfooter
	"$installdir/$startbin" ||:
	printfooter2
}

makefinishsetup () {
	binfnstp=finishsetup.sh  
	cat > root/bin/"$binfnstp" <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	printf "\\n\\e[1;34m:: \\e[1;37mRemoving redundant packages...\\n"
	EOM
	if [[ -e "$HOME"/.bash_profile ]];then
		grep "proxy" "$HOME"/.bash_profile | grep "export" >> root/bin/"$binfnstp" 2>/dev/null ||:
	fi
	if [[ -e "$HOME"/.bashrc ]];then
		grep "proxy" "$HOME"/.bashrc  | grep "export" >> root/bin/"$binfnstp" 2>/dev/null ||:
	fi
	if [[ -e "$HOME"/.profile ]];then
		grep "proxy" "$HOME"/.profile | grep "export" >> root/bin/"$binfnstp" 2>/dev/null ||:
	fi
	if [[ "$cpuabi" = "$cpuabi5" ]];then
		printf "pacman -Rc linux-armv5 linux-firmware systemd --noconfirm --color=always 2>/dev/null ||:\\n" >> root/bin/"$binfnstp"
	elif [[ "$cpuabi" = "$cpuabi7" ]];then
		printf "pacman -Rc linux-armv7 linux-firmware systemd --noconfirm --color=always 2>/dev/null ||:\\n" >> root/bin/"$binfnstp"
	elif [[ "$cpuabi" = "$cpuabi8" ]];then
		printf "pacman -Rc linux-aarch64 linux-firmware systemd --noconfirm --color=always 2>/dev/null ||:\\n" >> root/bin/"$binfnstp"
	elif [[ "$cpuabi" = "$cpuabix86" ]] || [[ "$cpuabi" = "$cpuabix8664" ]];then
		printf "pacman -Rc systemd --noconfirm --color=always 2>/dev/null ||:\\n" >> root/bin/"$binfnstp"
	fi
	printf "printf \"\\n\\\e[1;32m==> \\\e[0mRunning ./root/bin/keys…\"\\n" >> root/bin/"$binfnstp"
	if [[ "$cpuabi" = "$cpuabix86" ]];then
		printf "./root/bin/keys x86\\n" >> root/bin/"$binfnstp"
	else
		printf "./root/bin/keys\\n" >> root/bin/"$binfnstp"
	fi
	if [[ "$cpuabi" = "$cpuabix86" ]] || [[ "$cpuabi" = "$cpuabix8664" ]];then
		printf "./root/bin/pc gzip sed 2>/dev/null ||:\\n" >> root/bin/"$binfnstp"
	else
		printf "./root/bin/pc 2>/dev/null ||:\\n" >> root/bin/"$binfnstp"
	fi
	cat >> root/bin/"$binfnstp" <<- EOM
	printf "\\n\\e[1;32m==> \\e[0m"
	locale-gen ||:
	printf "\\a\\n\\a"
	printf '\033]2; 🕛 > 🕤 Arch Linux in Termux is installed and configured 📲 \007'
	EOM
	chmod 770 root/bin/"$binfnstp" 
}

makesetupbin () {
	cat > root/bin/setupbin.sh <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	unset LD_PRELOAD
	EOM
	echo "$prootstmnt /root/bin/finishsetup.sh ||:" >> root/bin/setupbin.sh 
	chmod 700 root/bin/setupbin.sh
}

makestartbin () {
	cat > "$startbin" <<- EOM
	#!/bin/bash -e
	# Copyright 2017-2018 by SDRausty. All rights reserved.  🌎 🌍 🌏 🌐 🗺
	# Hosting https://sdrausty.github.io/TermuxArch courtesy https://pages.github.com
	# https://sdrausty.github.io/TermuxArch/CONTRIBUTORS Thank you for your help.  
	# https://sdrausty.github.io/TermuxArch/README has information about this project. 
	################################################################################
	declare -g ar2ar=\${@:2}
	declare -g ar3ar=\${@:3}
	unset LD_PRELOAD
	printusage () { 
	printf "\\n\\e[0;32mUsage:  \\e[1;32m$startbin \\e[0;32mStart Arch Linux as root.  This account should only be reserved for system administration.\\n\\n	\\e[1;32m$startbin command command \\e[0;32mRun Arch Linux command from Termux as root user.\\n\\n	\\e[1;32m$startbin login user \\e[0;32mLogin as user.  Use \\e[1;32maddauser user \\e[0;32mfirst to create a user and the user's home directory.\\n\\n	\\e[1;32m$startbin raw \\e[0;32mConstruct the \\e[1;32mstartarch \\e[0;32mproot statement.  For example \\e[1;32mstartarch raw su - user \\e[0;32mwill login to Arch Linux as user.  Use \\e[1;32maddauser user \\e[0;32mfirst to create a user and the user's home directory.\\n\\n	\\e[1;32m$startbin su user command \\e[0;32mLogin as user and execute command.  Use \\e[1;32maddauser user \\e[0;32mfirst to create a user and the user's home directory.\\n\\n\\e[0m"'\033]2; TermuxArch '$startbin' help 📲  \007' 
	}

	if [[ \$1 = [?]* ]] || [[ \$1 = -[?]* ]] || [[ \$1 = --[?]* ]] || [[ \$1 = [Hh]* ]] || [[ \$1 = -[Hh]* ]] || [[ \$1 = --[Hh]* ]];then
	# [?|help] Displays usage information.
		printusage
	elif [[ \$1 = [Cc]* ]] || [[ \$1 = -[Cc]* ]] || [[ \$1 = --[Cc]* ]];then
	# [command args] Execute a command in BASH as root.
		printf '\033]2; '$startbin' command args 📲  \007'
		touch $installdir/root/.chushlogin
	EOM
		echo "$prootstmnt /bin/bash -lc \"\$ar2ar\" " >> "$startbin"
	cat >> "$startbin" <<- EOM
		printf '\033]2; '$startbin' command args 📲  \007'
		rm $installdir/root/.chushlogin
	elif [[ \$1 = [Ll]* ]] || [[ \$1 = -[Ll]* ]] || [[ \$1 = --[Ll]* ]] ;then
	# [login user|login user [options]] Login as user [plus options].  Use \`addauser user\` first to create this user and the user's home directory.
		printf '\033]2; '$startbin' login user [options] 📲  \007'
	EOM
		echo "$prootstmnt /bin/su - \"\$ar2ar\" " >> "$startbin"
	cat >> "$startbin" <<- EOM
		printf '\033]2; '$startbin' login user [options] 📲  \007'
	elif [[ \$1 = [Rr]* ]] || [[ \$1 = -[Rr]* ]] || [[ \$1 = --[Rr]* ]];then
	# [raw args] Construct the \`startarch\` proot statement.  For example \`startarch r su - archuser\` will login as user archuser.  Use \`addauser archuser\` first to create this user and the user home directory.
		printf '\033]2; '$startbin' raw args 📲  \007'
	EOM
		echo "$prootstmnt /bin/\"\$ar2ar\" " >> "$startbin"
	cat >> "$startbin" <<- EOM
		printf '\033]2; '$startbin' raw args 📲  \007'
	elif [[ \$1 = [Ss]* ]] || [[ \$1 = -[Ss]* ]] || [[ \$1 = --[Ss]* ]];then
	# [su user command] Login as user and execute command.  Use \`addauser user\` first to create this user and the user's home directory.
		printf '\033]2; '$startbin' su user command 📲  \007'
		if [[ \$2 = root ]];then
			touch $installdir/root/.chushlogin
		else
			touch $installdir/home/\$2/.chushlogin
		fi
	EOM
		echo "$prootstmnt /bin/su - \$2 -c \"\$ar3ar\" " >> "$startbin"
	cat >> "$startbin" <<- EOM
		printf '\033]2; '$startbin' su user command 📲  \007'
		if [[ \$2 = root ]];then
			rm $installdir/root/.chushlogin
		else
			rm $installdir/home/\$2/.chushlogin
		fi
	elif [[ \$1 = "" ]];then
	# [] Default Arch Linux in Termux PRoot root login.
	EOM
		echo "$prootstmnt /bin/bash -l  " >> "$startbin"
	cat >> "$startbin" <<- EOM
		printf '\033]2; TermuxArch '$startbin' 📲  \007'
	else
		printusage
	fi
	EOM
	chmod 700 "$startbin"
}

makesystem () {
	printwla 
	termux-wake-lock 
	printdone 
	if [[ "$cpuabi" = "$cpuabix86" ]] || [[ "$cpuabi" = "$cpuabix8664" ]];then
		getimage
	else
		if [[ "$mirror" = "os.archlinuxarm.org" ]] || [[ "$mirror" = "mirror.archlinuxarm.org" ]]; then
			until ftchstnd;do
				ftchstnd ||: 
				sleep 2
				printf "\\n"
				COUNTER=$((COUNTER + 1))
				if [[ "$COUNTER" = 12 ]];then 
					printf "\\n\\e[07;1m\\e[31;1m 🔆 ERROR Maximum amount of attempts exceeded!\\e[34;1m\\e[30;1m  Run \`bash setupTermuxArch.sh\` again.  See \`bash setupTermuxArch.sh help\` to resolve download errors.  If this keeps repeating, copy \`knownconfigurations.sh\` to \`setupTermuxArchConfigs.sh\` with preferred mirror.  After editing \`setupTermuxArchConfigs.sh\`, run \`bash setupTermuxArch.sh\` and \`setupTermuxArchConfigs.sh\` loads automaticaly from the same directory.  Change mirror to desired geographic location to resolve md5sum errors.\\n\\nUser configurable variables are in \`setupTermuxArchConfigs.sh\`.  Create this file from \`kownconfigurations.sh\` in the working directory.  Use \`bash setupTermuxArch.sh manual\` to create and edit \`setupTermuxArchConfigs.sh\`.\\n\\n	Run \`bash setupTermuxArch.sh\` again…\\n\\e[0;0m\\n"'\033]2;  Thank you for using setupTermuxArch.sh.  Run `bash setupTermuxArch.sh` again…\007'
					exit
				fi
			done
		else
			ftchit
		fi
	fi
	printmd5check
	if "$PREFIX"/bin/applets/md5sum -c "$file".md5 1>/dev/null ; then
		printmd5success
		preproot 
	else
		rmarchrm 
		printmd5error
	fi
	printcu 
	rm *.tar.gz *.tar.gz.md5
	printdone 
	makestartbin 
	printconfigup 
	touchupsys 
}

preproot () {
	if [[ "$(du "$installdir"/*z | awk {'print $1'})" -gt 112233 ]];then
		if [[ "$cpuabi" = "$cpuabix86" ]] || [[ "$cpuabi" = "$cpuabix8664" ]];then
			#cd $HOME
			#proot --link2symlink -0 $PREFIX/bin/applets/tar xf $installdir$file 
			#cd $installdir
			proot --link2symlink -0 bsdtar -xpf "$file" --strip-components 1 
		else
			proot --link2symlink -0 "$PREFIX"/bin/applets/tar xf "$file" 
			#proot --link2symlink -0 bsdtar -xpf $file --strip-components 1 
		fi
	else
		printf "\\n\\n\\e[1;31mDownload Exception!  Execute \\e[0;32mbash setupTermuxArch.sh\\e[1;31m again…\\n"'\033]2;  Thank you for using setupTermuxArch.sh.  Execute `bash setupTermuxArch.sh` again…\007'
		exit
	fi
}

runfinishsetup () {
	printf "\\e[0m"
	if [[ "$fstnd" ]]; then
		nmir="$(echo "$nmirror" |awk -F'/' '{print $3}')"
		sed -e '/http\:\/\/mir/ s/^#*/# /' -i "$installdir"/etc/pacman.d/mirrorlist
		sed -e "/$nmir/ s/^# *//" -i "$installdir"/etc/pacman.d/mirrorlist
	else
	if [[ "$ed" = "" ]];then
		editors 
	fi
	if [[ ! "$(sed 1q  "$installdir"/etc/pacman.d/mirrorlist)" = "# # # # # # # # # # # # # # # # # # # # # # # # # # #" ]];then
		editfiles
	fi
		"$ed" "$installdir"/etc/pacman.d/mirrorlist
	fi
	printf "\\n"
	"$installdir"/root/bin/setupbin.sh 
}

addlangq () {
	while true; do
		printf "\\e[1;34m  Add languages to the Arch Linux system? To edit \\e[1;32m/etc/locale.gen\\e[1;34m for your preferred language(s) before running \\e[1;32mlocale-gen\\e[1;34m choose edit.  Would you like to run \\e[1;32mlocale-gen\\e[1;34m with the English en_US.UTF-8 locale only?  "
		read -p "Answer yes to generate the English en_US.UTF-8 locale only [Y|e] " ye
		if [[ "$ye" = [Yy]* ]] || [[ "$ye" = "" ]];then
			break
		elif [[ "$ye" = [Ee]* ]] || [[ "$ye" = [Nn]* ]];then
			printf "\\e[0m"
			"$ed" "$installdir"/etc/locale.gen
			sleep 1
			break
		else
			printf "\\nYou answered \\e[1;36m$ye\\e[1;32m.\\n"
			sleep 1
			printf "\\nAnswer yes to run, or edit to edit the file [Y|e]\\n"
		fi
	done
}

runfinishsetupq () {
	while true; do
		printf "\\n\\e[0;32mWould you like to run \\e[1;32mfinishsetup.sh\\e[0;32m to complete the Arch Linux configuration and update now, or at a later time?  \\e[1;32mNow is recommended.  \\e[0;32m"
		read -p "Answer yes to complete the Arch Linux configuration and update now; Or answer no for later [Y|n] " nl
	if [[ "$nl" = [Yy]* ]] || [[ "$nl" = "" ]];then
		runfinishsetup 
		break
	elif [[ "$nl" = [Nn]* ]];then
		printf "\\n\\e[0;32mSet the geographically nearby mirror in \\e[1;32m/etc/pacman.d/mirrorlist\\e[0;32m first.  Then use \\e[1;32m$installdir/root/bin/setupbin.sh\\e[0;32m in Termux to run \\e[1;32mfinishsetup.sh\\e[0;32m or simply \\e[1;32mfinishsetup.sh\\e[0;32m in Arch Linux Termux PRoot to complete the Arch Linux configuration and update."
		break
	else
		printf "\\nYou answered \\e[1;36m$nl\\e[1;32m.\\n"
		sleep 1
		printf "\\nAnswer yes to complete, or no for later [Y|n]\\n"
	fi
	done
	printf "\\n"
}

setlocaleconf () {
	if ! grep en_US etc/locale.conf 2>/dev/null ; then
		echo LANG=en_US.UTF-8 >> etc/locale.conf 
		echo LANGUAGE=en_US >> etc/locale.conf 
		
	fi
}

setlocalegen () {
	if [[ -e etc/locale.gen ]]; then
		sed -i '/\#en_US.UTF-8 UTF-8/{s/#//g;s/@/-at-/g;}' etc/locale.gen 
	else
		cat >  etc/locale.gen <<- EOM
		en_US.UTF-8 UTF-8 
		EOM
	fi
}

touchupsys () {
	mkdir -p root/bin
	addae
	addauser
	addauserps
	addauserpsc
	addcdtd
	addcdth
	addbash_logout 
	addbash_profile 
	addbashrc 
	adddfa
	addexd
	addga
	addgcl
	addgcm
	addgp
	addgpl
	addkeys
	addmotd
	addmoto
	addpc
	addpci
	addprofile 
	addresolvconf 
	addt 
	addtour
	addtrim 
	addyt
	addwe  
	addv 
	setlocalegen
	setlocaleconf 
	makefinishsetup
	makesetupbin 
	runfinishsetup
	rm root/bin/finishsetup.sh
	rm root/bin/setupbin.sh 
}

