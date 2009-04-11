dir_path = File.dirname(__FILE__)
lib_path = File.expand_path(dir_path + "/../../lib")
$:.unshift lib_path unless $:.include? lib_path

require "irdb"
include IRDb

module OracleHelper
  def get_database
    provider_factory = DbProviderFactory.new
    provider = provider_factory.create_provider("System.Data.OracleClient")
    
    cstr = "server=xe;user=irdb;password=irdb;"
  
    Database.new(provider, cstr)
  end
end
