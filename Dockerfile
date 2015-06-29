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
    curl ftp://ftp.ncbi.nlm.nih.gov/blast/executables/release/2.2.26/wwwblast-2.2.26-x64-linux.tar.gz | tar -zxpC /var/www/html --strip-components 1

ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
ADD startup.sh /usr/local/bin/startup.sh

#Need to mount /var/www/html/db, which should contain symlinks to /data
#Need to mount /data
#Add www-data to the appropriate groups?
#Copy in /var/www/html/blast.rc if it exists

EXPOSE :80

VOLUME ["/data"]
VOLUME ["/var/www/html/db"]
#The above should have symlinks and html pages, which can be moved, and a groups file, which will also get moved

#need to start apache and then tail -f its logs
CMD ["startup.sh"]
