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
require 'libraries/provider_fastly_acl'
require 'libraries/resource_fastly_acl'

describe Chef::Provider::FastlyACL do
  before(:each) do
    @node = Chef::Node.new
    @events = Chef::EventDispatch::Dispatcher.new
    @run_context = Chef::RunContext.new(@node, {}, @events)
    @new_resource = Chef::Resource::FastlyACL.new('acl_name')
    @current_resource = Chef::Resource::FastlyACL.new('acl_name')
    @provider = Chef::Provider::FastlyACL.new(@new_resource, @run_context)
    @provider.current_resource = @current_resource
  end

  describe '#acl' do
    before(:each) do
      @new_resource.api_key('an_api_key')
      @new_resource.service('service_name')

      allow(@provider.fastly_client).to receive(:list_services) \
        .and_return([
          double(Fastly::Service,
           name: 'service_name',
           id: '1234abc',
           version: double(Fastly::Version, number: 10)
          ),
          double(Fastly::Service, name: 'another_service', id: 'cba4321'),
        ])
    end

    it 'returns acl object if acl name matches' do
      allow(@provider.fastly_client).to receive(:get_acl) \
        .and_return(double(Fastly::ACL, name: 'acl_group'))

      @new_resource.name('acl_group')
      expect(@provider.acl.name).to eq('acl_group')
    end

    it 'returns nil if acl is not found' do
      allow(@provider.fastly_client).to receive(:get_acl) \
        .and_raise(Fastly::Error, message: 'Record not found')

      @new_resource.name('not-found')
      expect(@provider.acl).to be_nil
    end
  end
end
