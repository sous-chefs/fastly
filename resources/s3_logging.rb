# frozen_string_literal: true

provides :fastly_s3_logging
unified_mode true

use '_partial/authentication'
use '_partial/service'

property :response_condition, String, default: ''
property :bucket_name, String, required: true
property :access_key, String, required: true
property :secret_key, String, required: true, sensitive: true
property :path, String
property :format, String, default: '%h %l %u %{now}V %{req.request}V %{req.url}V %>s'
property :format_version, Integer, default: 2
property :message_type, String, default: 'classic', equal_to: %w(classic loggly logplex blank)
property :period, Integer, default: 3600
property :gzip_level, Integer, default: 3
property :domain, String, default: 's3.amazonaws.com'
property :redundancy, String, default: 'Standard'

action :create do
  s3_logging = named_fastly_object(:list_s3_loggings) || create_fastly_object(:create_s3_logging, fastly_service_options.merge(name: new_resource.name))

  update_fastly_property(s3_logging, :response_condition, new_resource.response_condition)
  update_fastly_property(s3_logging, :bucket_name, new_resource.bucket_name)
  update_fastly_property(s3_logging, :path, new_resource.path)
  update_fastly_property(s3_logging, :format, new_resource.format)
  update_fastly_property(s3_logging, :format_version, new_resource.format_version)
  update_fastly_property(s3_logging, :message_type, new_resource.message_type)
  update_fastly_property(s3_logging, :access_key, new_resource.access_key)
  update_fastly_property(s3_logging, :secret_key, new_resource.secret_key)
  update_fastly_integer_property(s3_logging, :period, new_resource.period)
  update_fastly_integer_property(s3_logging, :gzip_level, new_resource.gzip_level)
  update_fastly_property(s3_logging, :domain, new_resource.domain)
  update_fastly_property(s3_logging, :redundancy, new_resource.redundancy)
end

action_class do
  include FastlyCookbook::Helpers
end
