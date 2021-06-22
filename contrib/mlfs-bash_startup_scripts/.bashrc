if [ -f "/etc/bashrc" ] ; then
       source /etc/bashrc
fi

export LANG=en_US.utf8
#export SUDO_ASKPASS="/usr/libexec/openssh/ssh-askpass"


#export XORG_PREFIX="/usr"
#export XORG_CONFIG="--prefix=/usr --sysconfdir=/etc --localstatedir=/var --disable-static"
#export PATH=$PATH:/opt/xorg/bin
#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/xorg/lib/pkgconfig:/opt/xorg/share/pkgconfig
#export ACLOCAL="aclocal -I /opt/xorg/share/aclocal"
export ACLOCAL="aclocal -I /usr/share/aclocal"

#export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/qt5/lib/pkgconfig
#export PATH=$PATH:/opt/qt5/bin

export PS1_GIT="\\w:\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\n\$ "
