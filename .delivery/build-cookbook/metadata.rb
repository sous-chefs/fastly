name             'build-cookbook'
maintainer       'Corporate Infrastructure and Security - Chef Software, Inc.'
maintainer_email 'cia@chef.io'
license          'Apache-2.0'
description      'Build Cookbook for the fastly cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

depends 'delivery-truck'
depends 'chef-sugar'

gem 'fastly'
