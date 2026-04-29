# fastly_healthcheck

Creates and updates a Fastly healthcheck.

## Actions

* `:create`

## Properties

* `api_key`, `username`, `password` - Fastly authentication.
* `service` - Fastly service name.
* `path`, `host` - Required healthcheck target fields.
* `comment`, `http_version`, `timeout`, `window`, `threshold`, `http_method`, `expected_response`, `initial`, `check_interval` - Healthcheck settings.
