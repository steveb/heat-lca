#!/bin/sh

rm -rf files
mkdir -p files
pushd files
wget http://download.wikimedia.org/mediawiki/1.20/mediawiki-1.20.2.tar.gz
git clone git://github.com/steveb/SwiftCloudFiles.git
popd