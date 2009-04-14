require "fake_transaction"

class FakeConnection
  attr_accessor :connection_string, :transaction
  
  def initialize
    @opened = false
    @closed = true
    @transaction = FakeTransaction.new
  end
  
  def open
    @opened = true
    @closed = false
  end
  
  def close
    @closed = true
    @opened = false
  end
  
  def begin_transaction
    @transaction
  end
  
  def open?
    @opened
  end
  
  def closed?
    @closed
  end
  
  def transaction_started?
    @trans_started
  end
end
