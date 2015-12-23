Vagrant.configure("2") do |config|

	config.vm.box = "ubuntu/trusty64"
	
	# Nginx
	config.vm.network :forwarded_port, guest: 80, host: 9000, auto_correct: true
	
	# Mongod Daemon
	# Mongod port mapping is set to 27050 for host to avoid conflict with any existing mongod daemon on host machine
	config.vm.network :forwarded_port, guest: 27017, host: 27050, auto_correct: true
	
	config.vm.synced_folder "./", "/vagrant", create: true, id: "vagrant-root", group: "www-data", owner: "www-data", mount_options: ["dmode=775,fmode=664"]
	
	config.vm.provider "virtualbox" do|v|
		v.name = "MEAN_stack_vagrant"
		v.customize ["modifyvm", :id, "--memory", "1024"]
	end
	
	config.vm.provision "shell" do |s|
		s.path = "provision/setup.sh"
	end

	# https://github.com/emyl/vagrant-triggers
	config.trigger.after [:up] do
		#run_remote "supervisor --watch /vagrant/src /vagrant/src/server.js"
		run_remote "bash /vagrant/mongo/restore.sh"
	end
	
	config.trigger.before [:halt] do
		run_remote "bash /vagrant/mongo/backup.sh"
	end	
  
end