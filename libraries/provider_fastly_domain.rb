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

require 'chef/provider/lwrp_base'
require_relative 'provider_fastly_base'

class Chef
  class Provider
    class FastlyDomain < Chef::Provider::FastlyBase
      action :create do
        if domain
          Chef::Log.info "#{@new_resource} already exists - nothing to do."
        else
          create_domain
          Chef::Log.info "#{@new_resource} created."
          new_resource.updated_by_last_action(true)
        end
      end

      def domain
        @domain = fastly_client.list_domains(
          service_id: service.id,
          version: service.version.number
        ).select { |d| d.name == new_resource.name }
        @domain.first
      end

      def create_domain
        fastly_client.create_domain(
          service_id: service.id,
          version: service.version.number,
          name: new_resource.name
        )
      end
    end
  end
end
