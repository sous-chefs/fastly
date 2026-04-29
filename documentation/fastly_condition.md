# fastly_condition

Creates and updates a Fastly condition.

## Actions

* `:create`

## Properties

* `api_key`, `username`, `password` - Fastly authentication.
* `service` - Fastly service name.
* `type` - One of `request`, `cache`, or `response`.
* `statement` - VCL condition statement.
* `priority` - Condition priority. Defaults to `10`.
