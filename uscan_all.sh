#!/bin/bash -ve

# checks if there is an update available for any eduVPN package.
# Will only print out information.

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${KERN_ROOT}/settings.sh

pushd build

for i in $KERN_PACKAGES; do
    pushd $i
    uscan || true
    popd
done
