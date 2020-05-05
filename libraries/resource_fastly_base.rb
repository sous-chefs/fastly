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

class Chef
  class Resource
    class FastlyBase < Chef::Resource::LWRPBase
      self.resource_name = :fastly_base
      actions :create
      default_action :create

      attribute :username, kind_of: String, default: nil
      attribute :password, kind_of: String, default: nil
      attribute :api_key, kind_of: String, default: nil
      attribute :service, kind_of: String, required: true
    end
  end
end
