require 'rubygems'
require 'rake'
require 'rake/testtask'

desc "Default Task"
task :default => [ :test ]
task :db_tests => [ :sql_client_test ]

# Run the unit tests
Rake::TestTask.new { |t|
  t.libs << "test"
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = true
}

# Run SQLServer tests
Rake::TestTask.new { |t|
  t.name = "sql_client_test"
  t.libs << "test"
  t.pattern = 'sql_client_test/**/*_test.rb'
  t.verbose = true
  t.warning = true
}
