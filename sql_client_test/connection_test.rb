require "sql_client_test/setup"

class SqlConnectionTest < Test::Unit::TestCase
  include Setup
  
  def test_opens_connection_for_yield
    @db.connection do |c|
      assert_equal System::Data::ConnectionState.Open, c.state
    end
  end
  
  def test_closes_connection_after_yield
    connection = nil
    @db.connection { |c| connection = c }
    
    assert_equal System::Data::ConnectionState.Closed, connection.state
  end
  
  def test_ensures_connection_is_closed_on_exception
    connection = nil
    assert_raise(TestException) {
      @db.connection do |c|
        connection = c
        raise TestException
      end
    }
    
    assert_equal System::Data::ConnectionState.Closed, connection.state
  end
end

class TestException < System::Data::Common::DbException; end
