require "database_test_fixture"

class DatabaseTest < Test::Unit::TestCase
  include DatabaseTestFixture
  
  def test_stores_provider
    assert_same @provider, @db.provider
  end
  
  def test_stores_connection
    assert_same @provider.connection, @conn
  end
  
  def test_sets_connection_string_on_conn
    assert_equal "connection string", @conn.connection_string
  end
end