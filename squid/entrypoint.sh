#!/bin/bash

env

TMP_CERT_PRIVATE_KEY_PATH=$(echo ${CERT_PRIVATE_KEY_PATH} | sed 's/\//\\\//g')
TMP_DOMAIN_BLACKLIST_PATH=$(echo ${DOMAIN_BLACKLIST_PATH} | sed 's/\//\\\//g')

cat /etc/squid/squid.conf.tmp | \
sed "s/ icap:\/\/default:1344\/squidclamav / icap:\/\/${CICAP_HOST}:1344\/squidclamav /g" | \
sed "s/ cert=privateca\.pem/ cert=${TMP_CERT_PRIVATE_KEY_PATH}/g" | \
sed "s/acl domain_blacklist dstdomain blacklist\.txt/acl domain_blacklist dstdomain \"${TMP_DOMAIN_BLACKLIST_PATH}\"/g" \
> /etc/squid/squid.conf

/usr/sbin/squid -N -f /etc/squid/squid.conf
