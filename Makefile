
VAGRANT	= vagrant
VPROV	= $(VAGRANT) provision --provision-with

all:
	echo "No default target" >&2
	exit 1

up:
	vagrant up

provision:
	$(VPROV) consul-rv
	$(VPROV) storageos

refresh-plugin:
	$(VPROV) storageos-remove
	$(VPROV) consul
	$(VPROV) consul-rv
	$(VPROV) storageos
