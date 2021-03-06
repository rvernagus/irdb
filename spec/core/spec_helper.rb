dir_path = File.dirname(__FILE__)
lib_path = File.expand_path(dir_path + "/../../lib")
helpers_path = File.expand_path(dir_path +"/../../spec/helpers")
$:.unshift lib_path unless $:.include? lib_path
$:.unshift helpers_path unless $:.include? helpers_path

require "irdb"
require "fake_system_data"
require "fake_provider"
require "fake_reader"
include IRDb
