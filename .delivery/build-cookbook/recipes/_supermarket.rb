include_recipe 'chef-sugar::default'

supermarket_rb = File.join(node['delivery']['workspace']['cache'], 'supermarket.rb')
supermarket_pem = File.join(node['delivery']['workspace']['cache'], 'supermarket.pem')

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
  sensitive true
end

# this requires that recipe[delivery-truck::publish] to have already run
cookbook_directory = File.join(node['delivery']['workspace']['cache'], "cookbook-upload")
execute "upload_cookbook_#{node['delivery']['change']['project']}" do
  command "knife cookbook site share #{node['delivery']['change']['project']} other" \
    "--config #{supermarket_rb} " \
    "--cookbook-path #{cookbook_directory}"
end
