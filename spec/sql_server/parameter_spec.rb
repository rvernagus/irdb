describe Database, "parameters on SQL Server" do
  extend SqlServerHelper
  
  before :each do
    @db = get_database
  end
  
  it "should set the value to expected" do
    result = @db.execute_scalar("SELECT @param") do |cmd|
      @db.add_parameter(cmd, :name => "param", :value => "value".to_string)
    end
    
    result.should == "value"
  end
end
