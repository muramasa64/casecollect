# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'casecollect/version'

Gem::Specification.new do |spec|
  spec.name          = "casecollect"
  spec.version       = Casecollect::VERSION
  spec.authors       = ["ISOBE Kazuhiko"]
  spec.email         = ["muramasa64@gmail.com"]

  spec.summary       = %q{Collect AWS Support cases}
  spec.description   = %q{Collect AWS Support cases}
  spec.homepage      = "https://github.com/muramasa64/collectcase"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "aws-sdk", "2.9.19"
  spec.add_dependency "thor", "0.19.4"
  spec.add_dependency "thor-aws", "0.0.5"
end
