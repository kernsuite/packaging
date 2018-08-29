#!/usr/bin/env bash 

set -e
set -v 

. settings.sh

pushd repo
apt-ftparchive packages . > Packages
popd

sudo pbuilder create --distribution ${KERN_DIST} --override-config --configfile ./pbuilderrc

