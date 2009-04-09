require "sql_client_test/setup"

class SqlTransactionTest < Test::Unit::TestCase
  include Setup
  
  def test_created_successfully
    @db.connection do |c|
      @db.transaction do |t|
        assert_not_nil t
      end
    end
  end
end
