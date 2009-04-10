describe Database, "execute_scalar" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
  end
  
  it "should yield the expected command object" do
    was_yielded = false
    @db.execute_scalar("command text") do |cmd|
      was_yielded = true
      cmd.should == @provider.command
    end
    
    was_yielded.should be_true
  end
  
  it "should open connection for yield" do
    @db.execute_scalar("command text") do |cmd|
      @provider.connection.opened?.should be_true
    end
  end
  
  it "should execute command as scalar and return results" do
    @provider.command.query_result[:scalar] = :result
    result = @db.execute_scalar("command text")
    
    @provider.command.command_text.should == "command text"
    result.should == :result
  end
end
