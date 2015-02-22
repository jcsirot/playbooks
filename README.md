
OVERVIEW

A collection of playbooks for some usual services. Only tested on ubuntu so far, make sure to put the host in an ubuntu group.

Usage:

	- include <service>/playbook.yml [vars]

Beware! to keep things simple the subdirs *are not roles*.

SERVICES

  * apache
  * btsync
  * docker
  * gitd
  * jenkins
  * pypiserver
