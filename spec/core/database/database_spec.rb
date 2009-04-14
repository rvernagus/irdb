describe Database, "once initialized" do
  before :each do
    @mock_conn = mock("Connection")
    @provider = mock("Provider")
    
    @mock_provider.
      should_receive(:create_connection).
      and_return(@mock_conn)
    @mock_conn.
      should_receive(:connection_string=).
      with("connection string")
    
    @db = Database.new(@mock_provider, "connection string")
  end
  
  def conn
    @db.instance_variable_get("@conn")
  end
  
  it "should hold a reference to the provider" do
    @db.provider.should == @mock_provider
  end
  
  it "should store a connection" do
    conn.should == @mock_conn
  end
end
