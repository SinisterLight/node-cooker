node_package "forever" do
  action :install
  not_if do
    File.exists?("/usr/local/bin/forever")
  end
end
