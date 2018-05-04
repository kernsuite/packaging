#!/bin/bash -ve

for i in `ls -d build/*/`; do
    PACKAGE=`grep Package ${i}debian/control | head -n 1`
    HOMEPAGE=`grep Homepage ${i}debian/control | head -n 1`
    DESCRIPTION=`grep Description ${i}debian/control | head -n 1`
    VERSION=`head -1 ${i}debian/changelog | egrep -o "\(.*\)"`
    echo "${PACKAGE:9}|||${HOMEPAGE:10}|||${DESCRIPTION:13}|||${VERSION:1:-1}"
done
