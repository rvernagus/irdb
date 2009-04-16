describe Database, "transaction" do
  before :each do
    provider = FakeProvider.new
    @transaction = provider.connection.transaction
    @db = Database.new(provider, "connection string")
  end
  
  def current_transaction
    @db.instance_variable_get("@trans")
  end
  
  it "should yield the expected object" do
    was_yielded = false
    @db.transaction do |t|
      was_yielded = true
      t.should == @transaction
    end
    
    was_yielded.should be_true
  end
  
  it "should set the current transaction only for duration of block" do
    current_transaction.should be_nil
    
    @db.transaction do |t|
      current_transaction.should == @transaction
    end
    
    current_transaction.should be_nil
  end
  
  it "should reset the current transaction on error" do
    lambda { @db.transaction { |t| raise Exception }}.should raise_error(Exception)
    
    current_transaction.should be_nil
  end
  
  it "should commit the transcation after the block exits" do
    @transaction.committed?.should be_false
    
    @db.transaction
    
    @transaction.rolled_back?.should be_false
    @transaction.committed?.should be_true
  end
  
  it "should rollback the transaction on error" do
    @transaction.rolled_back?.should be_false
    
    lambda { @db.transaction { |t| raise Exception }}.should raise_error(Exception)
    
    @transaction.committed?.should be_false
    @transaction.rolled_back?.should be_true
  end
  
  it "should open a connection for the block" do
    @db.transaction do |t|
      @db.provider.connection.open?.should be_true
    end
  end
end
