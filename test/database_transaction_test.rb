require "database_test_fixture"

class DatabaseTransactionTest  < Test::Unit::TestCase
  include DatabaseTestFixture
  
  def test_yields_expected
    expected = @provider.connection.transaction
    was_yielded = false
    
    @db.transaction do |t|
      was_yielded = true
      assert_same expected, t
    end
    
    assert was_yielded
  end
end
