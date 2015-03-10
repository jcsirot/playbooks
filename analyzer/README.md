Troubleshooting
---------------

xrdp has a log in /var/log. If it says there's no more X display available, then it means all sessions were used up.
Stop xrdp, killall Xvnc and restart xrdp.
