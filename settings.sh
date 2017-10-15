#!/usr/bin/env bash -ve

export BASE=git@github.com:kernsuite-debian/
export PACKAGES=`cat packages | grep -v ^#`
export DIST=xenial  # ubuntu 16.04

export DEBEMAIL=gijs@pythonic.nl
export DEBFULLNAME='Gijs Molenaar (launchpad ppa build key)'
export DEB_BUILD_OPTIONS="parallel=56"
