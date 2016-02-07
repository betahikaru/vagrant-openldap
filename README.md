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
- [jq](https://stedolan.github.io/jq/) (format output)
- [asciiflow](http://asciiflow.com) (draw graph)

## Setup

```shell
vagrant up
vagrant ssh-config >> ~/.ssh/config
```

## Usage

- Use openldap-client

```shell
vagrant ssh ldap-client
id taro.suzuki

# output
uid=1001(taro.suzuki) gid=1000(test1) 所属グループ=1000(test1)
```

- Use ruby (net-ldap gem)

```shell
cd client
bundle install --path vendor/bundle
bundle exec ruby app.rb | jq .

# output
{
  "list": [
    {
      "DN": "uid=taro.suzuki,ou=People,dc=betahikaru,dc=com",
      "attributes": {
        "dn": "uid=taro.suzuki,ou=People,dc=betahikaru,dc=com",
        "objectclass": [
          "shadowAccount",
          "posixAccount",
          "account",
          "top"
        ],
        "cn": "Taro Suzuki",
        "uid": "taro.suzuki",
        "uidnumber": "1001",
        "gidnumber": "1000",
        "homedirectory": "/home/taro.suzuki",
        "loginshell": "/bin/bash",
        "shadowmin": "0",
        "shadowmax": "99999",
        "shadowwarning": "7",
        "shadowlastchange": "16175",
        "userpassword": "{md5}dqIXO+Y5MlTnL/pNbfEDCg=="
      }
    }
  ]
}
```

## FYI

- LDAP Client Tool : [Active Directory Studio](Active Directory Studio)

## License
MIT

## Authors
- [@betahikaru](https://twitter.com/betahikaru)


