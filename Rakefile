require "hoe"
require "lib/irdb"

task :default => "spec:core"

Hoe.spec "irdb" do
  developer "Ray Vernagus", "r.vernagus@gmail.com"
end

namespace :spec do |n|
  task :core do |t|
    puts `ir mspec/bin/mspec -B spec/core.mspec`
  end
  
  task :oracle do |t|
    puts `ir mspec/bin/mspec -B spec/oracle.mspec`
  end
  
  task :sql_server do |t|
    puts `ir mspec/bin/mspec -B spec/sql_server.mspec`
  end
end
