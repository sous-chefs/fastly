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
require 'libraries/resource_fastly_healthcheck'

describe Chef::Resource::FastlyHealthcheck do

  let(:resource) { Chef::Resource::FastlyHealthcheck.new('an_healthcheck') }

  {
    name: 'an_healthcheck',
    comment: 'random comment',
    path: '/_status' ,
    host: 'origin.mysite.com',
    http_version: "1.0",
    timeout: 600,
    window: 10,
    threshold: 6,
    http_method: "HEAD",
    expected_response: 301,
    initial: 4,
    check_interval: 10000,
  }.each do |property_name, expected_value|
    it "should let you set the name string" do
      expect(resource.send(property_name, expected_value)).to eq(expected_value)
    end
  end
end
