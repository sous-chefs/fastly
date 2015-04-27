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

class Chef
  class Provider
    class FastlyHeader < Chef::Provider::LWRPBase

      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        false
      end

      action :create do
        if header
          Chef::Log.info "#{ @new_resource } already exists - nothing to do."
        else
          create_header
          Chef::Log.info "#{ @new_resource } created."
          new_resource.updated_by_last_action(true)
        end
        action_update
      end

      action :update do

        unless header.request_condition == new_resource.request_condition
          header.request_condition = new_resource.request_condition
          header.save!
          Chef::Log.info "#{ @new_resource } request_condition updated."
          new_resource.updated_by_last_action(true)
        end

        unless header.response_condition == new_resource.response_condition
          header.response_condition = new_resource.response_condition
          header.save!
          Chef::Log.info "#{ @new_resource } response_condition updated."
          new_resource.updated_by_last_action(true)
        end

        unless header.cache_condition == new_resource.cache_condition
          header.cache_condition = new_resource.cache_condition
          header.save!
          Chef::Log.info "#{ @new_resource } cache_condition updated."
          new_resource.updated_by_last_action(true)
        end

        unless header.ignore_if_set == fastly_bool(new_resource.ignore_if_set)
          header.ignore_if_set = fastly_bool(new_resource.ignore_if_set)
          header.save!
          Chef::Log.info "#{ @new_resource } ignore_if_set updated."
          new_resource.updated_by_last_action(true)
        end

        unless header.action == new_resource.header_action
          header.action = new_resource.header_action
          header.save!
          Chef::Log.info "#{ @new_resource } header_action updated."
          new_resource.updated_by_last_action(true)
        end

        unless header.type == new_resource.type
          header.type = new_resource.type
          header.save!
          Chef::Log.info "#{ @new_resource } type updated."
          new_resource.updated_by_last_action(true)
        end

        unless header.dst == new_resource.dst
          header.dst = new_resource.dst
          header.save!
          Chef::Log.info "#{ @new_resource } dst updated."
          new_resource.updated_by_last_action(true)
        end

        unless header.src == new_resource.src
          header.src = new_resource.src
          header.save!
          Chef::Log.info "#{ @new_resource } src updated."
          new_resource.updated_by_last_action(true)
        end

        unless header.regexp == new_resource.regexp
          header.regexp = new_resource.regexp
          header.save!
          Chef::Log.info "#{ @new_resource } regexp updated."
          new_resource.updated_by_last_action(true)
        end

        unless header.substitution == new_resource.substitution
          header.substitution = new_resource.substitution
          header.save!
          Chef::Log.info "#{ @new_resource } substitution updated."
          new_resource.updated_by_last_action(true)
        end

        unless header.priority.to_i == new_resource.priority
          header.priority = new_resource.priority
          header.save!
          Chef::Log.info "#{ @new_resource } priority updated."
          new_resource.updated_by_last_action(true)
        end

      end

      def get_auth_hash
        if new_resource.username && new_resource.password
          return {username: new_resource.username, password: new_resource.password}
        end

        if new_resource.api_key
          return {api_key: new_resource.api_key}
        end

        fail "A username and password or api key must be set"
      end

      def fastly_client
        unless @fastly_client
          require 'fastly'
          @fastly_client = Fastly.new(get_auth_hash)
        end
        @fastly_client
      end

      def service
        @service = fastly_client.list_services.select { |svc| svc.name == new_resource.service }
        if @service.first
          @service.first
        else
          fail "The service does not exist"
        end
      end

      def header
        unless @header
          @header = fastly_client.list_headers(
            service_id: service.id,
            version: service.version.number,
          ).select { |b| b.name == new_resource.name }
          @header = @header.first
        end
        @header
      end

      def create_header
        fastly_client.create_header(
          service_id: service.id,
          version: service.version.number,
          name: new_resource.name,
          type: new_resource.type,
          dst: new_resource.dst
        )
      end

      def fastly_bool(bool)
        if bool == nil
          nil
        end

        if bool
          "1"
        else
          "0"
        end
      end

    end
  end
end
