describe Database, "after exiting connected state" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @db.begin_connection
    @result = @db.end_connection
    @statebag = @db.instance_variable_get("@statebag")
  end
  
  it "should have removed the connection from the statebag" do
    @statebag[:connection].should be_nil
  end
  
  it "should have closed the connection" do
    @provider.connection.closed?.should be_true
  end
  
  it "should have returned self" do
    @result.should == @db
  end
  
  it "should allow subsequent end messages" do
    result = @db.end_connection
    result.should == @db
  end
end
