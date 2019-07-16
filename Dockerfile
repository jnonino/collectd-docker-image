FROM ubuntu
LABEL maintainer="Julian Nonino <noninojulian@gmail.com>"

RUN apt-get update -y && \
    apt-get install -y build-essential wget tar tcpdump && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

ENV COLLECD_VERSION 5.8.0
RUN wget https://collectd.org/files/collectd-${COLLECD_VERSION}.tar.bz2 && \
    tar -jxvf collectd-${COLLECD_VERSION}.tar.bz2 && \
    rm -rf collectd-${COLLECD_VERSION}.tar.bz2 && \
    cd collectd-${COLLECD_VERSION} && \
    ./configure && \
    make all install && \
    rm -rf /opt/collectd/etc/collectd.conf

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]