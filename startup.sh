#!/bin/bash

cd /var/www/html/db
for html in *.html
do
    rm /var/www/html/$html
    ln -s $html /var/www/html/$html
done

if [ -f /var/www/html/db/group ]
then
    rm /etc/group
    ln -s /var/www/html/db/group /etc/group
fi

service apache2 start

tail -f /var/log/apache2/*.log
