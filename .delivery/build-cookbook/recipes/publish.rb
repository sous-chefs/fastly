include_recipe 'build-cookbook::_handler'
include_recipe 'delivery-truck::publish'

notify_and_log 'Publish' do
  message "#{node['delivery']['change']['project']} has been published"
end
