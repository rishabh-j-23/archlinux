#!/usr/bin/env bash

builds_dir=$DEV_CONFIG/builds/

set -e

echo "INFO::builds::building in dir [$builds_dir]"
cd $builds_dir
echo "INFO::git::cloning xofikit"
git clone git@github.com:rishabh-j-23/xofikit.git
cd xofikit
echo "INSTALLING::xofikit::[$builds_dir/xofikit]"
make install 
