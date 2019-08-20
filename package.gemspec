Gem::Specification.new do |spec|
  spec.name                  = 'halumi'
  spec.version               = '0.2.4'
  spec.date                  = '2019-03-02'
  spec.summary               = 'Use query objects as flexible building blocks'
  spec.authors               = ['Piotr Wald']
  spec.email                 = ['valdpiotr@gmail.com']
  spec.require_paths         = ['lib']
  spec.license               = 'MIT'
  spec.files                 = Dir['LICENSE', 'README.md', 'lib/**/*']
  spec.homepage              = 'https://github.com/PiotrWald/halumi'
  spec.test_files            = spec.files.grep(/spec/)
  spec.required_ruby_version = '> 2.2'

  spec.add_runtime_dependency 'activerecord'
  spec.add_runtime_dependency 'dry-types', '~> 0.14.0'

  spec.add_development_dependency 'rspec', '~> 3.6.0'
end
