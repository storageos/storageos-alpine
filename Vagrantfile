scripts = "script"
version = "0.7.1"

Vagrant.configure("2") do |config|
  config.vm.box = "maier/alpine-3.4-x86_64"
  # config.vm.network "private_network", type: "dhcp"

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.synced_folder '.', '/vagrant', disabled: true

  # Stage 1 - pre-requisites
  config.vm.provision "mcastroute", type: "shell", name: "install mcastroute", path: "#{scripts}/alpine-install-mcastroute", args: "eth0"
  config.vm.provision "docker", type: "shell", name: "install docker", path: "#{scripts}/alpine-install-docker"
  config.vm.provision "utils", type: "shell", name: "install test dependencies", path: "#{scripts}/install-serverspec"
  #config.vm.provision "consul", type: "shell", name: "start consul", path: "#{scripts}/run-consul", args: hostnames
  config.vm.provision "consul", type: "shell", name: "start consul", path: "#{scripts}/run-consul-single"
  config.vm.provision "stcli", type: "shell", name: "install stcli", path: "#{scripts}/install-stcli"

  config.vm.provision "storageos", run: "never", type: "shell", name: "start storageos", path: "#{scripts}/run-storageos-plugin", args: version

  config.vm.provision :serverspec, run: "never" do |spec|
    spec.pattern = '**/*_spec.rb'
  end

end
