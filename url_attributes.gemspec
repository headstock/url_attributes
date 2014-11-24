# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'url_attributes/version'

Gem::Specification.new do |s|
  s.name          = "url_attributes"
  s.version       = URLAttributes::VERSION
  s.authors       = ["George Millo"]
  s.email         = ["georgejulianmillo@gmail.com"]
  s.summary       = "Simple URL attributes for ActiveRecord"
  s.description   = "Validate and sanitize URLs in ActiveRecord"
  s.homepage      = 'http://github.com/headstock/url_attributes'
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 4.0.0"

  s.add_development_dependency "bundler", "~> 1.7"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec-rails", ">= 3.0.0"
  s.add_development_dependency "activerecord-nulldb-adapter", '~> 0.3.1'
  s.add_development_dependency "sqlite3", "~> 1.3.10"
end
