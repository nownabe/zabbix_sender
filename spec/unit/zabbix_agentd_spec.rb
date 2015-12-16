require "spec_helper"
require "tempfile"

describe ZabbixSender do
  describe ".from_config" do
    subject { described_class.from_config(config_path) }
    context "has both host and port" do
      let(:config_path) { File.expand_path("../../config/zabbix_agentd.conf.2.4.7", __FILE__) }
      its(:zabbix_host) { is_expected.to eq "server.from-config" }
      its(:zabbix_port) { is_expected.to eq 20051 }
    end

    context "config file does not exist" do
      let(:config_path) { "/path/to/not/exist" }
      it "raises MissingConfigFile" do
        expect { subject }.to raise_error(ZabbixSender::MissingConfigFile)
      end
    end

    context "config file has no `ServerActive`" do
      let(:config_path) { __FILE__ }
      it "raises MissingServerActiveConfig" do
        expect { subject }.to raise_error(ZabbixSender::MissingServerActiveConfig)
      end
    end

    context "config file has only host" do
      around do |example|
        Tempfile.create("zabbix_sender") do |f|
          File.write(f.path, "ServerActive=server.from-config")
          @config_path = f.path
          example.run
        end
      end
      let(:config_path) { @config_path }
      its(:zabbix_host) { is_expected.to eq "server.from-config" }
      its(:zabbix_port) { is_expected.to eq 10051 }
    end
  end
end
