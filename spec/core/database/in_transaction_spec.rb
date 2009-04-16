describe Database, "in transaction state" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @result = @db.begin_transaction
    @connection = @db.instance_variable_get("@conn")
    @transaction = @db.instance_variable_get("@trans")
  end
  
  it "should have a connection in state" do
    @connection.should == @provider.connection
  end
  
  it "should have a transaction in state" do
    @transaction.should == @provider.connection.transaction
  end
  
  it "should have an open connection" do
    @connection.open?.should be_true
  end
  
  it "should have returned the transaction" do
    @result.should == @provider.connection.transaction
  end
  
  it "should not set the connection in state more than once" do
    @connection = :expected
    @db.begin_transaction
    @connection.should == :expected
  end

  it "should not set the transaction in state more than once" do
    @transaction = :expected
    @db.begin_transaction
    @transaction.should == :expected
  end
  
  it "should just return transaction if begin_transaction is called" do
    result = @db.begin_transaction
    result.should == @provider.connection.transaction
  end
end
