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

read -p "Check build progress at ${PRGSS}/tc.progess" &&

bash scripts/tc-musl.sh         && echo "01/36: Musl Libc"               >> ${PRGRSS}/tc.progress &&
bash scripts/tc-Adjust_CT.sh    && echo "02/36: Adjust Cross toolchain"  >> ${PRGRSS}/tc.progress &&
bash scripts/tc-binutils.sh     && echo "03/36: Binutils"                >> ${PRGRSS}/tc.progress &&
bash scripts/tc-gcc.sh          && echo "04/36: GCC"                     >> ${PRGRSS}/tc.progress &&
bash scripts/tc-headers.sh      && echo "05/36: Kernel Headers"          >> ${PRGRSS}/tc.progress &&
bash scripts/tc-Adjust_TC.sh    && echo "06/36: Adjust Toolchain"        >> ${PRGRSS}/tc.progress &&
bash scripts/tc-libstdcxx.sh    && echo "07/36: Libstdc++ (GCC)"         >> ${PRGRSS}/tc.progress &&
bash scripts/tc-tcl.sh          && echo "08/36: TCL"                     >> ${PRGRSS}/tc.progress &&
bash scripts/tc-expect.sh       && echo "09/36: Expect"                  >> ${PRGRSS}/tc.progress && 
bash scripts/tc-dejagnu.sh      && echo "10/36: DejaGnu"                 >> ${PRGRSS}/tc.progress &&
bash scripts/tc-m4.sh           && echo "11/36: M4"                      >> ${PRGRSS}/tc.progress &&
bash scripts/tc-ncurses.sh      && echo "12/36: Ncurses"                 >> ${PRGRSS}/tc.progress &&
bash scripts/tc-bash.sh         && echo "13/36: Bash"                    >> ${PRGRSS}/tc.progress &&
bash scripts/tc-bison.sh        && echo "14/36: Bison"                   >> ${PRGRSS}/tc.progress &&
bash scripts/tc-bzip2.sh        && echo "15/36: Bzip2"                   >> ${PRGRSS}/tc.progress &&
bash scripts/tc-coreutils.sh    && echo "16/36: Coreutils"               >> ${PRGRSS}/tc.progress &&
bash scripts/tc-diffutils.sh    && echo "17/36: diffutils"               >> ${PRGRSS}/tc.progress &&
bash scripts/tc-file.sh         && echo "18/36: file"                    >> ${PRGRSS}/tc.progress &&
bash scripts/tc-findutils.sh    && echo "19/36: findutils"               >> ${PRGRSS}/tc.progress &&
bash scripts/tc-gawk.sh         && echo "20/36: Gawk"                    >> ${PRGRSS}/tc.progress &&
bash scripts/tc-gettext-tiny.sh && echo "21/36: Gettext-tiny"            >> ${PRGRSS}/tc.progress &&
bash scripts/tc-grep.sh         && echo "22/36: Grep"                    >> ${PRGRSS}/tc.progress &&
bash scripts/tc-gzip.sh         && echo "23/36: Gzip"                    >> ${PRGRSS}/tc.progress &&
bash scripts/tc-make.sh         && echo "24/36: Make"                    >> ${PRGRSS}/tc.progress &&
bash scripts/tc-patch.sh        && echo "25/36: Patch"                   >> ${PRGRSS}/tc.progress &&
bash scripts/tc-perl.sh         && echo "26/36: Perl"                    >> ${PRGRSS}/tc.progress &&
bash scripts/tc-sed.sh          && echo "27/36: Sed"                     >> ${PRGRSS}/tc.progress &&
bash scripts/tc-tar.sh          && echo "28/36: Tar"                     >> ${PRGRSS}/tc.progress &&
bash scripts/tc-texinfo.sh      && echo "39/36: Texinfo"                 >> ${PRGRSS}/tc.progress &&
bash scripts/tc-xz.sh           && echo "30/36: Xz"                      >> ${PRGRSS}/tc.progress &&
bash scripts/tc-nano.sh         && echo "31/36: nano"                    >> ${PRGRSS}/tc.progress &&
echo "Toolchain Complete!"
