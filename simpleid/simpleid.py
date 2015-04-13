
# replace FIXME by a password and run this program to get simpleid pass= field in the corresponding identity file

import hashlib

m = hashlib.sha1()
passwd = FIXME
m.update(passwd)
print "%s:sha1" % m.hexdigest()
