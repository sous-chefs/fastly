include_recipe 'fastly::default'

cwebber_test = fastly_service 'cwebber_test' do
  api_key node['fastly']['api_key']
end

fastly_domain 'cwebber-test.chef.io' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
end

fastly_backend 'www.chef.io' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
  port 443
  ssl true
  notifies :activate_latest, 'fastly_service[cwebber_test]', :delayed
end

not_www_lb = fastly_condition 'not_www-lb' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
  type 'request'
  statement 'req.http.host != "www.chef.io"'
  notifies :activate_latest, 'fastly_service[cwebber_test]', :delayed
end

fastly_backend 'www.chef.io_http' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
  address 'www.chef.io'
  request_condition not_www_lb.name
  notifies :activate_latest, 'fastly_service[cwebber_test]', :delayed
end

fastly_request_setting 'force_ssl' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
  force_ssl true
  notifies :activate_latest, 'fastly_service[cwebber_test]', :delayed
end

fastly_cache_setting 'ttl_goodness' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
  ttl 60
  stale_ttl 120
  notifies :activate_latest, 'fastly_service[cwebber_test]', :delayed
end

subdomain = fastly_condition 'subdomain' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
  type 'request'
  statement 'req.http.host ~ "^subdomain"'
  notifies :activate_latest, 'fastly_service[cwebber_test]', :delayed
end

fastly_header 'redirect_subdomain' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
  type 'response'
  header_action 'set'
  dst 'http.location'
  src '"https://www.chef.io/subdomain" req.url'
  priority 10
  request_condition subdomain.name
  notifies :activate_latest, 'fastly_service[cwebber_test]', :delayed
end

fastly_gzip 'standard_gzip' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
  extensions 'css js html eot ico otf ttf json'
  content_types [
    'text/html',
    'application/x-javascript',
    'text/css',
    'application/javascript',
    'text/javascript',
    'application/json',
    'application/vnd.ms-fontobject',
    'application/x-font-opentype',
    'application/x-font-truetype',
    'application/x-font-ttf',
    'application/xml',
    'font/eot',
    'font/opentype',
    'font/otf',
    'image/svg+xml',
    'image/vnd.microsoft.icon',
    'text/plain',
    'text/xml',
  ].join(' ')
end

fastly_response 'subdomain_redirect' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
  request_condition subdomain.name
  status 302
  notifies :activate_latest, 'fastly_service[cwebber_test]', :delayed
end

fastly_s3_logging 's3_logging' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
  gzip_level 9
  access_key node['fastly']['aws_access_key']
  secret_key node['fastly']['aws_secret_key']
  bucket_name 'cwebber_test_logs'
  notifies :activate_latest, 'fastly_service[cwebber_test]', :delayed
end

