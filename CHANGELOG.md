v0.1.12 (2017-02-02)
-------------------
- Add `message_type` attribute to `fastly_s3_logging` resource

v0.1.4 (2016-09-06)
-------------------
- Add `fastly_healthcheck` resource

v0.1.3 (2016-08-31)
-------------------
- Add `format_version` support to `fastly_s3_logging` resource

v0.1.2 (2016-08-12)
-------------------
- Add Fastly Shield support.

v0.1.0 (2016-05-27)
-------------------
- Take advantage of installing the gem via the metadata

v0.0.18 (2016-05-13)
--------------------
- Updates the gem version
- Sets the max stale age on request setting to the default on creation

v0.0.17 (2016-03-09)
--------------------
- Pins the gem version

v0.0.16 (2016-03-09)
--------------------
- Updates method call to be compatible with latest gem

v0.0.15 (2015-09-26)
--------------------
- Forces a new version to be cloned after activate

v0.0.14 (2015-05-17)
--------------------
- Adds fastly_s3_logging resource

v0.0.13 (2015-05-05)
--------------------
- Adds a fastly_response resource

v0.0.12 (2015-04-27)
--------------------
- Adds fastly_gzip resource

v0.0.11 (2015-04-27)
--------------------
- Refactors to use a base resource and provider to DRY up code

v0.0.10 (2015-04-27)
--------------------
- Adds fastly_header

v0.0.9 (2015-04-21)
-------------------
- Adds fastly_cache_setting resource

v0.0.8 (2015-04-21)
-------------------
- Adds fastly_request_setting resource

v0.0.7 (2015-04-10)
-------------------
- Publish to GitHub

v0.0.6 (2015-04-08)
-------------------
- Adds fastly_condition resource
- Adds ability for fastly_backend to consume conditions
- Fixes issues where a newly created resource cant make changes to itself

v0.0.5 (2015-04-08)
-------------------
- Added fastly_backend resource
- Updated :activate_latest and :purge_all actions on the fastly_service resource they notify when the make a change
