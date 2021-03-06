Installation
------------

On the target laptop:

  1. install Ubuntu 14.04 desktop
  1. apt-get install openssh-server
  2. allow root login
    - sudo passwd root    # set password
    - sudo passwd -u root # unlock account
  3. allow ssh root login:
    - edit /etc/ssh/sshd_config, set PermitRootLogin yes
    - sudo service ssh restart
  4. in the network-manager, remove the generate entry for the wired interface

On your workstation:

  1. `ssh-copy-id root@$laptop`
  2. create the inventory file `hosts`, e.g.:

		[analyzer]
		$LAPTOP_IP

  3. `ansible-playbook -i hosts playbook.yml`

Usage
-----

On ubuntu, install remmina, on OS/X, install RDP from the appstore.

On any RDP client, add an entry to connect to $LAPTOP_IP, login: trudy, pass: trudy.

Troubleshooting
---------------

xrdp has a log in /var/log. If it says there's no more X display available, then it means all sessions were used up.
Stop xrdp, killall Xvnc and restart xrdp.
