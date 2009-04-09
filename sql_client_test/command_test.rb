require "sql_client_test/setup"

class SqlCommandTest < Test::Unit::TestCase
  include Setup
  
  def test_scalar
    @db.connection do |c|
      @db.command("SELECT 'Death Knight'") do |cmd|
        result = cmd.execute_scalar
        assert_equal "Death Knight", result
      end
    end
  end
  
  def test_two_scalars
    @db.connection do |c|
      @db.command("SELECT 'Death Knight'") do |cmd|
        result = cmd.execute_scalar
        assert_equal "Death Knight", result
      end
      
      @db.command("SELECT 'Shaman'") do |cmd|
        result = cmd.execute_scalar
        assert_equal "Shaman", result
      end
    end
  end
  
  def test_scalar_within_transaction
    @db.connection do |c|
      @db.transaction do |t|
        @db.command("SELECT 'Death Knight'") do |cmd|
          result = cmd.execute_scalar
          assert_equal "Death Knight", result
        end
      end
    end
  end
end