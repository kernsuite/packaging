#!/bin/bash -ve

# this script will clone all package repositories and build them
# it will install required dependencies during the run, so it requires sudo access
#
# package dependencies: sudo devscripts git git-buildpackage equivs apt-utils

. settings.sh

if [ ! -d "${BUILD}" ]; then
    mkdir -p ${BUILD};
fi

pushd ${BUILD}

for i in ${PACKAGES}; do
    if [ ! -f "$i.build" ]; then
        if [ ! -d "$i" ]; then
            git clone ${BASE}$i
        fi
        pushd $i
        dh_clean
        git pull
        BUILDER=pbuilder gbp buildpackage --git-pbuilder --git-ignore-new
        popd
        touch $i.build
        apt-ftparchive packages . > Packages
    fi
done
