#!/bin/bash -ve

# this script will clone all package repositories and build them
# it will install required dependencies during the run, so it requires sudo access
#
# package dependencies: sudo devscripts git git-buildpackage equivs apt-utils debhelper
#
# also you first need to setup the pbuilder chroot environment:
#
# $ sudo pbuilder create --configfile pbuilderrc
#
#

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

        BUILDER=pbuilder gbp buildpackage \
            --git-pbuilder \
            --git-ignore-new \
            --git-pbuilder-options="--buildresult ${RESULTS} \
             --configfile ${ROOT}/pbuilderrc"

        popd
        touch $i.build

        pushd ${RESULTS}
        apt-ftparchive packages . > Packages
        popd
    fi
done
