# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webmock/net/http/pipeline/version'

Gem::Specification.new do |spec|
  spec.name          = "webmock-net-http-pipeline"
  spec.version       = WebMock::NetHTTPPipeline::VERSION
  spec.authors       = ["Tim Blair", "Mat Sadler"]
  spec.email         = ["tim@bla.ir", "mat@sourcetagsandcodes.com"]
  spec.summary       = %q{Use WebMock to test your use of pipelined HTTP requests.}
  spec.description   = %q{Mimics net-http-pipeline's behaviour within WebMock's Net::HTTP implementation, allowing you to mock and test your pipelined HTTP calls.}
  spec.homepage      = "http://github.com/globaldev/webmock-net-http-pipeline"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "webmock", "~> 1.8"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rake"
end
