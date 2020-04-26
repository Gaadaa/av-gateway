FROM centos:centos7.7.1908

RUN yum install epel-release -y --nogpgcheck

RUN yum install clamav clamav-data clamav-devel clamav-filesystem clamav-update clamd -y --nogpgcheck

COPY scan.conf /etc/clamd.d/scan.conf

RUN ln -sf /dev/stderr /var/log/clamd.scan

EXPOSE 3310

USER clamscan
ENTRYPOINT /usr/sbin/clamd -c /etc/clamd.d/scan.conf
