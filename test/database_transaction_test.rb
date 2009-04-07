require "database_test_fixture"

class DatabaseTransactionTest  < Test::Unit::TestCase
  include DatabaseTestFixture
  
  def test_yields_expected
    was_yielded = false
    
    @db.transaction do |t|
      was_yielded = true
      assert_same @transaction, t
    end
    
    assert was_yielded
  end
  
  def test_sets_current_transaction_for_duration_only
    assert_nil @db.instance_variable_get("@current_transaction")
    
    @db.transaction do |t|
      assert_same @transaction, @db.instance_variable_get("@current_transaction")
    end
    
    assert_nil @db.instance_variable_get("@current_transaction")
  end
  
  def test_resets_current_transaction_if_exception
    assert_raise(Exception) { @db.transaction { |t| raise Exception }}
    
    assert_nil @db.instance_variable_get("@current_transaction")
  end
  
  def test_commits_transaction
    assert !@transaction.committed?
    
    @db.transaction
    
    assert !@transaction.rolled_back?
    assert @transaction.committed?
  end
  
  def test_rolls_back_on_exception
    assert !@transaction.rolled_back?
    
    assert_raise(Exception) { @db.transaction { |t| raise Exception }}
    
    assert !@transaction.committed?
    assert @transaction.rolled_back?
  end
end
