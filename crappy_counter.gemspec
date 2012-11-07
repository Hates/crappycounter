# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crappy_counter/version'

Gem::Specification.new do |gem|
  gem.name          = "CrappyCounter"
  gem.version       = CrappyCounter::VERSION
  gem.authors       = ["Richard Hart"]
  gem.email         = ["richard@ur-ban.com"]
  gem.description   = %q{Crappy redis counter}
  gem.summary       = %q{Crappy redis counter}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
end
