# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minified_erb/version'

Gem::Specification.new do |spec|
  spec.name          = 'minified_erb'
  spec.version       = MinifiedErb::VERSION
  spec.authors       = ['Roman Usherenko']
  spec.email         = ['roman.usherenko@gmail.com']

  spec.summary       = 'Minified HTML generator for popular ERB implementations'
  spec.homepage      = 'https://github.com/dreyks/minified_erb'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'fuubar'
  spec.add_development_dependency 'cells-erb'
  spec.add_development_dependency 'actionview', '~> 5.0.0.rc1'
end
