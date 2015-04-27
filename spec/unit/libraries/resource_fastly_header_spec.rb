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
require 'libraries/resource_fastly_header'

describe Chef::Resource::FastlyHeader do

  before(:each) do
    @resource = Chef::Resource::FastlyHeader.new('an_header')
  end

  it "should have the name set" do
    expect(@resource.name).to eq('an_header')
  end

  it "should let you set the name string" do
    expect(@resource.name('an_new_header')).to eq('an_new_header')
  end

  it "should set the resource_name to :fastly_header" do
    expect(@resource.resource_name).to eq(:fastly_header)
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

  it "should be able to set request_condition" do
    expect(@resource.request_condition('an_request_condition')).to eq('an_request_condition')
  end

  it "should be able to set cache_condition" do
    expect(@resource.cache_condition('an_cache_condition')).to eq('an_cache_condition')
  end

  it "should be able to set response_condition" do
    expect(@resource.response_condition('an_response_condition')).to eq('an_response_condition')
  end

  it "should be able to set header_action to set" do
    expect(@resource.header_action('set')).to eq('set')
  end

  it "should be able to set header_action to append" do
    expect(@resource.header_action('append')).to eq('append')
  end

  it "should be able to set header_action to delete" do
    expect(@resource.header_action('delete')).to eq('delete')
  end

  it "should be able to set header_action to regex" do
    expect(@resource.header_action('regex')).to eq('regex')
  end

  it "should be able to set header_action to regex_repeat" do
    expect(@resource.header_action('regex_repeat')).to eq('regex_repeat')
  end

  it "should raise an exception if header_action is not valid" do
    expect {@resource.header_action('not_valid')}.to raise_error
  end

  it "should be able to set ignore_if_set if set to true" do
    expect(@resource.ignore_if_set(true)).to eq(true)
  end

  it "should be able to set ignore_if_set if set to false" do
    expect(@resource.ignore_if_set(false)).to eq(false)
  end

  it "should allow type to be request" do
    expect(@resource.type('request')).to eq('request')
  end

  it "should allow type to be fetch" do
    expect(@resource.type('fetch')).to eq('fetch')
  end
  
  it "should allow type to be cache" do
    expect(@resource.type('cache')).to eq('cache')
  end
  
  it "should allow type to be response" do
    expect(@resource.type('response')).to eq('response')
  end

  it "should throw an error if type is not valid" do
    expect {@resource.type('not_valid')}.to raise_error
  end

  it "should allow dst to be set" do
    expect(@resource.dst('an_header')).to eq('an_header')
  end

  it "should allow src to be set" do
    expect(@resource.src('an_value')).to eq('an_value')
  end

  it "should allow regexp to be set" do
    expect(@resource.regexp('an_regex')).to eq('an_regex')
  end

  it "should allow substitution to be set" do
    expect(@resource.substitution('an_substitution')).to eq('an_substitution')
  end

  it "should allow priority to be set" do
    expect(@resource.priority(10)).to eq(10)
  end

end
