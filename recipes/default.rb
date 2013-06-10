#
# Cookbook Name:: node-cooker
# Recipe:: default
#
# Copyright 2013, Sinister Light
#

Chef::Log.info("Install ssl for #{node[:platform]}")
case node[:platform]
  when "centos","redhat","fedora","rhel"
    package "openssl-devel"
    package "gcc-c++"
  when "debian","ubuntu"
    package "libssl-dev"
end

node_file      = "node-v#{node[:node][:version]}"
node_tar       = "#{node_file}.tar.gz"
node_tar_path  = "v#{node[:node][:version]}/#{node_tar}"
node_src_url   = "#{node[:node][:source_url]}/#{node_tar_path}"

remote_file "/usr/local/src/#{node_tar}" do
  Chef::Log.info("downloading #{node_tar}")
  source node_src_url
  mode 0644
  owner 'root'
  group 'root'
  action :create_if_missing
  notifies :run, "script[install-node]", :immediately
end

script "install-node" do
  Chef::Log.info("Installing #{node_tar}")
  user 'root'
  interpreter "bash"
  cwd "/usr/local/src"
  code <<-EOH
  tar -zxf #{node_tar}
  cd #{node_file}
  ./configure
  make
  make install
  EOH
  not_if do
    File.exists?("/usr/local/bin/node") && `/usr/local/bin/node --version`.chomp == "v#{node[:node][:version]}"
  end
end
