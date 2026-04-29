describe command('/opt/chef/bin/chef-client --version') do
  its('exit_status') { should eq 0 }
end
