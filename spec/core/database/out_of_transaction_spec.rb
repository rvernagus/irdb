describe Database, "after exiting connected state" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @db.begin_transaction
    @result = @db.end_transaction
    @statebag = @db.instance_variable_get("@statebag")
  end
  
  it "should have removed the transaction from the statebag" do
    @statebag[:transaction].should be_nil
  end
  
  it "should have returned self" do
    @result.should == @db
  end
  
  it "should allow subsequent end messages" do
    result = @db.end_transaction
    result.should == @db
  end
end
