describe Database, "transactions on SQL Server" do
  extend SqlServerHelper
  
  before :each do
    @db = get_database
  end
  
  it "should not be nil" do
    @db.transaction do |t|
      t.should_not be_nil
    end
  end
  
  it "should commit" do
    @db.transaction do |t|
      @db.execute_scalar("DELETE FROM characters")
    end
    
    result = @db.execute_scalar("SELECT COUNT(*) FROM characters")
    result.should == 0
  end
  
  it "should rollback on error" do
    lambda {
      @db.transaction do |t|
        @db.command("DELETE FROM characters") do |cmd|
          cmd.execute_scalar
        end
        raise Exception
      end
    }.should raise_error(Exception)
    
    
    result = @db.execute_scalar("SELECT COUNT(*) FROM characters")
    result.should == 2
  end
end
