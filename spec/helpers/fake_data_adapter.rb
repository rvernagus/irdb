class FakeDataAdapter
  attr_accessor :select_command
  
  def initialize
    @disposed = @filled = false
  end
  
  def fill(tbl)
    @filled = true
    1
  end
  
  def dispose
    @disposed = true
  end
  
  def filled?
    @filled
  end
  
  def disposed?
    @disposed
  end
end
