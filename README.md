# ZabbixSender
Zabbix Sender gem

[![Gem Version](https://badge.fury.io/rb/zabbix_sender.svg)](https://badge.fury.io/rb/zabbix_sender)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zabbix_sender'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zabbix_sender

## Usage

```ruby
require "zabbix_sender"

sender = ZabbixSender.new(zabbix_host: "some-zabbix", port: 10051)
sender.post("host", "key", "value")
#=> {"response"=>"success", "info"=>"processed: 1; failed: 0; total: 1; seconds spent: 0.000075"}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nownabe/zabbix_sender.

