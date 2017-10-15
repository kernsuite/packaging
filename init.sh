#!/usr/bin/env bash 

set -e
set -v 

. settings.sh

sudo pbuilder create --distribution ${DIST} --components main,restricted,universe,multiverse
