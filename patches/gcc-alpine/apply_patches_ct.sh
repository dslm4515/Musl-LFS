#! /bin/bash

for p in 0001-posix_memalign 0002-gcc-poison-system-directories \
  0003-Turn-on-Wl-z-relro-z-now-by-default \
  0004-Turn-on-D_FORTIFY_SOURCE-2-by-default-for-C-C-ObjC-O \
  0006-Enable-Wformat-and-Wformat-security-by-default \
  0007-Enable-Wtrampolines-by-default \
  0009-Ensure-that-msgfmt-doesn-t-encounter-problems-during \
  0010-Don-t-declare-asprintf-if-defined-as-a-macro \
  0011-libiberty-copy-PIC-objects-during-build-process \
  0012-libitm-disable-FORTIFY \
  0013-libgcc_s \
  0014-nopie \
  0015-libffi-use-__linux__-instead-of-__gnu_linux__-for-mu \
  0016-dlang-update-zlib-binding \
  0017-dlang-fix-fcntl-on-mips-add-libucontext-dep \
  0018-ada-fix-shared-linking \
  0019-build-fix-CXXFLAGS_FOR_BUILD-passing \
  0020-add-fortify-headers-paths \
  0023-Pure-64-bit-MIPS \
  0024-use-pure-64-bit-configuration-where-appropriate \
  0025-always-build-libgcc_eh.a \
  0027-ada-musl-support-fixes \
  0028-gcc-go-Use-_off_t-type-instead-of-_loff_t \
  0029-gcc-go-Don-t-include-sys-user.h \
  0030-gcc-go-Fix-ucontext_t-on-PPC64 \
  0031-gcc-go-Fix-handling-of-signal-34-on-musl \
  0032-gcc-go-Use-int64-type-as-offset-argument-for-mmap \
  0034-gcc-go-signal-34-is-special-on-musl-libc \
  0035-gcc-go-Prefer-_off_t-over-_off64_t \
  0036-gcc-go-undef-SETCONTEXT_CLOBBERS_TLS-in-proc.c \
  0037-gcc-go-link-to-libucontext \
  0038-gcc-go-Disable-printing-of-unaccessible-ppc64-struct \
  0041-Use-generic-errstr.go-implementation-on-musl \
  0042-Disable-ssp-on-nostdlib-nodefaultlibs-and-ffreestand \
  0043-configure-Add-enable-autolink-libatomic-use-in-LINK_ \
  0022-DP-Use-push-state-pop-state-for-gold-as-well-when-li
do
	patch -Np1 -i ../patches/gcc-alpine/$p.patch
done
