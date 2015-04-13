A collection of simple playbooks for common services.

**QUICK START**

  1. First, get the playbooks, e.g. add this repository as a submodule:

		$ mkdir vendor
		$ cd vendor
		vendor$ git submodule add $this

  2. In your main playbook, add:

		- include vendor/playbooks/playbook.yml

  3. In your inventory, simply put your hosts in its service groups and set the configuration keys e.g.:

		[jenkins]
		foo jenkins_memory=3G jenkins_listen_port=9999

NOTE: each playbook is defined for a subset of platforms (e.g. ubuntu);
and therefore expect the host to be in the platform group.
This is handled automatically by detecting each host platform and dynamically putting it into that group.

**PLAYBOOKS**

Beware! to keep things simple the subdirs *are not roles*,
as defined [here](http://docs.ansible.com/playbooks_roles.html#roles).

  * ubuntu / __analyzer__ — transform a laptop into a WiFi traffic analyzer server.
    The setup used for this is a regular laptop with a RJ45 interface and a wireless interface.
    A wifi router is connected to the RJ45 interface and fetch its address from the DHCP server
    installed on the laptop. The laptop forwards the traffic from all the devices connected to
    the WiFi router through its wireless interface and is therefore able to intercept everything.
    Users can connect via RDP via the laptop wireless interface and use network analysis tools
    (wireshark, charles) over the wired interface. For details check analyzer/README.md.
  * ubuntu / __apache__ (or __no-apache__ to remove)
  * debian / __aptproxy__
    * `aptproxy_http`
    * `aptproxy_https`
    * `aptproxy_direct`: list of hostnames
  * ubuntu / __btsync__ (no __no-btsync__ to remove)
    * `btsync_device_name`: btsync service name
    * `btsync_login`: web interface login
    * `btsync_password`: web interface password
    * `btsync_arch`: ia32 | x64
    * `btsync_listen_address`: defaults to "127.0.0.1"
    * `btsync_listen_port`: defaults to "8888"
  * debian / __docker__
    * `docker_listen_address`: defaults to "127.0.0.1"
    * `docker_listen_port`: defaults to "4243"
    * `docker_environment`: specify web proxy settings, see below
  * debian/ __elk__: install the logstash/elasticsearch/kibana stack.
    * `kibana_listen_address`: defaults to "127.0.0.1"
    * `kibana_listen_port`: defaults to "5601"
    * `logstash_listen_address`: defaults to "127.0.0.1"
    * `logstash_listen_port`: defaults to "10514"
    * `elk_environment`: specify web proxy settings, see below
  * debian/ __fermod__: enable ferm (debian firewall wrapper) "mods" (i.e. /etc/ferm.d instead of a single ferm.conf)
  * ubuntu / __gitd__
    * `gitd_authorized_keys_path`: local path to authorized_keys file setup for the remote ssh git user
  * ubuntu|debian / __jenkins__|__jenkinslts__
    * `jenkins_memory`: set how much memory the JVM can use, defaults to "256m"
    * `jenkins_sshpath`: local path used to populate the remote ~jenkins/.ssh directory
    * `jenkins_listen_port`: set the port to bind, defaults to "8080"
    * `jenkins_listen_address`: set the address to bind, defaults to "127.0.0.1"
    * `jenkins_environment`: specify web proxy settings, see below
  * debian / __nexus__
  * ubuntu|debian / __nginx__ (or __no-nginx__ to remove)
    * `nginx_sites_path`: local directory which content is copied into /etc/nginx/sites-enabled/
    * `nginx_crt_path`: local path to the directory containing the certificates
  * ubuntu|debian / __pypiserver__
    * `pypiserver_htaccess_path`: local path to the htaccess file
    * `pypiserver_listen_port`: set the port to bind, defaults to "8080"
    * `pypiserver_listen_address`: set the address to bind, defaults to "127.0.0.1"d
  * ubuntu / __simpleid__ (or __no-simpleid__ to remove)
    * `simpleid_base_url`: simpleid site URL
    * `simpleid_identities_path`: path to identity files

**WEB PROXY**

If you need to go through a web proxy, check the playbook has a dedicated _environment variable then set it as follows:

	[somegroup]
	somehost xyz_environment="{{ {'http_proxy': 'http://someproxy:3128', 'https_proxy': 'http://someproxy:3128'} }}"
