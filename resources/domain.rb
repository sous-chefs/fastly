# frozen_string_literal: true

provides :fastly_domain
unified_mode true

use '_partial/authentication'
use '_partial/service'

action :create do
  next if named_fastly_object(:list_domains)

  create_fastly_object(:create_domain, fastly_service_options.merge(name: new_resource.name))
end

action_class do
  include FastlyCookbook::Helpers
end
