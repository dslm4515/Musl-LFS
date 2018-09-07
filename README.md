# Musl-LFS
Linux From Scratch using Musl as Libc and Runit as init system

This is based on the works of Linux From Scratch (http://www.linuxfromscratch.org), which use GLibc and SysVinit/systemD. Additional work was derived from Void Linux (https://voidlinux.org), Alpine Linux (https://alpinelinux.org), and Dragora Linux (https://dragora.org). Runit scripts were used from (https://github.com/inthecloud247/runit-for-lfs). For logging, I used porg from http://porg.sourceforge.net/.

The aim of this project is to create a create a Linux system using Musl (www.musl-libc.org) instead of GNU's Glibc and Runit (http://smarden.org/runit/) instead SysVinit.

Goals:
<ul>
<li> [x] ~~Use the chroot method used in the Linux From Scratch (LFS) book. So far version 1.00 has 77% of packages are cross-compiled~~ ~~with 23% under a chroot'ed environment.~~ Version 2.xx now compiles all packages under chroot by cross-compiling the toolchain. </li>
<li> [ ] Currently, I only have computers with 32 and 64 bit x86 CPUs (i.e. Intel Core Duo). In the future, I would like this project to expand to the ARM architecture </li>
<li> [ ] ~~First build had Stack Smashing Protection (SSP) defaulted to High, which made the build process harder. In the future, I would~~ ~~like to enable SSP again.~~ Stack Smashing Protection (SSP) will be enabled since using a patch from Void Linux should solve the previous issues of packages failing to compile when SSP is enabled by default.
</ul>

Once the build is refined, I will convert project to a series of text files and a HTML "book". Text files are great when working on a host that does not have a GUI (i.e. Xorg) but has GPM installed (to easily copy and past commands).
