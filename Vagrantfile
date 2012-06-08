Vagrant::Config.run do |config|
  # box setup
  config.vm.box = "lucid64"
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"
  
  # share folder setup
  config.vm.share_folder("v-root", "/vagrant", ".", :owner => "www-data", :group => "vagrant")
  
  # gui will help debug
  config.vm.boot_mode = :gui
  
  # network setup
  config.vm.network :hostonly, "33.33.33.33"
  
  # puppet setup
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet"
    puppet.manifest_file  = "manifest.pp"
  end
end