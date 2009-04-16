describe Database, "in connected state" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @result = @db.begin_connection
    @statebag = @db.instance_variable_get("@statebag")
  end
  
  it "should have a connection in the statebag" do
    @statebag[:connection].should == @provider.connection
  end
  
  it "should have an open connection" do
    @statebag[:connection].open?.should be_true
  end
  
  it "should have returned the connection" do
    @result.should == @provider.connection
  end
  
  it "should not add the connection to the statebag more than once" do
    @statebag[:connection] = :expected
    @db.begin_connection
    @statebag[:connection].should == :expected
  end
  
  it "should just return connection if begin_connection is called" do
    result = @db.begin_connection
    result.should == @provider.connection
  end
end
