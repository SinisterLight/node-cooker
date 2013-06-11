define :app_deployer do
  application_name = params[:name]
  include_recipe 'node'

  directory "#{node[:node][:home]}/apps" do
    owner "node"
    group "node"
    mode 00755
    action :create
    not_if do
      File.exists? "#{node[:node][:home]}/apps"
    end
  end
end
