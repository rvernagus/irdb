class FakeTransaction
  def initialize
    @committed = @rolled_back = false
  end
  
  def commit
    @commited = true
  end
  
  def rollback
    @rolled_back = true
  end
end
