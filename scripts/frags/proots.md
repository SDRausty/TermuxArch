archsystemconfigs.sh:		exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PATH=/bin:/usr/bin:/sbin:/usr/sbin $rootdir/root/bin/ce 

archsystemconfigs.sh:		exec proot --kill-on-exit --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" PATH=/bin:/usr/bin:/sbin:/usr/sbin /root/bin/ce 

necessaryfunctions.sh:		exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" $HOME$rootdir/root/bin/finishsetup.sh 

necessaryfunctions.sh:		exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r \$HOME$rootdir/ -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/"\${@:2}"

necessaryfunctions.sh:		exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r \$HOME$rootdir/ -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/bash -l

necessaryfunctions.sh:		exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r \$HOME$rootdir/ -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/bash -lc  "\${@:2}"

necessaryfunctions.sh:		exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r \$HOME$rootdir/ -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/su - \$2 -c "\${@:3}"

necessaryfunctions.sh:		exec proot --kill-on-exit --kernel-release=4.14.15 --link2symlink -0 -r \$HOME$rootdir/ -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/su - \${@:2}"

necessaryfunctions.sh:		exec proot --kill-on-exit --link2symlink -0 -r $HOME$rootdir/ -b /dev/ -b /sys/ -b /proc/ -b /storage/ -b $HOME -w $HOME /bin/env -i HOME=/root TERM="$TERM" $HOME$rootdir/root/bin/finishsetup.sh 

necessaryfunctions.sh:		exec proot --kill-on-exit --link2symlink -0 -r \$HOME$rootdir/ -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/"\${@:2}"

necessaryfunctions.sh:		exec proot --kill-on-exit --link2symlink -0 -r \$HOME$rootdir/ -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/bash -l

necessaryfunctions.sh:		exec proot --kill-on-exit --link2symlink -0 -r \$HOME$rootdir/ -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/bash -lc "\${@:2}"

necessaryfunctions.sh:		exec proot --kill-on-exit --link2symlink -0 -r \$HOME$rootdir/ -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/su - "\${@:2}"

necessaryfunctions.sh:		exec proot --kill-on-exit --link2symlink -0 -r \$HOME$rootdir/ -b /dev/ -b \$ANDROID_DATA -b \$EXTERNAL_STORAGE -b /proc/ -w "\$PWD" /bin/env -i HOME=/root TERM=\$TERM /bin/su - \$2 -c "\${@:3}"
