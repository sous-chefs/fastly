#
# Author:: Christopher Webber (<cwebber@chef.io>)
# Copyright:: Copyright (c) 2015 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'
require 'libraries/resource_fastly_domain'

describe Chef::Resource::FastlyDomain do

  before(:each) do
    @resource = Chef::Resource::FastlyDomain.new('domain.name')
  end

  it "should have the name set" do
    expect(@resource.name).to eq('domain.name')
  end

  it "should let you set the name string" do
    expect(@resource.name('domain.name')).to eq('domain.name')
  end

  it "should set the resource_name to :fastly_domain" do
    expect(@resource.resource_name).to eq(:fastly_domain)
  end

  it "should allow the username to be set" do
    expect(@resource.username('an_username')).to eq('an_username')
  end

  it "should allow the password to be set" do
    expect(@resource.password('an_password')).to eq('an_password')
  end

  it "should allow the api_key to be set" do
    expect(@resource.api_key('an_api_key')).to eq('an_api_key')
  end

  it "should allow the service to be set" do
    expect(@resource.api_key('service')).to eq('service')
  end

end
