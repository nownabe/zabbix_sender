require "json"
require "socket"

require "zabbix_sender_legacy/sender"

module ZabbixSenderLegacy
  MissingConfigFile = Class.new(StandardError)
  MissingServerActiveConfig = Class.new(StandardError)

  class << self
    def from_config(config_path = "/etc/zabbix/zabbix_agentd.conf")
      unless File.exist?(config_path)
        raise MissingConfigFile, "Missing config file with #{config_path}"
      end
      host, port = parse_config(config_path)
      Sender.new(zabbix_host: host, zabbix_port: port)
    end

    def new(zabbix_host="127.0.0.1", zabbix_port=10051)
      Sender.new(zabbix_host: zabbix_host, zabbix_port: zabbix_port)
    end

    private

    def parse_config(config_path)
      unless /^ServerActive\s*=\s*(?<server>[\w\-:,\.\[\]]+)\s*$/ =~ File.read(config_path)
        raise MissingServerActiveConfig, "Missing ServerActive config in #{config_path}"
      end 
      host, port = server.split(":")
      port ||= 10051
      [host, port.to_i]
    end
  end
end
