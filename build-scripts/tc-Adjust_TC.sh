#! /bin/bash

echo "Dump gcc specs..." &&
SPECFILE=`dirname $(${MLFS_TARGET}-gcc -print-libgcc-file-name)`/specs &&
${MLFS_TARGET}-gcc -dumpspecs > tempspecfile                           &&
echo "Modify dumped tempspecfile file for every instance of:"          &&
echo "/lib/ld-musl-$ARCH.so.1 to /tools/lib/ld-musl-$ARCH.so.1"        &&
case ${MLFS_ARCH} in
   i686)   # for i386
           sed -i 's/\/lib\/ld-musl-i386.so.1/\/tools\/lib\/ld-musl-i386.so.1/g' tempspecfile
           # check with sed
           grep "/tools/lib/ld-musl-i386.so.1" tempspecfile  --color=auto
           ;;
   x86_64) # for x86_64
           sed -i 's/\/lib\/ld-musl-x86_64.so.1/\/tools\/lib\/ld-musl-x86_64.so.1/g' tempspecfile
           # check with
           grep "/tools/lib/ld-musl-x86_64.so.1" tempspecfile --color=auto
           ;;
   arm*)   # for arm
           sed -i 's/\/lib\/ld-musl-arm/\/tools\/lib\/ld-musl-arm/g' tempspecfile
           # check with
           grep "/tools/lib/ld-musl-arm" tempspecfile --color=auto
           ;;
  aarch64) # for 64-bit arm64
           sed -i 's/\/lib\/ld-musl-aarch64/\/tools\/lib\/ld-musl-aarch64/g' tempspecfile
           # check with
           grep "/tools/lib/ld-musl-aarch64" tempspecfile --color=auto
           ;;
esac &&

echo "Install modified specs to the toolchain" &&
mv -vf tempspecfile $SPECFILE                  &&
unset SPECFILE                                 &&
GCC_INCLUDEDIR=`dirname $(${MLFS_TARGET}-gcc -print-libgcc-file-name)`/include &&
find ${GCC_INCLUDEDIR}/* -maxdepth 0 -xtype d -exec rm -rvf '{}' \;            &&
rm -vf `grep -l "DO NOT EDIT THIS FILE" ${GCC_INCLUDEDIR}/*`                   &&
unset GCC_INCLUDEDIR                                                           &&

echo "Testing toolchain..."                                       &&

echo 'int main(){}' > dummy.c                                     &&
${MLFS_TARGET}-gcc -B/tools/lib dummy.c                           &&
readelf -l a.out | grep ': /tools' >> ${PRGRSS}/tc.progress                               &&
#echo "The above should match one of the below:"                              &&
#echo "# [Requesting program interpreter: /tools/lib/ld-musl-x86_64.so.1]"    &&
#echo "# [Requesting program interpreter: /tools/lib/ld-musl-i386.so.1]"      &&
#echo "# [Requesting program interpreter: /tools/lib/ld-musl-arm.so.1]"       &&
#echo "# [Requesting program interpreter: /tools/lib/ld-musl-aarch64.so.1]"   &&
#read -p "Press [ENTER] to continue or [CTRL]+[C] to stop "                   &&
rm -rvf a.out dummy.c

