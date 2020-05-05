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

require 'chef/provider/lwrp_base'
require_relative 'provider_fastly_base'

class Chef
  class Provider
    class FastlyHealthcheck < Chef::Provider::FastlyBase
      action :create do
        if healthcheck
          Chef::Log.info "#{@new_resource} already exists - nothing to do."
        else
          create_healthcheck
          Chef::Log.info "#{@new_resource} created."
          new_resource.updated_by_last_action(true)
        end
        action_update
      end

      action :update do
        [
          :comment,
          :path,
          :host,
          :http_version,
          :timeout,
          :window,
          :threshold,
          :http_method,
          :expected_response,
          :initial,
          :check_interval,
        ].each do |property|
          fastly_property = if property == :http_method
                              :method
                            else
                              property
                            end

          next if healthcheck.send(fastly_property) == new_resource.send(property)
          healthcheck.send("#{fastly_property}=", new_resource.send(property))
          healthcheck.save!
          Chef::Log.info "#{@new_resource} #{property} updated."
          new_resource.updated_by_last_action(true)
        end
      end

      def healthcheck
        @healthcheck ||= begin
          fastly_client.list_healthchecks(
            service_id: service.id,
            version: service.version.number
          ).select { |b| b.name == new_resource.name }.first
        end
      end

      def create_healthcheck
        fastly_client.create_healthcheck(
          service_id: service.id,
          version: service.version.number,
          name: new_resource.name
        )
      end
    end
  end
end
