#
# Author:: Christopher Webber (<cwebber@chef.io>)
# Author:: Ryan Hass (<rhass@chef.io>)
# Copyright:: Copyright (c) 2017 Chef Software Inc.
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
    class FastlySyslogLogging < Chef::Provider::FastlyBase

      action :create do
        if syslog_logging
          Chef::Log.info "#{ @new_resource } already exists - nothing to do."
        else
          create_syslog_logging
          Chef::Log.info "#{ @new_resource } created."
          new_resource.updated_by_last_action(true)
        end
        action_update
      end

      action :update do

        unless syslog_logging.response_condition == new_resource.response_condition
          syslog_logging.response_condition = new_resource.response_condition
          syslog_logging.save!
          Chef::Log.info "#{ @new_resource } response_condition updated."
          new_resource.updated_by_last_action(true)
        end

        unless syslog_logging.hostname == new_resource.hostname
          syslog_logging.hostname = new_resource.hostname
          syslog_logging.save!
          Chef::Log.info "#{ @new_resource } hostname updated."
          new_resource.updated_by_last_action(true)
        end

        unless syslog_logging.port == new_resource.port
          syslog_logging.port = new_resource.port
          syslog_logging.save!
          Chef::Log.info "#{ @new_resource } port updated."
          new_resource.updated_by_last_action(true)
        end

        unless syslog_logging.token == new_resource.token
          syslog_logging.token = new_resource.token
          syslog_logging.save!
          Chef::Log.info "#{ @new_resource } token updated."
          new_resource.updated_by_last_action(true)
        end

        unless syslog_logging.format == new_resource.format
          syslog_logging.format = new_resource.format
          syslog_logging.save!
          Chef::Log.info "#{ @new_resource } format updated."
          new_resource.updated_by_last_action(true)
        end

        unless syslog_logging.message_type == new_resource.message_type
          syslog_logging.message_type = new_resource.message_type
          syslog_logging.save!
          Chef::Log.info "#{ @new_resource } message_type updated."
          new_resource.updated_by_last_action(true)
        end

        # While the Fastly API docs indicate the expected value for this is
        # a boolean, the `GET` method on this API shows the values as strings
        # which are either "0" for false or "1" for true.
        use_tls = new_resource.use_tls ? "1" : "0"
        unless syslog_logging.use_tls == use_tls
          syslog_logging.use_tls = use_tls
          syslog_logging.save!
          Chef::Log.info "#{ @new_resource } use_tls updated."
          new_resource.updated_by_last_action(true)
        end

        unless syslog_logging.tls_hostname == new_resource.tls_hostname
          syslog_logging.tls_hostname = new_resource.tls_hostname
          syslog_logging.save!
          Chef::Log.info "#{ @new_resource } tls_hostname level updated."
          new_resource.updated_by_last_action(true)
        end

        unless syslog_logging.tls_ca_cert == new_resource.tls_cert
          syslog_logging.tls_ca_cert = new_resource.tls_cert
          syslog_logging.save!
          Chef::Log.info "#{ @new_resource } tls_cert level updated."
          new_resource.updated_by_last_action(true)
        end
      end

      def syslog_logging
        unless @syslog_logging
          @syslog_logging = fastly_client.list_syslogs(
            service_id: service.id,
            version: service.version.number
          ).select { |b| b.name == new_resource.name }
          @syslog_logging = @syslog_logging.first
        end
        @syslog_logging
      end

      def create_syslog_logging
        fastly_client.create_syslog(
          service_id: service.id,
          version: service.version.number,
          name: new_resource.name,
          hostname: new_resource.hostname,
        )
      end

    end
  end
end
