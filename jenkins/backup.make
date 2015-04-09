# copyright (c) 2015 fclaerhout.fr, released under the MIT license.
# poorman implementation of a backup/restore system for jenkins.

.PHONY: usage backup restore

#################
# configuration #
#################

# remote hoststring
HOSTSTRING ?= root@fclaerhout.fr

# remote jenkins parent directory
LIBDIR := /var/lib

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
	$(SSH) -- find $(LIBDIR)/jenkins/jobs -name workspace -type d -exec rm -rf {} +
	$(SSH) -- tar zcvf $(NAME) -C $(LIBDIR) jenkins
	scp $(HOSTSTRING):$(NAME) $(STOREDIR)
	$(SSH) -- rm $(NAME)

# BEWARE: change LIBDIR into /var/lib once validated!
restore: LATEST:=$(shell find $(STOREDIR) -name 'jenkins_*.tgz' | sort | tail -n 1)
restore:
	scp $(STOREDIR)/$(LATEST) $(HOSTSTRING):$(LIBDIR)
	$(SSH) -- tar xvf $(LIBDIR)/$(LATEST) -C $(LIBDIR)
	$(SSH) -- rm $(LIBDIR)/$(LATEST)
