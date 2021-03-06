#!/bin/bash
# copyright (c) 2015 fclaerhout.fr, released under the MIT license.

#         ---------> [input]-------
#       /                           \
#  [nat] -> ip_forward? ->[forward]->[output]->

set -eu

if test $EUID -ne 0
then
	echo "This script must be run as root"
	exit 1
fi

IPFWD=/proc/sys/net/ipv4/ip_forward

case ${1:-usage} in
	start)
		echo 1 > $IPFWD
		iptables -F
		iptables -t nat -F
		iptables -t mangle -F
		iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
		iptables -A FORWARD -i eth0 -j ACCEPT
		iptables -A INPUT -p tcp -m state --state ESTABLISHED,RELATED -j ACCEPT
		iptables -A INPUT -p udp -m state --state ESTABLISHED,RELATED -j ACCEPT
		;;
	stop)
		echo 0 > $IPFWD
		;;
	status)
		echo -n "forwarding..."
		if test $(cat $IPFWD) = 1
		then echo "enabled"
		else echo "disabled"
		fi
		iptables -L -t nat -t filter
		;;
	*)
		echo "usage: $(basename $0) (start|stop|status)"
		exit 1
esac
