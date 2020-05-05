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
require 'libraries/resource_fastly_response'

describe Chef::Resource::FastlyResponse do
  before(:each) do
    @resource = Chef::Resource::FastlyResponse.new('an_response')
  end

  it 'should set the resource_name to :fastly_response' do
    expect(@resource.resource_name).to eq(:fastly_response)
  end

  it 'should allow the request_condition to be set' do
    expect(@resource.request_condition('an_request_condition')).to eq('an_request_condition')
  end

  it 'should allow the cache_condition to be set' do
    expect(@resource.cache_condition('an_cache_condition')).to eq('an_cache_condition')
  end

  it 'should allow the status to be set' do
    expect(@resource.status(404)).to eq(404)
  end

  it 'should allow the content to be set' do
    expect(@resource.content('some_html')).to eq('some_html')
  end

  it 'should allow the content-type to be set' do
    expect(@resource.content_type('text/plain')).to eq('text/plain')
  end

  it 'should allow the response to be set' do
    expect(@resource.response('OK')).to eq('OK')
  end
end
