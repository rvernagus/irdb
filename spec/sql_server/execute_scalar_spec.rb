describe Database, "execute_scalar on SQL Server" do
  extend SqlServerHelper
  
  before :each do
    @db = get_database
  end
  
  it "should return expected value" do
    result = @db.execute_scalar("SELECT 'Death Knight'")
    
    result.should == "Death Knight"
  end
end
