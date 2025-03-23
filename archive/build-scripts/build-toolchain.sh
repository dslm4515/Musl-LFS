#! /bin/bash

export MLFS=/mnt/mlfs
# Script requires the following layout:
# ${MLFS}/sources
#         +--files
#         +--packages
#         +--patches
#         +--scripts (contains auto-build scripts, including this script)

cd ${MLFS}/sources

export PRGRSS=/tmp
source scripts/toolchain.conf

read -p "Check build progress at ${PRGRSS}/tc.progess" && \

printf "01/33: Musl Libc ............." >> ${PRGRSS}/tc.progress && bash scripts/tc-musl.sh         && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "02/33: Adjust Cross toolchain." >> ${PRGRSS}/tc.progress && bash scripts/tc-Adjust_CT.sh    && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "03/33: Binutils..............." >> ${PRGRSS}/tc.progress && bash scripts/tc-binutils.sh     && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "04/33: GCC...................." >> ${PRGRSS}/tc.progress && bash scripts/tc-gcc.sh          && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "05/33: Kernel Headers........." >> ${PRGRSS}/tc.progress && bash scripts/tc-headers.sh      && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "06/33: Adjust Toolchain......." >> ${PRGRSS}/tc.progress && bash scripts/tc-Adjust_TC.sh    && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "07/33: Libstdc++ (GCC)........" >> ${PRGRSS}/tc.progress && bash scripts/tc-libstdcxx.sh    && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "08/33: TCL...................." >> ${PRGRSS}/tc.progress && bash scripts/tc-tcl.sh          && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "09/33: Expect................." >> ${PRGRSS}/tc.progress && bash scripts/tc-expect.sh       && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "10/33: DejaGnu................" >> ${PRGRSS}/tc.progress && bash scripts/tc-dejagnu.sh      && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "11/33: M4....................." >> ${PRGRSS}/tc.progress && bash scripts/tc-m4.sh           && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "12/33: Ncurses................" >> ${PRGRSS}/tc.progress && bash scripts/tc-ncurses.sh      && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "13/33: Bash..................." >> ${PRGRSS}/tc.progress && bash scripts/tc-bash.sh         && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "14/33: Bison.................." >> ${PRGRSS}/tc.progress && bash scripts/tc-bison.sh        && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "15/33: Bzip2.................." >> ${PRGRSS}/tc.progress && bash scripts/tc-bzip2.sh        && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "16/33: Coreutils.............." >> ${PRGRSS}/tc.progress && bash scripts/tc-coreutils.sh    && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "17/33: diffutils.............." >> ${PRGRSS}/tc.progress && bash scripts/tc-diffutils.sh    && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "18/33: file..................." >> ${PRGRSS}/tc.progress && bash scripts/tc-file.sh         && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "19/33: findutils.............." >> ${PRGRSS}/tc.progress && bash scripts/tc-findutils.sh    && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "20/33: Gawk..................." >> ${PRGRSS}/tc.progress && bash scripts/tc-gawk.sh         && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "21/33: Gettext-tiny..........." >> ${PRGRSS}/tc.progress && bash scripts/tc-gettext-tiny.sh && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "22/33: Grep..................." >> ${PRGRSS}/tc.progress && bash scripts/tc-grep.sh         && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "23/33: Gzip..................." >> ${PRGRSS}/tc.progress && bash scripts/tc-gzip.sh         && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "24/33: Make..................." >> ${PRGRSS}/tc.progress && bash scripts/tc-make.sh         && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "25/33: Patch.................." >> ${PRGRSS}/tc.progress && bash scripts/tc-patch.sh        && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "26/33: Perl..................." >> ${PRGRSS}/tc.progress && bash scripts/tc-perl.sh         && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "27/33: Sed...................." >> ${PRGRSS}/tc.progress && bash scripts/tc-sed.sh          && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "28/33: Tar...................." >> ${PRGRSS}/tc.progress && bash scripts/tc-tar.sh          && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "39/33: Texinfo................" >> ${PRGRSS}/tc.progress && bash scripts/tc-texinfo.sh      && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "30/33: Xz....................." >> ${PRGRSS}/tc.progress && bash scripts/tc-xz.sh           && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "31/33: flex..................." >> ${PRGRSS}/tc.progress && bash scripts/tc-flex.sh         && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "32/33: nano..................." >> ${PRGRSS}/tc.progress && bash scripts/tc-nano.sh         && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
printf "33/33: Vim...................." >> ${PRGRSS}/tc.progress && bash scripts/tc-vim.sh          && printf " [ DONE ]\n" >> ${PRGRSS}/tc.progress && \
echo   "Toolchain Complete!" >> ${PRGRSS}/tc.progress
