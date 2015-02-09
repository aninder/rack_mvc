# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack_mvc/version'

Gem::Specification.new do |spec|
  spec.name          = "rack_mvc"
  spec.version       = RackMvc::VERSION
  spec.authors       = ["aninder"]
  spec.email         = ["aninder@gmail.com"]
  spec.summary       = %q{rack based mvc}
  spec.description   = %q{Rack MVC}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "pry"
  spec.add_runtime_dependency "pry-stack_explorer"
  spec.add_runtime_dependency "pry-doc"
  spec.add_runtime_dependency "pry-nav"
  spec.add_runtime_dependency "byebug"
  spec.add_runtime_dependency "rack"
  spec.add_runtime_dependency "tilt"
  spec.add_runtime_dependency "erubis"
end
