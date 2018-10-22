# Musl-LFS
Linux From Scratch using Musl as Libc and Runit as init system

This is based on the works of Linux From Scratch (http://www.linuxfromscratch.org), which use GLibc and SysVinit/systemD. Additional work was derived from Void Linux (https://voidlinux.org), Alpine Linux (https://alpinelinux.org), and Dragora Linux (https://dragora.org). Runit scripts were used from (https://github.com/inthecloud247/runit-for-lfs). For logging, I used porg from http://porg.sourceforge.net/.

The aim of this project is to create a create a Linux system using Musl (www.musl-libc.org) instead of GNU's Glibc and Runit (http://smarden.org/runit/) instead SysVinit.

Goals:
<ul>
<li> [x] Version 2.xx now compiles all packages under chroot by cross-compiling the toolchain. </li>
<li> [ ] Currently, I only have computers with 32 and 64 bit x86 CPUs (i.e. Intel Core Duo). In the future, I would like this project to expand to the ARM architecture </li>
<li> [x] Stack Smashing Protection (SSP) will be enabled since using a patch from Void Linux should solve the previous issues of packages failing to compile when SSP is enabled by default.
<li> [ ] Properly name patches to reflect origin (i.e. Alpine or void) </li>
<li> [ ] Transition from Runit to S6 </li>
</ul>

Supported Architectures
<ul>
<li>32bit - i686/i586 : Stable and tested. Stable enough to build Xorg, Qt5 (without QT-webengine), and Midori.</li>
<li>64bit - x86_64 : Stable and tested. Stable enough to build Xorg, Qt5, Rust, and Firefox.
</ul>

Additional Required Packages 

Intial issue with just following the LFS book verbatium is that pkg-config and libelf, will not compile. Additionally, if pursuing BLFS, some packages will fail to compile due certian implementions left out in the Musl C Library.

<ul>
<li>Musl C Library
https://www.musl-libc.org/</li>

<li>Musl-FTS 
https://github.com/pullmoll/musl-fts</li>

<li>Musl-Obstack
https://github.com/pullmoll/musl-obstack</li>

<li>Musl-Legacy-Compatibility Headers
https://github.com/void-linux/void-packages/blob/master/srcpkgs/musl-legacy-compat </li>

<li>Argp-Standalone
https://github.com/jahrome/argp-standalone</li>
</ul>

Optional Packages:

LibreSSL (instead of OpenSSL)
https://www.libressl.org/

Porg
http://porg.sourceforge.net/

Projects of Interest

<ul>
<li>gCompat - "The gcompat project provides a glibc-compatible runtime environment for distributions that use musl libc."
https://code.foxkit.us/adelie/gcompat</li>
</ul>

Layout

<ul>
<li>build-scripts - Build scripts to use when building the final system with the toolchain (/tools) that was cross-compiled with the small cross-toolchain (/cross-tools)</li>
<li>extra - Scripts to mount, chroot, and umount a MLFS build. Also includes some build instructions for some BLFS packages... mostly to get Xorg setup.</li>
<li>files - Files that will be needed during the build</li>
<li>patches - All patches used to patch sources to work/recognize Musl C Library</li>
<li>plain-text - Build instructions to build a LFS installation that uses Musl instead of Glibc and Runit instead of SysVint. Instructions differ slightly for i686 and x86_64.</li>
</ul>
