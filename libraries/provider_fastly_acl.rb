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

      provides :fastly_acl

      action :create do
        if acl.nil?
          fastly_client.create_acl(acl_options)
          Chef::Log.info "#{new_resource} ACL created."
          new_resource.updated_by_last_action(true)
        else
          Chef::Log.debug "ACL exists."
        end

        new_resource.entries.each do |entry_ip|
          if entry_ips.include?(entry_ip)
            Chef::Log.debug "ACL entry '#{entry_ip}' exists."
          else
            acl.create_entry(ip: entry_ip)
            Chef::Log.info "ACL entry '#{entry_ip}' created."
          end
        end

        entry_ips.each do |entry_ip|
          if !new_resource.entries.include?(entry_ip)
            acl.delete_entry(entry_for(entry_ip))
            Chef::Log.info "ACL entry '#{entry_ip}' deleted."
          end
        end
      end

      def acl
        @acl ||= fastly_client.list_acls(acl_options).find { |acl| acl.name == new_resource.name }
      end

      def entry_for(ip_address)
        acl.list_entries.find { |entry| entry.ip == ip_address }
      end

      def entry_ips
        @entry_ips ||= acl.list_entries.map(&:ip)
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
