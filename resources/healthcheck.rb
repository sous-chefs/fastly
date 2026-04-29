# frozen_string_literal: true

provides :fastly_healthcheck
unified_mode true

use '_partial/authentication'
use '_partial/service'

property :comment, String
property :path, String, required: true
property :host, String, required: true
property :http_version, String, default: '1.1'
property :timeout, Integer, default: 500
property :window, Integer, default: 5
property :threshold, Integer, default: 3
property :http_method, String, default: 'GET'
property :expected_response, Integer, default: 200
property :initial, Integer, default: 2
property :check_interval, Integer, default: 5000

action :create do
  healthcheck = named_fastly_object(:list_healthchecks) || create_fastly_object(:create_healthcheck, fastly_service_options.merge(name: new_resource.name))

  {
    comment: :comment,
    path: :path,
    host: :host,
    http_version: :http_version,
    timeout: :timeout,
    window: :window,
    threshold: :threshold,
    http_method: :method,
    expected_response: :expected_response,
    initial: :initial,
    check_interval: :check_interval,
  }.each do |resource_property, fastly_property|
    update_fastly_property(healthcheck, fastly_property, new_resource.public_send(resource_property), resource_property)
  end
end

action_class do
  include FastlyCookbook::Helpers
end
