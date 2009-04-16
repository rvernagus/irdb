describe Database, "execute_reader on SQL Server" do
  extend SqlServerHelper
  
  before :each do
    @db = get_database
  end
  
  it "should yield expected number of times" do
    times_yielded = 0
    @db.connection do |c|
      cmd = @db.command("SELECT * FROM characters")
      @db.execute_reader(cmd) do |rdr|
        times_yielded += 1
      end
    end
    
    times_yielded.should == 2
  end
end