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
require 'libraries/resource_fastly_s3_logging'

describe Chef::Resource::FastlyS3Logging do

  before(:each) do
    @resource = Chef::Resource::FastlyS3Logging.new('an_s3')
  end

  it "should have the name set" do
    expect(@resource.name).to eq('an_s3')
  end

  it "should let you set the name string" do
    expect(@resource.name('an_new_s3')).to eq('an_new_s3')
  end

  it "should set the resource_name to :fastly_s3_logging" do
    expect(@resource.resource_name).to eq(:fastly_s3_logging)
  end

  it "should allow bucket_name to be set" do
    expect(@resource.bucket_name('an_bucket')).to eq('an_bucket')
  end

  it "should allow access_key to be set" do
    expect(@resource.access_key('an_access_key')).to eq('an_access_key')
  end

  it "should allow secret_key to be set" do
    expect(@resource.secret_key('an_secret_key')).to eq('an_secret_key')
  end

  it "should allow path to be set" do
    expect(@resource.path('/an/path')).to eq('/an/path')
  end

  it "should allow period to be set" do
    expect(@resource.period(60)).to eq(60)
  end

  it "should allow gzip_level to be set" do
    expect(@resource.gzip_level(9)).to eq(9)
  end

  it "should allow format to be set" do
    expect(@resource.format('an_format')).to eq('an_format')
  end

  it "should set response condition if it is specified" do
    expect(@resource.response_condition('an_condition')).to eq('an_condition')
  end
end
