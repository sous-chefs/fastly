include_recipe 'chef-sugar::default'

supermarket_rb = File.join('/var/opt/delivery/workspace/.chef', 'supermarket.rb')
supermarket_pem = File.join('/var/opt/delivery/workspace/.chef', 'supermarket.pem')

supermarket = encrypted_data_bag_item_for_environment('creds', 'supermarket')

template supermarket_rb do
  source 'supermarket.rb.erb'
  variables(
    username: supermarket['username']
  )
end

template supermarket_rb do
  source 'supermarket.rb.erb'
  variables(
    username: supermarket['username']
  )
end

file supermarket_pem do
  content supermarket['pem']
end
