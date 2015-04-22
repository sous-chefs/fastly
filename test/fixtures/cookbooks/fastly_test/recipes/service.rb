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

