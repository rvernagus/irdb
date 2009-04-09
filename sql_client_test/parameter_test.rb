require "test/unit"
require "lib/irdb"

class SqlExecuteScalarTest < Test::Unit::TestCase
  def setup
    provider_factory = IRDb::DbProviderFactory.new
    provider = provider_factory.create_provider("System.Data.SqlClient")
    cstr = "Data Source=.\\sqlexpress;Initial Catalog=IRDbTest;Integrated Security=True;"

    @db = IRDb::Database.new(provider, cstr)
  end
  
  def test_specify_name_and_value
    result = @db.execute_scalar("SELECT @param") do |cmd|
      @db.add_parameter(cmd, :name => "param", :value => "value".to_string)
    end
    
    assert_equal "value", result
  end
end
