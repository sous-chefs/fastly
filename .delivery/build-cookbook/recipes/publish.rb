include_recipe 'delivery-truck::publish'
include_recipe 'build-cookbook::_supermarket'

notify_and_log 'Publish' do
  message "#{node['delivery']['change']['project']} has been published"
end
