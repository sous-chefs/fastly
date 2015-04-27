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
    class FastlyHeader < Chef::Resource::FastlyBase

      self.resource_name = :fastly_header
      actions :create
      default_action :create

      attribute :request_condition, kind_of: String, default: ""
      attribute :cache_condition, kind_of: String, default: ""
      attribute :response_condition, kind_of: String, default: ""
      attribute :header_action, kind_of: String, default: nil, equal_to: [
        'set',
        'append',
        'delete',
        'regex',
        'regex_repeat'
      ]
      attribute :ignore_if_set, kind_of: [TrueClass, FalseClass], default: false
      attribute :type, kind_of: String, default: nil, required: true, equal_to: [
        'request',
        'cache',
        'fetch',
        'response'
      ]
      attribute :dst, kind_of: String, default: nil, required: true
      attribute :src, kind_of: String, default: nil
      attribute :regexp, kind_of: String, default: nil
      attribute :substitution, kind_of: String, default: ""
      attribute :priority, kind_of: Integer, default: nil

    end
  end
end
