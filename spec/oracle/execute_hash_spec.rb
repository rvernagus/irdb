describe Database, "execute_hash on Oracle" do
  extend OracleHelper
  
  before :each do
    @db = get_database
  end
  
  it "should return expected record hash" do
    result = @db.execute_hash("SELECT 'value' AS key FROM dual")
    
    result.should == [{"key" => "value"}]
  end
end