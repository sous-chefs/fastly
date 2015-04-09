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
require 'libraries/resource_fastly_condition'

describe Chef::Resource::FastlyCondition do

  before(:each) do
    @resource = Chef::Resource::FastlyCondition.new('an_condition')
  end

  it "should have the name set" do
    expect(@resource.name).to eq('an_condition')
  end

  it "should let you set the name string" do
    expect(@resource.name('an_new_condition')).to eq('an_new_condition')
  end

  it "should set the resource_name to :fastly_condition" do
    expect(@resource.resource_name).to eq(:fastly_condition)
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

  it "should allow the statement to be set" do
    expect(@resource.statement('statement')).to eq('statement')
  end

  it "should allow the priority to be set" do
    expect(@resource.priority(20)).to eq(20)
  end

  it "should allow the type to be set to response" do
    expect(@resource.type('response')).to eq('response')
  end

  it "should allow the type to be set to cache" do
    expect(@resource.type('cache')).to eq('cache')
  end

  it "should allow the type to be set to request" do
    expect(@resource.type('request')).to eq('request')
  end

  it "should throw an exception if type is not valid" do
    expect {@resource.type('not_valid')}.to raise_error
  end

end
