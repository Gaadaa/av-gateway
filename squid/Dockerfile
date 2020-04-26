FROM centos:centos7.7.1908

# squidセットアップ
RUN yum install squid openssl -y --nogpgcheck
# COPY privateca.pem /etc/pki/CA/private/privateca.pem
# RUN chown -R squid /etc/pki/CA/private
RUN /usr/lib64/squid/ssl_crtd -c -s /var/lib/ssl_db
RUN chown -R squid /var/lib/ssl_db

# squidリビルド
RUN yum install rpm-build -y --nogpgcheck
RUN yum install openldap-devel pam-devel openssl-devel krb5-devel expat-devel libxml2-devel libcap-devel libecap-devel libtool libtool-ltdl-devel cppunit-devel libdb-devel gcc-c++ -y --nogpgcheck

RUN useradd mockbuild

RUN su mockbuild && cd && curl -O http://vault.centos.org/7.7.1908/os/Source/SPackages/squid-3.5.20-12.el7_6.1.src.rpm

RUN su mockbuild && cd && rpm -i squid-3.5.20-12.el7_6.1.src.rpm
COPY squid.spec /root/rpmbuild/SPECS/squid.spec
RUN su mockbuild && cd && rpmbuild -ba /root/rpmbuild/SPECS/squid.spec

# squid上書きインストール
RUN rpm -Uhv /root/rpmbuild/RPMS/x86_64/squid-3.5.20-12.el7.1.x86_64.rpm /root/rpmbuild/RPMS/x86_64/squid-migration-script-3.5.20-12.el7.1.x86_64.rpm --force

COPY squid.conf /etc/squid/squid.conf.tmp
RUN chown squid:squid /etc/squid/squid.conf && chmod a+w /etc/squid/squid.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

RUN chmod a+rwx /var/log/squid && \
    ln -sf /dev/stdout /var/log/squid_access.log && \
    ln -sf /dev/stderr /var/log/squid_cache.log && \ 
    ln -sf /dev/stdout /var/log/squid/access.log && \
    ln -sf /dev/stderr /var/log/squid/cache.log 

RUN mkdir /squidconf && chown squid:squid /squidconf

EXPOSE 3128

USER squid

ENTRYPOINT /entrypoint.sh
