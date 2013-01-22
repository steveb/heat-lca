#!/bin/sh

pushd files

tar -xzf mediawiki-1.20.2.tar.gz
rm -rf wiki
mv mediawiki-1.20.2 wiki
cp -r SwiftCloudFiles wiki/extensions/
cp ../LocalSettings.php wiki/

chown -R apache:apache wiki
rm -rf /var/www/html/wiki
cp -r wiki /var/www/html/

mkdir -p /var/lib/php/session
chown apache:apache /var/lib/php/session
