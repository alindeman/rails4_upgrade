# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails4_upgrade/version'

Gem::Specification.new do |gem|
  gem.name          = "rails4_upgrade"
  gem.version       = Rails4Upgrade::VERSION
  gem.authors       = ["Andy Lindeman"]
  gem.email         = ["alindeman@gmail.com"]
  gem.description   = %q{Upgrade assistant for transitioning applications from Rails 3 to Rails 4}
  gem.summary       = %q{Upgrade assistant for transitioning applications from Rails 3 to Rails 4}
  gem.homepage      = "http://www.upgradingtorails4.com/"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "bundler", ">=1.2.0"

  gem.add_development_dependency "rspec",    "~>2.12.0"
  gem.add_development_dependency "vcr",      "~>2.3.0"
  gem.add_development_dependency "webmock",  "~>1.8.0"
end
