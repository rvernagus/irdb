describe Database, "in transaction state" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @result = @db.begin_transaction
    @statebag = @db.instance_variable_get("@statebag")
  end
  
  it "should have a connection in the statebag" do
    @statebag[:connection].should == @provider.connection
  end
  
  it "should have a transaction in the statebag" do
    @statebag[:transaction].should == @provider.connection.transaction
  end
  
  it "should have an open connection" do
    @statebag[:connection].open?.should be_true
  end
  
  it "should have returned the transaction" do
    @result.should == @provider.connection.transaction
  end
  
  it "should not add the connection to the statebag more than once" do
    @statebag[:connection] = :expected
    @db.begin_transaction
    @statebag[:connection].should == :expected
  end

  it "should not add the transaction to the statebag more than once" do
    @statebag[:transaction] = :expected
    @db.begin_transaction
    @statebag[:transaction].should == :expected
  end
  
  it "should just return transaction if begin_transaction is called" do
    result = @db.begin_transaction
    result.should == @provider.connection.transaction
  end
end
