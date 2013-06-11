action :install do
  execute "installing NPM package #{new_resource.name}" do
    command npm_execute(:install, new_resource.name, new_resource.version)
  end
end

action :uninstall do
  execute "uninstalling NPM package #{new_resource.name}" do
    command npm_execute(:uninstall, new_resource.name, new_resource.version)
  end
end

def npm_execute npm_action, name, version
  cmd  = "npm -g #{npm_action} #{name}"
  cmd += "@#{version}" if new_resource.version
  return cmd
end
