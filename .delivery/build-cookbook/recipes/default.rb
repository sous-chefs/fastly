#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2015 Chef Software, Inc.

include_recipe 'chef-sugar::default'
include_recipe 'chef_handler::default'
include_recipe 'hipchat::default'

load_data_bag_item('creds', 'hipchat')

cookbook_file "hipchat.rb" do
  path File.join(node["chef_handler"]["handler_path"], 'hipchat.rb')
end.run_action(:create)

include_recipe 'build-cookbook::_handler'

chef_gem 'fastly' do
  action :install
end.run_action(:install)
