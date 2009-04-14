describe Database, "execute_hash" do
  before :each do
    @reader = FakeReader.new
    @provider = FakeProvider.new
    @provider.command.query_result[:reader] = @reader
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
  
  it "should return an empty array when no data" do
    result = @db.execute_hash("command text")

    result.length.should == 0
  end
  
  it "should return a single hash when one record" do
    @reader.data << { :id => 1 }
    result = @db.execute_hash("command text")
    
    result.length.should == 1
  end
  
  it "should return the expected number of hashes when many records" do
    @reader.data.concat [{:id => 1}, {:id => 2}, {:id => 3}]
    result = @db.execute_hash("command text")
    
    result.length.should == 3
  end
end
