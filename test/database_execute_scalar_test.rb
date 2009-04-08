require "database_test_fixture"

class DatabaseExecuteScalarTest < Test::Unit::TestCase
  include DatabaseTestFixture
  
  def test_yields_expected
    was_yielded = false
    @db.execute_scalar("command text") do |cmd|
      was_yielded = true
      assert_same @provider.command, cmd
    end
    
    assert was_yielded
  end
  
  def test_connection_is_open_at_yield
    @db.execute_scalar("command text") do |cmd|
      assert @provider.connection.opened?
    end
  end
end
