#!/usr/bin/env bash 

set -e
set -v 

. settings.sh

pushd repo
apt-ftparchive packages . > Packages
popd

sudo pbuilder create --distribution ${KERN_DIST} --override-config --configfile ./pbuilderrc

# On ubuntu 19.10 I'm using (after symlinking the config file to my homedir)

# git-pbuilder create --dist=bionic



