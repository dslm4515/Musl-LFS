# Musl-LFS
Linux From Scratch using Musl as Libc and S6+S6-rc as init system

This is based on the works of Linux From Scratch (http://www.linuxfromscratch.org), which use GLibc and SysVinit/systemD. Additional work was derived from Void Linux (https://voidlinux.org), Alpine Linux (https://alpinelinux.org), and Dragora Linux (https://dragora.org). For logging during development of tool chains, I used porg from http://porg.sourceforge.net/.

The aim of this project is to create a create a Linux system using Musl (www.musl-libc.org) instead of GNU's Glibc and S6 (https://skarnet.org/) instead SysVinit.

## Supported Architectures
<ul>
  <li>i686/i586 : Stable and tested. Stable enough to build Xorg, Qt5 (without QT-webengine), Rust, and Firefox.</li>
  <li>x86_64 : Stable and tested. Stable enough to build Xorg, Qt5, Rust, and Firefox.</li>
  <li>aarch64: Stable and tested. Stable enough to build Xorg, Qt5, Rust, and Firefox.</li>
  <li>armv7/armv6: Builds fine. Requires modification to suit target hardware.</li>
</ul>

## Goals:
<ul>
  <li> [x] Properly name patches to reflect origin (i.e. Alpine or void) </li>
  <li> [x] Create a list for wget to download sources.</li>
  <li> [x] Create md5s list for sources</li>
  <li> [ ] Update s6-rc & s6 to lastest version </li>
  <li> [x] Redesign tool chain build to avoid two build passes of binutils and GCC</li>
  <li> [ ] Generate HTML 'book' like LFS</li>
  <li> [x] Add utmp/utmpx implementation</li>
  <li> [x] Transition from pkgconfig to pkgconf</li>
  <li> [x] Transition from gettext to gettext-tiny?</li>
  <li> [ ] POSIX compatibility </li>
</ul>

## Tested Builds

| Host         | Target      | Build Status   |
| ------------ | ----------- | -------------- | 
| i686-musl    | i686-musl   | Pass |
| i686-glibc   | i686-musl   | Pending |
| x86_64-musl  | x86_64-musl | Pending |
| x86_64-glibc | x86_64-musl | Pending |
| aarch64-glibc | aarch64-musl | Pending |
| armv7l-glibc | armv7l-musl | Pending |
| armv7l-musl  | armv7l-musl | Pending |
| armv6-glibc  | armv6-musl  | Pending |
| armv6-musl   | armv6-musl  | Pending |

*ARM builds will need some modification based on specific hardware*

## Additional Required Packages 

If pursuing BLFS, some packages will fail to compile due certian implementions left out in the Musl C Library.

<ul>
<li>Musl C Library
https://www.musl-libc.org/</li>

<li>Musl-FTS 
https://github.com/pullmoll/musl-fts</li>

<li>Musl-Obstack
https://github.com/pullmoll/musl-obstack</li>

<li>Musl-RPmatch
https://github.com/pullmoll/musl-rpmatch</li>

<li>Musl-Legacy-Compatibility Headers
https://github.com/void-linux/void-packages/blob/master/srcpkgs/musl-legacy-compat </li>

<li>utmps - An implementation of the utmpx.h family of functions performing user accounting on Unix systems.
https://skarnet.org/software/utmps</li>

<li>pkgconf - A newer, actively maintained implementation of pkg-config
http://pkgconf.org/</li>

<li>Argp-Standalone - Required by elfutils for libelf
https://github.com/jahrome/argp-standalone</li>

</ul>

## Optional Packages:
<ul>
<li>LibreSSL (instead of OpenSSL)
https://www.libressl.org/</li>
<li>GNU Nano (Text Editor)
https://www.nano-editor.org/ </li>
</ul>

## Projects of Interest

<ul>
<li>gCompat - "The gcompat project provides a glibc-compatible runtime environment for distributions that use musl libc."
https://code.foxkit.us/adelie/gcompat</li>
<li> Locales - "Locale program for musl libc"
https://github.com/rilian-la-te/musl-locales </li>
<li>Mussel - "...the shortest and fastest script available today to build working cross compilers that target musl libc."
https://github.com/firasuke/mussel </li>
<li>shimmy - POSIX:registered: compatibility shims for Linux (and other environments)
https://code.foxkit.us/adelie/shimmy</li>
<li>gettext-tiny - It provides lightweight replacements for tools typically used from the GNU gettext suite.
https://github.com/AdelieLinux/gettext-tiny</li>
</ul>

## Layout

<ul>
  <li>build-scripts - [WIP] Build scripts to use to semi-automate building /cross-tools, /tools, and the final system</li>
  <li>contrib - Additional sources that are hard to find or re-packed
  <li>doc - Build instructions to build a LFS installation that uses Musl instead of Glibc and S6 instead of SysVint.</li>
  <li>extra - Helpful scripts to mount, chroot, and umount a MLFS build.</li>
  <li>files - Files that will be needed during the build</li>
  <li>patches - All patches used to patch sources to work/recognize Musl C Library</li>
  <li>sources.list - List of sources to download
</ul>

## Changelog (8.00)
<ul>
 <li>Reorganized documentation for easier maintainence</li>
 <li>Added skarnet's utmps for utmp/utmpx implementation</li>
 <li>Updated Time Zone data and utilities per Adelie Linux's method</li> 
 <li>Added security patches for binutils from Adelie Linux</li>
 <li>Added utmpx support in Shadow</li>
 <li>Added utmpx support in procps-ng</li>
 <li>Added utmpx support in util-linux</li>
 <li>Added utmpx support in coreutils</li>
 <li>Replaced pkgconfig with pkgconf</li>
 <li>Replaced gettext with gettext-tiny</li>
 <li>Upgraded to Binutils 2.35.1</li>
 <li>Upgraded to mpc 1.2.0</li>
 <li>Upgraded to libcap 2.44</li>
 <li>Upgraded to iana-etc 20201012 </li>
 <li>Upgraded to bison 3.7.3</li>
 <li>Upgraded to grep 3.5</li>
 <li>Upgraded to expat 2.2.10</li>
 <li>Upgraded to libelf(from elfutits) 0.181</li>
 <li>Upgraded to Python 3.9.0</li>
 <li>Upgraded to Ninja 1.10.1</li>
 <li>Upgraded to Meson 0.55.3</li>
 <li>Upgraded to IProute2 5.9.0</li>
 <li>Upgraded to Vim 8.2.1845</li>
 <li>Upgraded to execline 2.6.1.1</li>
</ul>

## Changelog (7.00)

<ul>
 <li>Upgraded to GCC-10.2.0 and several other packages</li>
 <li>Added musl-rpmatch to build</li>
 <li>Add zstd to build</li>
 <li>Changed tool chain build flow to build binutils and GCC once</li>
 <li>Added nano text editor for tool chain - Helps with troubleshooting</li>
 <li>Updated patches and files directory scheme to reflect origins</li>
 <li>Removed porg. Recommend use of Slackware's pkgtools</li>
</ul>
