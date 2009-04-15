require "spec/oracle/spec_helper"

class MSpecScript
  # Invalid argument exception when using * patterns below
  #  from ExpandPath
  # Thus the use of Dir.glob
  set :files, Dir.glob("spec/oracle/**/*_spec.rb")
  
  # RUBY_EXE must be full path to ir.exe
  set :target, ENV["RUBY_EXE"]
end
