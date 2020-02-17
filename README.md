# vagrant-subdomains-updater

[![Gem Version](https://badge.fury.io/rb/vagrant-subdomains-updater.svg)](http://badge.fury.io/rb/vagrant-subdomains-updater)
[![Code Climate](https://codeclimate.com/github/illuin-tech/vagrant-subdomains-updater/badges/gpa.svg)](https://codeclimate.com/github/illuin-tech/vagrant-subdomains-updater)

## Introduction

`vagrant-subdomains-updater` allows you to automatically configure subdomains with the ip of your vagrant instance using your registrar API.

Difference with the [upstream](https://github.com/nasskach/vagrant-dns-updater) : `vagrant-subdomains-updater` handles multiple subdomains instead of a single one.

## Important
- This plugin is currently only compatible with Linux guests.
- autodetect interface if no interface specified
- Only OVH registrar is supported for the moment.

## Installation

    $ vagrant plugin install vagrant-subdomains-updater

## Usage

Configuration example for OVH:

```ruby
Vagrant.configure(2) do |config|
    # for the moment only "ovh" is supported
    config.subdomainsupdater.registrar = "ovh"

    # API credentials, specific to OVH
    # for more information read the OVH section below
    config.subdomainsupdater.appkey = "XXXXXXXX"
    config.subdomainsupdater.appsecret = "YYYYYYYYYYYYYYYYYY"
    config.subdomainsupdater.consumerkey = "ZZZZZZZZZZZZZZZZZZZ"

    # domain settings, test.mydomain.com in our example
    config.subdomainsupdater.zone = "mydomain.com"
    config.subdomainsupdater.subdomains = ["test"]

    # the network interface on which retreive the ip
    config.subdomainsupdater.interface = "eth2"

    # ttl is optional, default value is set to 60 seconds
    config.subdomainsupdater.ttl = "120"
end
```

## Registrars
### OVH

First you need an `appkey` and an `appsecret` which can be obtained [here](https://www.ovh.com/fr/cgi-bin/api/createApplication.cgi).

You will also need a `consumerkey`, you can get it using the `ovh-consumer-key` command provided by this plugin:

```
vagrant ovh-consumer-key <appkey>
```

This command will display a `consumerkey` and a `validationUrl`, the `consumerkey` need a validation before use, this
can be done by following the `validationUrl` and entering your credentials.

Finally you can add the following parameters to your Vagrantfile.

```ruby
Vagrant.configure(2) do |config|
    config.subdomainsupdater.registrar = "ovh"
    config.subdomainsupdater.appkey = "XXXXXXXX"
    config.subdomainsupdater.appsecret = "YYYYYYYYYYYYYYYYYY"
    config.subdomainsupdater.consumerkey = "ZZZZZZZZZZZZZZZZZZZ"
    config.subdomainsupdater.zone = "mydomain.com"
    config.subdomainsupdater.subdomains = ["test"]
    config.subdomainsupdater.interface = "eth2"
end
```

## ToDo

- Improve error handling.
- Support additional registrars : gandi, ultradns, ...
- Write tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/illuin-tech/vagrant-subdomains-updater.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

