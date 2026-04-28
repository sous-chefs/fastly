# Migration

This cookbook has been migrated from legacy LWRP classes under `libraries/` to Chef Infra custom resources under `resources/`.

## What Changed

* Chef Infra Client 16.0 or later is required.
* The `recipes/` directory was removed.
* Legacy `Chef::Resource::LWRPBase` and `Chef::Provider::LWRPBase` classes were removed.
* Shared authentication and service properties now live in resource partials under `resources/_partial/`.
* Shared Fastly client and object update behavior now lives in `libraries/helpers.rb`.

## User Impact

Use the `fastly_*` resources directly in your own cookbooks. Do not include `fastly::default`; the resources install the `fastly` RubyGem on demand when the client library is not already available.

Existing resource names, primary properties, and actions are preserved.
