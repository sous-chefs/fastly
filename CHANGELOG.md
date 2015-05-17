v0.0.14 (2015-05-17)
====================
- Adds fastly_s3_logging resource

v0.0.13 (2015-05-05)
====================
- Adds a fastly_response resource

v0.0.12 (2015-04-27)
====================
- Adds fastly_gzip resource

v0.0.11 (2015-04-27)
====================
- Refactors to use a base resource and provider to DRY up code

v0.0.10 (2015-04-27)
====================
- Adds fastly_header

v0.0.9 (2015-04-21)
===================
- Adds fastly_cache_setting resource

v0.0.8 (2015-04-21)
===================
- Adds fastly_request_setting resource

v0.0.7 (2015-04-10)
===================
- Publish to GitHub

v0.0.6 (2015-04-08)
==================
- Adds fastly_condition resource
- Adds ability for fastly_backend to consume conditions
- Fixes issues where a newly created resource cant make changes to itself

v0.0.5 (2015-04-08)
===================
- Added fastly_backend resource
- Updated :activate_latest and :purge_all actions on the fastly_service resource they notify when the make a change
