require_relative '../spec_helper'

describe command('docker plugin ls') do
  its(:stdout) { should match /storageos:/ }
  its(:stdout) { should match /storageos:.*true$/ }
end
