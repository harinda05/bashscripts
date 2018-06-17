#!/bin/bash

set -xv

srcdir=$1
destdir=$2

filename=$1_`date +%Y-%m-%d`.tgz
tar --create --gzip --file=$destdir/$filename $srcdir
