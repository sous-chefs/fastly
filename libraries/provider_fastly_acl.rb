#
# Author:: Patrick Wright (<patrick@chef.io>)
# Copyright:: Copyright (c) 2016 Chef Software, Inc.
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
    class FastlyACL < Chef::Provider::FastlyBase

      action :create do
        if acl
          Chef::Log.debug "ACL exists."
        else
          fastly_client.create_acl(
            service_id: service.id,
            version: service.version.number,
            name: new_resource.name
          )
          Chef::Log.info "#{new_resource} ACL created."
          new_resource.updated_by_last_action(true)
        end

        entries_to_delete = entries.select { |entry| !new_resource.entries.include?(entry.ip) }

        entries.each do |entry| 
          if new_resource.entries.include?(entry.ip)
            Chef::Log.debug "ACL entry '#{entry.ip}' exists."
          elsif entries_to_delete.include?(entry.ip)
            acl.delete_entry(entry)
            Chef::Log.info "ACL entry '#{entry.ip}' deleted."
            new_resource.updated_by_last_action(true)
          else
            acl.create_entry(ip: entry.ip)
            Chef::Log.info "ACL entry '#{entry.ip}' created."
            new_resource.updated_by_last_action(true)
          end
        end
      end

      def acl
        @acl ||= begin
          begin
            fastly_client.get_acl(service.id, service.version.number, new_resource.name)
          rescue Fastly::Error => e
            if e.message =~ /Record not found/
              nil
            else
              raise
            end
          end
        end
      end

      def entries
        @entries ||= acl.list_entries
      end
    end
  end
end
