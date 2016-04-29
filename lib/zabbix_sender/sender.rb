require "socket"

require "zabbix_sender/request"

module ZabbixSender
  class Sender
    attr_reader :zabbix_host, :zabbix_port

    def initialize(zabbix_host: "127.0.0.1", zabbix_port: 10051)
      @zabbix_host = zabbix_host
      @zabbix_port = zabbix_port
    end

    def post(host, key, value)
      request = Request.new(host, key, value)
      begin
        socket = TCPSocket.new(zabbix_host, zabbix_port)
        request.send(socket)
      ensure
        socket.close if socket
      end
    end

    private

    def decode(raw_data)
      JSON.parse(raw_data[13..-1])
    end
  end
end
