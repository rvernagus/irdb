describe Database, "in connected state" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @result = @db.begin_connection
    @connection = @db.instance_variable_get("@conn")
  end
  
  it "should have a connection in state" do
    @connection.should == @provider.connection
  end
  
  it "should have an open connection" do
    @connection.open?.should be_true
  end
  
  it "should have returned the connection" do
    @result.should == @provider.connection
  end
  
  it "should not set the connection in state more than once" do
    @connection = :expected
    @db.begin_connection
    @connection.should == :expected
  end
  
  it "should just return connection if begin_connection is called" do
    result = @db.begin_connection
    result.should == @provider.connection
  end
end
