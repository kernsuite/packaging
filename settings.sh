#!/usr/bin/env bash -ve

export KERN_BASE=git@github.com:kernsuite-debian/
export KERN_PACKAGES=`cat packages | grep -v ^#`
export KERN_DIST=bionic  # ubuntu 18.04

export DEBEMAIL="packaging@kernsuite.info"
export DEBFULLNAME="KERN packaging"

# This depends on your system. use #cores +1
#export DEB_BUILD_OPTIONS="parallel=15"

export KERN_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export KERN_BUILD=${KERN_ROOT}/build
export KERN_RESULTS=${KERN_ROOT}/repo
