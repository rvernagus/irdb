describe Database, "connection" do
  before :each do
    @provider = FakeProvider.new
    @db = Database.new(@provider, "connection string")
    @conn = @db.instance_variable_get("@conn")
  end
  
  it "should open the connection" do
    @conn.opened?.should be_false
    
    @db.connection
    
    @conn.opened?.should be_true
  end
  
  it "should close the connection" do
    @conn.closed?.should be_false

    @db.connection

    @conn.closed?.should be_true
  end
  
  it "should ensure a closed connection upon error" do
    def @conn.open
      raise Exception
    end
    
    lambda { @db.connection }.should raise_error(Exception) 
    
    @conn.closed?.should be_true
  end
  
  it "should yield an opened connection" do
    was_yielded = false
    @db.connection do |c|
      was_yielded = true
      c.opened?.should be_true
    end
    
    was_yielded.should be_true
  end
end
