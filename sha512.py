import hashlib

msg = hashlib.sha512()
msg.update("wireshark")

print msg.hexdigest()
