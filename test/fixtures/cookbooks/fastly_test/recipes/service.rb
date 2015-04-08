include_recipe 'fastly::default'

cwebber_test = fastly_service 'cwebber_test' do
  api_key node['fastly']['api_key']
end

fastly_domain 'cwebber-test.chef.io' do
  api_key node['fastly']['api_key']
  service cwebber_test.name
end
