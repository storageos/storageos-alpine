# -*- mode: ruby -*-
# vi: set ft=ruby :
#
#
require "./lib/random.rb"
include Randomize

version = (ENV['VERSION'] || '0.7.1')

nodes = 3
scripts = "script"

random = Randomize::digits
vmnames = nodes.times.collect { |n| "s-#{n+1}" }
hostnames = nodes.times.collect { |n| "storageos-#{n + 1}-#{random}" }
vm_to_host = Hash[vmnames.zip(hostnames)]


Vagrant.configure("2") do |config|
  config.vm.box = "maier/alpine-3.4-x86_64"
  config.vm.network "private_network", type: "dhcp"

  vmnames.each do |vmname|
    config.vm.define vmname do |node|
      node.vm.hostname = vm_to_host[vmname]
    end
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.synced_folder '.', '/vagrant', disabled: true

  # Stage 0 - fix box.
  config.vm.provision "alpinebox", type: "shell", name: "fixup box", path: "#{scripts}/alpine-box-fixup"

  # Stage 1 - pre-requisites
  config.vm.provision "mcastroute", type: "shell", name: "install mcastroute", path: "#{scripts}/alpine-install-mcastroute", args: "eth1"
  config.vm.provision "docker", type: "shell", name: "install docker", path: "#{scripts}/alpine-install-docker"
  # config.vm.provision "utils", type: "shell", name: "install test dependencies", path: "#{scripts}/install-serverspec"
  config.vm.provision "consul", type: "shell", name: "start consul", path: "#{scripts}/run-consul", args: hostnames
  # config.vm.provision "consul", type: "shell", name: "start consul", path: "#{scripts}/run-consul-single"
  config.vm.provision "stcli", type: "shell", name: "install stcli", path: "#{scripts}/install-stcli"

  config.vm.provision "consul-rv", type: "shell", run: "never" do |s|
    s.name = "consul-rv"
    s.path = "#{scripts}/consul-rv"
  end
  config.vm.provision "storageos", type: "shell", run: "never" do |s|
    s.name = "storageos"
    s.path = "#{scripts}/run-storageos-plugin"
    s.args = version
  end

  # config.vm.provision :serverspec, run: "never" do |spec|
  #   spec.pattern = '**/*_spec.rb'
  # end

end
