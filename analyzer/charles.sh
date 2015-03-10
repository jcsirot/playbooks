#!/bin/bash

set -eu

if test $EUID -ne 0
then
	echo "This script must be run as root"
	exit 1
fi

case ${1:-usage} in
	start)
		iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8888
		;;
	stop)
		false
		;;
	status)
		true
		;;
	*)
		echo "usage: $(basename $0) (start|stop|status)"
		exit 1
esac
