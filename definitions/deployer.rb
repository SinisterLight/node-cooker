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

  template "#{node[:node][:home]}/apps/#{application_name}_deployer.sh" do
    cookbook "node"
    source "deployer.sh.erb"
    owner "node"
    group "node"
    mode 0755
    variables(
      :application_name => application_name,
      :application_main => params[:main],
      :server => params[:server],
      :port => params[:port],
      :user => params[:user],
      :password => params[:password],
      :project_code => params[:project_code]
    )
  end
end
