# frozen_string_literal: true

provides :fastly_syslog_logging
unified_mode true

use '_partial/authentication'
use '_partial/service'

property :response_condition, String, default: ''
property :hostname, String, required: true
property :port, Integer, default: 514
property :token, String
property :format, String, default: '%h %l %u %t %r %>s'
property :message_type, String, default: 'classic', equal_to: %w(classic loggly logplex blank)
property :use_tls, [true, false], default: false
property :tls_hostname, String
property :tls_cert, String

action :create do
  syslog_logging = named_fastly_object(:list_syslogs) || create_fastly_object(
    :create_syslog,
    fastly_service_options.merge(name: new_resource.name, hostname: new_resource.hostname)
  )

  update_fastly_property(syslog_logging, :response_condition, new_resource.response_condition)
  update_fastly_property(syslog_logging, :hostname, new_resource.hostname)
  update_fastly_property(syslog_logging, :port, new_resource.port)
  update_fastly_property(syslog_logging, :token, new_resource.token)
  update_fastly_property(syslog_logging, :format, new_resource.format)
  update_fastly_property(syslog_logging, :message_type, new_resource.message_type)
  update_fastly_property(syslog_logging, :use_tls, new_resource.use_tls ? '1' : '0')
  update_fastly_property(syslog_logging, :tls_hostname, new_resource.tls_hostname)
  update_fastly_property(syslog_logging, :tls_ca_cert, new_resource.tls_cert, :tls_cert)
end

action_class do
  include FastlyCookbook::Helpers
end
