require_relative '../spec_helper'

context "dataplane" do

  context "ports" do
    context "stats" do
      describe port(8999) do
        it { should be_listening }
      end
    end
    context "directfs server" do
      describe port(17100) do
        it { should be_listening }
      end
    end
  end

  context "processes" do
    context "director" do
      describe process("storageos-director") do
        it { should be_running }
        its(:user) { should eq "root" }
      end
    end
    context "fuse" do
      describe process("storageos-fs-director") do
        it { should be_running }
        its(:user) { should eq "root" }
        its(:args) { should match /\/var\/lib\/storageos\/volumes/ }
      end
    end
    context "directfs server" do
      describe process("server") do
        it { should be_running }
        its(:user) { should eq "root" }
      end
    end
    context "directfs client" do
      describe process("client") do
        it { should be_running }
        its(:user) { should eq "root" }
      end
    end
    context "rdb plugin" do
      describe process("storageos-rdbplugin") do
        it { should be_running }
        its(:user) { should eq "root" }
        its(:args) { should match /\/var\/lib\/storageos\/data/ }
      end
    end
  end

  context "stats" do
    context "rw" do
      describe command('curl -s http://localhost:8999/rwstats') do
        its(:exit_status) { should eq 0 }
        # TODO - check output (currently empty?)
      end
    end
  end

  context "health" do
    context "directfs-client" do
      describe command('curl -s http://localhost:8001/v1/health | jq -r -j .submodules.\"directfs-client\".status') do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should match /alive|starting/  }
      end
    end
    context "directfs-server" do
      describe command('curl -s http://localhost:8001/v1/health | jq -r -j .submodules.\"directfs-server\".status') do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should eq "alive" }
      end
    end
    context "director" do
      describe command('curl -s http://localhost:8001/v1/health | jq -r -j .submodules.director.status') do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should eq "alive" }
      end
    end
    context "filesystem-driver" do
      describe command('curl -s http://localhost:8001/v1/health | jq -r -j .submodules.\"filesystem-driver\".status') do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should eq "alive" }
      end
    end
    context "fs" do
      describe command('curl -s http://localhost:8001/v1/health | jq -r -j .submodules.fs.status') do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should eq "alive" }
      end
    end
  end

end
