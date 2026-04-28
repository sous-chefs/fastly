# frozen_string_literal: true

provides :fastly_condition
unified_mode true

use '_partial/authentication'
use '_partial/service'

property :type, String, required: true, equal_to: %w(request cache response)
property :statement, String, required: true
property :priority, Integer, default: 10

action :create do
  condition = named_fastly_object(:list_conditions) || create_fastly_object(
    :create_condition,
    fastly_service_options.merge(name: new_resource.name, type: new_resource.type.upcase, statement: new_resource.statement)
  )

  update_fastly_property(condition, :statement, new_resource.statement)
  update_fastly_integer_property(condition, :priority, new_resource.priority)
  update_fastly_property(condition, :type, new_resource.type.upcase)
end

action_class do
  include FastlyCookbook::Helpers
end
