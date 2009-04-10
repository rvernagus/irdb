describe Database, "command" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
  end
  
  it "should yield the expected command object" do
    was_yielded = false
    @db.command("command text") do |cmd|
      was_yielded = true
      cmd.should == @provider.command
    end
    
    was_yielded.should be_true
  end
  
  it "should set the connection property of the command" do
    @db.command("command text") do |cmd|
      cmd.connection.should == @provider.connection
    end
  end
  
  it "should set the command_text property of the command" do
    @db.command("command text") do |cmd|
      cmd.command_text.should == "command text"
    end
  end
  
  it "should not set the transaction property if there is not one current" do
    @db.command("command text") do |cmd|
      cmd.transaction.should be_nil
    end
  end
  
  it "should set the transaction property if there is one current" do
    @db.transaction do |t|
        @db.command("command text") do |cmd|
          cmd.transaction.should == t
        end
    end
  end
end
