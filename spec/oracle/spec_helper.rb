dir_path = File.dirname(__FILE__)
lib_path = File.expand_path(dir_path + "/../../lib")
$:.unshift lib_path unless $:.include? lib_path

require "irdb"
require "yaml"
include IRDb

$config = YAML.load_file(dir_path + "/config.yaml")

module OracleHelper
  def get_database
    provider_factory = DbProviderFactory.new
    provider = provider_factory.create_provider($config[:provider])
    db = Database.new(provider, $config[:cstr])
    
    $config[:setup].each do |sql|
      db.execute_non_query(sql) rescue nil
    end
    db
  end
end
