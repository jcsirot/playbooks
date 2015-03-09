#!/usr/bin/python -tt
# skvidal@fedoraproject.org - (c) Red Hat, inc 2013
# gpl v2+
# utterly trivial so I'm not worried one way or the other

# change: prefix output with salt, as required by ansible.user

import crypt
import string
import getpass
import random

match = False
while not match:
    input = getpass.getpass()
    input2 = getpass.getpass(prompt="Re-enter Password: ")
    if input == input2:
        match = True
    else:
        print 'Passwords do not match, try again!'

salt = ''.join(random.choice(string.ascii_letters + string.digits + './') for x in range(86))
salt = '$6$%s$' % salt

gen = crypt.crypt(input, salt)
print "%s%s" % (salt, gen)
