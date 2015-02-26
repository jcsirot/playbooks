A collection of simple playbooks for common services.

### PLAYBOOKS ###

  * ubuntu / __apache__ (or __noapache__ to remove)
    * `htmlpath`: local path to the directory used to populate the remote /var/www/html directory
  * btsync
    * `device_name`
    * `login`
    * `password`
    * `arch`
  * debian / __docker__
  * ubuntu / __gitd__
    * `authorized_keys_path`: local path to authorized_keys file setup for the remote ssh git user
  * ubuntu|debian / __jenkins__
    * `memory`: set how much memory the JVM can use, default 256m
    * `sshpath`
    * `listen_port`
    * `listen_address`
  * ubuntu / __nginx__
    * `htmlpath`: local path to the directory used to populate the remote /var/www/html directory
    * `default_path`: local path to the default file copied to /etc/nginx/sites-enabled/default.
  * ubuntu / __pypiserver__
    * `htaccess_path`: local path to the htaccess file

### USAGE ###

Beware! to keep things simple the subdirs *are not roles*, just regular includes.

  1. First, add this repository as a submodule:

		$ git submodule add $this

  2. In your main playbook, for each service you're interested in, add:

		- include <service>/playbook.yml [options]

  3. In your inventory, put your hosts in the appropriate groups, e.g.:

		[ubuntu]
		foo
		[jenkins]
		foo
