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
    class FastlyResponse < Chef::Provider::FastlyBase

      action :create do
        if response
          Chef::Log.info "#{ @new_resource } already exists - nothing to do."
        else
          create_response
          Chef::Log.info "#{ @new_resource } created."
          new_resource.updated_by_last_action(true)
        end
        action_update
      end

      action :update do

        unless response.status.to_i == new_resource.status
          response.status = new_resource.status
          response.save!
          Chef::Log.info "#{ @new_resource } status updated."
          new_resource.updated_by_last_action(true)
        end

        unless response.request_condition == new_resource.request_condition
          response.request_condition = new_resource.request_condition
          response.save!
          Chef::Log.info "#{ @new_resource } request_condition updated."
          new_resource.updated_by_last_action(true)
        end

        unless response.cache_condition == new_resource.cache_condition
          response.cache_condition = new_resource.cache_condition
          response.save!
          Chef::Log.info "#{ @new_resource } cache_condition updated."
          new_resource.updated_by_last_action(true)
        end

        unless response.content == new_resource.content
          response.content = new_resource.content
          response.save!
          Chef::Log.info "#{ @new_resource } content updated."
          new_resource.updated_by_last_action(true)
        end

        unless response.content_type == new_resource.content_type
          response.content_type = new_resource.content_type
          response.save!
          Chef::Log.info "#{ @new_resource } content_type updated."
          new_resource.updated_by_last_action(true)
        end

        unless response.response == new_resource.response
          response.response = new_resource.response
          response.save!
          Chef::Log.info "#{ @new_resource } response updated."
          new_resource.updated_by_last_action(true)
        end

      end

      def response
        unless @response
          @response = fastly_client.list_response_objects(
            service_id: service.id,
            version: service.version.number
          ).select { |b| b.name == new_resource.name }
          @response = @response.first
        end
        @response
      end

      def create_response
        fastly_client.create_response_object(
          service_id: service.id,
          version: service.version.number,
          name: new_resource.name,
        )
      end

    end
  end
end
