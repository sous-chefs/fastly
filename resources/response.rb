# frozen_string_literal: true

provides :fastly_response
unified_mode true

use '_partial/authentication'
use '_partial/service'

property :request_condition, String, default: ''
property :cache_condition, String, default: ''
property :status, Integer, default: 200
property :content, String
property :content_type, String
property :response, String

action :create do
  response = named_fastly_object(:list_response_objects) || create_fastly_object(:create_response_object, fastly_service_options.merge(name: new_resource.name))

  update_fastly_integer_property(response, :status, new_resource.status)
  update_fastly_property(response, :request_condition, new_resource.request_condition)
  update_fastly_property(response, :cache_condition, new_resource.cache_condition)
  update_fastly_property(response, :content, new_resource.content)
  update_fastly_property(response, :content_type, new_resource.content_type)
  update_fastly_property(response, :response, new_resource.response)
end

action_class do
  include FastlyCookbook::Helpers
end
