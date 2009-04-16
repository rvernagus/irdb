class FakeTransaction
  def initialize
    @committed = @rolled_back = false
  end
  
  def commit
    raise "cannot commit same transaction twice" if committed?
    @committed = true
  end
  
  def rollback
    raise "cannot rollback same transaction twice" if rolled_back?
    @rolled_back = true
  end
  
  def committed?
    @committed
  end
  
  def rolled_back?
    @rolled_back
  end
end
