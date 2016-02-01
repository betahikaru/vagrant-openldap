# -*- mode: ruby -*-
# vi: set ft=ruby :

# refer: http://qiita.com/T_Tsan/items/3d76b9b03792e4e9ce1d
# refer: http://unixlife.jp/linux/centos-6/openldap-setting.html
# refer: https://www.ipa.go.jp/security/pki/064.html
#
Vagrant.configure(2) do |config|
  config.vm.define "ldap-server" do |server|
    server.vm.box = "puphpet/centos65-x64"
    server.vm.hostname = "ldapserver"
    server.vm.network "private_network", ip: "192.168.33.20"
    server.vm.synced_folder "data/server/", "/vagrant"
    server.vm.provision "shell", inline: <<-SHELL
      sudo yum install -y openldap openldap-servers openldap-clients
      yum list installed openldap

      sudo rm -rf /etc/openldap/slapd.d/*
      sudo rm -rf /var/lib/ldap/*
      sudo cp /vagrant/slapd.conf /etc/openldap/slapd.conf
      sudo cp /vagrant/DB_CONFIG /var/lib/ldap/DB_CONFIG
      sudo chown ldap.ldap -R /var/lib/ldap/

      sudo -u ldap slaptest -u -v
      sudo -u ldap slaptest -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d
      sudo chkconfig slapd on
      sudo /etc/init.d/slapd start

      sudo -u ldap ldapadd -x -D "cn=Manager,dc=betahikaru,dc=com" \
        -f /vagrant/ldif/base.ldif -w passwd
      sudo -u ldap ldapadd -x -D "cn=Manager,dc=betahikaru,dc=com" \
        -f /vagrant/ldif/group.ldif -w passwd
      sudo -u ldap ldapadd -x -D "cn=Manager,dc=betahikaru,dc=com" \
        -f /vagrant/ldif/user.ldif -w passwd
      echo ldap-server provisioned.
    SHELL
  end

  config.vm.define "ldap-client" do |client|
    client.vm.box = "puphpet/centos65-x64"
    client.vm.hostname = "ldapclient"
    client.vm.network "private_network", ip: "192.168.33.21"
    client.vm.synced_folder "data/client/", "/vagrant"
    client.vm.provision "shell", inline: <<-SHELL
      sudo yum install -y authconfig nss-pam-ldapd openldap-clients
      sudo authconfig --enableldap --enableldapauth --enablemkhomedir \
        --ldapserver="ldap://192.168.33.21/" \
        --ldapbasedn="dc=betahikaru,dc=com" --update
      sudo chkconfig nslcd on
    SHELL
  end

end
