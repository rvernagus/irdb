require "fake_transaction"

class FakeConnection
  attr_accessor :connection_string, :transaction
  
  def initialize
    @opened = @closed = false
    @transaction = FakeTransaction.new
  end
  
  def open
    @opened = true
  end
  
  def close
    @closed = true
  end
  
  def begin_transaction
    @transaction
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
