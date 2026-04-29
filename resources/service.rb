# frozen_string_literal: true

provides :fastly_service
unified_mode true

use '_partial/authentication'

action :create do
  next if fastly_named_service

  create_fastly_object(:create_service, name: new_resource.name)
end

action :activate_latest do
  converge_by("activate #{new_resource}") do
    fastly_named_service.version.activate!
    fastly_named_service.version.clone
  end
end

action :purge_all do
  converge_by("purge #{new_resource}") do
    fastly_named_service.purge_all
  end
end

action_class do
  include FastlyCookbook::Helpers

  def fastly_named_service
    fastly_client.list_services.find { |svc| svc.name == new_resource.name }
  end
end
