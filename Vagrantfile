Vagrant.configure("2") do |config|
  config.vm.box = "chef/ubuntu-14.04"
  config.vm.network :private_network, ip: "10.7.28.87"
  config.vm.provision :shell, :path => "./bootstrap.sh"
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
  end
end
