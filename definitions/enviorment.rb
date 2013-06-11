define :enviorment_setup do
  application_name = params[:name]

  template "/etc/profile.d/#{params[:name]}.sh" do
    source params[:source]
    mode 00644
    owner 'root'
    notifies :restart, "service[jboss-as-standalone]"
  end

  execute "restart" do
    Chef::Log.info("Installing restarting app")
    command "forever restartall"
    not_if do
      File.exists?("/usr/local/bin/forever")
    end
  end
end
