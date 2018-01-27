
releasewakelock ()
{
	printf " 🕦 \033[36;1m<\033[0m 🕛 "
	while true; do
	read -p "Release termux-wake-lock? [y|n]" answer
	#read -p $'\e[31mRelease termux-wake-lock? [y|n]\e[0m: ' answer
	#RESET="\033[0m"
	#BOLD="\033[1m"
	#YELLOW="\033[38;5;11m"
	#read -p "$(echo -e $BOLD$YELLOW"Release termux-wake-lock? [y|n] "$RESET)" answer
	#BC=$'\e[4m'
	#EC=$'\e[0m'
	#read -p "Release ${BC}termux-wake-lock${EC}? [y|n]" answer
	if [[ $answer = [Yy]* ]];then
		termux-wake-unlock
		printf "\n 🕛 \033[32;1m=\033[0m 🕛 Termux-wake-lock released.  \033[0m"
		break
	elif [[ $answer = [Nn]* ]];then
		printf "\n 🕛 \033[32;1m=\033[0m 🕛 "
		break
	elif [[ $answer = [Qq]* ]];then
		printf "\n 🕛 \033[32;1m=\033[0m 🕛 "
		break
	else
		printf "\n 🕦 \033[36;1m<\033[0m 🕛 You answered \033[33;1m$answer\033[0m.\n"
		printf "\n 🕦 \033[36;1m<\033[0m 🕛 Answer Yes or No (y|n).\n\n"
	fi
	done
}

