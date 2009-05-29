require "fake_transaction"

class FakeConnection < System::Data::Common::DbConnection
  attr_accessor :connection_string, :transaction, :state

  def initialize
    @state = System::Data::ConnectionState.closed
    @transaction = FakeTransaction.new
  end

  def open
    @state = System::Data::ConnectionState.open
  end

  def close
    @state = System::Data::ConnectionState.closed
  end

  def begin_transaction
    @transaction
  end

  def open?
    @state == System::Data::ConnectionState.open
  end

  def closed?
    @state == System::Data::ConnectionState.closed
  end

  #def transaction_started?
  #  @trans_started
  #end
end
