describe Database, "execute_reader" do
  before :each do
    @provider = FakeProvider.new
    @reader = mock("DbDataReader")
    @reader.stub!(:dispose)
    cmd = @provider.command
    def cmd.execute_reader
      @reader
    end
    p @provider.command.execute_reader
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
  
  #it "should continue to yield reader while read is true" do
  #  @reader.should_receive(:read).exactly(3).and_return(true, true, false)
  #  times_yielded = 0
  #  @db.execute_reader(@provider.command) do |rdr|
  #    times_yielded += 1
  #  end
  #  
  #  times_yielded.should == 2
  #end
  #
  #it "should dispose of reader" do
  #  @reader.should_receive(:read).once.and_return(false)
  #  @reader.should_receive(:dispose).once
  #  @db.execute_reader(@provider.command) { }
  #end
  #
  #it "should not dispose of reader if command fails" do
  #  cmd = @provider.command
  #  def cmd.execute_reader
  #    raise Exception
  #  end
  #  @reader.should_not_receive(:dispose)
  #  lambda { @db.execute_reader(cmd) { }}.should raise_error(Exception)
  #end
  #
  #it "should not dispose of reader if nil" do
  #  cmd = @provider.command
  #  def cmd.execute_reader
  #    raise Exception
  #  end
  #  lambda { @db.execute_reader(cmd) { }}.should_not raise_error(NoMethodError)
  #end
end
