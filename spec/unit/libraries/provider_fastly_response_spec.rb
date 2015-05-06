
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
require 'libraries/provider_fastly_response'
require 'libraries/resource_fastly_response'

describe Chef::Provider::FastlyResponse do
  before(:each) do
    @node = Chef::Node.new
    @events = Chef::EventDispatch::Dispatcher.new
    @run_context = Chef::RunContext.new(@node, {}, @events)

    @new_resource = Chef::Resource::FastlyResponse.new('an_response')

    @current_resource = Chef::Resource::FastlyResponse.new('an_response')

    @provider = Chef::Provider::FastlyResponse.new(@new_resource, @run_context)
    @provider.current_resource = @current_resource
  end

  describe '#resource' do
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
      allow(@provider.fastly_client).to receive(:list_response_objects) \
        .and_return([
          double(Fastly::ResponseObject, name: 'an_response'),
          double(Fastly::ResponseObject, name: 'another_response')
      ])
    end

    it 'returns response object if response name matches' do
      expect(@provider.response.name).to eq('an_response')
    end

    it 'returns nil if response is not found' do
      @new_resource.name('not-found')
      expect(@provider.response).to eq(nil)
    end
  end

  describe '#create_response' do
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

      allow(@provider.fastly_client).to receive(:create_response_object) \
        .and_return(double(Fastly::ResponseObject, name: 'an_response'))
    end

    it 'should return a response object when created' do
      expect(@provider.create_response.name).to eq('an_response')
    end
  end
end
