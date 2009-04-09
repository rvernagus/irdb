require "sql_client_test/setup"

class SqlExecuteScalarTest < Test::Unit::TestCase
  include Setup
  
  def test_returns_value
    result = @db.execute_scalar("SELECT 'Death Knight'")
    
    assert_equal "Death Knight", result
  end
end
