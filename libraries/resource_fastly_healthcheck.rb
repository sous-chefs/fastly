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

require 'chef/resource/lwrp_base'
require_relative 'resource_fastly_base'

class Chef
  class Resource
    class FastlyHealthcheck < Chef::Resource::FastlyBase

      self.resource_name = :fastly_healthcheck
      actions :create
      default_action :create

      attribute :comment, kind_of: String, default: nil
      attribute :path, kind_of: String, required: true
      attribute :host, kind_of: String, required: true
      attribute :http_version, kind_of: String, default: "1.1"
      attribute :timeout, kind_of: Integer, default: 500
      attribute :window, kind_of: Integer, default: 5
      attribute :threshold, kind_of: Integer, default: 3
      attribute :method, kind_of: String, default: "GET"
      attribute :expected_response, kind_of: Integer, default: 200
      attribute :initial, kind_of: Integer, default: 2
      attribute :check_interval, kind_of: Integer, default: 5000
    end
  end
end
