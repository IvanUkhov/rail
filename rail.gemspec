lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rail/version'

Gem::Specification.new do |spec|
  spec.name          = 'rail'
  spec.version       = Rail::VERSION
  spec.authors       = ['Ivan Ukhov']
  spec.email         = ['ivan.ukhov@gmail.com']
  spec.summary       = 'A light framework for front-end development ' \
                       'inspired by Rails'
  spec.description   = 'A light framework for front-end development ' \
                       'closely following the conventions of Ruby on Rails.'
  spec.homepage      = 'https://github.com/IvanUkhov/rail'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency 'coffee-script', '~> 2.4'
  spec.add_dependency 'haml', '~> 4.0'
  spec.add_dependency 'rack', '~> 1.6'
  spec.add_dependency 'rake', '~> 11.2'
  spec.add_dependency 'sass', '~> 3.4'
  spec.add_dependency 'uglifier', '~> 3.0'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'rspec', '~> 3.4'
end
