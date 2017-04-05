
VAGRANT	= vagrant
VPROV	= $(VAGRANT) provision --provision-with

all:
	echo "No default target" >&2
	exit 1

rebuild: destroy up provision

up:
	vagrant up

destroy:
	vagrant destroy -f

provision:
	$(VPROV) consul-rv
	$(VPROV) storageos

refresh-plugin:
	$(VPROV) storageos-remove
	$(VPROV) consul
	$(VPROV) consul-rv
	$(VPROV) storageos
