#
# Author:: Patrick Wright (<patrick@chef.io>)
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
    class FastlyACL < Chef::Resource::FastlyBase
      self.resource_name = :fastly_acl
      actions :create
      default_action :create

      attribute :entries, kind_of: Array, required: true, callbacks: {
        'entries must be an array of valid ip addresses as strings' => proc do |entries|
          entries.all? { |entry| (entry.is_a?(String) && valid_ip?(entry)) }
        end,
      }

      def self.valid_ip?(ip)
        ip =~ /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
      end
    end
  end
end
