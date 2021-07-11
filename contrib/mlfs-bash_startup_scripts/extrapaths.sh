
if [ -d /usr/local/lib/pkgconfig ] ; then
         export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
fi

if [ -d /usr/local/bin ] ; then
        export PATH=/usr/local/bin:$PATH
fi

if [ -d /usr/local/sbin -a $EUID -eq 0 ] ; then
        export PATH=/usr/local/sbin:$PATH
fi

export MANPATH=/usr/share/man
export INFOPATH=/usr/share/info
