# fastly_syslog_logging

Creates and updates Fastly syslog logging.

## Actions

* `:create`

## Properties

* `api_key`, `username`, `password` - Fastly authentication.
* `service` - Fastly service name.
* `hostname` - Required syslog destination host.
* `response_condition`, `port`, `token`, `format`, `message_type`, `use_tls`, `tls_hostname`, `tls_cert` - Syslog logging settings.
