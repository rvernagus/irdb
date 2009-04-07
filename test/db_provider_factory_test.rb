require "test/unit"
require "lib/irdb"
require "helpers/db_provider_factories"
include IRDb
DbProviderFactories = System::Data::Common::DbProviderFactories

class DbProviderFactoryTest < Test::Unit::TestCase
  def test_calls_dotnet_method
    expected = Object.new
    DbProviderFactories.factory = expected
    provider_factory = DbProviderFactory.new
    result = provider_factory.get_provider("provider name")
    
    assert_equal "provider name", DbProviderFactories.provider_name
    assert_equal expected, result
  end
  
  #def test_does_not_add_create_data_table_method_if_namespace_is_not_defined
  #  result = ProviderFactory.get_provider("System.Data.SqlClient")
  #  assert !defined?(System::Data::DataTable)
  #  assert !result.respond_to?(:create_data_table)
  #end
  #
  #def test_adds_create_data_table_method_if_namespace_defined
  #  ProviderFactory.class_eval do
  #    def defined?(constant)
  #      true
  #    end
  #  end
  #  result = ProviderFactory.get_provider("System.Data.SqlClient")
  #  assert defined?(System::Data::DataTable)
  #  assert result.respond_to?(:create_data_table)
  #end
end

