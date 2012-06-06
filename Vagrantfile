Vagrant::Config.run do |config|
  config.vm.box = "lucid64"
  
  #config.vm.boot_mode = :gui
  
  config.vm.network :hostonly, "33.33.33.33"
  config.vm.provision :puppet
end