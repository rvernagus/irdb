$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
require "netdb/database"
require "netdb/provider_factory"
begin
  require "System.Data"
rescue LoadError
  # Assume not running IronPython
  # Only .NET dependency is in ProviderFactory
end
