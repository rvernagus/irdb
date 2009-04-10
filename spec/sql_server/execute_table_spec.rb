describe Database, "execute_table on SQL Server" do
  extend SqlServerHelper
  
  before :each do
    @db = get_database
  end
  
  it "table should contain expected number of rows" do
    result = @db.execute_table("SELECT * FROM characters")
    
    result.rows.count.should == 2
  end
end
