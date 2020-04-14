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
require 'libraries/provider_fastly_request_setting'
require 'libraries/resource_fastly_request_setting'

describe Chef::Provider::FastlyRequestSetting do
  before(:each) do
    @node = Chef::Node.new
    @events = Chef::EventDispatch::Dispatcher.new
    @run_context = Chef::RunContext.new(@node, {}, @events)

    @new_resource = Chef::Resource::FastlyRequestSetting.new('an_request_setting')

    @current_resource = Chef::Resource::FastlyRequestSetting.new('an_request_setting')

    @provider = Chef::Provider::FastlyRequestSetting.new(@new_resource, @run_context)
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
      @new_resource.service('service_name')

      allow(@provider.fastly_client).to receive(:list_services) \
        .and_return([
          double(Fastly::Service, name: 'service_name', id: '1234abc'),
          double(Fastly::Service, name: 'another_service', id: 'cba4321'),
        ])
    end

    it 'returns service object if service name exists' do
      expect(@provider.service.id).to eq('1234abc')
    end

    it 'throws an exception if no service is found' do
      @new_resource.service('not_found')
      expect { @provider.service }.to raise_error
    end
  end

  describe '#request_setting' do
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

      allow(@provider.fastly_client).to receive(:list_request_settings) \
        .and_return([
          double(Fastly::RequestSetting, name: 'an_request_setting'),
          double(Fastly::RequestSetting, name: 'an_second_setting'),
      ])
    end

    it 'returns request_setting object if request_setting name matches' do
      expect(@provider.request_setting.name).to eq('an_request_setting')
    end

    it 'returns nil if backend is not found' do
      @new_resource.name('not-found')
      expect(@provider.request_setting).to eq(nil)
    end
  end

  describe '#create_request_setting' do
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

      allow(@provider.fastly_client).to receive(:create_request_setting) \
        .and_return(double(Fastly::RequestSetting, name: 'an_new_request_setting'))
    end

    it 'should return a request_setting object when created' do
      expect(@provider.create_request_setting.name).to eq('an_new_request_setting')
    end
  end
end
