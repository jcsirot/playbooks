# copyright (c) 2015 fclaerhout.fr, released under the MIT license.
# poorman implementation of a backup/restore system for jenkins.

.PHONY: usage backup restore

#################
# configuration #
#################

ifndef $(HOSTSTRING)
	$(error HOSTSTRING: remote hoststring not defined)
endif

# remote jenkins parent directory
LIBDIR ?= /var/lib

# local directory storing archives
STOREDIR ?= .

##################
# implementation #
##################

LASTPATH := $(shell find $(STOREDIR) -name 'jenkins_*.tgz' | sort | tail -n 1)
SSH := ssh $(HOSTSTRING)

usage:
	@echo "usage:"
	@echo "  make <target>"
	@echo
	@echo targets:
	@echo "  backup: archive $(HOSTSTRING):$(LIBDIR)/jenkins directory in $(STOREDIR)"
	@echo "  restore: unarchive $(LASTPATH) at $(HOSTSTRING):$(LIBDIR)"

backup: NAME:=jenkins_$(shell date +%Y%m%d%H%M%S).tgz
backup:
	$(SSH) -- find $(LIBDIR)/jenkins/jobs -name workspace -type d -exec rm -rf {} +
	$(SSH) -- tar zcvf $(NAME) -C $(LIBDIR) jenkins
	scp $(HOSTSTRING):$(NAME) $(STOREDIR)
	$(SSH) -- rm $(NAME)

restore:
	scp $(LASTPATH) $(HOSTSTRING):$(LIBDIR)
	$(SSH) -- tar xvf $(LIBDIR)/$(notdir $(LASTPATH)) -C $(LIBDIR)
	$(SSH) -- rm $(LIBDIR)/$(notdir $(LASTPATH))
