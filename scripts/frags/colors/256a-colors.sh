
# taken from https://misc.flogisoft.com/bash/tip_colors_and_formatting#colors2
# with a blacklist of the hardest colors to see agaist a black or white background

blacklist=(0 1 7 9 {15..18} {232..235} {250..255})
#blacklist=()
colors=$(printf '%d\n' {0..255} ${blacklist[@]} | sort -n | uniq -u)

slot=0
for fgbg in 38 48 ; do # Foreground / Background
    for color in $colors ; do # Colors
        # Display the color
        printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
        # Display 6 colors per lines
        if [ $((($slot + 1) % 6)) == 4 ] ; then
            echo # New line
        fi
        slot=$((slot + 1))
    done
    echo # New line
done
