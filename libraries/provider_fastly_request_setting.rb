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
    class FastlyRequestSetting < Chef::Provider::LWRPBase

      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        false
      end

      action :create do
        if request_setting
          Chef::Log.info "#{ @new_resource } already exists - nothing to do."
        else
          create_request_setting
          Chef::Log.info "#{ @new_resource } created."
          new_resource.updated_by_last_action(true)
        end
        action_update
      end

      action :update do

        unless request_setting.force_ssl == fastly_bool(new_resource.force_ssl)
          request_setting.force_ssl = fastly_bool(new_resource.force_ssl)
          request_setting.save!
          Chef::Log.info "#{ @new_resource } force_ssl updated."
          new_resource.updated_by_last_action(true)
        end

        unless request_setting.request_condition == new_resource.request_condition
          request_setting.request_condition = new_resource.request_condition
          request_setting.save!
          Chef::Log.info "#{ @new_resource } request_condition updated."
          new_resource.updated_by_last_action(true)
        end

        unless request_setting.force_miss == fastly_bool(new_resource.force_miss)
          request_setting.force_miss = fastly_bool(new_resource.force_miss)
          request_setting.save!
          Chef::Log.info "#{ @new_resource } force_miss updated."
          new_resource.updated_by_last_action(true)
        end

        unless request_setting.bypass_busy_wait == fastly_bool(new_resource.bypass_busy_wait)
          request_setting.bypass_busy_wait = fastly_bool(new_resource.bypass_busy_wait)
          request_setting.save!
          Chef::Log.info "#{ @new_resource } bypass_busy_wait updated."
          new_resource.updated_by_last_action(true)
        end

        unless request_setting.default_host == new_resource.default_host
          request_setting.default_host = new_resource.default_host
          request_setting.save!
          Chef::Log.info "#{ @new_resource } default_host updated."
          new_resource.updated_by_last_action(true)
        end

        unless request_setting.hash_keys == new_resource.hash_keys
          request_setting.hash_keys = new_resource.hash_keys
          request_setting.save!
          Chef::Log.info "#{ @new_resource } hash_keys updated."
          new_resource.updated_by_last_action(true)
        end

        unless request_setting.max_stale_age == new_resource.max_stale_age
          request_setting.max_stale_age = new_resource.max_stale_age
          request_setting.save!
          Chef::Log.info "#{ @new_resource } max_stale_age updated."
          new_resource.updated_by_last_action(true)
        end

        unless request_setting.action == new_resource.request_action
          request_setting.action = new_resource.request_action
          request_setting.save!
          Chef::Log.info "#{ @new_resource } request_action updated."
          new_resource.updated_by_last_action(true)
        end

        unless request_setting.xff == new_resource.x_forwarded_for
          request_setting.xff = new_resource.x_forwarded_for
          request_setting.save!
          Chef::Log.info "#{ @new_resource } x_forwarded_for updated."
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

      def request_setting
        unless @request_setting
          @request_setting = fastly_client.list_request_settings(
            service_id: service.id,
            version: service.version.number
          ).select { |b| b.name == new_resource.name }
          @request_setting = @request_setting.first
        end
        @request_setting
      end

      def create_request_setting
        fastly_client.create_request_setting(
          service_id: service.id,
          version: service.version.number,
          name: new_resource.name,
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
