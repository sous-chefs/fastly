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
    class FastlyGzip < Chef::Provider::FastlyBase
      action :create do
        if gzip
          Chef::Log.info "#{@new_resource} already exists - nothing to do."
        else
          create_gzip
          Chef::Log.info "#{@new_resource} created."
          new_resource.updated_by_last_action(true)
        end
        action_update
      end

      action :update do
        unless gzip.extensions == new_resource.extensions
          gzip.extensions = new_resource.extensions
          gzip.save!
          Chef::Log.info "#{@new_resource} extensions updated."
          new_resource.updated_by_last_action(true)
        end

        unless gzip.cache_condition == new_resource.cache_condition
          gzip.cache_condition = new_resource.cache_condition
          gzip.save!
          Chef::Log.info "#{@new_resource} cache_condition updated."
          new_resource.updated_by_last_action(true)
        end

        unless gzip.content_types == new_resource.content_types
          gzip.content_types = new_resource.content_types
          gzip.save!
          Chef::Log.info "#{@new_resource} content_types updated."
          new_resource.updated_by_last_action(true)
        end
      end

      def gzip
        unless @gzip
          @gzip = fastly_client.list_gzips(
            service_id: service.id,
            version: service.version.number
          ).select { |b| b.name == new_resource.name }
          @gzip = @gzip.first
        end
        @gzip
      end

      def create_gzip
        fastly_client.create_gzip(
          service_id: service.id,
          version: service.version.number,
          name: new_resource.name
        )
      end
    end
  end
end
