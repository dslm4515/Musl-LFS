#!/bin/bash
# Simple shell hack to download and MD5 check source tarballs.
# Copyright 2021: Luiz Antônio (takusuman).
# This particular script is dual-licensed between BSD 2-Clause
# or GPL3, at your preference.
# n() function taken from otto-pkg's posix-alt.shi lib.
# realpath() function taken from Pindorama/Copacabana version
# of this script.
# USAGE: ./download_sources.sh sources.list sources.md5

MD5CHECK=${MD5CHECK:-YES};
SRCDIR=${SRCDIR:-src}

# Workaround to the # macro in arrays
# which doesn't work properly in bash 4.3 for some reason.
n(){
	echo ${@} | tr " " "\n" | wc -l;
}

realpath(){
  file_basename=`basename $1`
  file_dirname=`dirname $1`
	# get the absolute directory name
	# example: ./sources.txt -> /usr/src/copacabana-repo/sources.txt
  echo "`cd "${file_dirname}"; pwd`/${file_basename}"
}


main(){
	sources_file="`realpath ${1}`"
	test -n "${2}" && md5sum_file="`realpath ${2}`"
	test ! -e "${SRCDIR}" && mkdir "${SRCDIR}";
	urls=( `cat ${sources_file} | tr "\n" " "` );
	n_urls=`n ${urls[*]}`;
	cd "${SRCDIR}";
	for (( i=0; i < ${n_urls}; i++ )){
		printf 'Downloading %s\n' "$(basename ${urls[${i}]})";
		curl -L "${urls[${i}]}" -O;
	}
	if `echo ${MD5CHECK} | grep -i '^y' &>/dev/null`; then
	  md5sum -c "${md5sum_file}" \
	  	&& cd "${OLDPWD}";
	fi
	return 0;
}

main "${1}" "${2}";
