require_relative '../spec_helper'

describe package('docker-engine') do
  it { should be_installed }
end

describe service('docker') do
  it { should be_enabled }
  it { should be_running }
end

describe group('docker') do
  it { should exist }
end

describe file('/var/run/docker.sock') do
  it { should be_socket }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'docker' }
end
