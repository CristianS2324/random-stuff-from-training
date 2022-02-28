Vagrant.configure("2") do |config|
  #define vm specs and ip
  
    os = "generic/ubuntu2004"
    config.vm.define :ubuntuserver do |ubuntuserver_config|
        ubuntuserver_config.vm.provider "Hyper-V" do |spec|
            spec.memory = "3072"
            spec.cpus = 2
            spec.name = "random-ubuntu-vm"
        end
        ubuntuserver_config.vm.host_name = 'ubuntu'
        ubuntuserver_config.vm.box = "#{os}"
        ubuntuserver_config.vm.network "private_network", ip: "192.168.17.70"
        ubuntuserver_config.vm.provision "shell", inline: <<-SHELL
		
		
  #set root password and disable ipv6
  
	echo "root:23241012" | chpasswd
	echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf
	echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.conf
	echo "net.ipv6.conf.lo.disable_ipv6=1" >> /etc/sysctl.conf
	sudo sysctl -p
	
	
  #firewall config to allow ssh and open port 22
  
	ufw default deny incoming
	ufw default allow outgoing
	ufw allow OpenSSH
	ufw allow ssh
	ufw allow 22
	ufw enable
	
   # set static ip
    sudo cat << EOF > /etc/netplan/01-netcfg.yaml
    network:
      version: 2
      renderer: networkd
      ethernets:
        eth0:
          dhcp4: no
          addresses:
            - 192.168.17.70/24
          gateway4: 192.168.17.1
          nameservers:
            addresses: [8.8.8.8, 1.1.1.1]
EOF
    sudo cat /etc/netplan/01-netcfg.yaml
    sudo netplan apply
	
  #ssh config to login without password
  
	echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
	mkdir ~/.ssh
	touch authorized_keys ~/.ssh/
	systemctl restart ssh
	echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDHQwA9kkvQ8gWQ/dwZ1Feu8kpq/T5Zz/LxwXfumU+aUiP10fThAwXwVIqVn8g8vSLla3f173sEwmHdsuZq1VSyNJhudPxg1E3iUDvz2Dx54px9CKRUIVP94D6O8UoRgLxh55FkLm1R2oqIG4YyGKOVfHEN1R6Ti0fqkgB3faSLgJ24jC51ObZqSGevuD0BjOOIdICsaSZc46nEstajomwqKiwTzeHs6urWGHBCPG1d8fU9wg6w78e72zk8NsLFmSplL+02cwu8GHAsnZdFlguoGrrM1S/S5nm3Z6V7PsXrdn3QYlIezdY0Y1Xm84cB1YKZe2WCPinqA4E36NrT4HKWFwluiWJDD8HLGtRujkc9WMSto38vi+EYboCzQNHzBfBbBBXvf05qXJWFfBOYUZf+tGQYBNwtfAjPjqJ9z+fM1wHXH/Suy4BG79BlOMt6HTQ9GmUPPTDikaQttDsMzpWZ34jwCFJRUk2zxbY3ol67onr1InOWX2p2wQR/gdvja0E= yonder\csuciuc@cSuciuc-LAP" >> ~/.ssh/authorized_keys
        SHELL
		

	end
end