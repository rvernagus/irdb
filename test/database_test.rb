require "test/unit"
require "lib/irdb"
require "helpers/fake_provider"

class DatabaseTest < Test::Unit::TestCase
  def setup
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
  end
  
  def test_stores_provider
    assert_equal @provider, @db.provider
  end
  
  def test_stores_connection
    assert_equal @provider.connection, @db.instance_variable_get("@connection")
  end
  
  def test_sets_connection_string_on_connection
    connection = @db.instance_variable_get("@connection")
    
    assert_equal "connection string", connection.connection_string
  end
end