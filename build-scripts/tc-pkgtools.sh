#! /bin/bash

export PKGNAME="pkgtools"
cd ${SRC_PKGS}/${PKGNAME} &&
for prog in installpkg makepkg removepkg explodepkg \
            pkgdiff upgradepkg; do
	install -v -m755 $prog /tools/bin/
done &&

cd ${SRC_ROOT} 
