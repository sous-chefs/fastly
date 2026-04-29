fastly_service 'new_service' do
  api_key 'secret'
end

fastly_domain 'www.example.com' do
  api_key 'secret'
  service 'service_name'
end

fastly_backend 'backend' do
  api_key 'secret'
  service 'service_name'
  address 'backend.example.com'
end

fastly_condition 'condition' do
  api_key 'secret'
  service 'service_name'
  type 'request'
  statement 'req.url'
end

fastly_cache_setting 'cache' do
  api_key 'secret'
  service 'service_name'
  ttl 60
end

fastly_request_setting 'request' do
  api_key 'secret'
  service 'service_name'
  force_ssl true
end

fastly_header 'header' do
  api_key 'secret'
  service 'service_name'
  type 'response'
  dst 'http.location'
end

fastly_gzip 'gzip' do
  api_key 'secret'
  service 'service_name'
  extensions 'css js'
end

fastly_healthcheck 'healthcheck' do
  api_key 'secret'
  service 'service_name'
  path '/'
  host 'www.example.com'
end

fastly_response 'response' do
  api_key 'secret'
  service 'service_name'
end

fastly_s3_logging 's3' do
  api_key 'secret'
  service 'service_name'
  bucket_name 'logs'
  access_key 'access'
  secret_key 'secret'
end

fastly_syslog_logging 'syslog' do
  api_key 'secret'
  service 'service_name'
  hostname 'logs.example.com'
end

fastly_acl 'acl' do
  api_key 'secret'
  service 'service_name'
  entries ['192.0.2.1']
end
