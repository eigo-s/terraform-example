#!/bin/bash

hostname ${host}
sed -i -e "s/^HOSTNAME=.*\$/HOSTNAME=${host}/g" /etc/sysconfig/network

