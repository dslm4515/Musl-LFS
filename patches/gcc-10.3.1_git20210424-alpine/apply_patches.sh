#! /bin/bash

for p in 0001-posix_memalign.patch \
	 0002-gcc-poison-system-directories.patch \
	 0003-Turn-on-Wl-z-relro-z-now-by-default.patch \
	 0004-Turn-on-D_FORTIFY_SOURCE-2-by-default-for-C-C-ObjC-O.patch \
	 0005-On-linux-targets-pass-as-needed-by-default-to-the-li.patch \
	 0006-Enable-Wformat-and-Wformat-security-by-default.patch \
        0007-Enable-Wtrampolines-by-default.patch \
        0008-Disable-ssp-on-nostdlib-nodefaultlibs-and-ffreestand.patch \
        0009-Ensure-that-msgfmt-doesn-t-encounter-problems-during.patch \
        0010-Don-t-declare-asprintf-if-defined-as-a-macro.patch \
        0011-libiberty-copy-PIC-objects-during-build-process.patch \
        0012-libitm-disable-FORTIFY.patch \
        0013-libgcc_s.patch \
        0014-nopie.patch \
        0015-libffi-use-__linux__-instead-of-__gnu_linux__-for-mu.patch \
        0016-dlang-update-zlib-binding.patch \
        0017-dlang-fix-fcntl-on-mips-add-libucontext-dep.patch \
        0018-ada-fix-shared-linking.patch \
        0019-build-fix-CXXFLAGS_FOR_BUILD-passing.patch \
        0020-add-fortify-headers-paths.patch \
        0021-Alpine-musl-package-provides-libssp_nonshared.a.-We-.patch \
        0022-DP-Use-push-state-pop-state-for-gold-as-well-when-li.patch \
        0023-Pure-64-bit-MIPS.patch \
        0024-use-pure-64-bit-configuration-where-appropriate.patch \
        0025-always-build-libgcc_eh.a.patch \
        0026-ada-libgnarl-compatibility-for-musl.patch \
        0027-ada-musl-support-fixes.patch \
        0028-gcc-go-Use-_off_t-type-instead-of-_loff_t.patch \
        0029-gcc-go-Don-t-include-sys-user.h.patch \
        0030-gcc-go-Fix-ucontext_t-on-PPC64.patch \
        0031-gcc-go-Fix-handling-of-signal-34-on-musl.patch \
        0032-gcc-go-Use-int64-type-as-offset-argument-for-mmap.patch \
        0033-gcc-go-Fix-st_-a-m-c-tim-fields-in-generated-sysinfo.patch \
        0034-gcc-go-signal-34-is-special-on-musl-libc.patch \
        0035-gcc-go-Prefer-_off_t-over-_off64_t.patch \
        0036-gcc-go-undef-SETCONTEXT_CLOBBERS_TLS-in-proc.c.patch \
        0037-gcc-go-link-to-libucontext.patch \
        0038-gcc-go-Disable-printing-of-unaccessible-ppc64-struct.patch \
        0039-CRuntime_Musl-Support-v1.2.0-for-32-bits.patch \
        0040-configure-Add-enable-autolink-libatomic-use-in-LINK_.patch \
        0041-Use-generic-errstr.go-implementation-on-musl.patch 
do
	patch -Np1 -i ../patches/gcc-10.3.1_git20210424-alpine/$p
done
