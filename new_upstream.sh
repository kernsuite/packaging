#!/bin/bash -ve

# Will update the package repository on new upstream release.
# Will only work if the build dependenices and scripts don't require a change
# Run from the debian package source folder.
# package dependencies: git-buildpackage and devscripts.

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source ${KERN_ROOT}/settings.sh

dh_clean
git pull
git checkout upstream
git checkout master
git clean -f -d
gbp import-orig --uscan
gbp dch -D ${KERN_DIST} --commit
BUILDER=pbuilder gbp buildpackage \
    --git-pbuilder \
    --git-pbuilder-options="--configfile ${KERN_ROOT}/pbuilderrc --buildresult ${KERN_ROOT}/repo" \
    --git-tag
git push --all --follow-tags
debuild -S -sa
