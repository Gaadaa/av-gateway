#!/bin/bash

env

cat /usr/local/c-icap/etc/squidclamav.conf.tmp | sed "s/^clamd_ip default/clamd_ip ${CLAMD_HOST}/g" > /usr/local/c-icap/etc/squidclamav.conf

rm /var/run/c-icap/c-icap.pid

/usr/local/c-icap/bin/c-icap -N -d 10 -D
