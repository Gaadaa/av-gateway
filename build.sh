#!/bin/bash

CLAMD_IMAGE=docker.pkg.github.com/n-noguchi/av-gateway/clamd:1.0.0
CICAP_IMAGE=docker.pkg.github.com/n-noguchi/av-gateway/c-icap:1.0.0
SQUID_IMAGE=docker.pkg.github.com/n-noguchi/av-gateway/squid:1.0.0

docker build -t $CLAMD_IMAGE clamd || exit 1
docker build -t $CICAP_IMAGE c-icap || exit 1
docker build -t $SQUID_IMAGE squid || exit 1

docker push $CLAMD_IMAGE || exit 1
docker push $CICAP_IMAGE || exit 1
docker push $SQUID_IMAGE || exit 1
