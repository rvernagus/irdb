require "test/unit"
require "lib/netdb"
require "helpers/db_provider_factories"
include IRDb

class ProviderFactoryTest < Test::Unit::TestCase
  def test_calls_dotnet_method
    expected = Object.new
    System::Data::Common::DbProviderFactories.get_factory_returns(expected)
    assert_equal expected, ProviderFactory.get_provider("System.Data.SqlClient")
    assert_equal "System.Data.SqlClient", System::Data::Common::DbProviderFactories.get_factory_last_called_with
  end
  
  def test_does_not_add_create_data_table_method_if_namespace_is_not_defined
    result = ProviderFactory.get_provider("System.Data.SqlClient")
    assert !defined?(System::Data::DataTable)
    assert !result.respond_to?(:create_data_table)
  end
  
  def test_adds_create_data_table_method_if_namespace_defined
    ProviderFactory.class_eval do
      def defined?(constant)
        true
      end
    end
    result = ProviderFactory.get_provider("System.Data.SqlClient")
    assert defined?(System::Data::DataTable)
    assert result.respond_to?(:create_data_table)
  end
end

