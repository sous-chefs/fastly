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
    class FastlyCacheSetting < Chef::Provider::LWRPBase

      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        false
      end

      action :create do
        if cache_setting
          Chef::Log.info "#{ @new_resource } already exists - nothing to do."
        else
          create_cache_setting
          Chef::Log.info "#{ @new_resource } created."
          new_resource.updated_by_last_action(true)
        end
        action_update
      end

      action :update do

        unless cache_setting.cache_condition == new_resource.cache_condition
          cache_setting.cache_condition = new_resource.cache_condition
          cache_setting.save!
          Chef::Log.info "#{ @new_resource } cache_condition updated."
          new_resource.updated_by_last_action(true)
        end

        unless cache_setting.ttl.to_i == new_resource.ttl
          cache_setting.ttl = new_resource.ttl
          cache_setting.save!
          Chef::Log.info "#{ @new_resource } ttl updated."
          new_resource.updated_by_last_action(true)
        end

        unless cache_setting.stale_ttl.to_i == new_resource.stale_ttl
          cache_setting.stale_ttl = new_resource.stale_ttl
          cache_setting.save!
          Chef::Log.info "#{ @new_resource } stale_ttl updated."
          new_resource.updated_by_last_action(true)
        end

        unless cache_setting.action == new_resource.cache_action
          cache_setting.action = new_resource.cache_action
          cache_setting.save!
          Chef::Log.info "#{ @new_resource } cache_action updated."
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

      def cache_setting
        unless @cache_setting
          @cache_setting = fastly_client.list_cache_settings(
            service_id: service.id,
            version: service.version.number
          ).select { |b| b.name == new_resource.name }
          @cache_setting = @cache_setting.first
        end
        @cache_setting
      end

      def create_cache_setting
        fastly_client.create_cache_setting(
          service_id: service.id,
          version: service.version.number,
          name: new_resource.name,
        )
      end

    end
  end
end
