#!/bin/bash -ve

. settings.sh

pushd ${BUILD}/casacore-data
gbp import-orig --uscan --no-interactive
gbp dch -D ${DIST}
git commit debian/changelog "new upstream release"
gpb buildpackage --git-ignore-new --git-tag
git push --all
git push --tags
debuild -S -sa
dput ppa:kernsuite/kern-dev ../

