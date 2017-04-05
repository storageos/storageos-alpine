# andrelucas/storageos-alpine

Vagrant setup for running StorageOS (plugin) on Alpine Linux.

# Running

```
$ vagrant up
...time passes...
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
