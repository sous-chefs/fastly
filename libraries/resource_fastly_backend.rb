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

require 'chef/resource/lwrp_base'
require_relative 'resource_fastly_base'

class Chef
  class Resource
    class FastlyBackend < Chef::Resource::FastlyBase

      self.resource_name = :fastly_backend
      actions :create
      default_action :create

      attribute :request_condition, kind_of: String, default: ""
      attribute :service, kind_of: String, default: nil, required: true
      attribute :port, kind_of: Integer, default: 80
      attribute :ssl, kind_of: [TrueClass, FalseClass], default: false
      attribute :address, kind_of: String, name_attribute: true, required: true
      attribute :auto_loadbalance, kind_of: [TrueClass, FalseClass], default: false

    end
  end
end
