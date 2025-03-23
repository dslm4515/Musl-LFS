#! /bin/bash

# Auto-build Cross-toolchain for MLFS-9.00
# Please check Build Config section before running script

#### Build Config
export MLFS_HOST="$(echo $MACHTYPE | \
	    sed "s/$(echo $MACHTYPE | cut -d- -f2)/cross/")"
export MLFS_TARGET="armv7l-mlfs-linux-musleabihf"
export   MLFS_ARCH="arm"
export    MLFS_CPU="armv7-a+neon-vfpv4"
export  BUILD_ROOT="/mnt/mlfs"
export    SRC_ROOT=${BUILD_ROOT}/sources
export    SRC_PKGS=${SRC_ROOT}/packages
export SRC_PATCHES=${SRC_ROOT}/patches
export   SRC_FILES=${SRC_ROOT}/files
export          MJ="-j8"
export      PRGRSS=/tmp
export       CSPEC="--with-tune=cortex-a15.cortex-a7 \
		    --with-float=hard \
		    --with-abi=aapcs-linux \
		    --with-mode=thumb "

#### Build environment check
# WIP
# Check source packages are present
# Check source patches are present
# Check host for required packages installed
# Check if /cross-tools is present
# Check if executed as Non-root user

export MLFS=${BUILD_ROOT}
# Script requires the following layout:
# ${MLFS}/sources
#         +--files
#         +--packages
#         +--patches
#         +--scripts (contains auto-build scripts, including this scripts

read -p "Check build progress at $PRGRSS/ct.progess" &&

#### Build kernel headers
export PKG_NAME="linux"                                    &&
export PKG_PATH=${SRC_PKGS}/${PKG_NAME}*                   &&
export PKG_DIR=$(echo ${SRC_ROOT}/${PKG_NAME}* )           &&
echo "Building kernel headers..." >> ${PRGRSS}/ct.progress &&
tar xf ${PKG_PATH}                                         &&
cd ${PKG_DIR}                                              &&
make mrproper ${MJ}                                        &&
make ARCH=${MLFS_ARCH} headers_check ${MJ}                 &&
mkdir -pv /cross-tools/${MLFS_TARGET}/include              &&
cp -rv usr/include/* /cross-tools/${MLFS_TARGET}/include   &&
rm -v /cross-tools/${MLFS_TARGET}/include/Makefile         &&
cd ${SRC_ROOT}                                             &&

#### Build Binutils
export PKG_NAME="binutils"                                 &&
export PKG_PATH=${SRC_PKGS}/${PKG_NAME}*                   &&
export PKG_DIR=$(echo ${SRC_ROOT}/${PKG_NAME}* )           &&
echo "Building binutils..."       >> ${PRGRSS}/ct.progress &&
tar xf ${PKG_PATH} && cd ${PKG_DIR}                        &&
mkdir -v build && cd build                                 &&
../configure \
   --prefix=/cross-tools \
   --target=${MLFS_TARGET} \
   --with-sysroot=/cross-tools/${MLFS_TARGET} \
   --disable-nls \
   --disable-multilib \
   --disable-werror \
   --enable-deterministic-archives \
   --disable-compressed-debug-sections                    &&
make configure-host ${MJ}                                 &&
make ${MJ} && make install                                &&
cd ${SRC_ROOT}                                            &&
rm -rvf ${PKG_DIR}                                        &&

#### Build GCC
export PKG_NAME="gcc"                                     &&
export PKG_PATH=${SRC_PKGS}/${PKG_NAME}*                  &&
export PKG_DIR=$(echo ${SRC_ROOT}/${PKG_NAME}* )          &&
echo "Building GCC Static..."    >> ${PRGRSS}/ct.progress &&
tar xf ${PKG_PATH}  && cd ${PKG_DIR}                      &&
tar xf ${SRC_PKGS}/mpfr*                                  &&
tar xf ${SRC_PKGS}/gmp*                                   &&
tar xf ${SRC_PKGS}/mpc*                                   &&
mv -v mpfr* mpfr                                          &&
mv -v gmp* gmp                                            &&
mv -v mpc* mpc                                            &&
mkdir -v build && cd  build                               &&
CFLAGS='-g0 -O0' \
CXXFLAGS='-g0 -O0' \
../configure \
          --prefix=/cross-tools --build=${MLFS_HOST} \
          --host=${MLFS_HOST}   --target=${MLFS_TARGET} \
          --with-sysroot=/cross-tools/${MLFS_TARGET} \
          --disable-nls         --with-newlib  \
          --disable-libitm     --disable-libvtv \
          --disable-libssp     --disable-shared \
          --disable-libgomp    --without-headers \
          --disable-threads    --disable-multilib \
          --disable-libatomic  --disable-libstdcxx \
          --enable-languages=c --disable-libquadmath \
          --disable-libsanitizer --with-arch=${MLFS_CPU} \
          --disable-decimal-float --enable-clocale=generic ${CSPEC} &&
make all-gcc all-target-libgcc ${MJ}                       &&
make install-gcc install-target-libgcc                     &&
cd ${SRC_ROOT} && rm -rf gcc*                              &&

#### Build Musl Libc
export PKG_NAME="musl-1"                                  &&
export PKG_PATH=${SRC_PKGS}/${PKG_NAME}*                  &&
export PKG_DIR=$(echo ${SRC_ROOT}/${PKG_NAME}* )          &&
echo "Building Musl Libc..."    >> ${PRGRSS}/ct.progress  &&
tar xf ${PKG_PATH} && cd ${PKG_DIR}                       &&
./configure \
  CROSS_COMPILE=${MLFS_TARGET}- \
    --prefix=/ \
    --target=${MLFS_TARGET}                               &&
make ${MJ} && DESTDIR=/cross-tools make install           &&
mkdir -pv /cross-tools/usr                                &&
ln -sv ../include  /cross-tools/usr/include               &&
case $(uname -m) in
  x86_64) export ARCH="x86_64"  ;;
  i686)   export ARCH="i386"    ;;
  arm*)   export ARCH="arm"  ARCH2="armhf"   ;;
 aarch64) export ARCH="aarch64" ;;
esac                                                      &&
rm -vf /cross-tools/lib/ld-musl* &&
ln -sv libc.so /cross-tools/lib/ld-musl-${ARCH}.so.1 &&
ln -sv ../lib/libc.so \
         /cross-tools/bin/ldd                             &&
mkdir -v /cross-tools/etc                                 &&
printf "/cross-tools/lib \n"  >> /cross-tools/etc/ld-musl-$ARCH.path &&
printf "/tools/lib \n"        >> /cross-tools/etc/ld-musl-$ARCH.path &&
case $(uname -m) in
	arm*) ln -sv libc.so /cross-tools/lib/ld-musl-${ARCH2}.so.1
	      cp -v /cross-tools/etc/ld-musl-$ARCH.path \
		      /cross-tools/etc/ld-musl-$ARCH2.path ;;
esac &&

unset ARCH ARCH2                                          &&
cd ${SRC_ROOT} && rm -rf musl-1*                          &&

#### Build GCC Final
export PKG_NAME="gcc"                                     &&
export PKG_PATH=${SRC_PKGS}/${PKG_NAME}*                  &&
export PKG_DIR=$(echo ${SRC_ROOT}/${PKG_NAME}* )          &&
echo "Building GCC Final... "    >> ${PRGRSS}/ct.progress &&
tar xf ${PKG_PATH}  && cd ${PKG_DIR}                      &&
tar xf ${SRC_PKGS}/mpfr*                                  &&
tar xf ${SRC_PKGS}/gmp*                                   &&
tar xf ${SRC_PKGS}/mpc*                                   &&
mv -v mpfr* mpfr                                          &&
mv -v gmp* gmp                                            &&
mv -v mpc* mpc                                            &&
bash ../patches/gcc-10.3.1_git20210424-alpine/apply_patches_ct.sh && \
case $(uname -m) in
  x86_64) sed -e '/m64=/s/lib64/lib/' \
              -i.orig gcc/config/i386/t-linux64 ;;
esac && mkdir -pv  build && cd build                                           &&
AR=ar LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
../configure \
    --prefix=/cross-tools \
    --build=${MLFS_HOST} \
    --host=${MLFS_HOST} \
    --target=${MLFS_TARGET} \
    --disable-multilib \
    --with-sysroot=/cross-tools \
    --disable-nls \
    --enable-shared \
    --enable-languages=c,c++ \
    --enable-threads=posix \
    --enable-clocale=generic \
    --enable-libstdcxx-time \
    --enable-fully-dynamic-string \
    --disable-symvers \
    --disable-libsanitizer \
    --disable-lto-plugin \
    --disable-libssp  \
    --with-arch=${MLFS_CPU} ${CSPEC}    &&
make AS_FOR_TARGET="${MLFS_TARGET}-as" \
    LD_FOR_TARGET="${MLFS_TARGET}-ld" ${MJ}                                  &&
make install                                                                 &&
cd ${SRC_ROOT} && rm -rf gcc*  

#### Build File
export PKG_NAME="file-5"                                                     &&
export PKG_PATH=${SRC_PKGS}/${PKG_NAME}*                                     &&
export PKG_DIR=$(echo ${SRC_ROOT}/${PKG_NAME}* )                             &&
echo "Building File... "                            >> ${PRGRSS}/ct.progress &&
tar xf ${PKG_PATH} && cd ${PKG_DIR}                                          &&
./configure --prefix=/cross-tools --disable-libseccomp                       &&
make ${MJ} && make install                                                   &&
rm -rf file-*                                                                &&
echo "Cross Toolchain complete!"

