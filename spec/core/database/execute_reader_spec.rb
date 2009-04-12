describe Database, "execute_scalar" do
  before :each do
    @provider = FakeProvider.new
    @reader = mock("DbDataReader")
    @reader.stub!(:dispose)
    @provider.command.query_result[:reader] = @reader
    @db = Database.new(@provider, "connection string")
  end
  
  it "should yield the expected reader object" do
    @reader.should_receive(:read).twice.and_return(true, false)
    was_yielded = false
    @db.execute_reader(@provider.command) do |rdr|
      was_yielded = true
      rdr.should == @reader
    end
    
    was_yielded.should be_true
  end
  
  it "should continue to yield reader while read is true" do
    @reader.should_receive(:read).exactly(3).and_return(true, true, false)
    times_yielded = 0
    @db.execute_reader(@provider.command) do |rdr|
      times_yielded += 1
    end
    
    times_yielded.should == 2
  end
  
  it "should dispose of reader" do
    @reader.should_receive(:read).once.and_return(false)
    @reader.should_receive(:dispose).once
    @db.execute_reader(@provider.command) { }
  end
end
