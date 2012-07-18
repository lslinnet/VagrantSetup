#VagrantSetup

###Decription:
===
This repo is my personal [Vagrant](http://vagrantup.com/) setup, that I use to have the same develop environment on all my computeres. if you like it feel free to fork/clone and use it!

It's using [puppet](http://puppetlabs.com/) to configure the server:
	
	/puppet/manifest.pp: This is configuration file whre all the magic is going on
	/puppet/default.conf: This is the file that controls the VitualHosts
	/puppet/php.ini: This is the php.ini file for the server
	
This setup is design to have all my projects inside the /sites directory and then adding them to /puppet/default.conf and my hosts file on the computer I'm using.

###Setup:
===
* Make sure you have [Vagrant](http://vagrantup.com/) and [VirtualBox](https://www.virtualbox.org/) installed
* Clone this repo
* Open the cloned folder in your terminal and run "vagrant up" to start the server 
* Go to [33.33.33.33](http://33.33.33.33) in a browser to see the php.ini file!

#####"Advanced" setup:
Add this to youre hosts file on the local computer whit youre favorit editor (I use [Gas Mask](http://www.clockwise.ee/gasmask/) to do this)

	# Vagrant
	33.33.33.33		vagrant.local

You can now visit the server by going to [vagrant.local](http://vagrant.local)

###Bugs
===
#####The "vagrant up" command can get stock on "Waiting for VM to boot" [issue](https://github.com/mitchellh/vagrant/issues/391)

######Solution 1: 
	Ctrl+c to stop the command and then run "vagrant halt -f" and try agian 

######Solution 2:
	Outcommet config.vm.boot_mode = :gui in the Vagrantfile on line 10 
	Login using (vagrant/vagrant) and then run "sudo dhclient"