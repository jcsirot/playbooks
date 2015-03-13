#!/bin/bash

set -eu

if test $EUID -ne 0
then
	echo "This script must be run as root"
	exit 1
fi

/sbin/iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8888
/usr/bin/charles
/sbin/iptables -t nat -D PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8888
