# frozen_string_literal: true

require 'date'

Gem::Specification.new do |s|
  s.name     = 'puttext-rails'
  s.version  = '0.0.1'
  s.date     = Date.today.to_s
  s.summary  = 'Extract gettext strings from a Rails application'
  s.authors  = ['Mantas Norvaiša']
  s.email    = 'mntnorv@gmail.com'
  s.homepage = 'https://github.com/mntnorv/puttext-rails'
  s.license  = 'MIT'

  s.files         = `git ls-files`.split
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency('puttext', '>= 0.2.1', '< 1')
  s.add_runtime_dependency('railties', '>= 5.0', '< 6')

  # Tools
  s.add_development_dependency('rake')

  # Testing
  s.add_development_dependency('rspec', '~> 3.5')
  s.add_development_dependency('unindent')
  s.add_development_dependency('timecop')

  # Linters and code policies
  s.add_development_dependency('rubocop', '~> 0.46.0')
  s.add_development_dependency('simplecov')
  s.add_development_dependency('codeclimate-test-reporter', '~> 1.0.0')
end
