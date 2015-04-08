include_recipe 'fastly::default'

fastly_service 'cwebber_test' do
  api_key node['fastly']['api_key']
end
