lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rail/version'

Gem::Specification.new do |spec|
  spec.name          = 'rail'
  spec.version       = Rail::VERSION
  spec.authors       = [ 'Ivan Ukhov' ]
  spec.email         = [ 'ivan.ukhov@gmail.com' ]
  spec.summary       = 'Less is more'
  spec.description   = 'Less is more'
  spec.homepage      = 'https://github.com/IvanUkhov/rail'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = [ 'lib' ]

  spec.add_dependency 'rake'

  spec.add_dependency 'sprockets', '~> 2.12'

  spec.add_dependency 'coffee-script', '~> 2.2'
  spec.add_dependency 'haml', '~> 4.0'
  spec.add_dependency 'sass', '~> 3.3'

  spec.add_dependency 'uglifier', '~> 2.5'

  spec.add_development_dependency 'bundler', '~> 1.6'
end
