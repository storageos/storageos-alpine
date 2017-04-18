
VAGRANT	= vagrant
VPROV	= $(VAGRANT) provision --provision-with

all: up provision

rebuild: destroy up provision

up: plugin
	vagrant up

plugin:
	if ! vagrant plugin list | egrep '^vagrant-alpine '; then \
		vagrant plugin install vagrant-alpine; \
	fi

destroy:
	vagrant destroy -f

provision:
	$(VPROV) consul-rv
	$(VPROV) storageos
	$(VPROV) storageos-check

restart: up consul provision

refresh-plugin: remove-plugin consul provision

remove-plugin:
	$(VPROV) storageos-remove

consul:
	$(VPROV) consul
