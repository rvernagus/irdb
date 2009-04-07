require "test/unit"
require "lib/irdb"
require "helpers/fake_system_data"
include IRDb
DbProviderFactories = System::Data::Common::DbProviderFactories

class DbProviderFactoryTest < Test::Unit::TestCase
  def setup
    @provider_factory = DbProviderFactory.new
  end
  
  def test_calls_dotnet_method
    expected = Object.new
    DbProviderFactories.factory = expected
    provider = @provider_factory.get_provider("provider name")
    
    assert_equal "provider name", DbProviderFactories.provider_name
    assert_equal expected, provider
  end
  
  def test_adds_create_data_table_method
    provider = @provider_factory.get_provider("provider name")
    
    assert provider.respond_to?(:create_data_table)
  end
  
  def test_create_data_table_returns_expected
    provider = @provider_factory.get_provider("provider name")
    result = provider.create_data_table
    
    assert_equal FakeDataTable, result.class
  end
end

