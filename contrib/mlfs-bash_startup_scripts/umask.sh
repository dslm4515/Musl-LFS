if [ "$(id -gn)" = "$(id -un)" -a $EUID -gt 99 ] ; then
	umask 002
else
	umask 022
fi
