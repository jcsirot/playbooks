# copyright (c) 2015 fclaerhout.fr, released under the MIT license.
# KISS implementation of a jenkins backup/restore system.

.PHONY: usage backup restore

#################
# configuration #
#################

# remote hoststring
HOSTSTRING ?= root@fclaerhout.fr

# local directory storing archives
STOREDIR := .

##################
# implementation #
##################

SSH := ssh $(HOSTSTRING)

usage:
	@echo "usage:"
	@echo "  make <target>"
	@echo
	@echo targets:
	@echo "  backup: archive remote /var/lib/jenkins directory locally"
	@echo "  restore: push and expand latest archive"

backup: NAME:=jenkins_$(shell date +%Y%m%d%H%M%S).tgz
backup:
	$(SSH) -- find /var/lib/jenkins/jobs -name workspace -type d -exec rm -rf {} +
	$(SSH) -- tar zcvf $(NAME) -C /var/lib/ jenkins
	scp $(HOSTSTRING):$(NAME) $(STOREDIR)
	$(SSH) -- rm $(NAME)

# BEWARE: change LIBDIR into /var/lib once validated!
restore: LATEST:=$(shell find $(STOREDIR) -name 'jenkins_*.tgz' | sort | tail -n 1)
restore: LIBDIR:=/tmp
restore:
	scp $(STOREDIR)/$(LATEST) $(HOSTSTRING):$(LIBDIR)
	$(SSH) -- tar xvf $(LATEST) -C $(LIBDIR)
	$(SSH) -- rm $(LIBDIR)/$(LATEST)
