#
# Author:: Christopher Webber (<cwebber@chef.io>)
# Author:: Ryan Hass (<rhass@chef.io>)
# Copyright:: Copyright (c) 2017 Chef Software Inc.
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
    class FastlySyslogLogging < Chef::Resource::FastlyBase

      self.resource_name = :fastly_syslog_logging
      actions :create
      default_action :create

      attribute :response_condition, kind_of: String, default: ""
      attribute :hostname, kind_of: String, required: true
      attribute :port, kind_of: Integer, default: 514
      attribute :token, kind_of: String, default: nil
      attribute :format, kind_of: String, default: "%h %l %u %t %r %>s"
      attribute :message_type, kind_of: String, default: "classic", equal_to: ["classic", "loggly", "logplex", "blank"]
      attribute :use_tls, kind_of: [TrueClass, FalseClass], default: false
      attribute :tls_hostname, kind_of: String
      attribute :tls_cert, kind_of: String
    end
  end
end
