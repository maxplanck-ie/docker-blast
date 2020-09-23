# docker - blast
#
# Provides a web blast server in a Docker container
#
# VERSION	0.1

FROM ubuntu:16.04

MAINTAINER Devon P. Ryan, dpryan79@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y build-essential ruby ruby-dev wget
RUN apt-get install -y psmisc nfs-kernel-server autofs nis git nodejs npm
RUN wget -q ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.9.0/ncbi-blast-2.9.0+-x64-linux.tar.gz && \
    tar xf ncbi-blast-2.9.0+-x64-linux.tar.gz && \
    cp ncbi-blast-2.9.0+/bin/* /usr/local/bin
RUN git clone https://github.com/wurmlab/sequenceserver && \
    cd sequenceserver && \
    git checkout 2.0.0.beta3 && \
    gem install bundler && \
    bundle install --without=development

ADD startup.sh /usr/local/bin/startup.sh
RUN rm -f /etc/auto.net /etc/auto.misc /etc/auto.smb
ADD ./mnt_pnts/automount/yp.conf /etc/yp.conf
ADD ./mnt_pnts/automount/auto.master /etc/auto.master
ADD ./mnt_pnts/automount/nsswitch.conf /etc/nsswitch.conf
COPY ./mnt_pnts/automount/auto* /etc/automount/
ADD ./.sequenceserver.conf /root/.sequenceserver.conf
ENV TERM xterm

EXPOSE :8080

VOLUME ["/db"]

CMD ["startup.sh"]
