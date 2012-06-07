###Setup
===
* Make sure you have Vagrant and VirtualBox installed
* Clone this repo
* Open the cloned folder in your terminal and write "vagrant up" to start the server 
* you can now see the index fiel by going to 33.33.33.33 in your browser

add projects in the "sites" folder


###Bugs
===
the "vagrant up" command can get stock on "Waiting for VM to boot" if this happens use Ctrl+c to stop the command and then sendt "vagrant halt -f" and try agian (https://github.com/mitchellh/vagrant/issues/391)
use gui -> login (vagrant/vagrant) run "sudo dhclient"