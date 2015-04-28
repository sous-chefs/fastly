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
require 'libraries/provider_fastly_gzip'
require 'libraries/resource_fastly_gzip'

describe Chef::Provider::FastlyGzip do
  before(:each) do
    @node = Chef::Node.new
    @events = Chef::EventDispatch::Dispatcher.new
    @run_context = Chef::RunContext.new(@node, {}, @events)

    @new_resource = Chef::Resource::FastlyGzip.new('an_gzip')

    @current_resource = Chef::Resource::FastlyGzip.new('an_gzip')

    @provider = Chef::Provider::FastlyGzip.new(@new_resource, @run_context)
    @provider.current_resource = @current_resource
  end

  describe '#gzip' do
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
      allow(@provider.fastly_client).to receive(:list_gzips) \
        .and_return([
          double(Fastly::Gzip, name: 'an_gzip'),
          double(Fastly::Gzip, name: 'another_gzip'),
      ])
    end

    it 'returns gzip object if gzip name matches' do
      expect(@provider.gzip.name).to eq('an_gzip')
    end

    it 'returns nil if gzip is not found' do
      @new_resource.name('not-found.name')
      expect(@provider.gzip).to eq(nil)
    end
  end

  describe '#create_gzip' do
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

      allow(@provider.fastly_client).to receive(:create_gzip) \
        .and_return(double(Fastly::Gzip, name: 'an_gzip'))
    end

    it 'should return a gzip object when created' do
      expect(@provider.create_gzip.name).to eq('an_gzip')
    end
  end
end
