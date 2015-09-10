# vagrant-dns-updater

`vagrant-dns-updater` allows you to automatically configure a subdomain with the ip of your vagrant instance using your registrar API.

## Important
- This plugin is currently only compatible with Linux guests.
- Only OVH registrar is supported for the moment.

## Installation

    $ vagrant plugin install vagrant-dns-updater

## Usage

Configuration example for OVH :

```ruby
Vagrant.configure(2) do |config|
    # for the moment only "ovh" is supported
    config.dnsupdater.provider = "ovh"

    # API credentials, specific to OVH
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

## ToDo

- Improve error handling.
- Support additional registrars : gandi, ultradns, ...
- Write tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/blueicefield/vagrant-dns-updater.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

