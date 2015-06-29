# docker - blast
#
# Provides a web blast server in a Docker container
#
# VERSION	0.1

FROM ubuntu

MAINTAINER Devon P. Ryan, dpryan79@gmail.com

RUN apt-get -qq update && apt-get install --no-install-recommends -y curl \
    apache2 csh && \
    mkdir /data && \
    mkdir /configs && \
    rm /var/www/html/index.html && \
    curl ftp://ftp.ncbi.nlm.nih.gov/blast/executables/release/2.2.26/wwwblast-2.2.26-x64-linux.tar.gz | tar -zxpC /var/www/html

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
ADD startup.sh /usr/local/bin/startup.sh

EXPOSE :80

VOLUME ["/data"]
VOLUME ["/var/www/html/blast/db"]

CMD ["startup.sh"]
