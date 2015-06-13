Vagrant.configure("2") do |config|
  config.vm.box = "chef/ubuntu-14.04"
  config.vm.network :private_network, ip: "10.1.2.28"
  config.ssh.forward_agent = true
  config.vm.provision :shell, :path => "./bootstrap.sh"
  config.vm.provider "virtualbox" do |v|
    v.memory = 512
  end
end
