# frozen_string_literal: true

provides :fastly_gzip
unified_mode true

use '_partial/authentication'
use '_partial/service'

property :extensions, String
property :content_types, String
property :cache_condition, String, default: ''

action :create do
  gzip = named_fastly_object(:list_gzips) || create_fastly_object(:create_gzip, fastly_service_options.merge(name: new_resource.name))

  update_fastly_property(gzip, :extensions, new_resource.extensions)
  update_fastly_property(gzip, :cache_condition, new_resource.cache_condition)
  update_fastly_property(gzip, :content_types, new_resource.content_types)
end

action :update do
  gzip = named_fastly_object(:list_gzips)

  update_fastly_property(gzip, :extensions, new_resource.extensions)
  update_fastly_property(gzip, :cache_condition, new_resource.cache_condition)
  update_fastly_property(gzip, :content_types, new_resource.content_types)
end

action_class do
  include FastlyCookbook::Helpers
end
