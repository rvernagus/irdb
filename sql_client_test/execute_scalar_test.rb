require "test/unit"
require "lib/irdb"

class SqlExecuteScalarTest < Test::Unit::TestCase
  def setup
    provider_factory = IRDb::DbProviderFactory.new
    provider = provider_factory.create_provider("System.Data.SqlClient")
    cstr = "Data Source=.\\sqlexpress;Initial Catalog=IRDbTest;Integrated Security=True;"

    @db = IRDb::Database.new(provider, cstr)
  end
  
  def test_returns_value
    result = @db.execute_scalar("SELECT 'Death Knight'")
    
    assert_equal "Death Knight", result
  end
end
