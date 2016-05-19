require "json"

module ZabbixSender
  # Zabbix Sender protocol:
  #
  # https://www.zabbix.org/wiki/Docs/protocols
  # https://www.zabbix.com/documentation/2.4/manual/appendix/items/activepassive
  #
  # <HEADER><DATA LENGTH><DATA>
  #
  # HEADER - "ZBXD\x01"
  # DATA LENGTH - data length (8 bytes, little endian)
  # DATA - JSON, see data method
  class Request
    HEADER = "ZBXD\x01"

    attr_reader :host, :key, :value

    def initialize(host, key, value)
      @host  = host
      @key   = key
      @value = value
    end

    def send(socket)
      socket.write(encoded_data)
      @raw_header = socket.read(HEADER.bytesize + 8)
      datalen = @raw_header[HEADER.bytesize, 8].unpack("Q")[0]
      @raw_response = socket.read(datalen)
      response
    end

    def response
      @response ||= JSON.parse(@raw_response)
    end

    private

    def data
      @data ||=
        {
          request: "sender data",
          data: [
            {
              host: host,
              key: key,
              value: value
            }
          ]
        }.to_json
    end

    def data_length
      [data.size].pack("Q").force_encoding("UTF-8")
    end

    def encoded_data
      "#{HEADER}#{data_length}#{data}"
    end
  end
end
