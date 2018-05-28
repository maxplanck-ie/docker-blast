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

cd /sequenceserver && bundle exec bin/sequenceserver -D
sleep 1000000
