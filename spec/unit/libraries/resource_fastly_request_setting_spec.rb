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
require 'libraries/resource_fastly_request_setting'

describe Chef::Resource::FastlyRequestSetting do

  before(:each) do
    @resource = Chef::Resource::FastlyRequestSetting.new('an_request_setting')
  end

  it "should have the name set" do
    expect(@resource.name).to eq('an_request_setting')
  end

  it "should let you set the name string" do
    expect(@resource.name('an_new_request_setting')).to eq('an_new_request_setting')
  end

  it "should set the resource_name to :fastly_request_setting" do
    expect(@resource.resource_name).to eq(:fastly_request_setting)
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

  it "should allow force_miss to be set to true" do
    expect(@resource.force_miss(true)).to eq(true)
  end

  it "should allow force_miss to be set to false" do
    expect(@resource.force_miss(false)).to eq(false)
  end

  it "should throw an exception if force_miss is not valid" do
    expect {@resource.force_miss('not_valid')}.to raise_error
  end

  it "should allow force_ssl to be set to true" do
    expect(@resource.force_ssl(true)).to eq(true)
  end

  it "should allow force_ssl to be set to false" do
    expect(@resource.force_ssl(false)).to eq(false)
  end

  it "should throw an exception if force_ssl is not valid" do
    expect {@resource.force_ssl('not_valid')}.to raise_error
  end

  it "should allow bypass_busy_wait to be set to true" do
    expect(@resource.bypass_busy_wait(true)).to eq(true)
  end

  it "should allow bypass_busy_wait to be set to false" do
    expect(@resource.bypass_busy_wait(false)).to eq(false)
  end

  it "should throw an exception if bypass_busy_wait is not valid" do
    expect {@resource.bypass_busy_wait('not_valid')}.to raise_error
  end

  it "should allow request_action to be set to pass" do
    expect(@resource.request_action('pass')).to eq('pass')
  end

  it "should allow request_action to be set to lookup" do
    expect(@resource.request_action('lookup')).to eq('lookup')
  end

  it "should throw an exception if request_action is not valid" do
    expect {@resource.request_action('not_valid')}.to raise_error
  end

  it "should allow max_stale_age to be set" do
    expect(@resource.max_stale_age(60)).to eq(60)
  end

  it "should allow hash_keys to be set" do
    expect(@resource.hash_keys('http.url')).to eq('http.url')
  end
 
  it "should allow x_forwarded_for to be set to clear" do
    expect(@resource.x_forwarded_for('clear')).to eq('clear')
  end

  it "should allow x_forwarded_for to be set to leave" do
    expect(@resource.x_forwarded_for('leave')).to eq('leave')
  end

  it "should allow x_forwarded_for to be set to append" do
    expect(@resource.x_forwarded_for('append')).to eq('append')
  end

  it "should allow x_forwarded_for to be set to append_all" do
    expect(@resource.x_forwarded_for('append_all')).to eq('append_all')
  end

  it "should allow x_forwarded_for to be set to overwrite" do
    expect(@resource.x_forwarded_for('overwrite')).to eq('overwrite')
  end

  it "should throw an exception if x_forwarded_for isnt valid" do
    expect {@resource.x_forwarded_for('not_valid')}.to raise_error
  end

  it "should allow default_host to be set" do
    expect(@resource.default_host('hostname')).to eq('hostname')
  end

  it "should set request condition if it is specified" do
    expect(@resource.request_condition('an_condition')).to eq('an_condition')
  end
end
