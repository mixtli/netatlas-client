# -*- encoding: utf-8 -*-
require File.expand_path('../lib/netatlas/client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["mixtli"]
  gem.email         = ["ronmcclain75@gmail.com"]
  gem.description   = %q{Client libraries and utilities for NetAtlas}
  gem.summary       = %q{Client libraries and utilities for NetAtlas}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "netatlas-client"
  gem.require_paths = ["lib"]
  gem.version       = NetAtlas::Client::VERSION
  gem.add_dependency 'json'
  gem.add_dependency 'faraday'
  gem.add_dependency 'faraday_middleware'
  gem.add_dependency 'i18n'
  gem.add_dependency 'active_support'
  gem.add_runtime_dependency('gli', '2.0.0.rc4')  

  gem.add_dependency 'command_line_reporter'
end
