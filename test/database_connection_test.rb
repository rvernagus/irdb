require "test/unit"
require "lib/irdb"
require "helpers/fake_provider"

class DatabaseTest < Test::Unit::TestCase
  def setup
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @conn = @db.instance_variable_get("@conn")
  end
  
  def test_stores_provider
    assert_same @provider, @db.provider
  end
  
  def test_stores_connection
    assert_same @provider.connection, @conn
  end
  
  def test_sets_connection_string_on_conn
    assert_equal "connection string", @conn.connection_string
  end
  
  def test_connection_opens_conn
    assert !@conn.opened?
    
    @db.connection
    
    assert @conn.opened?
  end
  
  def test_connection_closes_conn
    assert !@conn.closed?
    
    @db.connection
    
    assert @conn.closed?
  end
  
  def test_connection_ensures_conn_closed
    def @conn.open
      raise Exception
    end
    
    assert_raise(Exception) { @db.connection }
    
    assert @conn.closed?
  end
  
  def test_yields_opened_connection
    was_yielded = false
    
    @db.connection do |c|
      was_yielded = true
      assert c.opened?
    end
    
    assert was_yielded
  end
end