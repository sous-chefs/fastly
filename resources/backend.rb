# frozen_string_literal: true

provides :fastly_backend
unified_mode true

use '_partial/authentication'
use '_partial/service'

property :request_condition, String, default: ''
property :port, Integer, default: 80
property :ssl, [true, false], default: false
property :address, String, name_property: true
property :auto_loadbalance, [true, false], default: false
property :shield, String
property :healthcheck, String

action :create do
  backend = named_fastly_object(:list_backends) || create_fastly_object(:create_backend, fastly_service_options.merge(name: new_resource.name, address: new_resource.address))

  update_fastly_property(backend, :address, new_resource.address)
  update_fastly_property(backend, :request_condition, new_resource.request_condition)
  update_fastly_property(backend, :port, new_resource.port)
  update_fastly_property(backend, :use_ssl, new_resource.ssl, :ssl)
  update_fastly_backend_property(backend, :auto_loadbalance, new_resource.auto_loadbalance)
  update_fastly_backend_property(backend, :shield, new_resource.shield)
  update_fastly_backend_property(backend, :healthcheck, new_resource.healthcheck)
end

action_class do
  include FastlyCookbook::Helpers

  def update_fastly_backend_property(backend, property, desired_value)
    return if backend.public_send(property) == desired_value

    converge_by("update #{new_resource} #{property}") do
      backend.public_send("#{property}=", desired_value)
      fastly_client.update_backend(backend)
      backend.save!
    end
  end
end
