#
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
require 'libraries/provider_fastly_healthcheck'
require 'libraries/resource_fastly_healthcheck'

describe Chef::Provider::FastlyHealthcheck do

  let(:node) { stub_node(platform: 'ubuntu', version: '12.04') }
  let(:run_context) { Chef::RunContext.new(node, {}, nil) }

  let(:resource) do
    r = Chef::Resource::FastlyHealthcheck.new('an_healthcheck', run_context)
    r.api_key('an_api_key')
    r.service('service_name')
    r
  end

  let(:provider) { Chef::Provider::FastlyHealthcheck.new(resource, run_context) }

  before(:each) do
    allow(provider.fastly_client).to receive(:list_services) \
      .and_return([
        double(Fastly::Service,
         name: 'service_name',
         id: '1234abc',
         version: double(Fastly::Version, number: 10)
        ),
        double(Fastly::Service, name: 'another_service', id: 'cba4321'),
    ])
  end

  describe '#healthcheck' do
    before(:each) do
      allow(provider.fastly_client).to receive(:list_healthchecks) \
        .and_return([
          double(Fastly::Healthcheck, name: 'an_healthcheck'),
          double(Fastly::Healthcheck, name: 'an_second_healthcheck')
      ])
    end

    it 'returns a healthcheck object if healthcheck name matches' do
      expect(provider.new_resource.name).to eq('an_healthcheck')
    end

    it 'returns nil if healthcheck is not found' do
      resource.name('not-found')
      expect(provider.healthcheck).to eq(nil)
    end
  end

  describe '#create_healthcheck' do
    before(:each) do
      allow(provider.fastly_client).to receive(:create_healthcheck) \
        .and_return(double(Fastly::Healthcheck, name: 'an_new_healthcheck'))
    end

    it 'should return a healthcheck object when created' do
      expect(provider.create_healthcheck.name).to eq('an_new_healthcheck')
    end
  end
end
