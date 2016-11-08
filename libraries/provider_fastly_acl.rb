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
        if acl.nil?
          fastly_client.create_acl(acl_options)
          Chef::Log.info "#{new_resource} ACL created."
          new_resource.updated_by_last_action(true)
        else
          Chef::Log.debug "ACL exists."
        end

        new_resource.entries.each do |entry|
          if entries.include?(entry)
            Chef::Log.debug "ACL entry '#{entry}' exists."
          else
            acl.create_entry(ip: entry)
            Chef::Log.info "ACL entry '#{entry}' created."
          end
        end

        entries.each do |entry|
          if !new_resource.entries.include?(entry)
            acl.delete_entry(entry_for(entry.ip))
            Chef::Log.info "ACL entry '#{entry}' deleted."
          end
        end
      end

      def acl
        @acl ||= fastly_client.list_acls(acl_options).find { |acl| acl.name == new_resource.name }
      end

      def entry_for(ip_address)
        acl.list_entries.find { |entry| entry.ip == ip_address }
      end

      def entries
        @entries ||= acl.list_entries.map(&:ip)
      end

      def acl_options
        @acl_options ||= {
          service_id: service.id,
          version: service.version.number,
          name: new_resource.name
        }
      end
    end
  end
end
