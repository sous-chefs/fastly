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
require 'libraries/resource_fastly_gzip'

describe Chef::Resource::FastlyGzip do
  before(:each) do
    @resource = Chef::Resource::FastlyGzip.new('an_gzip')
  end

  it 'should set the resource_name to :fastly_gzip' do
    expect(@resource.resource_name).to eq(:fastly_gzip)
  end

  it 'should be able to set extensions' do
    expect(@resource.extensions('js html css')).to eq('js html css')
  end

  it 'should be able to set content_types' do
    expect(@resource.content_types('text/html application/x-javascript')).to \
      eq('text/html application/x-javascript')
  end

  it 'should be able to set cache_condition' do
    expect(@resource.cache_condition('an_condition')).to eq('an_condition')
  end
end
