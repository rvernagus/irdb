require "database_test_fixture"

class DatabaseConnectionTest < Test::Unit::TestCase
  include DatabaseTestFixture
  
  def test_opens_conn
    assert !@conn.opened?
    
    @db.connection
    
    assert @conn.opened?
  end
  
  def test_closes_conn
    assert !@conn.closed?
    
    @db.connection
    
    assert @conn.closed?
  end
  
  def test_ensures_conn_closed
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