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
require 'libraries/provider_fastly_s3_logging'
require 'libraries/resource_fastly_s3_logging'

describe Chef::Provider::FastlyS3Logging do
  before(:each) do
    @node = Chef::Node.new
    @events = Chef::EventDispatch::Dispatcher.new
    @run_context = Chef::RunContext.new(@node, {}, @events)

    @new_resource = Chef::Resource::FastlyS3Logging.new('an_s3')

    @current_resource = Chef::Resource::FastlyS3Logging.new('an_s3')

    @provider = Chef::Provider::FastlyS3Logging.new(@new_resource, @run_context)
    @provider.current_resource = @current_resource
  end

  describe '#s3_logging' do
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

      allow(@provider.fastly_client).to receive(:list_s3_loggings) \
        .and_return([
          double(Fastly::S3Logging, name: 'an_s3'),
          double(Fastly::S3Logging, name: 'an_second_s3')
      ])
    end

    it 'returns an s3_logging object if s3_logging name matches' do
      expect(@provider.s3_logging.name).to eq('an_s3')
    end

    it 'returns nil if s3_logging is not found' do
      @new_resource.name('not-found')
      expect(@provider.s3_logging).to eq(nil)
    end
  end

  describe '#create_s3_logging' do
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

      allow(@provider.fastly_client).to receive(:create_s3_logging) \
        .and_return(double(Fastly::S3Logging, name: 'an_new_s3'))
    end

    it 'should return a s3_logging object when created' do
      expect(@provider.create_s3_logging.name).to eq('an_new_s3')
    end
  end
end
