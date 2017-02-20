require 'rake/testtask'

Rake::TestTask.new do |t|
	t.libs << :test
	t.test_files = Dir['tests/**/*Test.rb']
	t.verbose = true
end

task default: [:test]
