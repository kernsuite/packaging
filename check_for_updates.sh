#!/bin/bash -ve

KERN_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${KERN_ROOT}/settings.sh

pushd build

rm -f ${KERN_ROOT}/uscan_log

for i in $KERN_PACKAGES; do
	if [ ! -d "$i" ]; then
		git clone ${KERN_BASE}$i
	fi

    pushd $i
    git checkout upstream
    git checkout master
    uscan --dehs 1>> ${KERN_ROOT}/uscan_log || true
    #gbp import-orig --uscan
    #gbp dch -D bionic --commit
    #gbp buildpackage --git-tag
    popd
done
