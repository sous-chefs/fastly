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
    class FastlyService < Chef::Provider::FastlyBase

      provides :fastly_service
      
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
        Chef::Log.info "#{ @new_resource } activated."
        service.version.activate!
        service.version.clone
        new_resource.updated_by_last_action(true)
      end

      action :purge_all do
        service.purge_all
        new_resource.updated_by_last_action(true)
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
