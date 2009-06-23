describe Database, "command" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @result = @db.command("command text")
  end
  
  it "should return the expected command object" do
    @result.should == @provider.command
  end
  
  it "should set the connection property of the command" do
    @result.connection.should == @provider.connection
  end
  
  it "should set the command_text property of the command" do
    @result.command_text.should == "command text"
  end
  
  it "should not set the transaction property if there is not one current" do
    @result.transaction.should be_nil
  end
  
  it "should set the transaction property if there is one current" do
    @db.transaction do |t|
      result = @db.command("command text")
      result.transaction.should == t
    end
  end
end
