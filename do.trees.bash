#!/bin/env bash
# Copyright 2019 (c) all rights reserved
# by S D Rausty https://sdrausty.github.io
# Checks sha512sum file: sha512sum -c ztree.sha512.sum
# Creates ztree.*.sum files and commits: ./do.trees.bash
#####################################################################
set -eu
rm -f *.sum
FILELIST=( $(find . -type f | grep -v .git | sort) )
CHECKLIST=(md5sum sha1sum sha224sum sha256sum sha384sum sha512sum)
for SCHECK in ${CHECKLIST[@]}
do
	for FILE in "${FILELIST[@]}"
	do
 		printf "%s\\n" "Creating $SCHECK for $FILE..."
		$SCHECK "$FILE" >> ztree.${SCHECK::-3}.sum
	done
done
for SCHECK in  ${CHECKLIST[@]}
do
	printf  "\\n%s\\n" "Checking $SCHECK..."
	$SCHECK -c ztree.${SCHECK::-3}.sum
done
git add .
git commit
git push
# do.trees.sh EOF
