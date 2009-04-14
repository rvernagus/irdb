describe Database, "execute_hash on SQL Server" do
  extend SqlServerHelper
  
  before :each do
    @db = get_database
  end
  
  it "should return expected record hash" do
    result = @db.execute_hash("SELECT 1 AS id")
    
    result.should == [{"id" => 1}]
  end
end