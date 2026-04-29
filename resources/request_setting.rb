# frozen_string_literal: true

provides :fastly_request_setting
unified_mode true

use '_partial/authentication'
use '_partial/service'

property :request_condition, String, default: ''
property :force_ssl, [true, false]
property :force_miss, [true, false]
property :bypass_busy_wait, [true, false]
property :default_host, String
property :hash_keys, String
property :max_stale_age, Integer
property :request_action, String, equal_to: %w(pass lookup)
property :x_forwarded_for, String, equal_to: %w(clear leave append append_all overwrite)

action :create do
  request_setting = named_fastly_object(:list_request_settings) || create_fastly_object(
    :create_request_setting,
    fastly_service_options.merge(name: new_resource.name, max_stale_age: 60)
  )

  update_fastly_bool_string_property(request_setting, :force_ssl, new_resource.force_ssl)
  update_fastly_property(request_setting, :request_condition, new_resource.request_condition)
  update_fastly_bool_string_property(request_setting, :force_miss, new_resource.force_miss)
  update_fastly_bool_string_property(request_setting, :bypass_busy_wait, new_resource.bypass_busy_wait)
  update_fastly_property(request_setting, :default_host, new_resource.default_host)
  update_fastly_property(request_setting, :hash_keys, new_resource.hash_keys)
  update_fastly_property(request_setting, :max_stale_age, new_resource.max_stale_age)
  update_fastly_property(request_setting, :action, new_resource.request_action, :request_action)
  update_fastly_property(request_setting, :xff, new_resource.x_forwarded_for, :x_forwarded_for)
end

action_class do
  include FastlyCookbook::Helpers
end
