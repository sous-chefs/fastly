#
# Cookbook Name:: build-cookbook
# Recipe:: default
#
# Copyright (c) 2015 Chef Software, Inc.

include_recipe 'chef-sugar::default'

load_data_bag_item('creds', 'supermarket')

chef_gem 'fastly' do
  action :install
end
