#!/bin/bash -ve

. settings.sh

pushd ${KERN_BUILD}/casacore-data
gbp import-orig --uscan --no-interactive
gbp dch -D ${KERN_DIST} --commit
gpb buildpackage --git-ignore-new --git-tag
git push --all --followtags
debuild -S -sa
dput ppa:kernsuite/kern-dev ../

