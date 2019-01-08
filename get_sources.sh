#!/bin/bash -ve

# this script will get all source packages from the system configured KERN repository.

. settings.sh

KERN_SOURCES=${KERN_ROOT}/sources

if [ ! -d "${KERN_SOURCES}" ]; then
    mkdir -p ${KERN_SOURCES};
fi

pushd ${KERN_SOURCES}

for i in ${KERN_PACKAGES}; do
    apt-get source ${i}
done
