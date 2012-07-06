# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "squeeze64"
  config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/benjamin-ds/vagrant/squeeze64.box"

  # Customize memory
  config.vm.customize ["modifyvm", :id, "--memory", "256"]
  
  config.vm.provision :shell, :inline => "[ -f /tmp/updated ] || apt-get update && touch /tmp/updated"
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "../"
    puppet.manifest_file = "site.pp"
    puppet.options = "--verbose"
  end
    
  config.vm.define :ftp do |ftp|
    ftp.vm.host_name = "ftp.domain.tld"
    ftp.vm.network :hostonly, "192.168.33.10"
    ftp.vm.forward_port 21, 2121
  end
end