Gem::Specification.new do |s|
  s.name         = 'retry_anything'
  s.summary      = 'Wrap an operation that may throw an exception, allowing retries'
  s.description  = ''
  s.version      = '0.0.1'
  s.platform     = Gem::Platform::RUBY

  s.files        = ['lib/retry_anything.rb']
  s.require_paths = ["lib"]

  s.author      = 'Tim "Roger" Harvey'
  s.email       = 'tim@theharveys.org'
  s.homepage    = 'http://github.com/tjh'

  s.test_file    = 'spec/retry_anything_spec.rb'
  s.add_development_dependency('rspec', ["~> 2.11"])
end

