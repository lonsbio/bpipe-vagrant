# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu-raring-x64"
  config.vm.provision :shell, :path => "bootstrap.sh"
  #config.vm.network :forwarded_port, host: 4567, guest: 80
  #config.vm.synced_folder "../data", "/vagrant_data"

   config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "init.pp"
     #puppet.module_path = "modules"
     puppet.options = "--fileserverconfig=/vagrant/files.conf"
     puppet.facter = { "repo" => "https://andrew.lonsdale%40lonsbio.com.au@code.google.com/r/andrewlonsdale-bpipe-dev/"}
   end

end
