# frozen_string_literal: true

provides :fastly_cache_setting
unified_mode true

use '_partial/authentication'
use '_partial/service'

property :cache_condition, String, default: ''
property :stale_ttl, Integer
property :ttl, Integer
property :cache_action, String, equal_to: %w(pass cache restart)

action :create do
  cache_setting = named_fastly_object(:list_cache_settings) || create_fastly_object(:create_cache_setting, fastly_service_options.merge(name: new_resource.name))

  update_fastly_property(cache_setting, :cache_condition, new_resource.cache_condition)
  update_fastly_integer_property(cache_setting, :ttl, new_resource.ttl)
  update_fastly_integer_property(cache_setting, :stale_ttl, new_resource.stale_ttl)
  update_fastly_property(cache_setting, :action, new_resource.cache_action, :cache_action)
end

action_class do
  include FastlyCookbook::Helpers
end
