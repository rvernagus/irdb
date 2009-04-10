describe Database, "execute_table" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
  end
  
  it "should yield the expected command object" do
    was_yielded = false
    @db.execute_table("command text") do |cmd|
      was_yielded = true
      cmd.should == @provider.command
    end
    
    was_yielded.should be_true
  end
  
  it "should open connection for yield" do
    @db.execute_table("command text") do |cmd|
      @provider.connection.opened?.should be_true
    end
  end
  
  it "should return the expected table object" do
    result = @db.execute_table("command text")
    
    result.should == @provider.data_table
  end
  
  it "should set the select_command of the data_adapter" do
    @db.execute_table("command text")
    
    @provider.data_adapter.select_command.should == @provider.command
  end
  
  it "should fill the table using the data_adapter" do
    @db.execute_table("command text")
    
    @provider.data_adapter.filled?.should be_true
  end
end
