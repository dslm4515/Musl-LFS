#! /bin/bash
# Tool Chain: Kernel Headers
# Build and install as mlfs

make mrproper -j4 &&

MLFS_ARCH=x86 make INSTALL_HDR_PATH=dest headers_install &&
find dest/include \( -name .install -o -name ..install.cmd \) -delete &&

cp -rv dest/include/* /tools/include
