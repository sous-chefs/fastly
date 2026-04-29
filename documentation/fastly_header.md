# fastly_header

Creates and updates a Fastly header rule.

## Actions

* `:create`

## Properties

* `api_key`, `username`, `password` - Fastly authentication.
* `service` - Fastly service name.
* `type`, `dst`, `src`, `regexp`, `substitution`, `priority` - Header fields.
* `request_condition`, `cache_condition`, `response_condition` - Condition references.
* `header_action` - One of `set`, `append`, `delete`, `regex`, or `regex_repeat`.
* `ignore_if_set` - Whether Fastly should leave an existing header value in place.
