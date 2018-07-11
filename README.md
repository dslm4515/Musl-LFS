# Musl-LFS
Linux From Scratch using Musl as Libc and Runit as init system

This is based on the works of Linux From Scratch (http://www.linuxfromscratch.org), which use GLibc and SysVinit/systemD. Additional work was derived from Void Linux (https://voidlinux.org), Alpine Linux (https://alpinelinux.org), and Dragora Linux (https://dragora.org)

The aim of this project is to create a create a Linux system using Musl (www.musl-libc.org) instead of GNU's Glibc and Runit (http://smarden.org/runit/) instead SysVinit.

Goals:
<ul>
<li>(1) Use the chroot method used in the Linux From Scratch (LFS) book. So far version 1.00 has 77% of packages are cross-compiled with 23% under a chroot'ed environment. </li>
<li>(2) Currently, I only have computers with 32 and 64 bit x86 CPUs (i.e. Intel Core Duo). In the future, I would like this project to expand to the ARM architecture </li>
<li>(3) First build had Stack Smashing Protection (SSP) defaulted to High, which made the build process harder. In the future, I would like to enable SSP again.
</ul>
