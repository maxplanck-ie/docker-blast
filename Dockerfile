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
ADD ./yp.conf /etc/yp.conf
ADD ./auto.master /etc/auto.master
ADD ./auto.cisterna /etc/automount/auto.cisterna
ADD ./auto.deep /etc/automount/auto.deep
ADD ./auto.deep1 /etc/automount/auto.deep1
ADD ./auto.solsys4 /etc/automount/auto.solsys4
ADD ./auto.scratch /etc/automount/auto.scratch
ADD ./auto.stiff /etc/automount/auto.stiff
ADD ./auto.valid /etc/automount/auto.valid
ADD ./auto.void /etc/automount/auto.void
ADD ./nsswitch.conf /etc/nsswitch.conf
ADD ./.sequenceserver.conf /root/.sequenceserver.conf
ENV TERM xterm

EXPOSE :8080

VOLUME ["/db"]

CMD ["startup.sh"]
