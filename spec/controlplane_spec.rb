require_relative '../spec_helper'

context "controlplane" do

  context "ports" do
    context "api" do
      describe port(5705) do
        it { should be_listening }
      end
    end
    context "nats" do
      describe port(4222) do
        it { should be_listening }
      end
      describe port(8222) do
        it { should be_listening }
      end
    end
    context "serf" do
      describe port(13700) do
        # TODO: check tcp & udp separately
        it { should be_listening }
      end
    end
  end

  context "state" do
    describe file('/var/lib/storageos') do
      it { should be_directory }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 755 }
    end
  end

  context "health" do
    context "kv" do
      describe command('curl http://localhost:5705/v1/health | jq -r -j .submodules.kv.status') do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should eq "alive" }
      end
    end
    context "kv_write" do
      describe command('curl http://localhost:5705/v1/health | jq -r -j .submodules.kv_write.status') do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should eq "alive" }
      end
    end
    context "nats" do
      describe command('curl http://localhost:5705/v1/health | jq -r -j .submodules.nats.status') do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should eq "alive" }
      end
    end
    context "scheduler" do
      describe command('curl http://localhost:5705/v1/health | jq -r -j .submodules.scheduler.status') do
        its(:exit_status) { should eq 0 }
        its(:stdout) { should eq "alive" }
      end
    end
  end

end
