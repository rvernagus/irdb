require "spec/core/spec_helper"

# By default, core specs are run with MRI Ruby
# This will continue until IronRuby fixes ExpandPath bugs (and gets faster)
class MSpecScript
  # Invalid argument exception when using * patterns below
  #  from ExpandPath
  # Thus the use of Dir.glob
  #set :files, Dir.glob("spec/core/**/*_spec.rb")
  set :files, [
                "spec/core/database/add_parameter_spec.rb",
                "spec/core/database/columns_spec.rb",
                "spec/core/database/command_spec.rb",
                "spec/core/database/connection_spec.rb"
              ]
  
  # RUBY_EXE must be full path to ir.exe
  if ENV["RUBY_EXE"]
    set :target, ENV["RUBY_EXE"]
  else
    puts "Must specify full path to ir.exe in ENV['RUBY_EXE']"
    exit
  end
end
