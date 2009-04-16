describe Database, "execute_hash on Oracle" do
  extend OracleHelper
  
  before :each do
    @db = get_database
  end
  
  it "should return expected record hash from a scalar query" do
    result = @db.execute_hash("SELECT 'value' AS key FROM dual")
    
    result.should == [{"key" => "value"}]
  end
  
  it "should return the expected record hash from a table query" do
    result = @db.execute_hash("SELECT * FROM characters ORDER BY id")
    
    result.length.should == 2
    result[0]["class"].should == "Death Knight"
    result[1]["class"].should == "Shaman"
  end
end