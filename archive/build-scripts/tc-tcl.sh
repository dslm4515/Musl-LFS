#! /bin/bash

tar xf ${SRC_PKGS}/tcl* &&
cd tcl* &&

export CC="${MLFS_TARGET}-gcc"             &&
export CXX="${MLFS_TARGET}-g++"            &&
export AR="${MLFS_TARGET}-ar"              &&
export AS="${MLFS_TARGET}-as"              &&
export RANLIB="${MLFS_TARGET}-ranlib"      &&
export LD="${MLFS_TARGET}-ld"              &&
export STRIP="${MLFS_TARGET}-strip"        &&

echo "Building TCL..." &&
cd unix                                    &&
ac_cv_func_strtod=yes \
tcl_cv_strtod_buggy=1 \
./configure --build=${MLFS_HOST} \
            --host=${MLFS_TARGET} \
            --prefix=/tools                &&
make ${MJ} && make install                 &&
chmod -v u+w /tools/lib/libtcl8.6.so       &&
make install-private-headers               &&
ln -sv tclsh8.6 /tools/bin/tclsh           &&

cd ${SRC_ROOT} && rm -rf tcl*
