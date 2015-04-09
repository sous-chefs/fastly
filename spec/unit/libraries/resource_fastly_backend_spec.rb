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
require 'libraries/resource_fastly_backend'

describe Chef::Resource::FastlyBackend do

  before(:each) do
    @resource = Chef::Resource::FastlyBackend.new('backend.domain.name')
  end

  it "should have the name set" do
    expect(@resource.name).to eq('backend.domain.name')
  end

  it "should let you set the name string" do
    expect(@resource.name('new-backend.domain.name')).to eq('new-backend.domain.name')
  end

  it "should set the resource_name to :fastly_backend" do
    expect(@resource.resource_name).to eq(:fastly_backend)
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
    expect(@resource.service('service')).to eq('service')
  end

  it "should have port set to 80 by default" do
    expect(@resource.port).to eq(80)
  end

  it "should be able to set to a different port" do
    expect(@resource.port(443)).to eq(443)
  end

  it "should have ssl set to false to by default" do
    expect(@resource.ssl).to eq(false)
  end

  it "should be able to set ssl to true" do
    expect(@resource.ssl(true)).to eq(true)
  end

  it "should set address to name if no address is specified" do
    expect(@resource.address).to eq('backend.domain.name')
  end

  it "should set address if it is specified" do
    expect(@resource.address('backend-other.domain.name')).to eq('backend-other.domain.name')
  end

  it "should default to not seting up auto load balancing" do
    expect(@resource.auto_loadbalance).to eq(false)
  end

end
