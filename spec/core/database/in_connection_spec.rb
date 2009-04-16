describe Database, "in connected state" do
  before :each do
    @provider = FakeProvider.new
    db = Database.new(@provider, "connection string")
    @result = db.begin_connection
    @statebag = db.instance_variable_get("@statebag")
  end
  
  it "should add the connection to the statebag" do
    @statebag[:connection].should == @provider.connection
  end
  
  it "should open the connection" do
    @statebag[:connection].open?.should be_true
  end
  
  it "should return the connection" do
    @result.should == @provider.connection
  end
end
