#!/data/data/com.termux/files/usr/bin/sh
unset LD_LIBRARY_PATH LD_PRELOAD
PATH=/system/bin

if [ $# != 0 ]; then
	echo $#
	echo 'usage: termux-wake-lock'
	echo 'Acquire the Termux wake lock to prevent the CPU from sleeping.'
	exit 1
fi

exec /system/bin/am startservice \
	--user 0 \
	-a com.termux.service_wake_lock \
	com.termux/com.termux.app.TermuxService \
	> /dev/null
