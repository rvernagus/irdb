describe Database, "transactions on Oracle" do
  extend OracleHelper
  
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
    result = System::Convert.to_int32(result)
    result.should == 0
  end
  
  it "should rollback on error" do
    lambda {
      @db.transaction do |t|
        @db.execute_scalar("DELETE FROM characters")
        raise Exception
      end
    }.should raise_error(Exception)
    
    
    result = @db.execute_scalar("SELECT COUNT(*) FROM characters")
    result = System::Convert.to_int32(result)
    result.should == 2
  end
end
