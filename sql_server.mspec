require "spec/sql_server/spec_helper"

class MSpecScript
  # Invalid argument exception when using * patterns below
  #  from ExpandPath
  # That's why each file is individually listed
  set :files, [
    "spec/sql_server/command_spec.rb",
    ]
  
  # Have to specify full path here on Windows...mspec gives
  #  an exception otherwise
  set :target, "c:/rvernagus/dev/ironruby/bin/ir.exe"
end
