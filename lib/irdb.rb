$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
require "irdb/database"
require "irdb/provider_factory"
begin
  require "System.Data"
rescue LoadError
  # Assume not running IronRuby
  # Only .NET dependency is in ProviderFactory
end
