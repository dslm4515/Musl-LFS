#! /bin/bash
# Tool Chain: Musl
# Build and install as mlfs

./configure \
  CROSS_COMPILE=${MLFS_TARGET}- \
  --prefix=/ \
  --target=${MLFS_TARGET} 
make -j2 && make DESTDIR=/tools install &&

# Make sure symlink is valid:
# /tools/lib/ld-musl-$ARCH.so.1 to /tools/lib/libc.so

case $(uname -m) in
	  x86_64)  rm -v  /tools/lib/ld-musl-x86_64.so.1
		   ln -sv libc.so /tools/lib/ld-musl-x86_64.so.1
	           ;;
	  i686)    rm -v  /tools/lib/ld-musl-i686.so.1
		   ln -sv libc.so /tools/lib/ld-musl-i686.so.1
                ;;
esac

