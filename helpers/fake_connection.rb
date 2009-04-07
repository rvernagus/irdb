class FakeConnection
  attr_accessor :connection_string
  
  def initialize
    @opened = @closed = @trans_started = false
  end
  
  def open
    @opened = true
  end
  
  def close
    @closed = true
  end
  
  def begin_transaction
    @trans_started = true
  end
  
  def opened?
    @opened
  end
  
  def closed?
    @closed
  end
  
  def transaction_started?
    @trans_started
  end
end
