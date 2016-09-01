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
    class FastlyBackend < Chef::Provider::FastlyBase

      action :create do
        if backend
          Chef::Log.info "#{ @new_resource } already exists - nothing to do."
        else
          create_backend
          Chef::Log.info "#{ @new_resource } created."
          new_resource.updated_by_last_action(true)
        end
        action_update
      end

      action :update do

        unless backend.address == new_resource.address
          backend.address = new_resource.address
          backend.save!
          Chef::Log.info "#{ @new_resource } address updated."
          new_resource.updated_by_last_action(true)
        end

        unless backend.request_condition == new_resource.request_condition
          backend.request_condition = new_resource.request_condition
          backend.save!
          Chef::Log.info "#{ @new_resource } request_condition updated."
          new_resource.updated_by_last_action(true)
        end

        unless backend.port == new_resource.port
          backend.port = new_resource.port
          backend.save!
          Chef::Log.info "#{ @new_resource } port updated."
          new_resource.updated_by_last_action(true)
        end

        unless backend.use_ssl == new_resource.ssl
          backend.use_ssl = new_resource.ssl
          backend.save!
          Chef::Log.info "#{ @new_resource } ssl updated."
          new_resource.updated_by_last_action(true)
        end

        unless backend.auto_loadbalance == new_resource.auto_loadbalance
          backend.auto_loadbalance = new_resource.auto_loadbalance
          fastly_client.update_backend(backend)
          backend.save!
          Chef::Log.info "#{ @new_resource } auto_loadbalance updated."
          new_resource.updated_by_last_action(true)
        end

        unless backend.shield == new_resource.shield
          backend.shield = new_resource.shield
          fastly_client.update_backend(backend)
          backend.save!
          Chef::Log.info "#{ @new_resource } shield updated."
          new_resource.updated_by_last_action(true)
        end

        unless backend.healthcheck == new_resource.healthcheck
          backend.healthcheck = new_resource.healthcheck
          fastly_client.update_backend(backend)
          backend.save!
          Chef::Log.info "#{ @new_resource } healthcheck updated."
          new_resource.updated_by_last_action(true)
        end
      end

      def backend
        unless @backend
          @backend = fastly_client.list_backends(
            service_id: service.id,
            version: service.version.number
          ).select { |b| b.name == new_resource.name }
          @backend = @backend.first
        end
        @backend
      end

      def create_backend
        fastly_client.create_backend(
          service_id: service.id,
          version: service.version.number,
          name: new_resource.name,
          address: new_resource.address
        )
      end

    end
  end
end
