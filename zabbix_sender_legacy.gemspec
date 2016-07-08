# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zabbix_sender_legacy/version'

Gem::Specification.new do |spec|
  spec.name          = "zabbix_sender_legacy"
  spec.version       = ZabbixSenderLegacy::VERSION
  spec.authors       = ["lehn-etracker"]
  spec.email         = ["lehn@etracker.com"]

  spec.summary       = %q{Zabbix Sender gem for ruby < 2.0}
  spec.homepage      = "https://github.com/lehn-etracker/zabbix_sender_legacy"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
end
