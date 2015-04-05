#
# Cookbook Name:: fastly
# Recipe:: default
#
# Copyright (c) 2015 Chef Software, Inc.

chef_gem 'fastly' do
  action :install
end.run_action(:install)
