require "database_test_fixture"

class DatabaseCommandTest < Test::Unit::TestCase
  include DatabaseTestFixture
  
  def test_yields_expected
    was_yielded = false
    @db.command("command text") do |cmd|
      was_yielded = true
      assert_same @provider.command, cmd
    end
    
    assert was_yielded
  end
  
  def test_sets_connection_property
    @db.command("command text") do |cmd|
      assert_same @provider.connection, cmd.connection
    end
  end
  
  def test_sets_command_text
    @db.command("command text") do |cmd|
      assert_equal "command text", cmd.command_text
    end
  end
  
  def test_does_not_set_transaction_if_none_current
    @db.command("command text") do |cmd|
      assert_nil cmd.transaction
    end
  end
  
  def test_sets_transaction_if_one_current
    @db.transaction do |t|
      @db.command("command text") do |cmd|
        assert_same t, cmd.transaction
      end
    end
  end
end
