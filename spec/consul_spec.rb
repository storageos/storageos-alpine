require_relative '../spec_helper'

describe docker_container('consul') do
  it { should exist }
  it { should be_running }
end

describe port(8301) do
  it { should be_listening.with('tcp') }
end
describe port(8400) do
  it { should be_listening.with('tcp6') }
end
describe port(8500) do
  it { should be_listening.with('tcp6') }
end
describe port(8600) do
  it { should be_listening.with('tcp6') }
end

describe command("docker exec -t consul consul members") do
  its(:stdout) { should match /alive/ }
end

describe command("docker exec -t consul consul info") do
  its(:stdout) { should match /server = true/ }
  its(:stdout) { should match /failed = 0/ }
  its(:stdout) { should_not match /failed = [1-9]/ } # there are 2 instances of failed, make sure neither > 0
  its(:stdout) { should match /state = [Leader|Follower]/ }
  its(:stdout) { should_not match /state = Candidate/ }
end
