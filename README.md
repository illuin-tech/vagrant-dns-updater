# vagrant-dns-updater

[![Gem Version](https://badge.fury.io/rb/vagrant-dns-updater.svg)](http://badge.fury.io/rb/vagrant-dns-updater)

## Introduction

`vagrant-dns-updater` allows you to automatically configure a subdomain with the ip of your vagrant instance using your registrar API.

## Important
- This plugin is currently only compatible with Linux guests.
- Only OVH registrar is supported for the moment.

## Installation

    $ vagrant plugin install vagrant-dns-updater

## Usage

Configuration example for OVH:

```ruby
Vagrant.configure(2) do |config|
    # for the moment only "ovh" is supported
    config.dnsupdater.registrar = "ovh"

    # API credentials, specific to OVH
    # for more information read the OVH section below
    config.dnsupdater.appkey = "XXXXXXXX"
    config.dnsupdater.appsecret = "YYYYYYYYYYYYYYYYYY"
    config.dnsupdater.consumerkey = "ZZZZZZZZZZZZZZZZZZZ"

    # domain settings, test.mydomain.com in our example
    config.dnsupdater.zone = "mydomain.com"
    config.dnsupdater.subdomain = "test"

    # the network interface on which retreive the ip
    config.dnsupdater.interface = "eth2"

    # ttl is optional, default value is set to 60 seconds
    config.dnsupdater.ttl = "120"
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
    config.dnsupdater.registrar = "ovh"
    config.dnsupdater.appkey = "XXXXXXXX"
    config.dnsupdater.appsecret = "YYYYYYYYYYYYYYYYYY"
    config.dnsupdater.consumerkey = "ZZZZZZZZZZZZZZZZZZZ"
    config.dnsupdater.zone = "mydomain.com"
    config.dnsupdater.subdomain = "test"
    config.dnsupdater.interface = "eth2"
end
```

## ToDo

- Improve error handling.
- Support additional registrars : gandi, ultradns, ...
- Write tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/blueicefield/vagrant-dns-updater.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

