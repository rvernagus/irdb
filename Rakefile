require 'rake'
require 'rake/testtask'

test_files_pattern = 'test/**/*_test.rb'
Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = test_files_pattern
  t.verbose = false
end

desc 'Default: run tests.'
task :default => ['test']