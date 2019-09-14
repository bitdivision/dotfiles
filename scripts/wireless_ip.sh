#!/usr/bin/env sh
INTERFACE=`echo /sys/class/net/*/wireless | awk -F'/' '{ print $5 }'`

ip -4 addr show ${INTERFACE} | grep -oP '(?<=inet\s)\d+(\.\d+){3}'

