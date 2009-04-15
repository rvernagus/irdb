describe Database, "transactions on Oracle" do
  extend OracleHelper
  
  before :each do
    @db = get_database
  end
  
  it "should not be nil" do
    @db.connection do |c|
      @db.transaction do |t|
        t.should_not be_nil
      end
    end
  end
  
  it "should commit" do
    @db.connection do |c|
      @db.transaction do |t|
        @db.command("DELETE FROM characters") do |cmd|
          cmd.execute_scalar
        end
      end
    end
    
    result = @db.execute_scalar("SELECT COUNT(*) FROM characters")
    result = System::Convert.to_int32(result)
    result.should == 0
  end
  
  it "should rollback on error" do
    lambda {
      @db.connection do |c|
        @db.transaction do |t|
          @db.execute_non_query("DELETE FROM characters")
          raise Exception
        end
      end
    }.should raise_error(Exception)
    
    result = @db.execute_scalar("SELECT COUNT(*) FROM characters")
    result = System::Convert.to_int32(result)
    result.should == 2
  end
end
