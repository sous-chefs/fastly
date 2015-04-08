define :notify_and_log, :message => nil do
  include_recipe 'chef-sugar::default'

  hipchat = encrypted_data_bag_item_for_environment('creds', 'hipchat')

  hipchat_msg 'Notify Hipchat' do
    room hipchat['room']
    token hipchat['token']
    nickname 'Delivery'
    message "[#{node['delivery']['change']['project']}] (#{node['delivery']['change']['stage']}:#{node['delivery']['change']['phase']}) #{params[:message]}"
    color 'green'
    notify false
    sensitive true
  end

  log params[:message]
end
