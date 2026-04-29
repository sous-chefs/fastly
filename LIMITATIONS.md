# Limitations

This cookbook manages Fastly through the Fastly API. It does not install operating system packages or manage a local Fastly service.

## Platform Support

Fastly is a hosted API service, so platform support is primarily constrained by Chef Infra Client and the Ruby runtime used by Chef. The cookbook declares `supports 'any'` and requires Chef Infra Client 16.0 or later because the custom resources use resource partials.

## Runtime Requirements

* The node must be able to install and load the `fastly` RubyGem.
* The node must be able to connect to Fastly API endpoints over TLS.
* Resources require either `api_key` or both `username` and `password`.
* Fastly API credentials must have permission to read and manage the target service objects.

## Package and Source Install

There are no apt, dnf, yum, or source package install paths for this cookbook. Resource actions install the Ruby API client gem on demand with `chef_gem` when it is not already available.

## API Client Notes

Fastly maintains the Ruby API client and publishes it through RubyGems. As of April 28, 2026, RubyGems lists `fastly` 16.1.0 as the latest stable version and the gem requires Ruby 2.4 or later.
