require "spec/core/spec_helper"

# By default, core specs are run with MRI Ruby
# This will continue until IronRuby fixes ExpandPath bugs (and gets faster)
class MSpecScript
  set :files, ["spec/core/**/*_spec.rb"]
end
