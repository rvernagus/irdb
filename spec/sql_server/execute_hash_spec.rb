describe Database, "execute_hash on SQL Server" do
  extend SqlServerHelper
  
  before :each do
    @db = get_database
  end
  
  it "should return expected record hash from a scalar query" do
    result = @db.execute_hash("SELECT 1 AS id")
    
    result.should == [{"id" => 1}]
  end
  
  it "should return the expected record hash from a table query" do
    result = @db.execute_hash("SELECT * FROM characters ORDER BY id")
    
    result.length.should == 2
    result[0]["character_class"].rstrip.should == "Death Knight"
    result[1]["character_class"].rstrip.should == "Shaman"
  end
end