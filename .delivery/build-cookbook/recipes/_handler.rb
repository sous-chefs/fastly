include_recipe 'chef-sugar::default'

hipchat = encrypted_data_bag_item_for_environment('creds', 'hipchat')

chef_handler "BuildCookbook::HipChatHandler" do
  source File.join(node["chef_handler"]["handler_path"], 'hipchat.rb')
  arguments [hipchat['token'], hipchat['room'], true]
  supports :exception => true
  action :nothing
end.run_action(:enable)
