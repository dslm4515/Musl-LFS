#!/bin/bash
# Simple shell hack to download and MD5 check source tarballs.
# Copyright 2021: Luiz Antônio (takusuman).
# This particular script is dual-licensed between BSD 2-Clause
# and GPL3, at your preference.
# n() function taken from otto-pkg's posix-alt.shi lib.

# USAGE: ./download_sources.sh sources.list sources.md5

MD5CHECK=${MD5CHECK:-YES};

# Workaround to the # macro in arrays
# which doesn't work properly in bash 4.3 for some reason.
n(){
	echo ${@} | tr " " "\n" | wc -l;
}

main(){
	PARENTDIR=${PWD};
	test ! -e src && mkdir src;
	urls=( `cat ${1} | tr "\n" " "` );
	n_urls=`n ${urls[*]}`;
	cd src;
	for (( i=0; i < ${n_urls}; i++ )){
		printf '%s\n' "Downloading $(basename ${urls[${i}]})";
		curl -L ${urls[${i}]} -O;
	}
	[ ${MD5CHECK} == 'YES' ] &&
	md5sum -c ${2};
	cd ${PARENTDIR};
	return 0;
}

main "${1}" "${2}";
