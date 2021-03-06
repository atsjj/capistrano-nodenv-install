# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = 'capistrano-nodenv-install'
  gem.version       = '1.0.0'
  gem.authors       = ['Steve Jabour']
  gem.email         = ['steve@jabour.me']
  gem.description   = %q{Capistrano plugin for lightweight nodes management with nodenv}
  gem.summary       = %q{Capistrano plugin for lightweight nodes management with nodenv}
  gem.homepage      = 'https://github.com/atsjj/capistrano-nodenv-install'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'capistrano', '~> 3.1'
  gem.add_dependency 'capistrano-nodenv', '~> 1.1'

  gem.add_development_dependency 'rake'
end
