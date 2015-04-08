#
# Cookbook Name:: build-cookbook
# Library:: _helper
#
# Copyright (C) Chef Software, Inc. 2015
#

Chef::Resource.send(:include, Chef::Mixin::ShellOut)

def bundler_cache_dir
  File.join(
    node['delivery']['workspace']['root'],
    'bundler-cache'
  )
end

def load_data_bag_item(data_bag, item)
  dbag = Chef::DataBag.new
  dbag.name(data_bag)
  dbag.save
  dbag_data = Chef::JSONCompat.from_json(File.read(File.join(File.dirname(__FILE__), "..", "files", "data_bags", data_bag, "#{item}.json")))
  dbag_item = Chef::DataBagItem.new
  dbag_item.data_bag(data_bag)
  dbag_item.raw_data = dbag_data
  dbag_item.save
end

def make_link(url)
  "<a href=\"#{url}\">#{url}</a>"
end
