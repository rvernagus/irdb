require "spec/sql_server/spec_helper"

class MSpecScript
  # Invalid argument exception when using * patterns below
  #  from ExpandPath
  # Thus the use of Dir.glob
  set :files, Dir.glob("spec/sql_server/**/*_spec.rb")
  
  # RUBY_EXE must be full path to ir.exe
  if ENV["RUBY_EXE"]
    set :target, ENV["RUBY_EXE"]
  else
    puts "Must specify full path to ir.exe in ENV['RUBY_EXE']"
    exit
  end
end
