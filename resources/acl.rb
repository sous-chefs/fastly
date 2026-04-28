# frozen_string_literal: true

provides :fastly_acl
unified_mode true

use '_partial/authentication'
use '_partial/service'

property :entries, Array,
         required: true,
         callbacks: {
           'entries must be an array of valid ip addresses as strings' => lambda { |entries|
             entries.all? { |entry| entry.is_a?(String) && entry.match?(/\A(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\z/) }
           },
         }

action :create do
  acl_options = fastly_service_options.merge(name: new_resource.name)
  acl = named_fastly_object(:list_acls, acl_options) || create_fastly_object(:create_acl, acl_options)

  entry_ips = acl.list_entries.map(&:ip)

  new_resource.entries.each do |entry_ip|
    next if entry_ips.include?(entry_ip)

    converge_by("create #{new_resource} entry #{entry_ip}") do
      acl.create_entry(ip: entry_ip)
    end
  end

  entry_ips.each do |entry_ip|
    next if new_resource.entries.include?(entry_ip)

    converge_by("delete #{new_resource} entry #{entry_ip}") do
      acl.delete_entry(acl.list_entries.find { |entry| entry.ip == entry_ip })
    end
  end
end

action_class do
  include FastlyCookbook::Helpers
end
