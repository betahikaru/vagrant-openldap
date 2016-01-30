# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define "ldap-server" do |server|
    server.vm.box = "puphpet/centos65-x64"
    server.vm.hostname = "ldapserver"
    server.vm.network "private_network", ip: "192.168.33.20"
    server.vm.synced_folder "data/server/", "/vagrant"
    server.vm.provision "shell", inline: <<-SHELL
      sudo yum install -y openldap openldap-servers openldap-clients
      yum list installed openldap
      #rm -rf /etc/openldap/slapd.d/*
      #rm -rf /var/lib/ldap/*
      echo ldap-server provisioned.
    SHELL
  end

  config.vm.define "ldap-client" do |client|
    client.vm.box = "puphpet/centos65-x64"
    client.vm.hostname = "ldapclient"
    client.vm.network "private_network", ip: "192.168.33.21"
    client.vm.synced_folder "data/client/", "/vagrant"
  end

end
