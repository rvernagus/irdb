class FakeConnection
  attr_accessor :connection_string
  
  def initialize
    @opened = @closed = false
  end
  
  def open
    @opened = true
  end
  
  def close
    @closed = true
  end
  
  def opened?
    @opened
  end
  
  def closed?
    @closed
  end
end
