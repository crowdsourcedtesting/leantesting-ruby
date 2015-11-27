Gem::Specification.new do |s|
	s.name        = 'leantesting'
	s.version     = '1.0.0'
	s.date        = '2015-11-20'
	s.platform    = Gem::Platform::RUBY
	s.summary     = 'Lean Testing Ruby SDK'
	s.description = 'Lean Testing Ruby SDK'
	s.authors     = ['Marcel Bontaș']
	s.email       = ['marcel.bontas@yandex.ru']
	s.files       = Dir['lib/**/*', 'tests/**/*'] + ['Gemfile', 'leantesting.gemspec', 'LICENSE', 'Rakefile', 'README.md']
	s.homepage    = 'https://leantesting.com/'
	s.license     = 'proprietary'
	s.require_path= 'lib'

	s.add_dependency 'json', '~> 1.8'
	s.add_dependency 'curb', '~> 0.8'

	s.add_development_dependency 'minitest', '~> 5.8'
	s.add_development_dependency 'mocha', '~> 1.1'
end
