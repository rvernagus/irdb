describe Database, "execute_scalar on Oracle" do
  extend OracleHelper
  
  before :each do
    @db = get_database
  end
  
  it "should return expected value" do
    result = @db.execute_scalar("SELECT 'Death Knight' FROM dual")
    
    result.should == "Death Knight"
  end
end
