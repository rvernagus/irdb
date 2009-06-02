require "fake_transaction"

class FakeDbConnection < System::Data::Common::DbConnection
  attr_accessor :connection_string, :transaction, :state, :_mock

  def initialize
    @state       = System::Data::ConnectionState.closed
    @transaction = FakeTransaction.new
    @_mock       = mock("DbConnection")
  end

  def open
    self.state = System::Data::ConnectionState.open
  end

  def close
    self.state = System::Data::ConnectionState.closed
  end

  def begin_transaction
    transaction
  end

  def open?
    state == System::Data::ConnectionState.open
  end

  def closed?
    state == System::Data::ConnectionState.closed
  end
  
  def method_missing(m, *args)
    _mock.send(m, args)
  end

  def get_schema(*args)
    _mock.get_schema(*args)
  end
end
