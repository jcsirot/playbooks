#!/bin/bash
# copyright (c) 2015 fclaerhout.fr, released under the MIT license.

#         ---------> [input]-------
#       /                           \
#  [nat] -> ip_forward? ->[forward]->[output]->

set -eu

IPFWD=/proc/sys/net/ipv4/ip_forward

case ${1:-usage} in
	start)
		echo 1 > $IPFWD
		iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
		iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
		iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
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
