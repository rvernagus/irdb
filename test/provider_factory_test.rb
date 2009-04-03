require "test/unit"
require "lib/netdb"
require "helpers/db_provider_factories"
include NetDb

class ProviderFactoryTest < Test::Unit::TestCase
  def test_calls_dotnet_method
    expected = Object.new
    System::Data::Common::DbProviderFactories.get_factory_returns(expected)
    assert_equal expected, ProviderFactory.get_provider("System.Data.SqlClient")
    assert_equal "System.Data.SqlClient", System::Data::Common::DbProviderFactories.get_factory_last_called_with
  end
end

