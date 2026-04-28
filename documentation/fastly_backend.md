# fastly_backend

Creates and updates a Fastly backend.

## Actions

* `:create`

## Properties

* `api_key`, `username`, `password` - Fastly authentication.
* `service` - Fastly service name.
* `address` - Backend address. Defaults to the resource name.
* `request_condition`, `port`, `ssl`, `auto_loadbalance`, `shield`, `healthcheck` - Backend settings.
