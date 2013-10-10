# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ir_ptz/version'

Gem::Specification.new do |spec|
  spec.name          = "ir_ptz"
  spec.version       = IrPtz::VERSION
  spec.authors       = ["Will Mernagh"]
  spec.email         = ["wmernagh@gmail.com"]
  spec.description   = %q{CLI to control a Pan Tilt Zoom Camera by InfraRed via an Arduino}
  spec.summary       = %q{see homepage}
  spec.homepage      = "https://github.com/wmernagh/ir_ptz"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "arduino_ir_remote", "~> 0.1.1"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "bourne"
end
