require "test/unit"
require "lib/irdb"

class SqlConnectionTest < Test::Unit::TestCase
  def setup
    provider_factory = IRDb::DbProviderFactory.new
    provider = provider_factory.create_provider("System.Data.SqlClient")
    cstr = "Data Source=.\\sqlexpress;Initial Catalog=IRDbTest;Integrated Security=True;"

    @db = IRDb::Database.new(provider, cstr)
  end
  
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
