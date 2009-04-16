describe Database, "connection" do
  before :each do
    provider = FakeProvider.new
    @db = Database.new(provider, "connection string")
  end
  
  def conn
    @db.instance_variable_get("@conn")
  end
  
  it "should close the connection" do
    conn.closed?.should be_true

    @db.connection

    conn.closed?.should be_true
  end
  
  it "should ensure a closed connection upon error" do
    def conn.open
      raise Exception
    end
        
    lambda { @db.connection }.should raise_error(Exception) 
    
    conn.closed?.should be_true
  end
  
  it "should yield an opened connection" do
    was_yielded = false
    @db.connection do |c|
      was_yielded = true
      c.open?.should be_true
    end
    
    was_yielded.should be_true
  end
end
