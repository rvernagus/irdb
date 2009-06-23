describe Database, "execute_hash" do
  before :each do
    @reader = FakeDataReader.new
    @provider = FakeProvider.new
    @mockCommand = mock("DbCommand")
    @mockCommand.should_receive(:command_text=).with("command text")
    
    @provider.command = @mockCommand
    @db = Database.new(@provider, "connection string")
  end
  
  it "should yield the expected command object" do
    was_yielded = false
    @db.execute_hash("command text") do |cmd|
      was_yielded = true
      cmd.should == @provider.command
    end
    
    was_yielded.should be_true
  end
  
  #it "should open connection for yield" do
  #  @db.execute_hash("command text") do |cmd|
  #    @provider.connection.open?.should be_true
  #  end
  #end
  #
  #it "should set the command text of the command" do
  #  @provider.command.query_result[:reader] = FakeReader.new
  #  result = @db.execute_hash("command text")
  #  
  #  @provider.command.command_text.should == "command text"
  #end
  #
  #it "should return an empty array when no data" do
  #  @mockCommand.should_receive(:execute_reader).and_return(nil)
  #  result = @db.execute_hash("command text")
  #
  #  result.length.should == 0
  #end
  #
  #it "should return a single hash when one record" do
  #  @reader.data << {"id" => 1}
  #  result = @db.execute_hash("command text")
  #  
  #  result.length.should == 1
  #end
  #
  #it "should return the expected number of hashes when many records" do
  #  @reader.data.concat [{"id" => 1}, {"id" => 2}, {"id" => 3}]
  #  result = @db.execute_hash("command text")
  #  
  #  result.length.should == 3
  #end
  #
  #it "should return a single hash with expected keys and values when one record" do
  #  @reader.data << {"id" => 1, "class" => "Death Knight"}
  #  result = @db.execute_hash("command text")
  #  
  #  result.first["id"].should == 1
  #  result.first["class"].should == "Death Knight"
  #end
  #
  #it "should return the expected number of hashes with expected keys and values when multiple records" do
  #  @reader.data << {"id" => 1, "class" => "Death Knight"}
  #  @reader.data << {"id" => 2, "class" => "Shaman"}
  #  result = @db.execute_hash("command text")
  #  
  #  result.first["id"].should == 2
  #  result.first["class"].should == "Shaman"
  #  result.last["id"].should == 1
  #  result.last["class"].should == "Death Knight"
  #end
  #
  #it "should convert key to lowercase" do
  #  key = "EXPECTED"
  #  @reader.data << {key => 1}
  #  result = @db.execute_hash("command text")
  #  
  #  result.first["expected"].should == 1
  #end
end
