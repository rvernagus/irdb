describe Database, "commands on SQL Server" do
  extend SqlServerHelper
  
  before :each do
    @db = get_database
  end
  
  it "should return expected scalar value" do
    @db.connection do |c|
      @db.command("SELECT 'Death Knight'") do |cmd|
        result = cmd.execute_scalar
        result.should == "Death Knight"
      end
    end
  end
end
