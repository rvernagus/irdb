describe Database, "execute_non_query on Oracle" do
  extend OracleHelper
  
  before :each do
    @db = get_database
  end
  
  it "should return expected value" do
    result = @db.execute_non_query("DELETE FROM characters WHERE id = -1")
    
    result.should == 0
  end
end
