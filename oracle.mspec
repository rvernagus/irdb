require "spec/oracle/spec_helper"

class MSpecScript
  # Invalid argument exception when using * patterns below
  #  from ExpandPath
  # Thus the use of Dir.glob
  set :files, Dir.glob("spec/oracle/**/*_spec.rb")
  
  # Have to specify full path here on Windows...mspec gives
  #  an exception otherwise
  set :target, "c:/rvernagus/dev/ironruby/bin/ir.exe"
end
