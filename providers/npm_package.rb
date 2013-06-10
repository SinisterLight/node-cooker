action :install do
  execute "installing NPM package #{name}" do
    command npm_execute(:uninstall, name, version)
  end
end

action :uninstall do
  execute "uninstalling NPM package #{name}" do
    command npm_execute(:uninstall, name, version)
  end
end

def npm_execute npm_action, name, version
  cmd  = "npm -g #{npm_action} #{name}"
  cmd += "@#{version}" if new_resource.version
  return cmd
end
