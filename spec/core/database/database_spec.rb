describe Database, "once initialized" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @conn = @db.instance_variable_get("@conn")
  end
  
  it "should hold a reference to the provider" do
    @db.provider.should == @provider
  end
  
  it "should store a connection" do
    @conn.should == @provider.connection
  end
  
  it "should set the connection_string of the connection" do
    @conn.connection_string.should == "connection string"
  end
end
