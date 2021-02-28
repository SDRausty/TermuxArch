#!/usr/bin/env bash
## copyright 2020 (c) by SDRausty, all rights reserved, see LICENSE
## hosting termuxarch.github.io/TermuxArch courtesy pages.github.com
## contributors:  github.com/WMCB-Tech github.com/JanuszChmiel thank you for helping
################################################################################
set -eu
_AU_() {
if command -v au
then
au "$@"
else
printf "%s\\n" "Installing 'au'" && curl -OL "https://raw.githubusercontent.com/WAE/au/master/au" -o "$PREFIX/bin/au" && chmod 744 "$PREFIX/bin/au"
au "$@"
fi
}
_BKPPROOT_() {
[ ! -d "$HOME/termux/proot/tmp" ] && mkdir -p "$HOME/termux/proot/tmp"
if [ ! -f "$HOME/termux/proot/tmp/proot.bkp" ] && [ -f "$PREFIX/bin/proot" ]
then
cp "$PREFIX/bin/proot" "$HOME/termux/proot/tmp/proot.bkp" && printf "%s\\n" "Copied file '$PREFIX/bin/proot' to '$HOME/termux/proot/tmp/proot.bkp'."
fi
}
_GITCLONETERMUXPROOT_ () {
if [[ -z "${GITCLONETERMUXPROOTLCR:-}" ]]
then
printf "%s\\n" "Cloning 'https://github.com/termux/proot' with 'git --depth 1 --single-branch'."
git clone --depth 1 "https://github.com/termux/proot" --single-branch
else
printf "%s\\n" "Cloning 'https://github.com/termux/proot' with 'git'."
git clone "https://github.com/termux/proot"
cd proot
git reset --hard "$GITCLONETERMUXPROOTLCR"
fi
}
_MAKEV1_() {
if [ -f "$HOME/termux/proot/src/builttaprootuserland.lock" ]
then
printf "%s\\n" "Found file '$HOME/termux/proot/src/builttaprootuserland.lock' in directory '$HOME/termux/proot/src';  Please remove file '$HOME/termux/proot/src/builttaprootuserland.lock' to attempt to rebuild Termux PRoot with USERLAND support:  Continuing..."
else
if ! grep DUSERLAND GNUmakefile
then
sed -ir 's/^CPPFLAGS.*/CPPFLAGS += -DUSERLAND -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE -I. -I$(VPATH)/g' GNUmakefile
fi
_BKPPROOT_
if ! ./proot -V
then
printf "%s\\n" "Running 'make clean && make V=1' in directory $(pwd)..."
make clean && make V=1
make install
else
make install
fi
fi
}
_DOTAPROOTUSERLAND_() {
if [ ! -e "$HOME/termux/proot/src" ]
then
mkdir -p "$HOME/termux" && cd "$HOME/termux"
_GITCLONETERMUXPROOT_ || (_AU_ git && _GITCLONETERMUXPROOT_)
fi
printf "%s\\n" "'cd $HOME/termux/proot/src'..." && cd "$HOME/termux/proot/src"
_MAKEV1_ || ( _AU_ clang libtalloc make && _MAKEV1_ )
command -v "$HOME/termux/proot/src/proot" && touch "$HOME/termux/proot/src/builttaprootuserland.lock"
}
## begin ##
if [[ -z "${1:-}" ]]
then
_DOTAPROOTUSERLAND_
elif [[ "${1//-}" = [Rr][Ee][Vv]* ]]	##  [rev[ert] build from commit:
then
GITCLONETERMUXPROOTLCR="bc3668f3238cee2011f9afa5a964b2dfc9dc523b"
_DOTAPROOTUSERLAND_
elif [[ "${1//-}" = [Rr][Ee]* ]]	##  [re[vert] build from commit:
then
GITCLONETERMUXPROOTLCR="292fbc8a5406fdaf17b530444cd3dbaa92b1551d"
_DOTAPROOTUSERLAND_
elif [[ "${1//-}" = [Rr]* ]]	##  [r[evert] from backup file:
then
if [ -f "$HOME/termux/proot/tmp/proot.bkp" ]
then
cp "$HOME/termux/proot/tmp/proot.bkp" "$PREFIX/bin/proot" && printf "%s\\n" "Copied file '$HOME/termux/proot/tmp/proot.bkp' to '$PREFIX/bin/proot'."
fi
else
printf "%s\\n" "Please run '${0##*/}' with no options to apply the DUSERLAND patch and to build the latest version of Termux 'proot' on smartphone;  You can also use the '${0##*/} r[e[v[ertPRootVersion]]]' options for DUSERLAND patching and building Termux 'proot' to one of two previously published source code versions."
fi
# taprootuserland.bash EOF
