require "database_test_fixture"

class DatabaseTransactionTest  < Test::Unit::TestCase
  include DatabaseTestFixture
  
  def test_begins_a_transaction
    assert !@provider.connection.transaction_started?
    
    @db.transaction
    
    assert @provider.connection.transaction_started?
  end
end
