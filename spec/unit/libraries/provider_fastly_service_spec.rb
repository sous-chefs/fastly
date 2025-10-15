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
require 'libraries/provider_fastly_service'
require 'libraries/resource_fastly_service'

describe Chef::Provider::FastlyService do
  before(:each) do
    @node = Chef::Node.new
    @events = Chef::EventDispatch::Dispatcher.new
    @run_context = Chef::RunContext.new(@node, {}, @events)

    @new_resource = Chef::Resource::FastlyService.new('service_name')

    @current_resource = Chef::Resource::FastlyService.new('service_name')

    @provider = Chef::Provider::FastlyService.new(@new_resource, @run_context)
    @provider.current_resource = @current_resource
  end

  describe '#get_auth_hash' do
    it 'returns a hash of the username and password when they are set' do
      @new_resource.username('an_username')
      @new_resource.password('an_password')
      expect(@provider.get_auth_hash).to eq({ username: 'an_username', password: 'an_password' })
    end

    it 'returns a hash of the api_key when it is set and username and password are not' do
      @new_resource.api_key('an_api_key')
      expect(@provider.get_auth_hash).to eq({ api_key: 'an_api_key' })
    end

    it 'should raise an exception if nothing is set' do
      expect { @provider.get_auth_hash }.to raise_error
    end
  end

  describe '#fastly_client' do
    it 'returns a Fastly object' do
      @new_resource.api_key('an_api_key')
      expect(@provider.fastly_client.class).to eq(Fastly)
    end
  end

  describe '#service' do
    before(:each) do
      @new_resource.api_key('an_api_key')

      allow(@provider.fastly_client).to receive(:list_services) \
        .and_return([
                      double(Fastly::Service, name: 'service_name', service_id: '1234abc'),
                      double(Fastly::Service, name: 'another_service', service_id: 'cba4321'),
                    ])
    end

    it 'returns service object if service name exists' do
      expect(@provider.service.service_id).to eq('1234abc')
    end

    it 'returns nil if no service is found' do
      @new_resource.name('not_found')
      expect(@provider.service).to eq(nil)
    end
  end

  describe '#create_service' do
    before(:each) do
      @new_resource.api_key('an_api_key')
      allow(@provider.fastly_client).to receive(:create_service) \
        .and_return(double(Fastly::Service, name: 'new_service', service_id: '9999zzz'))
    end

    it 'should return a fastly service' do
      @new_resource.name('new_service')
      new_service = @provider.create_service
      expect(new_service.name).to eq('new_service')
    end
  end
end
