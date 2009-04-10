class FakeTransaction
  def initialize
    @committed = @rolled_back = false
  end
  
  def commit
    @committed = true
  end
  
  def rollback
    @rolled_back = true
  end
  
  def committed?
    @committed
  end
  
  def rolled_back?
    @rolled_back
  end
end
