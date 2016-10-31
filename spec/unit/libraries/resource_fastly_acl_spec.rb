#
# Author:: Patrick Wright (<patrick@chef.io>)
# Copyright:: Copyright (c) 2016 Chef Software, Inc.
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
require 'libraries/resource_fastly_acl'

describe Chef::Resource::FastlyACL do

  before(:each) do
    @resource = Chef::Resource::FastlyACL.new('acl_name')
  end

  it "should set the entries" do
    expect(@resource.entries(['1.2.3.4'])).to eq(['1.2.3.4'])
  end

  it 'should raise validation error when not passed an array' do
    expect { @resource.entries('foo') }.to raise_error Chef::Exceptions::ValidationFailed
  end

  it 'should raise validation error when not passed valid string in the array' do
    expect { @resource.entries([1]) }.to raise_error Chef::Exceptions::ValidationFailed
  end

  it 'should raise validation error when not passed a valid ip' do
    expect { @resource.entries(['256.0.0.0']) }.to raise_error Chef::Exceptions::ValidationFailed
  end

end
