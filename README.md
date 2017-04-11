# storageos-alpine Vagrant setup

A simple Vagrant setup for running StorageOS (plugin) on Alpine Linux.

Makes use of the `vagrant-alpine` plugin and box kindly provided by [Matt Maier](https://github.com/maier). Matt's box runs Alpine 3.4 on Virtualbox.

I'm looking to upgrade to Alpine 3.5 and provide VMware desktop and KVM machines as well. When I get to it.

# Pre-requisites

- [Vagrant](https://www.vagrantup.com/) 1.9.3.

    1.8 versions may well work, I've not tested them. Earlier 1.9.x series versions have a problem with provisioning that means we can't conditionally run certain provisioners in a specific order.

- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)

    I'm not aware of any specific version, though the current version would be a safe bet. ATTOW that's 5.1.18, which works fine with Vagrant 1.9.3

# Run using `make`

```
# Bring up the VMs but don't install the plugin.

    $ make up

# Install the plugin into VMs that are already up.

    $ make provision

# Safely reload the plugin, stopping Docker and Consul to make sure the old
# one has gone away. This is not to test the user upgrade experience,
# but to make testing easier.

    $ make refresh-plugin

# Destroy VMs.

    $ make destroy

# Restart from scratch and provision VMs with the plugin.

    $ make rebuild
```

# Running directly

```
# Install the Vagrant plugin for Alpine.

    $ vagrant plugin install vagrant-alpine

# Create the VMs.

    $ vagrant up
...time passes...

# Optional check for a working Consul cluster.

    $ vagrant provision --provision-with consul-rv
    ==> s-1: Running provisioner: consul-rv (shell)...
        s-1: Running: script: consul-rv
    ==> s-1: 	leader_addr = 172.28.128.29:8300
    ==> s-1: Consul cluster created
    ==> s-2: Running provisioner: consul-rv (shell)...
        s-2: Running: script: consul-rv
    ==> s-2: 	leader_addr = 172.28.128.29:8300
    ==> s-2: Consul cluster created
    ==> s-3: Running provisioner: consul-rv (shell)...
        s-3: Running: script: consul-rv
    ==> s-3: 	leader_addr = 172.28.128.29:8300
    ==> s-3: Consul cluster created

# Install the plugin now Consul is present.

    $ vagrant provision --provision-with storageos
    ==> s-1: Running provisioner: storageos (shell)...
        s-1: Running: script: storageos
    ==> s-1: starting storageos plugin on 172.28.128.29
    ==> s-1: 0.7.1: Pulling from storageos/plugin
    ==> s-1: 88766bb7d8a7: Verifying Checksum
    ==> s-1: 88766bb7d8a7: Download complete
    ==> s-1: Digest: sha256:ee8ad78429e3d16f075874900ec156a9addd050889371f258830427ceb6f60af
    ==> s-1: Status: Downloaded newer image for storageos/plugin:0.7.1
    ==> s-1: Installed plugin storageos/plugin:0.7.1
    ==> s-2: Running provisioner: storageos (shell)...
        s-2: Running: script: storageos
    ...etc...

# Hosts have Vagrant names s-1, s-2, ...

    $ vagrant ssh s-1

    Alpine Linux v3.4 (3.4.0) Development Environment
    ...
    storageos-1-17072:~$ stcli volume ls
    NAMESPACE/NAME      SIZE                MOUNTED BY          STATUS
```

Now do that StorageOS thing.
