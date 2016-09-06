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
    class FastlyS3Logging < Chef::Provider::FastlyBase

      action :create do
        if s3_logging
          Chef::Log.info "#{ @new_resource } already exists - nothing to do."
        else
          create_s3_logging
          Chef::Log.info "#{ @new_resource } created."
          new_resource.updated_by_last_action(true)
        end
        action_update
      end

      action :update do

        unless s3_logging.response_condition == new_resource.response_condition
          s3_logging.response_condition = new_resource.response_condition
          s3_logging.save!
          Chef::Log.info "#{ @new_resource } response_condition updated."
          new_resource.updated_by_last_action(true)
        end

        unless s3_logging.bucket_name == new_resource.bucket_name
          s3_logging.bucket_name = new_resource.bucket_name
          s3_logging.save!
          Chef::Log.info "#{ @new_resource } bucket_name updated."
          new_resource.updated_by_last_action(true)
        end

        unless s3_logging.path == new_resource.path
          s3_logging.path = new_resource.path
          s3_logging.save!
          Chef::Log.info "#{ @new_resource } path updated."
          new_resource.updated_by_last_action(true)
        end

        unless s3_logging.format == new_resource.format
          s3_logging.format = new_resource.format
          s3_logging.save!
          Chef::Log.info "#{ @new_resource } format updated."
          new_resource.updated_by_last_action(true)
        end

        unless s3_logging.format_version == new_resource.format_version
          s3_logging.format_version = new_resource.format_version
          s3_logging.save!
          Chef::Log.info "#{ @new_resource } format_version updated."
          new_resource.updated_by_last_action(true)
        end

        unless s3_logging.access_key == new_resource.access_key
          s3_logging.access_key = new_resource.access_key
          s3_logging.save!
          Chef::Log.info "#{ @new_resource } access_key updated."
          new_resource.updated_by_last_action(true)
        end

        unless s3_logging.secret_key == new_resource.secret_key
          s3_logging.secret_key = new_resource.secret_key
          s3_logging.save!
          Chef::Log.info "#{ @new_resource } secret_key updated."
          new_resource.updated_by_last_action(true)
        end

        unless s3_logging.period.to_i == new_resource.period
          s3_logging.period = new_resource.period
          s3_logging.save!
          Chef::Log.info "#{ @new_resource } period updated."
          new_resource.updated_by_last_action(true)
        end

        unless s3_logging.gzip_level.to_i == new_resource.gzip_level
          s3_logging.gzip_level = new_resource.gzip_level
          s3_logging.save!
          Chef::Log.info "#{ @new_resource } gzip_level updated."
          new_resource.updated_by_last_action(true)
        end

        unless s3_logging.domain == new_resource.domain
          s3_logging.domain = new_resource.domain
          s3_logging.save!
          Chef::Log.info "#{ @new_resource } domain updated."
          new_resource.updated_by_last_action(true)
        end

        unless s3_logging.redundancy == new_resource.redundancy
          s3_logging.redundancy = new_resource.redundancy
          s3_logging.save!
          Chef::Log.info "#{ @new_resource } redundancy level updated."
          new_resource.updated_by_last_action(true)
        end

      end

      def s3_logging
        unless @s3_logging
          @s3_logging = fastly_client.list_s3_loggings(
            service_id: service.id,
            version: service.version.number
          ).select { |b| b.name == new_resource.name }
          @s3_logging = @s3_logging.first
        end
        @s3_logging
      end

      def create_s3_logging
        fastly_client.create_s3_logging(
          service_id: service.id,
          version: service.version.number,
          name: new_resource.name,
        )
      end

    end
  end
end
