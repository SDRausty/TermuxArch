#!/data/data/com.termux/files/usr/bin/bash
#RELEASE_URL=$(wget -q -O -  http://www.rstudio.org/download/daily/desktop/ubuntu64 | grep -o -m 1 "https[^\']*" )
RELEASE_URL=$(wget -q -O -  http://mirrors.evowise.com/archlinux/iso/latest/ | grep -o -m 1 "https[^\']*" |less )
RELEASE_URL=$(wget -q -O -  http://mirrors.evowise.com/archlinux/iso/latest/ | grep -o -m 1 "https[^\']*tar.gz" )
RELEASE_URL=$(wget -q -O -  http://mirrors.evowise.com/archlinux/iso/latest/ | less )
RELEASE_URL=$(wget -q -O -  http://mirrors.evowise.com/archlinux/iso/latest/ | grep -o -m 1 "https[^\']*" )

# check version from name ...


echo ${RELEASE_URL}
echo $RELEASE_URL
echo RELEASE_URL
wget ${RELEASE_URL}
