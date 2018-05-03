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

if [ ! -d "${KERN_BUILD}" ]; then
    mkdir -p ${KERN_BUILD};
fi

pushd ${KERN_BUILD}

for i in ${KERN_PACKAGES}; do
    if [ ! -f "$i.build" ]; then
        if [ ! -d "$i" ]; then
            git clone ${KERN_BASE}$i
        fi

        pushd $i
        dh_clean
        git pull

        echo RESULTS=${KERN_RESULTS}
        echo ROOT=${KERN_ROOT}
        BUILDER=pbuilder gbp buildpackage \
            --git-pbuilder \
            --git-ignore-new \
            --git-pbuilder-options="--buildresult ${KERN_RESULTS} \
             --configfile ${KERN_ROOT}/pbuilderrc"

        popd
        touch $i.build

        pushd ${KERN_RESULTS}
        apt-ftparchive packages . > Packages
        popd
    fi
done
