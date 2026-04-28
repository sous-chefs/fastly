# frozen_string_literal: true

provides :fastly_header
unified_mode true

use '_partial/authentication'
use '_partial/service'

property :request_condition, String, default: ''
property :cache_condition, String, default: ''
property :response_condition, String, default: ''
property :header_action, String, equal_to: %w(set append delete regex regex_repeat)
property :ignore_if_set, [true, false], default: false
property :type, String, required: true, equal_to: %w(request cache fetch response)
property :dst, String, required: true
property :src, String
property :regexp, String
property :substitution, String, default: ''
property :priority, Integer

action :create do
  header = named_fastly_object(:list_headers) || create_fastly_object(
    :create_header,
    fastly_service_options.merge(name: new_resource.name, type: new_resource.type, dst: new_resource.dst)
  )

  update_fastly_property(header, :request_condition, new_resource.request_condition)
  update_fastly_property(header, :response_condition, new_resource.response_condition)
  update_fastly_property(header, :cache_condition, new_resource.cache_condition)
  update_fastly_bool_string_property(header, :ignore_if_set, new_resource.ignore_if_set)
  update_fastly_property(header, :action, new_resource.header_action, :header_action)
  update_fastly_property(header, :type, new_resource.type)
  update_fastly_property(header, :dst, new_resource.dst)
  update_fastly_property(header, :src, new_resource.src)
  update_fastly_property(header, :regex, new_resource.regexp, :regexp)
  update_fastly_property(header, :substitution, new_resource.substitution)
  update_fastly_integer_property(header, :priority, new_resource.priority)
end

action_class do
  include FastlyCookbook::Helpers
end
