#! /bin/bash

export SPECFILE=`dirname $(${MLFS_TARGET}-gcc -print-libgcc-file-name)`/specs &&
${MLFS_TARGET}-gcc -dumpspecs > specs                                         &&

case $(uname -m) in
  x86_64)  sed -i 's/\/lib\/ld-musl-x86_64.so.1/\/tools\/lib\/ld-musl-x86_64.so.1/g' specs
           # check with
           grep "/tools/lib/ld-musl-x86_64.so.1" specs  --color=auto
           ;;
  i686)    sed -i 's/\/lib\/ld-musl-i386.so.1/\/tools\/lib\/ld-musl-i386.so.1/g' specs
           # check with
           grep "/tools/lib/ld-musl-i386.so.1" specs  --color=auto
           ;;
  arm*)    sed -i 's/\/lib\/ld-musl-arm/\/tools\/lib\/ld-musl-arm/g' specs
           # check with
           grep "/tools/lib/ld-musl-arm" specs  --color=auto
           ;;
  aarch64) sed -i 's/\/lib\/ld-musl-aarch64/\/tools\/lib\/ld-musl-aarch64/g' specs
           # check with
           grep "/tools/lib/ld-musl-aarch64" specs  --color=auto
           ;;
esac &&
echo "Install modified specs to the cross toolchain" &&
mv -v specs ${SPECFILE}                              &&
unset SPECFILE                                       &&
echo 'int main(){}' > dummy.c                        &&
${MLFS_TARGET}-gcc dummy.c                           &&
${MLFS_TARGET}-readelf -l a.out | grep Requesting    &&
echo "The above should match one of the below:"      &&
echo "# [Requesting program interpreter: /tools/lib/ld-musl-x86_64.so.1]"    &&
echo "# [Requesting program interpreter: /tools/lib/ld-musl-i386.so.1]"      &&
echo "# [Requesting program interpreter: /tools/lib/ld-musl-arm.so.1]"       &&
echo "# [Requesting program interpreter: /tools/lib/ld-musl-aarch64.so.1]"   &&
read -p "Press [ENTER] to continue or [CTRL]+[C] to stop "                   &&
rm -rvf a.out dummy.c

