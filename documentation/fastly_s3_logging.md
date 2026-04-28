# fastly_s3_logging

Creates and updates Fastly S3 logging.

## Actions

* `:create`

## Properties

* `api_key`, `username`, `password` - Fastly authentication.
* `service` - Fastly service name.
* `bucket_name`, `access_key`, `secret_key` - Required S3 destination credentials.
* `response_condition`, `path`, `format`, `format_version`, `message_type`, `period`, `gzip_level`, `domain`, `redundancy` - S3 logging settings.
