# docker - blast
#
# Provides a web blast server in a Docker container
#
# VERSION	0.1

FROM ubuntu

MAINTAINER Devon P. Ryan, dpryan79@gmail.com

RUN apt-get -qq update && apt-get install --no-install-recommends -y curl \
    apache2 csh psmisc nfs-kernel-server autofs nis && \
    adduser --uid 1450 galaxy && \
    mkdir /data && \
    mkdir /configs && \
    rm /var/www/html/index.html && \
    curl ftp://ftp.ncbi.nlm.nih.gov/blast/executables/release/2.2.26/wwwblast-2.2.26-x64-linux.tar.gz | tar -zxpC /var/www/html

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
ADD startup.sh /usr/local/bin/startup.sh

RUN rm -f /etc/auto.net /etc/auto.misc /etc/auto.smb
ADD ./yp.conf /etc/yp.conf
ADD ./auto.master /etc/auto.master
ADD ./auto.data /etc/automount/auto.data
ADD ./auto.home /etc/automount/auto.home
ADD ./nsswitch.conf /etc/nsswitch.conf

EXPOSE :80

VOLUME ["/var/www/html/blast/db"]

CMD ["startup.sh"]
