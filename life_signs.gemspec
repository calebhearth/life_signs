# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'life_signs/version'

Gem::Specification.new do |spec|
  spec.name          = 'life_signs'
  spec.version       = LifeSigns::VERSION
  spec.authors       = ['Caleb Thompson']
  spec.email         = ['cjaysson@gmail.com']
  spec.summary       = 'there seems to be no sign of intelligent life anywhere'
  spec.description   = <<-DESCRIPTION
    Create activity streams in your application which can be easily filtered by
    who or what created the activity or by the type of content.
  DESCRIPTION
  spec.homepage      = 'https://github.com/calebthompson/life_signs'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 3.2'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'generator_spec'
end
