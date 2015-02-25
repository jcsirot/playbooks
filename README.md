
OVERVIEW
--------

A collection of playbooks for usual services.
Only tested on \[ubuntu\] or \[debian\] so far, make sure to put the host in the right group.

  * apache (or noapache to remove)
    * `htmlpath`, path to the local directory used to populate the remote html directory
  * btsync
    * `device_name`
    * `login`
    * `password`
    * `arch`
  * docker
    * …
  * gitd
    * …
  * jenkins
    * `memory`
    * `keypath`
    * `listen_port`
    * `listen_address`
  * nginx
    * …
  * pypiserver
    * …

USAGE
-----

Beware! to keep things simple the subdirs *are not roles*, just regular includes.

	[...]
	- include <service>/playbook.yml [options]
	[...]
