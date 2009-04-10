module DatabaseHelper
  attr_reader :mocks
  
  def initialize
    @mocks = {}
    mocks[:provider]   = mock("Provider")
    mocks[:connection] = mock("Connection")
  end
  
  def new_database
    provider = mocks[:provider]
    provider.
      should_receive(:create_connection).
      and_return(mocks[:connection])
    mocks[:connection].
      should_receive(:connection_string=).
      with("connection string")
      
    db = Database.new(provider, "connection string")
  end
end
