# yum-amazon Cookbook CHANGELOG

## [0.6.16](https://github.com/sous-chefs/fastly/compare/v0.6.15...v0.6.16) (2025-10-15)


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#51](https://github.com/sous-chefs/fastly/issues/51)) ([a37ddaf](https://github.com/sous-chefs/fastly/commit/a37ddaf058ff8521cae2b7ecb1aaa4660414b486))

## 0.6.5 - *2023-02-13*

* Standardise files with files in sous-chefs/repo-management

## 0.6.4 - *2023-02-13*

* Remove delivery folder

## 0.6.3 - *2021-08-31*

* Standardise files with files in sous-chefs/repo-management

## 0.6.2 - *2021-06-01*

* Standardise files with files in sous-chefs/repo-management

## 0.6.1 - *2021-03-25*

* Cookstyle fixes

## v0.5.0 (2018-01-29)

## 0.6.0 - *2021-03-22*

* Sous Chefs Adoption
* Various Cookstyle Fixes
* ChefSpec test fix
* fastly gem 1.13.2 changed the syslog response_conditions attribute to response_condition

## v0.4.0 (2017-08-16)

* Add support for syslog logging endpoints.

## v0.3.1 (2017-08-02)

* Merge in upstream changes

## v0.3.0 (2017-08-02)

* Set the default format version to 2 and use an equivalent default format for s3_logging

## v0.2.1 (2017-04-17)

* Enable chef-server publishing and delivery-truck pinning process
* Fix logic error around :method invocation in `fastly_healthcheck`

## v0.2.0 (2017-04-17)

* Changes the `method` attribute to `http_method` on the `fastly_healthcheck` resource to make it compatible with Chef 13

## v0.1.12 (2017-02-02)

* Add `message_type` attribute to `fastly_s3_logging` resource

## v0.1.4 (2016-09-06)

* Add `fastly_healthcheck` resource

## v0.1.3 (2016-08-31)

* Add `format_version` support to `fastly_s3_logging` resource

## v0.1.2 (2016-08-12)

* Add Fastly Shield support.

## v0.1.0 (2016-05-27)

* Take advantage of installing the gem via the metadata

## v0.0.18 (2016-05-13)-

* Updates the gem version
* Sets the max stale age on request setting to the default on creation

## v0.0.17 (2016-03-09)-

* Pins the gem version

## v0.0.16 (2016-03-09)-

* Updates method call to be compatible with latest gem

## v0.0.15 (2015-09-26)-

* Forces a new version to be cloned after activate

## v0.0.14 (2015-05-17)-

* Adds fastly_s3_logging resource

## v0.0.13 (2015-05-05)-

* Adds a fastly_response resource

## v0.0.12 (2015-04-27)-

* Adds fastly_gzip resource

## v0.0.11 (2015-04-27)-

* Refactors to use a base resource and provider to DRY up code

## v0.0.10 (2015-04-27)-

* Adds fastly_header

## v0.0.9 (2015-04-21)

* Adds fastly_cache_setting resource

## v0.0.8 (2015-04-21)

* Adds fastly_request_setting resource

## v0.0.7 (2015-04-10)

* Publish to GitHub

## v0.0.6 (2015-04-08)

* Adds fastly_condition resource
* Adds ability for fastly_backend to consume conditions
* Fixes issues where a newly created resource cant make changes to itself

## v0.0.5 (2015-04-08)

* Added fastly_backend resource
* Updated :activate_latest and :purge_all actions on the fastly_service resource they notify when the make a change
