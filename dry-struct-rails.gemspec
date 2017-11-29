# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dry/struct/rails/version"

Gem::Specification.new do |spec|
  spec.name          = "dry-struct-rails"
  spec.version       = Dry::Struct::Rails::VERSION
  spec.authors       = ["Robert Schulze"]
  spec.email         = ["robert@dotless.de"]

  spec.summary       = %q{Dry::Struct railties}
  spec.description   = %q{Rails reloading for `dry-struct`}
  spec.homepage      = "https://github.com/fnordfish/dry-struct-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "combustion", "~> 0.7.0"
  spec.add_development_dependency "rspec-rails", "~> 3.7"

  spec.add_runtime_dependency "rails", ">= 5.1"
  spec.add_runtime_dependency "dry-struct", "~> 0.4.0"
end
