#!/bin/bash

domainname solsys1.immunbio.mpg.de

#Start rpcbind
/sbin/rpcbind
/sbin/rpc.statd --no-notify

#Start ypbind
/usr/sbin/ypbind

#Start automount
/usr/sbin/automount

#restart automount
sleep 15
killall -9 automount
/usr/sbin/automount

cd /var/www/html/blast/db

#.html files
count=`ls  *.html 2> /dev/null | wc -l`
if [ $count != 0 ]
then
    for html in `ls *.html`
    do
        rm /var/www/html/blast/$html
        cp $html /var/www/html/blast/$html
    done
fi

#.rc files
count=`ls  *.rc 2> /dev/null | wc -l`
if [ $count != 0 ]
then
    for rc in `ls *.rc`
    do
        rm /var/www/html/blast/$rc
        cp $rc /var/www/html/blast/$rc
    done
fi

#/etc/group
if [ -f /var/www/html/blast/db/group ]
then
    rm /etc/group
    ln -s /var/www/html/blast/db/group /etc/group
fi

a2enmod cgi
service apache2 start

tail -f /var/log/apache2/*.log /var/www/html/blast/wwwblast.log
