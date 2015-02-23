
OVERVIEW

A collection of playbooks for some usual services. Only tested on ubuntu so far, make sure to put the host in an ubuntu group.

USAGE

Beware! to keep things simple the subdirs *are not roles*, just regular includes.

	[...]
	- include <service>/playbook.yml [vars]
	[...]
