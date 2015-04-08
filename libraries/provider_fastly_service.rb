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
    class FastlyService < Chef::Provider::LWRPBase

      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        false
      end

      action :create do
        if service 
          Chef::Log.info "#{ @new_resource } already exists - nothing to do."
        else
          create_service
          Chef::Log.info "#{ @new_resource } created."
          new_resource.updated_by_last_action(true)
        end

      end

      action :activate_latest do
        service.version.activate!
      end

      action :purge_all do
        service.purge_all
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
        @service = fastly_client.list_services.select { |svc| svc.name == new_resource.name }
        @service.first
      end

      def create_service
        fastly_client.create_service(name: new_resource.name)
      end

    end
  end
end
