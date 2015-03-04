A collection of simple playbooks for common services.

### PLAYBOOKS ###

  * ubuntu / __apache__ (or __noapache__ to remove)
  * ubuntu / btsync
    * `btsync_device_name`: btsync service name
    * `btsync_login`: web interface login
    * `btsync_password`: web interface password
    * `btsync_arch`: ia32 | x64
    * `btsync_listen_address`: defaults to 127.0.0.1
    * `btsync_listen_port`: defaults to 127.0.0.1
  * debian / __docker__
    * `docker_listen_address`, defaults to 127.0.0.1
    * `docker_listen_port`, defaults to 4243
  * ubuntu / __gitd__
    * `gitd_authorized_keys_path`: local path to authorized_keys file setup for the remote ssh git user
  * ubuntu|debian / __jenkins__|__jenkinslts__
    * `jenkins_memory`: set how much memory the JVM can use, defaults to 256m
    * `jenkins_sshpath`: local path used to populate used the remote ~jenkins/.ssh directory
    * `jenkins_listen_port`: set the port to bind, defaults to 8080
    * `jenkins_listen_address`: set the address to bind, defaults to 127.0.0.1
  * ubuntu / __nginx__
    * `nginx_default_path`: local path to the default file copied to /etc/nginx/sites-enabled/default.
  * ubuntu / __pypiserver__
    * `pypiserver_htaccess_path`: local path to the htaccess file
    * `pypiserver_listen_port`: set the port to bind, defaults to 8080
    * `pypiserver_listen_address`: set the address to bind, defaults to 127.0.0.1
  * ubuntu / __simpleid__
    * `simpleid_base_url`: simpleid site URL
    * `simpleid_identities_path`: path to identity files

### USAGE ###

Beware! to keep things simple the subdirs *are not roles*, just regular includes.

  1. First, add this repository as a submodule:

		$ git submodule add $this

  2. In your main playbook, for each service you're interested in, add:

		- include <service>/playbook.yml key=value…

  3. In your inventory, put your hosts in the appropriate groups, e.g.:

		[ubuntu]
		foo
		[jenkins]
		foo key=value…

### TODO LIST ####

Add a htaccess generator taking a file listing user:pass records in input.