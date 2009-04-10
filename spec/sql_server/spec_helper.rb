dir_path = File.dirname(__FILE__)
lib_path = File.expand_path(dir_path + "/../../lib")
$:.unshift lib_path unless $:.include? lib_path

require "irdb"
include IRDb

module SqlServerHelper
  def get_database
    provider_factory = DbProviderFactory.new
    provider = provider_factory.create_provider("System.Data.SqlClient")
    
    cstr = "Data Source=.\\sqlexpress;Initial Catalog=IRDbTest;Integrated Security=True;"
  
    Database.new(provider, cstr)
  end
end
