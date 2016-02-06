vagrant-openldap
=================

Provisioning OpenLDAP Server and Client, by Vagrant.

```
+-----------------------------------------------------------+
|                                                           |
|  +-------------------+             +-------------------+  |
|  |                   |             |                   |  |
|  |    ldap-server    |   search    |   ldap-client     |  |
|  | (openldap-server) | <---------+ | (openldap-client) |  |
|  |    192.168.33.20  |             |   192.168.33.21   |  |
|  |                   |             |                   |  |
|  +-------------------+             +-------------------+  |
|  centos6.5 (virtualbox)            centos6.5 (virtualbox) |
|       ^                                  ^                |
|       +----------------------------------+                |
|       +                                                   |
|  vagrant up                                               |
|                                                           |
+-----------------------------------------------------------+
   OS X
```

We use following.
- OSX 10.10
- VitualBox 5.0.14
- Vagrant 1.8.1
- [asciiflow](http://asciiflow.com) (draw graph)

## Setup

```shell
vagrant up
vagrant ssh-config >> ~/.ssh/config
```

## Usage

```shell
# by openldap-client
vagrant ssh ldap-client
id taro.suzuki

# by ruby (net-ldap gem)
cd client
bundle install --path vendor/bundle
bundle exec ruby app.rb
```

## FYI

- LDAP Client Tool : [Active Directory Studio](Active Directory Studio)

## License
MIT

## Authors
- [@betahikaru](https://twitter.com/betahikaru)


