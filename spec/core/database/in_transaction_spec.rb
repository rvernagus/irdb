describe Database, "in transaction state" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @result = @db.begin_transaction
    @state = @db.instance_variable_get("@state")
  end
  
  it "should have a connection in state" do
    @state.connection.should == @provider.connection
  end
  
  it "should have a transaction in state" do
    @state.transaction.should == @provider.connection.transaction
  end
  
  it "should have an open connection" do
    @state.connection.open?.should be_true
  end
  
  it "should have returned the transaction" do
    @result.should == @provider.connection.transaction
  end
  
  it "should not set the connection in state more than once" do
    @state.connection = :expected
    @db.begin_transaction
    @state.connection.should == :expected
  end

  it "should not set the transaction in state more than once" do
    @state.transaction = :expected
    @db.begin_transaction
    @state.transaction.should == :expected
  end
  
  it "should just return transaction if begin_transaction is called" do
    result = @db.begin_transaction
    result.should == @provider.connection.transaction
  end
end
