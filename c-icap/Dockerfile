FROM centos:centos7.7.1908

RUN yum install libtool gcc-c++ make zlib brotli -y --nogpgcheck
RUN curl -O https://jaist.dl.sourceforge.net/project/c-icap/c-icap/0.5.x/c_icap-0.5.6.tar.gz
RUN tar zxvf c_icap-0.5.6.tar.gz \
    && cd c_icap-0.5.6 \
    && ./configure --prefix=/usr/local/c-icap --enable-large-files \
    && make \
    && make install
COPY c-icap.conf /usr/local/c-icap/etc/c-icap.conf

RUN yum install epel-release -y --nogpgcheck
RUN yum install clamav-devel -y --nogpgcheck
RUN curl -O https://github.com/darold/squidclamav/archive/v7.1.tar.gz -L 
RUN tar zxvf v7.1.tar.gz \
    && cd squidclamav-7.1/ \
    && ./configure --with-c-icap=/usr/local/c-icap/ \
    && make \
    && make install \
    && libtool --finish /usr/local/c-icap/lib/c_icap/

COPY squidclamav.conf /usr/local/c-icap/etc/squidclamav.conf.tmp
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

RUN mkdir -p /usr/local/c-icap/var/log/ && \
    ln -sf /dev/stderr /usr/local/c-icap/var/log/server.log && \
    ln -sf /dev/stdout /usr/local/c-icap/var/log/access.log

EXPOSE 1344

ENTRYPOINT [ "/entrypoint.sh" ]
